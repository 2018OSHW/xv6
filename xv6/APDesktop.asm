
_APDesktop：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <desktopInitStringFigure>:
#include "APDesktop.h"



void desktopInitStringFigure()
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
    printf(1, "init ASCII\n");
       6:	83 ec 08             	sub    $0x8,%esp
       9:	68 08 23 00 00       	push   $0x2308
       e:	6a 01                	push   $0x1
      10:	e8 4a 06 00 00       	call   65f <printf>
      15:	83 c4 10             	add    $0x10,%esp
    int fd = open("ASCII", O_RDONLY);
      18:	83 ec 08             	sub    $0x8,%esp
      1b:	6a 00                	push   $0x0
      1d:	68 14 23 00 00       	push   $0x2314
      22:	e8 d1 04 00 00       	call   4f8 <open>
      27:	83 c4 10             	add    $0x10,%esp
      2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (fd < 0)
      2d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      31:	79 14                	jns    47 <desktopInitStringFigure+0x47>
    {
        printf(1, "Cannot open file\n");
      33:	83 ec 08             	sub    $0x8,%esp
      36:	68 1a 23 00 00       	push   $0x231a
      3b:	6a 01                	push   $0x1
      3d:	e8 1d 06 00 00       	call   65f <printf>
      42:	83 c4 10             	add    $0x10,%esp
        return;
      45:	eb 7d                	jmp    c4 <desktopInitStringFigure+0xc4>
    }
    char * ASCII = (char *)malloc(sizeof(char) * ASCII_SIZE);
      47:	83 ec 0c             	sub    $0xc,%esp
      4a:	68 00 08 00 00       	push   $0x800
      4f:	e8 de 08 00 00       	call   932 <malloc>
      54:	83 c4 10             	add    $0x10,%esp
      57:	89 45 f0             	mov    %eax,-0x10(%ebp)
    read(fd, ASCII, sizeof(char) * ASCII_SIZE);
      5a:	83 ec 04             	sub    $0x4,%esp
      5d:	68 00 08 00 00       	push   $0x800
      62:	ff 75 f0             	pushl  -0x10(%ebp)
      65:	ff 75 f4             	pushl  -0xc(%ebp)
      68:	e8 63 04 00 00       	call   4d0 <read>
      6d:	83 c4 10             	add    $0x10,%esp
    close(fd);
      70:	83 ec 0c             	sub    $0xc,%esp
      73:	ff 75 f4             	pushl  -0xc(%ebp)
      76:	e8 65 04 00 00       	call   4e0 <close>
      7b:	83 c4 10             	add    $0x10,%esp
    printf(1, "read ASCII complete\n");
      7e:	83 ec 08             	sub    $0x8,%esp
      81:	68 2c 23 00 00       	push   $0x232c
      86:	6a 01                	push   $0x1
      88:	e8 d2 05 00 00       	call   65f <printf>
      8d:	83 c4 10             	add    $0x10,%esp
    
    initStringFigure(0, 0, ASCII, ASCII_SIZE);
      90:	68 00 08 00 00       	push   $0x800
      95:	ff 75 f0             	pushl  -0x10(%ebp)
      98:	6a 00                	push   $0x0
      9a:	6a 00                	push   $0x0
      9c:	e8 bf 04 00 00       	call   560 <initStringFigure>
      a1:	83 c4 10             	add    $0x10,%esp
    //free(GBK2312);
    free(ASCII);
      a4:	83 ec 0c             	sub    $0xc,%esp
      a7:	ff 75 f0             	pushl  -0x10(%ebp)
      aa:	e8 41 07 00 00       	call   7f0 <free>
      af:	83 c4 10             	add    $0x10,%esp
    printf(1, "init string figure complete\n");
      b2:	83 ec 08             	sub    $0x8,%esp
      b5:	68 41 23 00 00       	push   $0x2341
      ba:	6a 01                	push   $0x1
      bc:	e8 9e 05 00 00       	call   65f <printf>
      c1:	83 c4 10             	add    $0x10,%esp
}
      c4:	c9                   	leave  
      c5:	c3                   	ret    

000000c6 <runApp>:


void runApp(void * param)
{
      c6:	55                   	push   %ebp
      c7:	89 e5                	mov    %esp,%ebp
      c9:	83 ec 38             	sub    $0x38,%esp
    int pid = fork();
      cc:	e8 df 03 00 00       	call   4b0 <fork>
      d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    char temp[30];
    if (pid == 0)
      d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      d8:	75 37                	jne    111 <runApp+0x4b>
    {
        sprintf(temp, "AP%s", (char *)param);
      da:	83 ec 04             	sub    $0x4,%esp
      dd:	ff 75 08             	pushl  0x8(%ebp)
      e0:	68 5e 23 00 00       	push   $0x235e
      e5:	8d 45 d6             	lea    -0x2a(%ebp),%eax
      e8:	50                   	push   %eax
      e9:	e8 e5 1f 00 00       	call   20d3 <sprintf>
      ee:	83 c4 10             	add    $0x10,%esp
        char *argv[] = { temp, 0 };
      f1:	8d 45 d6             	lea    -0x2a(%ebp),%eax
      f4:	89 45 cc             	mov    %eax,-0x34(%ebp)
      f7:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
        exec(temp, argv);
      fe:	83 ec 08             	sub    $0x8,%esp
     101:	8d 45 cc             	lea    -0x34(%ebp),%eax
     104:	50                   	push   %eax
     105:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     108:	50                   	push   %eax
     109:	e8 e2 03 00 00       	call   4f0 <exec>
     10e:	83 c4 10             	add    $0x10,%esp
    }
}
     111:	90                   	nop
     112:	c9                   	leave  
     113:	c3                   	ret    

00000114 <wndProc>:
};



bool wndProc(AHwnd hwnd, AMessage msg)
{
     114:	55                   	push   %ebp
     115:	89 e5                	mov    %esp,%ebp
     117:	83 ec 18             	sub    $0x18,%esp
    //printf(1,"desktop processing!\n");
    switch(msg.type)
     11a:	8b 45 0c             	mov    0xc(%ebp),%eax
     11d:	83 f8 02             	cmp    $0x2,%eax
     120:	74 30                	je     152 <wndProc+0x3e>
     122:	83 f8 02             	cmp    $0x2,%eax
     125:	77 0a                	ja     131 <wndProc+0x1d>
     127:	83 f8 01             	cmp    $0x1,%eax
     12a:	74 1c                	je     148 <wndProc+0x34>
                changePosition(VK_RIGHT,0);
                break;
            default:break;
        }
            break;
        default: break;
     12c:	e9 dd 00 00 00       	jmp    20e <wndProc+0xfa>


bool wndProc(AHwnd hwnd, AMessage msg)
{
    //printf(1,"desktop processing!\n");
    switch(msg.type)
     131:	83 f8 03             	cmp    $0x3,%eax
     134:	0f 84 92 00 00 00    	je     1cc <wndProc+0xb8>
     13a:	83 f8 06             	cmp    $0x6,%eax
     13d:	0f 84 99 00 00 00    	je     1dc <wndProc+0xc8>
                changePosition(VK_RIGHT,0);
                break;
            default:break;
        }
            break;
        default: break;
     143:	e9 c6 00 00 00       	jmp    20e <wndProc+0xfa>
{
    //printf(1,"desktop processing!\n");
    switch(msg.type)
    {
	case MSG_DRAWMAINWINDOW:
            return False;
     148:	b8 00 00 00 00       	mov    $0x0,%eax
     14d:	e9 d0 00 00 00       	jmp    222 <wndProc+0x10e>
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
     152:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     159:	eb 49                	jmp    1a4 <wndProc+0x90>
            {
                int off = j * GRID_W_NUMBER;
     15b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     15e:	c1 e0 04             	shl    $0x4,%eax
     161:	89 45 ec             	mov    %eax,-0x14(%ebp)
                for (int i = 0; i< GRID_W_NUMBER; i++)
     164:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     16b:	eb 2d                	jmp    19a <wndProc+0x86>
                    hwnd->Grid[off + i] = desktop_layout[j][i];
     16d:	8b 45 08             	mov    0x8(%ebp),%eax
     170:	8b 40 0c             	mov    0xc(%eax),%eax
     173:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     176:	8b 55 f0             	mov    -0x10(%ebp),%edx
     179:	01 ca                	add    %ecx,%edx
     17b:	c1 e2 02             	shl    $0x2,%edx
     17e:	01 c2                	add    %eax,%edx
     180:	8b 45 f4             	mov    -0xc(%ebp),%eax
     183:	c1 e0 04             	shl    $0x4,%eax
     186:	89 c1                	mov    %eax,%ecx
     188:	8b 45 f0             	mov    -0x10(%ebp),%eax
     18b:	01 c8                	add    %ecx,%eax
     18d:	8b 04 85 a0 2a 00 00 	mov    0x2aa0(,%eax,4),%eax
     194:	89 02                	mov    %eax,(%edx)
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
            {
                int off = j * GRID_W_NUMBER;
                for (int i = 0; i< GRID_W_NUMBER; i++)
     196:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     19a:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
     19e:	7e cd                	jle    16d <wndProc+0x59>
    {
	case MSG_DRAWMAINWINDOW:
            return False;
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
     1a0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     1a4:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
     1a8:	7e b1                	jle    15b <wndProc+0x47>
            {
                int off = j * GRID_W_NUMBER;
                for (int i = 0; i< GRID_W_NUMBER; i++)
                    hwnd->Grid[off + i] = desktop_layout[j][i];
            }
            msg.type = MSG_PAINT;
     1aa:	c7 45 0c 03 00 00 00 	movl   $0x3,0xc(%ebp)
            APSendMessage(hwnd,msg);
     1b1:	ff 75 14             	pushl  0x14(%ebp)
     1b4:	ff 75 10             	pushl  0x10(%ebp)
     1b7:	ff 75 0c             	pushl  0xc(%ebp)
     1ba:	ff 75 08             	pushl  0x8(%ebp)
     1bd:	e8 01 14 00 00       	call   15c3 <APSendMessage>
     1c2:	83 c4 10             	add    $0x10,%esp
            return False;
     1c5:	b8 00 00 00 00       	mov    $0x0,%eax
     1ca:	eb 56                	jmp    222 <wndProc+0x10e>
        case MSG_PAINT:
            APGridPaint(hwnd);
     1cc:	83 ec 0c             	sub    $0xc,%esp
     1cf:	ff 75 08             	pushl  0x8(%ebp)
     1d2:	e8 5a 17 00 00       	call   1931 <APGridPaint>
     1d7:	83 c4 10             	add    $0x10,%esp
            break;
     1da:	eb 32                	jmp    20e <wndProc+0xfa>
        case MSG_KEY_DOWN:
            printf(1,"kbd message received!\n");
     1dc:	83 ec 08             	sub    $0x8,%esp
     1df:	68 63 23 00 00       	push   $0x2363
     1e4:	6a 01                	push   $0x1
     1e6:	e8 74 04 00 00       	call   65f <printf>
     1eb:	83 c4 10             	add    $0x10,%esp
            switch (msg.param)
     1ee:	8b 45 10             	mov    0x10(%ebp),%eax
     1f1:	3d e4 00 00 00       	cmp    $0xe4,%eax
     1f6:	74 02                	je     1fa <wndProc+0xe6>
        {
            case VK_RIGHT:
                changePosition(VK_RIGHT,0);
                break;
            default:break;
     1f8:	eb 13                	jmp    20d <wndProc+0xf9>
        case MSG_KEY_DOWN:
            printf(1,"kbd message received!\n");
            switch (msg.param)
        {
            case VK_RIGHT:
                changePosition(VK_RIGHT,0);
     1fa:	83 ec 08             	sub    $0x8,%esp
     1fd:	6a 00                	push   $0x0
     1ff:	68 e4 00 00 00       	push   $0xe4
     204:	e8 77 03 00 00       	call   580 <changePosition>
     209:	83 c4 10             	add    $0x10,%esp
                break;
     20c:	90                   	nop
            default:break;
        }
            break;
     20d:	90                   	nop
        default: break;
    }
    return APWndProc(hwnd, msg);
     20e:	ff 75 14             	pushl  0x14(%ebp)
     211:	ff 75 10             	pushl  0x10(%ebp)
     214:	ff 75 0c             	pushl  0xc(%ebp)
     217:	ff 75 08             	pushl  0x8(%ebp)
     21a:	e8 12 16 00 00       	call   1831 <APWndProc>
     21f:	83 c4 10             	add    $0x10,%esp
}
     222:	c9                   	leave  
     223:	c3                   	ret    

00000224 <main>:

int main(void)
{
     224:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     228:	83 e4 f0             	and    $0xfffffff0,%esp
     22b:	ff 71 fc             	pushl  -0x4(%ecx)
     22e:	55                   	push   %ebp
     22f:	89 e5                	mov    %esp,%ebp
     231:	51                   	push   %ecx
     232:	83 ec 04             	sub    $0x4,%esp
    desktopInitStringFigure();
     235:	e8 c6 fd ff ff       	call   0 <desktopInitStringFigure>
runApp("Snack ");
     23a:	83 ec 0c             	sub    $0xc,%esp
     23d:	68 7a 23 00 00       	push   $0x237a
     242:	e8 7f fe ff ff       	call   c6 <runApp>
     247:	83 c4 10             	add    $0x10,%esp
 printf(1,"Snack running\n");
     24a:	83 ec 08             	sub    $0x8,%esp
     24d:	68 81 23 00 00       	push   $0x2381
     252:	6a 01                	push   $0x1
     254:	e8 06 04 00 00       	call   65f <printf>
     259:	83 c4 10             	add    $0x10,%esp
   // AHwnd r = APCreateWindow("desktop",True,3);
   // AHwnd hwnd = r;
    //printf(1,"desktop initialized!\n");
    //APWndExec(hwnd, wndProc);
	
    exit();
     25c:	e8 57 02 00 00       	call   4b8 <exit>

00000261 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     261:	55                   	push   %ebp
     262:	89 e5                	mov    %esp,%ebp
     264:	57                   	push   %edi
     265:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     266:	8b 4d 08             	mov    0x8(%ebp),%ecx
     269:	8b 55 10             	mov    0x10(%ebp),%edx
     26c:	8b 45 0c             	mov    0xc(%ebp),%eax
     26f:	89 cb                	mov    %ecx,%ebx
     271:	89 df                	mov    %ebx,%edi
     273:	89 d1                	mov    %edx,%ecx
     275:	fc                   	cld    
     276:	f3 aa                	rep stos %al,%es:(%edi)
     278:	89 ca                	mov    %ecx,%edx
     27a:	89 fb                	mov    %edi,%ebx
     27c:	89 5d 08             	mov    %ebx,0x8(%ebp)
     27f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     282:	90                   	nop
     283:	5b                   	pop    %ebx
     284:	5f                   	pop    %edi
     285:	5d                   	pop    %ebp
     286:	c3                   	ret    

00000287 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     287:	55                   	push   %ebp
     288:	89 e5                	mov    %esp,%ebp
     28a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     28d:	8b 45 08             	mov    0x8(%ebp),%eax
     290:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     293:	90                   	nop
     294:	8b 45 08             	mov    0x8(%ebp),%eax
     297:	8d 50 01             	lea    0x1(%eax),%edx
     29a:	89 55 08             	mov    %edx,0x8(%ebp)
     29d:	8b 55 0c             	mov    0xc(%ebp),%edx
     2a0:	8d 4a 01             	lea    0x1(%edx),%ecx
     2a3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     2a6:	0f b6 12             	movzbl (%edx),%edx
     2a9:	88 10                	mov    %dl,(%eax)
     2ab:	0f b6 00             	movzbl (%eax),%eax
     2ae:	84 c0                	test   %al,%al
     2b0:	75 e2                	jne    294 <strcpy+0xd>
    ;
  return os;
     2b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     2b5:	c9                   	leave  
     2b6:	c3                   	ret    

000002b7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     2b7:	55                   	push   %ebp
     2b8:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     2ba:	eb 08                	jmp    2c4 <strcmp+0xd>
    p++, q++;
     2bc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2c0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     2c4:	8b 45 08             	mov    0x8(%ebp),%eax
     2c7:	0f b6 00             	movzbl (%eax),%eax
     2ca:	84 c0                	test   %al,%al
     2cc:	74 10                	je     2de <strcmp+0x27>
     2ce:	8b 45 08             	mov    0x8(%ebp),%eax
     2d1:	0f b6 10             	movzbl (%eax),%edx
     2d4:	8b 45 0c             	mov    0xc(%ebp),%eax
     2d7:	0f b6 00             	movzbl (%eax),%eax
     2da:	38 c2                	cmp    %al,%dl
     2dc:	74 de                	je     2bc <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     2de:	8b 45 08             	mov    0x8(%ebp),%eax
     2e1:	0f b6 00             	movzbl (%eax),%eax
     2e4:	0f b6 d0             	movzbl %al,%edx
     2e7:	8b 45 0c             	mov    0xc(%ebp),%eax
     2ea:	0f b6 00             	movzbl (%eax),%eax
     2ed:	0f b6 c0             	movzbl %al,%eax
     2f0:	29 c2                	sub    %eax,%edx
     2f2:	89 d0                	mov    %edx,%eax
}
     2f4:	5d                   	pop    %ebp
     2f5:	c3                   	ret    

000002f6 <strlen>:

uint
strlen(char *s)
{
     2f6:	55                   	push   %ebp
     2f7:	89 e5                	mov    %esp,%ebp
     2f9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     2fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     303:	eb 04                	jmp    309 <strlen+0x13>
     305:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     309:	8b 55 fc             	mov    -0x4(%ebp),%edx
     30c:	8b 45 08             	mov    0x8(%ebp),%eax
     30f:	01 d0                	add    %edx,%eax
     311:	0f b6 00             	movzbl (%eax),%eax
     314:	84 c0                	test   %al,%al
     316:	75 ed                	jne    305 <strlen+0xf>
    ;
  return n;
     318:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     31b:	c9                   	leave  
     31c:	c3                   	ret    

0000031d <memset>:

void*
memset(void *dst, int c, uint n)
{
     31d:	55                   	push   %ebp
     31e:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     320:	8b 45 10             	mov    0x10(%ebp),%eax
     323:	50                   	push   %eax
     324:	ff 75 0c             	pushl  0xc(%ebp)
     327:	ff 75 08             	pushl  0x8(%ebp)
     32a:	e8 32 ff ff ff       	call   261 <stosb>
     32f:	83 c4 0c             	add    $0xc,%esp
  return dst;
     332:	8b 45 08             	mov    0x8(%ebp),%eax
}
     335:	c9                   	leave  
     336:	c3                   	ret    

00000337 <strchr>:

char*
strchr(const char *s, char c)
{
     337:	55                   	push   %ebp
     338:	89 e5                	mov    %esp,%ebp
     33a:	83 ec 04             	sub    $0x4,%esp
     33d:	8b 45 0c             	mov    0xc(%ebp),%eax
     340:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     343:	eb 14                	jmp    359 <strchr+0x22>
    if(*s == c)
     345:	8b 45 08             	mov    0x8(%ebp),%eax
     348:	0f b6 00             	movzbl (%eax),%eax
     34b:	3a 45 fc             	cmp    -0x4(%ebp),%al
     34e:	75 05                	jne    355 <strchr+0x1e>
      return (char*)s;
     350:	8b 45 08             	mov    0x8(%ebp),%eax
     353:	eb 13                	jmp    368 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     355:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     359:	8b 45 08             	mov    0x8(%ebp),%eax
     35c:	0f b6 00             	movzbl (%eax),%eax
     35f:	84 c0                	test   %al,%al
     361:	75 e2                	jne    345 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     363:	b8 00 00 00 00       	mov    $0x0,%eax
}
     368:	c9                   	leave  
     369:	c3                   	ret    

0000036a <gets>:

char*
gets(char *buf, int max)
{
     36a:	55                   	push   %ebp
     36b:	89 e5                	mov    %esp,%ebp
     36d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     370:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     377:	eb 42                	jmp    3bb <gets+0x51>
    cc = read(0, &c, 1);
     379:	83 ec 04             	sub    $0x4,%esp
     37c:	6a 01                	push   $0x1
     37e:	8d 45 ef             	lea    -0x11(%ebp),%eax
     381:	50                   	push   %eax
     382:	6a 00                	push   $0x0
     384:	e8 47 01 00 00       	call   4d0 <read>
     389:	83 c4 10             	add    $0x10,%esp
     38c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     38f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     393:	7e 33                	jle    3c8 <gets+0x5e>
      break;
    buf[i++] = c;
     395:	8b 45 f4             	mov    -0xc(%ebp),%eax
     398:	8d 50 01             	lea    0x1(%eax),%edx
     39b:	89 55 f4             	mov    %edx,-0xc(%ebp)
     39e:	89 c2                	mov    %eax,%edx
     3a0:	8b 45 08             	mov    0x8(%ebp),%eax
     3a3:	01 c2                	add    %eax,%edx
     3a5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     3a9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     3ab:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     3af:	3c 0a                	cmp    $0xa,%al
     3b1:	74 16                	je     3c9 <gets+0x5f>
     3b3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     3b7:	3c 0d                	cmp    $0xd,%al
     3b9:	74 0e                	je     3c9 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     3bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3be:	83 c0 01             	add    $0x1,%eax
     3c1:	3b 45 0c             	cmp    0xc(%ebp),%eax
     3c4:	7c b3                	jl     379 <gets+0xf>
     3c6:	eb 01                	jmp    3c9 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     3c8:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     3c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     3cc:	8b 45 08             	mov    0x8(%ebp),%eax
     3cf:	01 d0                	add    %edx,%eax
     3d1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     3d4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     3d7:	c9                   	leave  
     3d8:	c3                   	ret    

000003d9 <stat>:

int
stat(char *n, struct stat *st)
{
     3d9:	55                   	push   %ebp
     3da:	89 e5                	mov    %esp,%ebp
     3dc:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3df:	83 ec 08             	sub    $0x8,%esp
     3e2:	6a 00                	push   $0x0
     3e4:	ff 75 08             	pushl  0x8(%ebp)
     3e7:	e8 0c 01 00 00       	call   4f8 <open>
     3ec:	83 c4 10             	add    $0x10,%esp
     3ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     3f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3f6:	79 07                	jns    3ff <stat+0x26>
    return -1;
     3f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     3fd:	eb 25                	jmp    424 <stat+0x4b>
  r = fstat(fd, st);
     3ff:	83 ec 08             	sub    $0x8,%esp
     402:	ff 75 0c             	pushl  0xc(%ebp)
     405:	ff 75 f4             	pushl  -0xc(%ebp)
     408:	e8 03 01 00 00       	call   510 <fstat>
     40d:	83 c4 10             	add    $0x10,%esp
     410:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     413:	83 ec 0c             	sub    $0xc,%esp
     416:	ff 75 f4             	pushl  -0xc(%ebp)
     419:	e8 c2 00 00 00       	call   4e0 <close>
     41e:	83 c4 10             	add    $0x10,%esp
  return r;
     421:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     424:	c9                   	leave  
     425:	c3                   	ret    

00000426 <atoi>:

int
atoi(const char *s)
{
     426:	55                   	push   %ebp
     427:	89 e5                	mov    %esp,%ebp
     429:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     42c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     433:	eb 25                	jmp    45a <atoi+0x34>
    n = n*10 + *s++ - '0';
     435:	8b 55 fc             	mov    -0x4(%ebp),%edx
     438:	89 d0                	mov    %edx,%eax
     43a:	c1 e0 02             	shl    $0x2,%eax
     43d:	01 d0                	add    %edx,%eax
     43f:	01 c0                	add    %eax,%eax
     441:	89 c1                	mov    %eax,%ecx
     443:	8b 45 08             	mov    0x8(%ebp),%eax
     446:	8d 50 01             	lea    0x1(%eax),%edx
     449:	89 55 08             	mov    %edx,0x8(%ebp)
     44c:	0f b6 00             	movzbl (%eax),%eax
     44f:	0f be c0             	movsbl %al,%eax
     452:	01 c8                	add    %ecx,%eax
     454:	83 e8 30             	sub    $0x30,%eax
     457:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     45a:	8b 45 08             	mov    0x8(%ebp),%eax
     45d:	0f b6 00             	movzbl (%eax),%eax
     460:	3c 2f                	cmp    $0x2f,%al
     462:	7e 0a                	jle    46e <atoi+0x48>
     464:	8b 45 08             	mov    0x8(%ebp),%eax
     467:	0f b6 00             	movzbl (%eax),%eax
     46a:	3c 39                	cmp    $0x39,%al
     46c:	7e c7                	jle    435 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     46e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     471:	c9                   	leave  
     472:	c3                   	ret    

00000473 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     473:	55                   	push   %ebp
     474:	89 e5                	mov    %esp,%ebp
     476:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     479:	8b 45 08             	mov    0x8(%ebp),%eax
     47c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     47f:	8b 45 0c             	mov    0xc(%ebp),%eax
     482:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     485:	eb 17                	jmp    49e <memmove+0x2b>
    *dst++ = *src++;
     487:	8b 45 fc             	mov    -0x4(%ebp),%eax
     48a:	8d 50 01             	lea    0x1(%eax),%edx
     48d:	89 55 fc             	mov    %edx,-0x4(%ebp)
     490:	8b 55 f8             	mov    -0x8(%ebp),%edx
     493:	8d 4a 01             	lea    0x1(%edx),%ecx
     496:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     499:	0f b6 12             	movzbl (%edx),%edx
     49c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     49e:	8b 45 10             	mov    0x10(%ebp),%eax
     4a1:	8d 50 ff             	lea    -0x1(%eax),%edx
     4a4:	89 55 10             	mov    %edx,0x10(%ebp)
     4a7:	85 c0                	test   %eax,%eax
     4a9:	7f dc                	jg     487 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     4ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
     4ae:	c9                   	leave  
     4af:	c3                   	ret    

000004b0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     4b0:	b8 01 00 00 00       	mov    $0x1,%eax
     4b5:	cd 40                	int    $0x40
     4b7:	c3                   	ret    

000004b8 <exit>:
SYSCALL(exit)
     4b8:	b8 02 00 00 00       	mov    $0x2,%eax
     4bd:	cd 40                	int    $0x40
     4bf:	c3                   	ret    

000004c0 <wait>:
SYSCALL(wait)
     4c0:	b8 03 00 00 00       	mov    $0x3,%eax
     4c5:	cd 40                	int    $0x40
     4c7:	c3                   	ret    

000004c8 <pipe>:
SYSCALL(pipe)
     4c8:	b8 04 00 00 00       	mov    $0x4,%eax
     4cd:	cd 40                	int    $0x40
     4cf:	c3                   	ret    

000004d0 <read>:
SYSCALL(read)
     4d0:	b8 05 00 00 00       	mov    $0x5,%eax
     4d5:	cd 40                	int    $0x40
     4d7:	c3                   	ret    

000004d8 <write>:
SYSCALL(write)
     4d8:	b8 10 00 00 00       	mov    $0x10,%eax
     4dd:	cd 40                	int    $0x40
     4df:	c3                   	ret    

000004e0 <close>:
SYSCALL(close)
     4e0:	b8 15 00 00 00       	mov    $0x15,%eax
     4e5:	cd 40                	int    $0x40
     4e7:	c3                   	ret    

000004e8 <kill>:
SYSCALL(kill)
     4e8:	b8 06 00 00 00       	mov    $0x6,%eax
     4ed:	cd 40                	int    $0x40
     4ef:	c3                   	ret    

000004f0 <exec>:
SYSCALL(exec)
     4f0:	b8 07 00 00 00       	mov    $0x7,%eax
     4f5:	cd 40                	int    $0x40
     4f7:	c3                   	ret    

000004f8 <open>:
SYSCALL(open)
     4f8:	b8 0f 00 00 00       	mov    $0xf,%eax
     4fd:	cd 40                	int    $0x40
     4ff:	c3                   	ret    

00000500 <mknod>:
SYSCALL(mknod)
     500:	b8 11 00 00 00       	mov    $0x11,%eax
     505:	cd 40                	int    $0x40
     507:	c3                   	ret    

00000508 <unlink>:
SYSCALL(unlink)
     508:	b8 12 00 00 00       	mov    $0x12,%eax
     50d:	cd 40                	int    $0x40
     50f:	c3                   	ret    

00000510 <fstat>:
SYSCALL(fstat)
     510:	b8 08 00 00 00       	mov    $0x8,%eax
     515:	cd 40                	int    $0x40
     517:	c3                   	ret    

00000518 <link>:
SYSCALL(link)
     518:	b8 13 00 00 00       	mov    $0x13,%eax
     51d:	cd 40                	int    $0x40
     51f:	c3                   	ret    

00000520 <mkdir>:
SYSCALL(mkdir)
     520:	b8 14 00 00 00       	mov    $0x14,%eax
     525:	cd 40                	int    $0x40
     527:	c3                   	ret    

00000528 <chdir>:
SYSCALL(chdir)
     528:	b8 09 00 00 00       	mov    $0x9,%eax
     52d:	cd 40                	int    $0x40
     52f:	c3                   	ret    

00000530 <dup>:
SYSCALL(dup)
     530:	b8 0a 00 00 00       	mov    $0xa,%eax
     535:	cd 40                	int    $0x40
     537:	c3                   	ret    

00000538 <getpid>:
SYSCALL(getpid)
     538:	b8 0b 00 00 00       	mov    $0xb,%eax
     53d:	cd 40                	int    $0x40
     53f:	c3                   	ret    

00000540 <sbrk>:
SYSCALL(sbrk)
     540:	b8 0c 00 00 00       	mov    $0xc,%eax
     545:	cd 40                	int    $0x40
     547:	c3                   	ret    

00000548 <sleep>:
SYSCALL(sleep)
     548:	b8 0d 00 00 00       	mov    $0xd,%eax
     54d:	cd 40                	int    $0x40
     54f:	c3                   	ret    

00000550 <uptime>:
SYSCALL(uptime)
     550:	b8 0e 00 00 00       	mov    $0xe,%eax
     555:	cd 40                	int    $0x40
     557:	c3                   	ret    

00000558 <paintWindow>:

SYSCALL(paintWindow)
     558:	b8 16 00 00 00       	mov    $0x16,%eax
     55d:	cd 40                	int    $0x40
     55f:	c3                   	ret    

00000560 <initStringFigure>:
SYSCALL(initStringFigure)
     560:	b8 17 00 00 00       	mov    $0x17,%eax
     565:	cd 40                	int    $0x40
     567:	c3                   	ret    

00000568 <sendMessage>:
SYSCALL(sendMessage)
     568:	b8 18 00 00 00       	mov    $0x18,%eax
     56d:	cd 40                	int    $0x40
     56f:	c3                   	ret    

00000570 <getMessage>:
SYSCALL(getMessage)
     570:	b8 1a 00 00 00       	mov    $0x1a,%eax
     575:	cd 40                	int    $0x40
     577:	c3                   	ret    

00000578 <registWindow>:
SYSCALL(registWindow)
     578:	b8 19 00 00 00       	mov    $0x19,%eax
     57d:	cd 40                	int    $0x40
     57f:	c3                   	ret    

00000580 <changePosition>:
SYSCALL(changePosition)
     580:	b8 1b 00 00 00       	mov    $0x1b,%eax
     585:	cd 40                	int    $0x40
     587:	c3                   	ret    

00000588 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     588:	55                   	push   %ebp
     589:	89 e5                	mov    %esp,%ebp
     58b:	83 ec 18             	sub    $0x18,%esp
     58e:	8b 45 0c             	mov    0xc(%ebp),%eax
     591:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     594:	83 ec 04             	sub    $0x4,%esp
     597:	6a 01                	push   $0x1
     599:	8d 45 f4             	lea    -0xc(%ebp),%eax
     59c:	50                   	push   %eax
     59d:	ff 75 08             	pushl  0x8(%ebp)
     5a0:	e8 33 ff ff ff       	call   4d8 <write>
     5a5:	83 c4 10             	add    $0x10,%esp
}
     5a8:	90                   	nop
     5a9:	c9                   	leave  
     5aa:	c3                   	ret    

000005ab <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     5ab:	55                   	push   %ebp
     5ac:	89 e5                	mov    %esp,%ebp
     5ae:	53                   	push   %ebx
     5af:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     5b2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     5b9:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     5bd:	74 17                	je     5d6 <printint+0x2b>
     5bf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     5c3:	79 11                	jns    5d6 <printint+0x2b>
    neg = 1;
     5c5:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     5cc:	8b 45 0c             	mov    0xc(%ebp),%eax
     5cf:	f7 d8                	neg    %eax
     5d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
     5d4:	eb 06                	jmp    5dc <printint+0x31>
  } else {
    x = xx;
     5d6:	8b 45 0c             	mov    0xc(%ebp),%eax
     5d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     5dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     5e3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     5e6:	8d 41 01             	lea    0x1(%ecx),%eax
     5e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
     5ec:	8b 5d 10             	mov    0x10(%ebp),%ebx
     5ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
     5f2:	ba 00 00 00 00       	mov    $0x0,%edx
     5f7:	f7 f3                	div    %ebx
     5f9:	89 d0                	mov    %edx,%eax
     5fb:	0f b6 80 60 2d 00 00 	movzbl 0x2d60(%eax),%eax
     602:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     606:	8b 5d 10             	mov    0x10(%ebp),%ebx
     609:	8b 45 ec             	mov    -0x14(%ebp),%eax
     60c:	ba 00 00 00 00       	mov    $0x0,%edx
     611:	f7 f3                	div    %ebx
     613:	89 45 ec             	mov    %eax,-0x14(%ebp)
     616:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     61a:	75 c7                	jne    5e3 <printint+0x38>
  if(neg)
     61c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     620:	74 2d                	je     64f <printint+0xa4>
    buf[i++] = '-';
     622:	8b 45 f4             	mov    -0xc(%ebp),%eax
     625:	8d 50 01             	lea    0x1(%eax),%edx
     628:	89 55 f4             	mov    %edx,-0xc(%ebp)
     62b:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     630:	eb 1d                	jmp    64f <printint+0xa4>
    putc(fd, buf[i]);
     632:	8d 55 dc             	lea    -0x24(%ebp),%edx
     635:	8b 45 f4             	mov    -0xc(%ebp),%eax
     638:	01 d0                	add    %edx,%eax
     63a:	0f b6 00             	movzbl (%eax),%eax
     63d:	0f be c0             	movsbl %al,%eax
     640:	83 ec 08             	sub    $0x8,%esp
     643:	50                   	push   %eax
     644:	ff 75 08             	pushl  0x8(%ebp)
     647:	e8 3c ff ff ff       	call   588 <putc>
     64c:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     64f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     653:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     657:	79 d9                	jns    632 <printint+0x87>
    putc(fd, buf[i]);
}
     659:	90                   	nop
     65a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     65d:	c9                   	leave  
     65e:	c3                   	ret    

0000065f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     65f:	55                   	push   %ebp
     660:	89 e5                	mov    %esp,%ebp
     662:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     665:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     66c:	8d 45 0c             	lea    0xc(%ebp),%eax
     66f:	83 c0 04             	add    $0x4,%eax
     672:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     675:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     67c:	e9 59 01 00 00       	jmp    7da <printf+0x17b>
    c = fmt[i] & 0xff;
     681:	8b 55 0c             	mov    0xc(%ebp),%edx
     684:	8b 45 f0             	mov    -0x10(%ebp),%eax
     687:	01 d0                	add    %edx,%eax
     689:	0f b6 00             	movzbl (%eax),%eax
     68c:	0f be c0             	movsbl %al,%eax
     68f:	25 ff 00 00 00       	and    $0xff,%eax
     694:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     697:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     69b:	75 2c                	jne    6c9 <printf+0x6a>
      if(c == '%'){
     69d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     6a1:	75 0c                	jne    6af <printf+0x50>
        state = '%';
     6a3:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     6aa:	e9 27 01 00 00       	jmp    7d6 <printf+0x177>
      } else {
        putc(fd, c);
     6af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6b2:	0f be c0             	movsbl %al,%eax
     6b5:	83 ec 08             	sub    $0x8,%esp
     6b8:	50                   	push   %eax
     6b9:	ff 75 08             	pushl  0x8(%ebp)
     6bc:	e8 c7 fe ff ff       	call   588 <putc>
     6c1:	83 c4 10             	add    $0x10,%esp
     6c4:	e9 0d 01 00 00       	jmp    7d6 <printf+0x177>
      }
    } else if(state == '%'){
     6c9:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     6cd:	0f 85 03 01 00 00    	jne    7d6 <printf+0x177>
      if(c == 'd'){
     6d3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     6d7:	75 1e                	jne    6f7 <printf+0x98>
        printint(fd, *ap, 10, 1);
     6d9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6dc:	8b 00                	mov    (%eax),%eax
     6de:	6a 01                	push   $0x1
     6e0:	6a 0a                	push   $0xa
     6e2:	50                   	push   %eax
     6e3:	ff 75 08             	pushl  0x8(%ebp)
     6e6:	e8 c0 fe ff ff       	call   5ab <printint>
     6eb:	83 c4 10             	add    $0x10,%esp
        ap++;
     6ee:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     6f2:	e9 d8 00 00 00       	jmp    7cf <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     6f7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     6fb:	74 06                	je     703 <printf+0xa4>
     6fd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     701:	75 1e                	jne    721 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     703:	8b 45 e8             	mov    -0x18(%ebp),%eax
     706:	8b 00                	mov    (%eax),%eax
     708:	6a 00                	push   $0x0
     70a:	6a 10                	push   $0x10
     70c:	50                   	push   %eax
     70d:	ff 75 08             	pushl  0x8(%ebp)
     710:	e8 96 fe ff ff       	call   5ab <printint>
     715:	83 c4 10             	add    $0x10,%esp
        ap++;
     718:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     71c:	e9 ae 00 00 00       	jmp    7cf <printf+0x170>
      } else if(c == 's'){
     721:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     725:	75 43                	jne    76a <printf+0x10b>
        s = (char*)*ap;
     727:	8b 45 e8             	mov    -0x18(%ebp),%eax
     72a:	8b 00                	mov    (%eax),%eax
     72c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     72f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     733:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     737:	75 25                	jne    75e <printf+0xff>
          s = "(null)";
     739:	c7 45 f4 90 23 00 00 	movl   $0x2390,-0xc(%ebp)
        while(*s != 0){
     740:	eb 1c                	jmp    75e <printf+0xff>
          putc(fd, *s);
     742:	8b 45 f4             	mov    -0xc(%ebp),%eax
     745:	0f b6 00             	movzbl (%eax),%eax
     748:	0f be c0             	movsbl %al,%eax
     74b:	83 ec 08             	sub    $0x8,%esp
     74e:	50                   	push   %eax
     74f:	ff 75 08             	pushl  0x8(%ebp)
     752:	e8 31 fe ff ff       	call   588 <putc>
     757:	83 c4 10             	add    $0x10,%esp
          s++;
     75a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     75e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     761:	0f b6 00             	movzbl (%eax),%eax
     764:	84 c0                	test   %al,%al
     766:	75 da                	jne    742 <printf+0xe3>
     768:	eb 65                	jmp    7cf <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     76a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     76e:	75 1d                	jne    78d <printf+0x12e>
        putc(fd, *ap);
     770:	8b 45 e8             	mov    -0x18(%ebp),%eax
     773:	8b 00                	mov    (%eax),%eax
     775:	0f be c0             	movsbl %al,%eax
     778:	83 ec 08             	sub    $0x8,%esp
     77b:	50                   	push   %eax
     77c:	ff 75 08             	pushl  0x8(%ebp)
     77f:	e8 04 fe ff ff       	call   588 <putc>
     784:	83 c4 10             	add    $0x10,%esp
        ap++;
     787:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     78b:	eb 42                	jmp    7cf <printf+0x170>
      } else if(c == '%'){
     78d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     791:	75 17                	jne    7aa <printf+0x14b>
        putc(fd, c);
     793:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     796:	0f be c0             	movsbl %al,%eax
     799:	83 ec 08             	sub    $0x8,%esp
     79c:	50                   	push   %eax
     79d:	ff 75 08             	pushl  0x8(%ebp)
     7a0:	e8 e3 fd ff ff       	call   588 <putc>
     7a5:	83 c4 10             	add    $0x10,%esp
     7a8:	eb 25                	jmp    7cf <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     7aa:	83 ec 08             	sub    $0x8,%esp
     7ad:	6a 25                	push   $0x25
     7af:	ff 75 08             	pushl  0x8(%ebp)
     7b2:	e8 d1 fd ff ff       	call   588 <putc>
     7b7:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     7ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7bd:	0f be c0             	movsbl %al,%eax
     7c0:	83 ec 08             	sub    $0x8,%esp
     7c3:	50                   	push   %eax
     7c4:	ff 75 08             	pushl  0x8(%ebp)
     7c7:	e8 bc fd ff ff       	call   588 <putc>
     7cc:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     7cf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     7d6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     7da:	8b 55 0c             	mov    0xc(%ebp),%edx
     7dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e0:	01 d0                	add    %edx,%eax
     7e2:	0f b6 00             	movzbl (%eax),%eax
     7e5:	84 c0                	test   %al,%al
     7e7:	0f 85 94 fe ff ff    	jne    681 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     7ed:	90                   	nop
     7ee:	c9                   	leave  
     7ef:	c3                   	ret    

000007f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     7f0:	55                   	push   %ebp
     7f1:	89 e5                	mov    %esp,%ebp
     7f3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     7f6:	8b 45 08             	mov    0x8(%ebp),%eax
     7f9:	83 e8 08             	sub    $0x8,%eax
     7fc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     7ff:	a1 94 2d 00 00       	mov    0x2d94,%eax
     804:	89 45 fc             	mov    %eax,-0x4(%ebp)
     807:	eb 24                	jmp    82d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     809:	8b 45 fc             	mov    -0x4(%ebp),%eax
     80c:	8b 00                	mov    (%eax),%eax
     80e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     811:	77 12                	ja     825 <free+0x35>
     813:	8b 45 f8             	mov    -0x8(%ebp),%eax
     816:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     819:	77 24                	ja     83f <free+0x4f>
     81b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     81e:	8b 00                	mov    (%eax),%eax
     820:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     823:	77 1a                	ja     83f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     825:	8b 45 fc             	mov    -0x4(%ebp),%eax
     828:	8b 00                	mov    (%eax),%eax
     82a:	89 45 fc             	mov    %eax,-0x4(%ebp)
     82d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     830:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     833:	76 d4                	jbe    809 <free+0x19>
     835:	8b 45 fc             	mov    -0x4(%ebp),%eax
     838:	8b 00                	mov    (%eax),%eax
     83a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     83d:	76 ca                	jbe    809 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     83f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     842:	8b 40 04             	mov    0x4(%eax),%eax
     845:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     84c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     84f:	01 c2                	add    %eax,%edx
     851:	8b 45 fc             	mov    -0x4(%ebp),%eax
     854:	8b 00                	mov    (%eax),%eax
     856:	39 c2                	cmp    %eax,%edx
     858:	75 24                	jne    87e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     85a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     85d:	8b 50 04             	mov    0x4(%eax),%edx
     860:	8b 45 fc             	mov    -0x4(%ebp),%eax
     863:	8b 00                	mov    (%eax),%eax
     865:	8b 40 04             	mov    0x4(%eax),%eax
     868:	01 c2                	add    %eax,%edx
     86a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     86d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     870:	8b 45 fc             	mov    -0x4(%ebp),%eax
     873:	8b 00                	mov    (%eax),%eax
     875:	8b 10                	mov    (%eax),%edx
     877:	8b 45 f8             	mov    -0x8(%ebp),%eax
     87a:	89 10                	mov    %edx,(%eax)
     87c:	eb 0a                	jmp    888 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     87e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     881:	8b 10                	mov    (%eax),%edx
     883:	8b 45 f8             	mov    -0x8(%ebp),%eax
     886:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     888:	8b 45 fc             	mov    -0x4(%ebp),%eax
     88b:	8b 40 04             	mov    0x4(%eax),%eax
     88e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     895:	8b 45 fc             	mov    -0x4(%ebp),%eax
     898:	01 d0                	add    %edx,%eax
     89a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     89d:	75 20                	jne    8bf <free+0xcf>
    p->s.size += bp->s.size;
     89f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8a2:	8b 50 04             	mov    0x4(%eax),%edx
     8a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8a8:	8b 40 04             	mov    0x4(%eax),%eax
     8ab:	01 c2                	add    %eax,%edx
     8ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8b0:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     8b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8b6:	8b 10                	mov    (%eax),%edx
     8b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8bb:	89 10                	mov    %edx,(%eax)
     8bd:	eb 08                	jmp    8c7 <free+0xd7>
  } else
    p->s.ptr = bp;
     8bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8c2:	8b 55 f8             	mov    -0x8(%ebp),%edx
     8c5:	89 10                	mov    %edx,(%eax)
  freep = p;
     8c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8ca:	a3 94 2d 00 00       	mov    %eax,0x2d94
}
     8cf:	90                   	nop
     8d0:	c9                   	leave  
     8d1:	c3                   	ret    

000008d2 <morecore>:

static Header*
morecore(uint nu)
{
     8d2:	55                   	push   %ebp
     8d3:	89 e5                	mov    %esp,%ebp
     8d5:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     8d8:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     8df:	77 07                	ja     8e8 <morecore+0x16>
    nu = 4096;
     8e1:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     8e8:	8b 45 08             	mov    0x8(%ebp),%eax
     8eb:	c1 e0 03             	shl    $0x3,%eax
     8ee:	83 ec 0c             	sub    $0xc,%esp
     8f1:	50                   	push   %eax
     8f2:	e8 49 fc ff ff       	call   540 <sbrk>
     8f7:	83 c4 10             	add    $0x10,%esp
     8fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     8fd:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     901:	75 07                	jne    90a <morecore+0x38>
    return 0;
     903:	b8 00 00 00 00       	mov    $0x0,%eax
     908:	eb 26                	jmp    930 <morecore+0x5e>
  hp = (Header*)p;
     90a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     90d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     910:	8b 45 f0             	mov    -0x10(%ebp),%eax
     913:	8b 55 08             	mov    0x8(%ebp),%edx
     916:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     919:	8b 45 f0             	mov    -0x10(%ebp),%eax
     91c:	83 c0 08             	add    $0x8,%eax
     91f:	83 ec 0c             	sub    $0xc,%esp
     922:	50                   	push   %eax
     923:	e8 c8 fe ff ff       	call   7f0 <free>
     928:	83 c4 10             	add    $0x10,%esp
  return freep;
     92b:	a1 94 2d 00 00       	mov    0x2d94,%eax
}
     930:	c9                   	leave  
     931:	c3                   	ret    

00000932 <malloc>:

void*
malloc(uint nbytes)
{
     932:	55                   	push   %ebp
     933:	89 e5                	mov    %esp,%ebp
     935:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     938:	8b 45 08             	mov    0x8(%ebp),%eax
     93b:	83 c0 07             	add    $0x7,%eax
     93e:	c1 e8 03             	shr    $0x3,%eax
     941:	83 c0 01             	add    $0x1,%eax
     944:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     947:	a1 94 2d 00 00       	mov    0x2d94,%eax
     94c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     94f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     953:	75 23                	jne    978 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     955:	c7 45 f0 8c 2d 00 00 	movl   $0x2d8c,-0x10(%ebp)
     95c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     95f:	a3 94 2d 00 00       	mov    %eax,0x2d94
     964:	a1 94 2d 00 00       	mov    0x2d94,%eax
     969:	a3 8c 2d 00 00       	mov    %eax,0x2d8c
    base.s.size = 0;
     96e:	c7 05 90 2d 00 00 00 	movl   $0x0,0x2d90
     975:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     978:	8b 45 f0             	mov    -0x10(%ebp),%eax
     97b:	8b 00                	mov    (%eax),%eax
     97d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     980:	8b 45 f4             	mov    -0xc(%ebp),%eax
     983:	8b 40 04             	mov    0x4(%eax),%eax
     986:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     989:	72 4d                	jb     9d8 <malloc+0xa6>
      if(p->s.size == nunits)
     98b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     98e:	8b 40 04             	mov    0x4(%eax),%eax
     991:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     994:	75 0c                	jne    9a2 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     996:	8b 45 f4             	mov    -0xc(%ebp),%eax
     999:	8b 10                	mov    (%eax),%edx
     99b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     99e:	89 10                	mov    %edx,(%eax)
     9a0:	eb 26                	jmp    9c8 <malloc+0x96>
      else {
        p->s.size -= nunits;
     9a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9a5:	8b 40 04             	mov    0x4(%eax),%eax
     9a8:	2b 45 ec             	sub    -0x14(%ebp),%eax
     9ab:	89 c2                	mov    %eax,%edx
     9ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9b0:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     9b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9b6:	8b 40 04             	mov    0x4(%eax),%eax
     9b9:	c1 e0 03             	shl    $0x3,%eax
     9bc:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     9bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9c2:	8b 55 ec             	mov    -0x14(%ebp),%edx
     9c5:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     9c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9cb:	a3 94 2d 00 00       	mov    %eax,0x2d94
      return (void*)(p + 1);
     9d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9d3:	83 c0 08             	add    $0x8,%eax
     9d6:	eb 3b                	jmp    a13 <malloc+0xe1>
    }
    if(p == freep)
     9d8:	a1 94 2d 00 00       	mov    0x2d94,%eax
     9dd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     9e0:	75 1e                	jne    a00 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     9e2:	83 ec 0c             	sub    $0xc,%esp
     9e5:	ff 75 ec             	pushl  -0x14(%ebp)
     9e8:	e8 e5 fe ff ff       	call   8d2 <morecore>
     9ed:	83 c4 10             	add    $0x10,%esp
     9f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
     9f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     9f7:	75 07                	jne    a00 <malloc+0xce>
        return 0;
     9f9:	b8 00 00 00 00       	mov    $0x0,%eax
     9fe:	eb 13                	jmp    a13 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a00:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a03:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a06:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a09:	8b 00                	mov    (%eax),%eax
     a0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     a0e:	e9 6d ff ff ff       	jmp    980 <malloc+0x4e>
}
     a13:	c9                   	leave  
     a14:	c3                   	ret    

00000a15 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     a15:	55                   	push   %ebp
     a16:	89 e5                	mov    %esp,%ebp
     a18:	83 ec 1c             	sub    $0x1c,%esp
     a1b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     a1e:	8b 55 10             	mov    0x10(%ebp),%edx
     a21:	8b 45 14             	mov    0x14(%ebp),%eax
     a24:	88 4d ec             	mov    %cl,-0x14(%ebp)
     a27:	88 55 e8             	mov    %dl,-0x18(%ebp)
     a2a:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     a2d:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     a31:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     a34:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     a38:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     a3b:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     a3f:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     a42:	8b 45 08             	mov    0x8(%ebp),%eax
     a45:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     a49:	66 89 10             	mov    %dx,(%eax)
     a4c:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     a50:	88 50 02             	mov    %dl,0x2(%eax)
}
     a53:	8b 45 08             	mov    0x8(%ebp),%eax
     a56:	c9                   	leave  
     a57:	c2 04 00             	ret    $0x4

00000a5a <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     a5a:	55                   	push   %ebp
     a5b:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     a5d:	8b 45 08             	mov    0x8(%ebp),%eax
     a60:	2b 45 10             	sub    0x10(%ebp),%eax
     a63:	89 c2                	mov    %eax,%edx
     a65:	8b 45 08             	mov    0x8(%ebp),%eax
     a68:	2b 45 10             	sub    0x10(%ebp),%eax
     a6b:	0f af d0             	imul   %eax,%edx
     a6e:	8b 45 0c             	mov    0xc(%ebp),%eax
     a71:	2b 45 14             	sub    0x14(%ebp),%eax
     a74:	89 c1                	mov    %eax,%ecx
     a76:	8b 45 0c             	mov    0xc(%ebp),%eax
     a79:	2b 45 14             	sub    0x14(%ebp),%eax
     a7c:	0f af c1             	imul   %ecx,%eax
     a7f:	01 d0                	add    %edx,%eax
}
     a81:	5d                   	pop    %ebp
     a82:	c3                   	ret    

00000a83 <abs_int>:

static inline int abs_int(int x)
{
     a83:	55                   	push   %ebp
     a84:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     a86:	8b 45 08             	mov    0x8(%ebp),%eax
     a89:	99                   	cltd   
     a8a:	89 d0                	mov    %edx,%eax
     a8c:	33 45 08             	xor    0x8(%ebp),%eax
     a8f:	29 d0                	sub    %edx,%eax
}
     a91:	5d                   	pop    %ebp
     a92:	c3                   	ret    

00000a93 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     a93:	55                   	push   %ebp
     a94:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     a96:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     a9a:	79 07                	jns    aa3 <APGetIndex+0x10>
        return X_SMALLER;
     a9c:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     aa1:	eb 40                	jmp    ae3 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     aa3:	8b 45 08             	mov    0x8(%ebp),%eax
     aa6:	8b 00                	mov    (%eax),%eax
     aa8:	3b 45 0c             	cmp    0xc(%ebp),%eax
     aab:	7f 07                	jg     ab4 <APGetIndex+0x21>
        return X_BIGGER;
     aad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     ab2:	eb 2f                	jmp    ae3 <APGetIndex+0x50>
    if (y < 0)
     ab4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     ab8:	79 07                	jns    ac1 <APGetIndex+0x2e>
        return Y_SMALLER;
     aba:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     abf:	eb 22                	jmp    ae3 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     ac1:	8b 45 08             	mov    0x8(%ebp),%eax
     ac4:	8b 40 04             	mov    0x4(%eax),%eax
     ac7:	3b 45 10             	cmp    0x10(%ebp),%eax
     aca:	7f 07                	jg     ad3 <APGetIndex+0x40>
        return Y_BIGGER;
     acc:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     ad1:	eb 10                	jmp    ae3 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     ad3:	8b 45 08             	mov    0x8(%ebp),%eax
     ad6:	8b 00                	mov    (%eax),%eax
     ad8:	0f af 45 10          	imul   0x10(%ebp),%eax
     adc:	89 c2                	mov    %eax,%edx
     ade:	8b 45 0c             	mov    0xc(%ebp),%eax
     ae1:	01 d0                	add    %edx,%eax
}
     ae3:	5d                   	pop    %ebp
     ae4:	c3                   	ret    

00000ae5 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     ae5:	55                   	push   %ebp
     ae6:	89 e5                	mov    %esp,%ebp
     ae8:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     aeb:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     af2:	8b 45 cc             	mov    -0x34(%ebp),%eax
     af5:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     af8:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     aff:	83 ec 08             	sub    $0x8,%esp
     b02:	6a 00                	push   $0x0
     b04:	ff 75 0c             	pushl  0xc(%ebp)
     b07:	e8 ec f9 ff ff       	call   4f8 <open>
     b0c:	83 c4 10             	add    $0x10,%esp
     b0f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     b12:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     b16:	79 2e                	jns    b46 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     b18:	83 ec 04             	sub    $0x4,%esp
     b1b:	ff 75 0c             	pushl  0xc(%ebp)
     b1e:	68 97 23 00 00       	push   $0x2397
     b23:	6a 01                	push   $0x1
     b25:	e8 35 fb ff ff       	call   65f <printf>
     b2a:	83 c4 10             	add    $0x10,%esp
        return bmp;
     b2d:	8b 45 08             	mov    0x8(%ebp),%eax
     b30:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b33:	89 10                	mov    %edx,(%eax)
     b35:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b38:	89 50 04             	mov    %edx,0x4(%eax)
     b3b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b3e:	89 50 08             	mov    %edx,0x8(%eax)
     b41:	e9 d2 01 00 00       	jmp    d18 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     b46:	83 ec 04             	sub    $0x4,%esp
     b49:	6a 0e                	push   $0xe
     b4b:	8d 45 ba             	lea    -0x46(%ebp),%eax
     b4e:	50                   	push   %eax
     b4f:	ff 75 ec             	pushl  -0x14(%ebp)
     b52:	e8 79 f9 ff ff       	call   4d0 <read>
     b57:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     b5a:	83 ec 04             	sub    $0x4,%esp
     b5d:	6a 28                	push   $0x28
     b5f:	8d 45 92             	lea    -0x6e(%ebp),%eax
     b62:	50                   	push   %eax
     b63:	ff 75 ec             	pushl  -0x14(%ebp)
     b66:	e8 65 f9 ff ff       	call   4d0 <read>
     b6b:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     b6e:	8b 45 96             	mov    -0x6a(%ebp),%eax
     b71:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     b74:	8b 45 9a             	mov    -0x66(%ebp),%eax
     b77:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     b7a:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b7d:	8b 45 cc             	mov    -0x34(%ebp),%eax
     b80:	0f af d0             	imul   %eax,%edx
     b83:	89 d0                	mov    %edx,%eax
     b85:	01 c0                	add    %eax,%eax
     b87:	01 d0                	add    %edx,%eax
     b89:	83 ec 0c             	sub    $0xc,%esp
     b8c:	50                   	push   %eax
     b8d:	e8 a0 fd ff ff       	call   932 <malloc>
     b92:	83 c4 10             	add    $0x10,%esp
     b95:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     b98:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     b9c:	0f b7 c0             	movzwl %ax,%eax
     b9f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     ba2:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ba5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ba8:	0f af c2             	imul   %edx,%eax
     bab:	83 c0 1f             	add    $0x1f,%eax
     bae:	c1 e8 05             	shr    $0x5,%eax
     bb1:	c1 e0 02             	shl    $0x2,%eax
     bb4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     bb7:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     bbd:	0f af c2             	imul   %edx,%eax
     bc0:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     bc3:	8b 45 e0             	mov    -0x20(%ebp),%eax
     bc6:	83 ec 0c             	sub    $0xc,%esp
     bc9:	50                   	push   %eax
     bca:	e8 63 fd ff ff       	call   932 <malloc>
     bcf:	83 c4 10             	add    $0x10,%esp
     bd2:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     bd5:	83 ec 04             	sub    $0x4,%esp
     bd8:	ff 75 e0             	pushl  -0x20(%ebp)
     bdb:	ff 75 dc             	pushl  -0x24(%ebp)
     bde:	ff 75 ec             	pushl  -0x14(%ebp)
     be1:	e8 ea f8 ff ff       	call   4d0 <read>
     be6:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     be9:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     bed:	66 c1 e8 03          	shr    $0x3,%ax
     bf1:	0f b7 c0             	movzwl %ax,%eax
     bf4:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     bf7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     bfe:	e9 e5 00 00 00       	jmp    ce8 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     c03:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c06:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c09:	29 c2                	sub    %eax,%edx
     c0b:	89 d0                	mov    %edx,%eax
     c0d:	8d 50 ff             	lea    -0x1(%eax),%edx
     c10:	8b 45 c8             	mov    -0x38(%ebp),%eax
     c13:	0f af c2             	imul   %edx,%eax
     c16:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     c19:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     c20:	e9 b1 00 00 00       	jmp    cd6 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     c25:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c28:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     c2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c2e:	01 c8                	add    %ecx,%eax
     c30:	89 c1                	mov    %eax,%ecx
     c32:	89 c8                	mov    %ecx,%eax
     c34:	01 c0                	add    %eax,%eax
     c36:	01 c8                	add    %ecx,%eax
     c38:	01 c2                	add    %eax,%edx
     c3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c3d:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     c41:	89 c1                	mov    %eax,%ecx
     c43:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c46:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     c4a:	01 c1                	add    %eax,%ecx
     c4c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c4f:	01 c8                	add    %ecx,%eax
     c51:	8d 48 ff             	lea    -0x1(%eax),%ecx
     c54:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c57:	01 c8                	add    %ecx,%eax
     c59:	0f b6 00             	movzbl (%eax),%eax
     c5c:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     c5f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c62:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     c65:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c68:	01 c8                	add    %ecx,%eax
     c6a:	89 c1                	mov    %eax,%ecx
     c6c:	89 c8                	mov    %ecx,%eax
     c6e:	01 c0                	add    %eax,%eax
     c70:	01 c8                	add    %ecx,%eax
     c72:	01 c2                	add    %eax,%edx
     c74:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c77:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     c7b:	89 c1                	mov    %eax,%ecx
     c7d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c80:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     c84:	01 c1                	add    %eax,%ecx
     c86:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c89:	01 c8                	add    %ecx,%eax
     c8b:	8d 48 fe             	lea    -0x2(%eax),%ecx
     c8e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c91:	01 c8                	add    %ecx,%eax
     c93:	0f b6 00             	movzbl (%eax),%eax
     c96:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     c99:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c9c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     c9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ca2:	01 c8                	add    %ecx,%eax
     ca4:	89 c1                	mov    %eax,%ecx
     ca6:	89 c8                	mov    %ecx,%eax
     ca8:	01 c0                	add    %eax,%eax
     caa:	01 c8                	add    %ecx,%eax
     cac:	01 c2                	add    %eax,%edx
     cae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cb1:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     cb5:	89 c1                	mov    %eax,%ecx
     cb7:	8b 45 d8             	mov    -0x28(%ebp),%eax
     cba:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     cbe:	01 c1                	add    %eax,%ecx
     cc0:	8b 45 d8             	mov    -0x28(%ebp),%eax
     cc3:	01 c8                	add    %ecx,%eax
     cc5:	8d 48 fd             	lea    -0x3(%eax),%ecx
     cc8:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ccb:	01 c8                	add    %ecx,%eax
     ccd:	0f b6 00             	movzbl (%eax),%eax
     cd0:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     cd2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     cd6:	8b 55 c8             	mov    -0x38(%ebp),%edx
     cd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cdc:	39 c2                	cmp    %eax,%edx
     cde:	0f 87 41 ff ff ff    	ja     c25 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     ce4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ce8:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ceb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cee:	39 c2                	cmp    %eax,%edx
     cf0:	0f 87 0d ff ff ff    	ja     c03 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     cf6:	83 ec 0c             	sub    $0xc,%esp
     cf9:	ff 75 ec             	pushl  -0x14(%ebp)
     cfc:	e8 df f7 ff ff       	call   4e0 <close>
     d01:	83 c4 10             	add    $0x10,%esp
    return bmp;
     d04:	8b 45 08             	mov    0x8(%ebp),%eax
     d07:	8b 55 c8             	mov    -0x38(%ebp),%edx
     d0a:	89 10                	mov    %edx,(%eax)
     d0c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     d0f:	89 50 04             	mov    %edx,0x4(%eax)
     d12:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d15:	89 50 08             	mov    %edx,0x8(%eax)
}
     d18:	8b 45 08             	mov    0x8(%ebp),%eax
     d1b:	c9                   	leave  
     d1c:	c2 04 00             	ret    $0x4

00000d1f <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     d1f:	55                   	push   %ebp
     d20:	89 e5                	mov    %esp,%ebp
     d22:	53                   	push   %ebx
     d23:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     d26:	83 ec 0c             	sub    $0xc,%esp
     d29:	6a 1c                	push   $0x1c
     d2b:	e8 02 fc ff ff       	call   932 <malloc>
     d30:	83 c4 10             	add    $0x10,%esp
     d33:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     d36:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d39:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     d40:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     d43:	8d 45 d8             	lea    -0x28(%ebp),%eax
     d46:	6a 0c                	push   $0xc
     d48:	6a 0c                	push   $0xc
     d4a:	6a 0c                	push   $0xc
     d4c:	50                   	push   %eax
     d4d:	e8 c3 fc ff ff       	call   a15 <RGB>
     d52:	83 c4 0c             	add    $0xc,%esp
     d55:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     d59:	66 89 43 13          	mov    %ax,0x13(%ebx)
     d5d:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     d61:	88 43 15             	mov    %al,0x15(%ebx)
     d64:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d67:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d6a:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     d6e:	66 89 48 10          	mov    %cx,0x10(%eax)
     d72:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     d76:	88 50 12             	mov    %dl,0x12(%eax)
     d79:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d7c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d7f:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     d83:	66 89 48 08          	mov    %cx,0x8(%eax)
     d87:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     d8b:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     d8e:	8b 45 08             	mov    0x8(%ebp),%eax
     d91:	89 c2                	mov    %eax,%edx
     d93:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d96:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     d98:	8b 45 0c             	mov    0xc(%ebp),%eax
     d9b:	89 c2                	mov    %eax,%edx
     d9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da0:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     da3:	8b 55 10             	mov    0x10(%ebp),%edx
     da6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da9:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     dac:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     daf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     db2:	c9                   	leave  
     db3:	c3                   	ret    

00000db4 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     db4:	55                   	push   %ebp
     db5:	89 e5                	mov    %esp,%ebp
     db7:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     dba:	8b 45 0c             	mov    0xc(%ebp),%eax
     dbd:	8b 50 08             	mov    0x8(%eax),%edx
     dc0:	89 55 f8             	mov    %edx,-0x8(%ebp)
     dc3:	8b 40 0c             	mov    0xc(%eax),%eax
     dc6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     dc9:	8b 45 0c             	mov    0xc(%ebp),%eax
     dcc:	8b 55 10             	mov    0x10(%ebp),%edx
     dcf:	89 50 08             	mov    %edx,0x8(%eax)
     dd2:	8b 55 14             	mov    0x14(%ebp),%edx
     dd5:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     dd8:	8b 45 08             	mov    0x8(%ebp),%eax
     ddb:	8b 55 f8             	mov    -0x8(%ebp),%edx
     dde:	89 10                	mov    %edx,(%eax)
     de0:	8b 55 fc             	mov    -0x4(%ebp),%edx
     de3:	89 50 04             	mov    %edx,0x4(%eax)
}
     de6:	8b 45 08             	mov    0x8(%ebp),%eax
     de9:	c9                   	leave  
     dea:	c2 04 00             	ret    $0x4

00000ded <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     ded:	55                   	push   %ebp
     dee:	89 e5                	mov    %esp,%ebp
     df0:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     df3:	8b 45 0c             	mov    0xc(%ebp),%eax
     df6:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     dfa:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     dfe:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     e02:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     e05:	8b 45 0c             	mov    0xc(%ebp),%eax
     e08:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     e0c:	66 89 50 10          	mov    %dx,0x10(%eax)
     e10:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     e14:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     e17:	8b 45 08             	mov    0x8(%ebp),%eax
     e1a:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     e1e:	66 89 10             	mov    %dx,(%eax)
     e21:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     e25:	88 50 02             	mov    %dl,0x2(%eax)
}
     e28:	8b 45 08             	mov    0x8(%ebp),%eax
     e2b:	c9                   	leave  
     e2c:	c2 04 00             	ret    $0x4

00000e2f <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     e2f:	55                   	push   %ebp
     e30:	89 e5                	mov    %esp,%ebp
     e32:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     e35:	8b 45 08             	mov    0x8(%ebp),%eax
     e38:	8b 40 0c             	mov    0xc(%eax),%eax
     e3b:	89 c2                	mov    %eax,%edx
     e3d:	c1 ea 1f             	shr    $0x1f,%edx
     e40:	01 d0                	add    %edx,%eax
     e42:	d1 f8                	sar    %eax
     e44:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     e47:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e4a:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     e4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     e51:	8b 45 10             	mov    0x10(%ebp),%eax
     e54:	2b 45 f4             	sub    -0xc(%ebp),%eax
     e57:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     e5a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     e5e:	0f 89 98 00 00 00    	jns    efc <APDrawPoint+0xcd>
        i = 0;
     e64:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     e6b:	e9 8c 00 00 00       	jmp    efc <APDrawPoint+0xcd>
    {
        j = x - off;
     e70:	8b 45 0c             	mov    0xc(%ebp),%eax
     e73:	2b 45 f4             	sub    -0xc(%ebp),%eax
     e76:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     e79:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     e7d:	79 69                	jns    ee8 <APDrawPoint+0xb9>
            j = 0;
     e7f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     e86:	eb 60                	jmp    ee8 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     e88:	ff 75 fc             	pushl  -0x4(%ebp)
     e8b:	ff 75 f8             	pushl  -0x8(%ebp)
     e8e:	ff 75 08             	pushl  0x8(%ebp)
     e91:	e8 fd fb ff ff       	call   a93 <APGetIndex>
     e96:	83 c4 0c             	add    $0xc,%esp
     e99:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     e9c:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     ea0:	74 55                	je     ef7 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     ea2:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     ea6:	74 67                	je     f0f <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     ea8:	ff 75 10             	pushl  0x10(%ebp)
     eab:	ff 75 0c             	pushl  0xc(%ebp)
     eae:	ff 75 fc             	pushl  -0x4(%ebp)
     eb1:	ff 75 f8             	pushl  -0x8(%ebp)
     eb4:	e8 a1 fb ff ff       	call   a5a <distance_2>
     eb9:	83 c4 10             	add    $0x10,%esp
     ebc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     ebf:	7f 23                	jg     ee4 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     ec1:	8b 45 08             	mov    0x8(%ebp),%eax
     ec4:	8b 48 18             	mov    0x18(%eax),%ecx
     ec7:	8b 55 ec             	mov    -0x14(%ebp),%edx
     eca:	89 d0                	mov    %edx,%eax
     ecc:	01 c0                	add    %eax,%eax
     ece:	01 d0                	add    %edx,%eax
     ed0:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     ed3:	8b 45 08             	mov    0x8(%ebp),%eax
     ed6:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     eda:	66 89 0a             	mov    %cx,(%edx)
     edd:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     ee1:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     ee4:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     ee8:	8b 55 0c             	mov    0xc(%ebp),%edx
     eeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eee:	01 d0                	add    %edx,%eax
     ef0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     ef3:	7d 93                	jge    e88 <APDrawPoint+0x59>
     ef5:	eb 01                	jmp    ef8 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     ef7:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     ef8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     efc:	8b 55 10             	mov    0x10(%ebp),%edx
     eff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f02:	01 d0                	add    %edx,%eax
     f04:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     f07:	0f 8d 63 ff ff ff    	jge    e70 <APDrawPoint+0x41>
     f0d:	eb 01                	jmp    f10 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     f0f:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     f10:	c9                   	leave  
     f11:	c3                   	ret    

00000f12 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     f12:	55                   	push   %ebp
     f13:	89 e5                	mov    %esp,%ebp
     f15:	53                   	push   %ebx
     f16:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     f19:	8b 45 0c             	mov    0xc(%ebp),%eax
     f1c:	3b 45 14             	cmp    0x14(%ebp),%eax
     f1f:	0f 85 80 00 00 00    	jne    fa5 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     f25:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f29:	0f 88 9d 02 00 00    	js     11cc <APDrawLine+0x2ba>
     f2f:	8b 45 08             	mov    0x8(%ebp),%eax
     f32:	8b 00                	mov    (%eax),%eax
     f34:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f37:	0f 8e 8f 02 00 00    	jle    11cc <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     f3d:	8b 45 10             	mov    0x10(%ebp),%eax
     f40:	3b 45 18             	cmp    0x18(%ebp),%eax
     f43:	7e 12                	jle    f57 <APDrawLine+0x45>
        {
            int tmp = y2;
     f45:	8b 45 18             	mov    0x18(%ebp),%eax
     f48:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     f4b:	8b 45 10             	mov    0x10(%ebp),%eax
     f4e:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     f51:	8b 45 dc             	mov    -0x24(%ebp),%eax
     f54:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     f57:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     f5b:	79 07                	jns    f64 <APDrawLine+0x52>
     f5d:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     f64:	8b 45 08             	mov    0x8(%ebp),%eax
     f67:	8b 40 04             	mov    0x4(%eax),%eax
     f6a:	3b 45 18             	cmp    0x18(%ebp),%eax
     f6d:	7d 0c                	jge    f7b <APDrawLine+0x69>
     f6f:	8b 45 08             	mov    0x8(%ebp),%eax
     f72:	8b 40 04             	mov    0x4(%eax),%eax
     f75:	83 e8 01             	sub    $0x1,%eax
     f78:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     f7b:	8b 45 10             	mov    0x10(%ebp),%eax
     f7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
     f81:	eb 15                	jmp    f98 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     f83:	ff 75 f4             	pushl  -0xc(%ebp)
     f86:	ff 75 0c             	pushl  0xc(%ebp)
     f89:	ff 75 08             	pushl  0x8(%ebp)
     f8c:	e8 9e fe ff ff       	call   e2f <APDrawPoint>
     f91:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     f94:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f98:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f9b:	3b 45 18             	cmp    0x18(%ebp),%eax
     f9e:	7e e3                	jle    f83 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     fa0:	e9 2b 02 00 00       	jmp    11d0 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     fa5:	8b 45 10             	mov    0x10(%ebp),%eax
     fa8:	3b 45 18             	cmp    0x18(%ebp),%eax
     fab:	75 7f                	jne    102c <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     fad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     fb1:	0f 88 18 02 00 00    	js     11cf <APDrawLine+0x2bd>
     fb7:	8b 45 08             	mov    0x8(%ebp),%eax
     fba:	8b 40 04             	mov    0x4(%eax),%eax
     fbd:	3b 45 10             	cmp    0x10(%ebp),%eax
     fc0:	0f 8e 09 02 00 00    	jle    11cf <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     fc6:	8b 45 0c             	mov    0xc(%ebp),%eax
     fc9:	3b 45 14             	cmp    0x14(%ebp),%eax
     fcc:	7e 12                	jle    fe0 <APDrawLine+0xce>
        {
            int tmp = x2;
     fce:	8b 45 14             	mov    0x14(%ebp),%eax
     fd1:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     fd4:	8b 45 0c             	mov    0xc(%ebp),%eax
     fd7:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     fda:	8b 45 d8             	mov    -0x28(%ebp),%eax
     fdd:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     fe0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     fe4:	79 07                	jns    fed <APDrawLine+0xdb>
     fe6:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     fed:	8b 45 08             	mov    0x8(%ebp),%eax
     ff0:	8b 00                	mov    (%eax),%eax
     ff2:	3b 45 14             	cmp    0x14(%ebp),%eax
     ff5:	7d 0b                	jge    1002 <APDrawLine+0xf0>
     ff7:	8b 45 08             	mov    0x8(%ebp),%eax
     ffa:	8b 00                	mov    (%eax),%eax
     ffc:	83 e8 01             	sub    $0x1,%eax
     fff:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1002:	8b 45 0c             	mov    0xc(%ebp),%eax
    1005:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1008:	eb 15                	jmp    101f <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    100a:	ff 75 10             	pushl  0x10(%ebp)
    100d:	ff 75 f0             	pushl  -0x10(%ebp)
    1010:	ff 75 08             	pushl  0x8(%ebp)
    1013:	e8 17 fe ff ff       	call   e2f <APDrawPoint>
    1018:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    101b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    101f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1022:	3b 45 14             	cmp    0x14(%ebp),%eax
    1025:	7e e3                	jle    100a <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1027:	e9 a4 01 00 00       	jmp    11d0 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    102c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1033:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    103a:	8b 45 0c             	mov    0xc(%ebp),%eax
    103d:	2b 45 14             	sub    0x14(%ebp),%eax
    1040:	50                   	push   %eax
    1041:	e8 3d fa ff ff       	call   a83 <abs_int>
    1046:	83 c4 04             	add    $0x4,%esp
    1049:	89 c3                	mov    %eax,%ebx
    104b:	8b 45 10             	mov    0x10(%ebp),%eax
    104e:	2b 45 18             	sub    0x18(%ebp),%eax
    1051:	50                   	push   %eax
    1052:	e8 2c fa ff ff       	call   a83 <abs_int>
    1057:	83 c4 04             	add    $0x4,%esp
    105a:	39 c3                	cmp    %eax,%ebx
    105c:	0f 8e b5 00 00 00    	jle    1117 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1062:	8b 45 10             	mov    0x10(%ebp),%eax
    1065:	2b 45 18             	sub    0x18(%ebp),%eax
    1068:	89 45 b0             	mov    %eax,-0x50(%ebp)
    106b:	db 45 b0             	fildl  -0x50(%ebp)
    106e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1071:	2b 45 14             	sub    0x14(%ebp),%eax
    1074:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1077:	db 45 b0             	fildl  -0x50(%ebp)
    107a:	de f9                	fdivrp %st,%st(1)
    107c:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    107f:	8b 45 14             	mov    0x14(%ebp),%eax
    1082:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1085:	7e 0e                	jle    1095 <APDrawLine+0x183>
        {
            s = x1;
    1087:	8b 45 0c             	mov    0xc(%ebp),%eax
    108a:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    108d:	8b 45 14             	mov    0x14(%ebp),%eax
    1090:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1093:	eb 0c                	jmp    10a1 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1095:	8b 45 14             	mov    0x14(%ebp),%eax
    1098:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    109b:	8b 45 0c             	mov    0xc(%ebp),%eax
    109e:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    10a1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10a5:	79 07                	jns    10ae <APDrawLine+0x19c>
    10a7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    10ae:	8b 45 08             	mov    0x8(%ebp),%eax
    10b1:	8b 00                	mov    (%eax),%eax
    10b3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10b6:	7f 0b                	jg     10c3 <APDrawLine+0x1b1>
    10b8:	8b 45 08             	mov    0x8(%ebp),%eax
    10bb:	8b 00                	mov    (%eax),%eax
    10bd:	83 e8 01             	sub    $0x1,%eax
    10c0:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    10c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    10c9:	eb 3f                	jmp    110a <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    10cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10ce:	2b 45 0c             	sub    0xc(%ebp),%eax
    10d1:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10d4:	db 45 b0             	fildl  -0x50(%ebp)
    10d7:	dc 4d d0             	fmull  -0x30(%ebp)
    10da:	db 45 10             	fildl  0x10(%ebp)
    10dd:	de c1                	faddp  %st,%st(1)
    10df:	d9 7d b6             	fnstcw -0x4a(%ebp)
    10e2:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    10e6:	b4 0c                	mov    $0xc,%ah
    10e8:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    10ec:	d9 6d b4             	fldcw  -0x4c(%ebp)
    10ef:	db 5d cc             	fistpl -0x34(%ebp)
    10f2:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    10f5:	ff 75 cc             	pushl  -0x34(%ebp)
    10f8:	ff 75 e4             	pushl  -0x1c(%ebp)
    10fb:	ff 75 08             	pushl  0x8(%ebp)
    10fe:	e8 2c fd ff ff       	call   e2f <APDrawPoint>
    1103:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1106:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    110a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    110d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1110:	7e b9                	jle    10cb <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1112:	e9 b9 00 00 00       	jmp    11d0 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1117:	8b 45 0c             	mov    0xc(%ebp),%eax
    111a:	2b 45 14             	sub    0x14(%ebp),%eax
    111d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1120:	db 45 b0             	fildl  -0x50(%ebp)
    1123:	8b 45 10             	mov    0x10(%ebp),%eax
    1126:	2b 45 18             	sub    0x18(%ebp),%eax
    1129:	89 45 b0             	mov    %eax,-0x50(%ebp)
    112c:	db 45 b0             	fildl  -0x50(%ebp)
    112f:	de f9                	fdivrp %st,%st(1)
    1131:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1134:	8b 45 10             	mov    0x10(%ebp),%eax
    1137:	3b 45 18             	cmp    0x18(%ebp),%eax
    113a:	7e 0e                	jle    114a <APDrawLine+0x238>
    {
        s = y2;
    113c:	8b 45 18             	mov    0x18(%ebp),%eax
    113f:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1142:	8b 45 10             	mov    0x10(%ebp),%eax
    1145:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1148:	eb 0c                	jmp    1156 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    114a:	8b 45 10             	mov    0x10(%ebp),%eax
    114d:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1150:	8b 45 18             	mov    0x18(%ebp),%eax
    1153:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1156:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    115a:	79 07                	jns    1163 <APDrawLine+0x251>
    115c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1163:	8b 45 08             	mov    0x8(%ebp),%eax
    1166:	8b 40 04             	mov    0x4(%eax),%eax
    1169:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    116c:	7f 0c                	jg     117a <APDrawLine+0x268>
    116e:	8b 45 08             	mov    0x8(%ebp),%eax
    1171:	8b 40 04             	mov    0x4(%eax),%eax
    1174:	83 e8 01             	sub    $0x1,%eax
    1177:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    117a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    117d:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1180:	eb 3f                	jmp    11c1 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1182:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1185:	2b 45 10             	sub    0x10(%ebp),%eax
    1188:	89 45 b0             	mov    %eax,-0x50(%ebp)
    118b:	db 45 b0             	fildl  -0x50(%ebp)
    118e:	dc 4d c0             	fmull  -0x40(%ebp)
    1191:	db 45 0c             	fildl  0xc(%ebp)
    1194:	de c1                	faddp  %st,%st(1)
    1196:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1199:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    119d:	b4 0c                	mov    $0xc,%ah
    119f:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    11a3:	d9 6d b4             	fldcw  -0x4c(%ebp)
    11a6:	db 5d bc             	fistpl -0x44(%ebp)
    11a9:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    11ac:	ff 75 e0             	pushl  -0x20(%ebp)
    11af:	ff 75 bc             	pushl  -0x44(%ebp)
    11b2:	ff 75 08             	pushl  0x8(%ebp)
    11b5:	e8 75 fc ff ff       	call   e2f <APDrawPoint>
    11ba:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    11bd:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    11c1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11c4:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11c7:	7e b9                	jle    1182 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    11c9:	90                   	nop
    11ca:	eb 04                	jmp    11d0 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    11cc:	90                   	nop
    11cd:	eb 01                	jmp    11d0 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    11cf:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    11d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11d3:	c9                   	leave  
    11d4:	c3                   	ret    

000011d5 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    11d5:	55                   	push   %ebp
    11d6:	89 e5                	mov    %esp,%ebp
    11d8:	53                   	push   %ebx
    11d9:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    11dc:	8b 55 10             	mov    0x10(%ebp),%edx
    11df:	8b 45 18             	mov    0x18(%ebp),%eax
    11e2:	01 d0                	add    %edx,%eax
    11e4:	83 e8 01             	sub    $0x1,%eax
    11e7:	83 ec 04             	sub    $0x4,%esp
    11ea:	50                   	push   %eax
    11eb:	ff 75 0c             	pushl  0xc(%ebp)
    11ee:	ff 75 10             	pushl  0x10(%ebp)
    11f1:	ff 75 0c             	pushl  0xc(%ebp)
    11f4:	ff 75 08             	pushl  0x8(%ebp)
    11f7:	e8 16 fd ff ff       	call   f12 <APDrawLine>
    11fc:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    11ff:	8b 55 0c             	mov    0xc(%ebp),%edx
    1202:	8b 45 14             	mov    0x14(%ebp),%eax
    1205:	01 d0                	add    %edx,%eax
    1207:	83 e8 01             	sub    $0x1,%eax
    120a:	83 ec 04             	sub    $0x4,%esp
    120d:	ff 75 10             	pushl  0x10(%ebp)
    1210:	50                   	push   %eax
    1211:	ff 75 10             	pushl  0x10(%ebp)
    1214:	ff 75 0c             	pushl  0xc(%ebp)
    1217:	ff 75 08             	pushl  0x8(%ebp)
    121a:	e8 f3 fc ff ff       	call   f12 <APDrawLine>
    121f:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1222:	8b 55 10             	mov    0x10(%ebp),%edx
    1225:	8b 45 18             	mov    0x18(%ebp),%eax
    1228:	01 d0                	add    %edx,%eax
    122a:	8d 48 ff             	lea    -0x1(%eax),%ecx
    122d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1230:	8b 45 14             	mov    0x14(%ebp),%eax
    1233:	01 d0                	add    %edx,%eax
    1235:	8d 50 ff             	lea    -0x1(%eax),%edx
    1238:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    123b:	8b 45 14             	mov    0x14(%ebp),%eax
    123e:	01 d8                	add    %ebx,%eax
    1240:	83 e8 01             	sub    $0x1,%eax
    1243:	83 ec 04             	sub    $0x4,%esp
    1246:	51                   	push   %ecx
    1247:	52                   	push   %edx
    1248:	ff 75 10             	pushl  0x10(%ebp)
    124b:	50                   	push   %eax
    124c:	ff 75 08             	pushl  0x8(%ebp)
    124f:	e8 be fc ff ff       	call   f12 <APDrawLine>
    1254:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1257:	8b 55 10             	mov    0x10(%ebp),%edx
    125a:	8b 45 18             	mov    0x18(%ebp),%eax
    125d:	01 d0                	add    %edx,%eax
    125f:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1262:	8b 55 0c             	mov    0xc(%ebp),%edx
    1265:	8b 45 14             	mov    0x14(%ebp),%eax
    1268:	01 d0                	add    %edx,%eax
    126a:	8d 50 ff             	lea    -0x1(%eax),%edx
    126d:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1270:	8b 45 18             	mov    0x18(%ebp),%eax
    1273:	01 d8                	add    %ebx,%eax
    1275:	83 e8 01             	sub    $0x1,%eax
    1278:	83 ec 04             	sub    $0x4,%esp
    127b:	51                   	push   %ecx
    127c:	52                   	push   %edx
    127d:	50                   	push   %eax
    127e:	ff 75 0c             	pushl  0xc(%ebp)
    1281:	ff 75 08             	pushl  0x8(%ebp)
    1284:	e8 89 fc ff ff       	call   f12 <APDrawLine>
    1289:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    128c:	8b 55 0c             	mov    0xc(%ebp),%edx
    128f:	8b 45 14             	mov    0x14(%ebp),%eax
    1292:	01 d0                	add    %edx,%eax
    1294:	8d 50 ff             	lea    -0x1(%eax),%edx
    1297:	8b 45 08             	mov    0x8(%ebp),%eax
    129a:	8b 40 0c             	mov    0xc(%eax),%eax
    129d:	89 c1                	mov    %eax,%ecx
    129f:	c1 e9 1f             	shr    $0x1f,%ecx
    12a2:	01 c8                	add    %ecx,%eax
    12a4:	d1 f8                	sar    %eax
    12a6:	29 c2                	sub    %eax,%edx
    12a8:	89 d0                	mov    %edx,%eax
    12aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    12ad:	8b 55 10             	mov    0x10(%ebp),%edx
    12b0:	8b 45 18             	mov    0x18(%ebp),%eax
    12b3:	01 d0                	add    %edx,%eax
    12b5:	8d 50 ff             	lea    -0x1(%eax),%edx
    12b8:	8b 45 08             	mov    0x8(%ebp),%eax
    12bb:	8b 40 0c             	mov    0xc(%eax),%eax
    12be:	89 c1                	mov    %eax,%ecx
    12c0:	c1 e9 1f             	shr    $0x1f,%ecx
    12c3:	01 c8                	add    %ecx,%eax
    12c5:	d1 f8                	sar    %eax
    12c7:	29 c2                	sub    %eax,%edx
    12c9:	89 d0                	mov    %edx,%eax
    12cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    12ce:	8b 45 08             	mov    0x8(%ebp),%eax
    12d1:	8b 40 0c             	mov    0xc(%eax),%eax
    12d4:	89 c2                	mov    %eax,%edx
    12d6:	c1 ea 1f             	shr    $0x1f,%edx
    12d9:	01 d0                	add    %edx,%eax
    12db:	d1 f8                	sar    %eax
    12dd:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    12e0:	8b 45 08             	mov    0x8(%ebp),%eax
    12e3:	8b 40 0c             	mov    0xc(%eax),%eax
    12e6:	89 c2                	mov    %eax,%edx
    12e8:	c1 ea 1f             	shr    $0x1f,%edx
    12eb:	01 d0                	add    %edx,%eax
    12ed:	d1 f8                	sar    %eax
    12ef:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    12f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12f6:	0f 88 d8 00 00 00    	js     13d4 <APDrawRect+0x1ff>
    12fc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1300:	0f 88 ce 00 00 00    	js     13d4 <APDrawRect+0x1ff>
    1306:	8b 45 08             	mov    0x8(%ebp),%eax
    1309:	8b 00                	mov    (%eax),%eax
    130b:	3b 45 0c             	cmp    0xc(%ebp),%eax
    130e:	0f 8e c0 00 00 00    	jle    13d4 <APDrawRect+0x1ff>
    1314:	8b 45 08             	mov    0x8(%ebp),%eax
    1317:	8b 40 04             	mov    0x4(%eax),%eax
    131a:	3b 45 10             	cmp    0x10(%ebp),%eax
    131d:	0f 8e b1 00 00 00    	jle    13d4 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1323:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1327:	79 07                	jns    1330 <APDrawRect+0x15b>
    1329:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1330:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1334:	79 07                	jns    133d <APDrawRect+0x168>
    1336:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    133d:	8b 45 08             	mov    0x8(%ebp),%eax
    1340:	8b 00                	mov    (%eax),%eax
    1342:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1345:	7f 0b                	jg     1352 <APDrawRect+0x17d>
    1347:	8b 45 08             	mov    0x8(%ebp),%eax
    134a:	8b 00                	mov    (%eax),%eax
    134c:	83 e8 01             	sub    $0x1,%eax
    134f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1352:	8b 45 08             	mov    0x8(%ebp),%eax
    1355:	8b 40 04             	mov    0x4(%eax),%eax
    1358:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    135b:	7f 0c                	jg     1369 <APDrawRect+0x194>
    135d:	8b 45 08             	mov    0x8(%ebp),%eax
    1360:	8b 40 04             	mov    0x4(%eax),%eax
    1363:	83 e8 01             	sub    $0x1,%eax
    1366:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1369:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1370:	8b 45 0c             	mov    0xc(%ebp),%eax
    1373:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1376:	eb 52                	jmp    13ca <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1378:	8b 45 10             	mov    0x10(%ebp),%eax
    137b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    137e:	eb 3e                	jmp    13be <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1380:	83 ec 04             	sub    $0x4,%esp
    1383:	ff 75 e8             	pushl  -0x18(%ebp)
    1386:	ff 75 ec             	pushl  -0x14(%ebp)
    1389:	ff 75 08             	pushl  0x8(%ebp)
    138c:	e8 02 f7 ff ff       	call   a93 <APGetIndex>
    1391:	83 c4 10             	add    $0x10,%esp
    1394:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1397:	8b 45 08             	mov    0x8(%ebp),%eax
    139a:	8b 48 18             	mov    0x18(%eax),%ecx
    139d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    13a0:	89 d0                	mov    %edx,%eax
    13a2:	01 c0                	add    %eax,%eax
    13a4:	01 d0                	add    %edx,%eax
    13a6:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    13a9:	8b 45 08             	mov    0x8(%ebp),%eax
    13ac:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    13b0:	66 89 0a             	mov    %cx,(%edx)
    13b3:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    13b7:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    13ba:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    13be:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13c1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    13c4:	7e ba                	jle    1380 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    13c6:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    13ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13cd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    13d0:	7e a6                	jle    1378 <APDrawRect+0x1a3>
    13d2:	eb 01                	jmp    13d5 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    13d4:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    13d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13d8:	c9                   	leave  
    13d9:	c3                   	ret    

000013da <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    13da:	55                   	push   %ebp
    13db:	89 e5                	mov    %esp,%ebp
    13dd:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    13e0:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    13e4:	0f 88 8e 01 00 00    	js     1578 <APDcCopy+0x19e>
    13ea:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    13ee:	0f 88 84 01 00 00    	js     1578 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    13f4:	8b 55 0c             	mov    0xc(%ebp),%edx
    13f7:	8b 45 20             	mov    0x20(%ebp),%eax
    13fa:	01 d0                	add    %edx,%eax
    13fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    13ff:	8b 55 10             	mov    0x10(%ebp),%edx
    1402:	8b 45 24             	mov    0x24(%ebp),%eax
    1405:	01 d0                	add    %edx,%eax
    1407:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    140a:	8b 55 18             	mov    0x18(%ebp),%edx
    140d:	8b 45 20             	mov    0x20(%ebp),%eax
    1410:	01 d0                	add    %edx,%eax
    1412:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1415:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1418:	8b 45 24             	mov    0x24(%ebp),%eax
    141b:	01 d0                	add    %edx,%eax
    141d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1420:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1424:	0f 88 51 01 00 00    	js     157b <APDcCopy+0x1a1>
    142a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    142e:	0f 88 47 01 00 00    	js     157b <APDcCopy+0x1a1>
    1434:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1438:	0f 88 3d 01 00 00    	js     157b <APDcCopy+0x1a1>
    143e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1442:	0f 88 33 01 00 00    	js     157b <APDcCopy+0x1a1>
    1448:	8b 45 14             	mov    0x14(%ebp),%eax
    144b:	8b 00                	mov    (%eax),%eax
    144d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1450:	0f 8c 25 01 00 00    	jl     157b <APDcCopy+0x1a1>
    1456:	8b 45 14             	mov    0x14(%ebp),%eax
    1459:	8b 40 04             	mov    0x4(%eax),%eax
    145c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    145f:	0f 8c 16 01 00 00    	jl     157b <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1465:	8b 45 08             	mov    0x8(%ebp),%eax
    1468:	8b 00                	mov    (%eax),%eax
    146a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    146d:	7f 0b                	jg     147a <APDcCopy+0xa0>
    146f:	8b 45 08             	mov    0x8(%ebp),%eax
    1472:	8b 00                	mov    (%eax),%eax
    1474:	83 e8 01             	sub    $0x1,%eax
    1477:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    147a:	8b 45 08             	mov    0x8(%ebp),%eax
    147d:	8b 40 04             	mov    0x4(%eax),%eax
    1480:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1483:	7f 0c                	jg     1491 <APDcCopy+0xb7>
    1485:	8b 45 08             	mov    0x8(%ebp),%eax
    1488:	8b 40 04             	mov    0x4(%eax),%eax
    148b:	83 e8 01             	sub    $0x1,%eax
    148e:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1491:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1498:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    149f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14a6:	e9 bc 00 00 00       	jmp    1567 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    14ab:	8b 45 08             	mov    0x8(%ebp),%eax
    14ae:	8b 00                	mov    (%eax),%eax
    14b0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14b3:	8b 55 10             	mov    0x10(%ebp),%edx
    14b6:	01 ca                	add    %ecx,%edx
    14b8:	0f af d0             	imul   %eax,%edx
    14bb:	8b 45 0c             	mov    0xc(%ebp),%eax
    14be:	01 d0                	add    %edx,%eax
    14c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    14c3:	8b 45 14             	mov    0x14(%ebp),%eax
    14c6:	8b 00                	mov    (%eax),%eax
    14c8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14cb:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14ce:	01 ca                	add    %ecx,%edx
    14d0:	0f af d0             	imul   %eax,%edx
    14d3:	8b 45 18             	mov    0x18(%ebp),%eax
    14d6:	01 d0                	add    %edx,%eax
    14d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    14db:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14e2:	eb 74                	jmp    1558 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    14e4:	8b 45 14             	mov    0x14(%ebp),%eax
    14e7:	8b 50 18             	mov    0x18(%eax),%edx
    14ea:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    14ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14f0:	01 c8                	add    %ecx,%eax
    14f2:	89 c1                	mov    %eax,%ecx
    14f4:	89 c8                	mov    %ecx,%eax
    14f6:	01 c0                	add    %eax,%eax
    14f8:	01 c8                	add    %ecx,%eax
    14fa:	01 d0                	add    %edx,%eax
    14fc:	0f b7 10             	movzwl (%eax),%edx
    14ff:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1503:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1507:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    150a:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    150e:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1512:	38 c2                	cmp    %al,%dl
    1514:	75 18                	jne    152e <APDcCopy+0x154>
    1516:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    151a:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    151e:	38 c2                	cmp    %al,%dl
    1520:	75 0c                	jne    152e <APDcCopy+0x154>
    1522:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1526:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    152a:	38 c2                	cmp    %al,%dl
    152c:	74 26                	je     1554 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    152e:	8b 45 08             	mov    0x8(%ebp),%eax
    1531:	8b 50 18             	mov    0x18(%eax),%edx
    1534:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1537:	8b 45 f0             	mov    -0x10(%ebp),%eax
    153a:	01 c8                	add    %ecx,%eax
    153c:	89 c1                	mov    %eax,%ecx
    153e:	89 c8                	mov    %ecx,%eax
    1540:	01 c0                	add    %eax,%eax
    1542:	01 c8                	add    %ecx,%eax
    1544:	01 d0                	add    %edx,%eax
    1546:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    154a:	66 89 10             	mov    %dx,(%eax)
    154d:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1551:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1554:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1558:	8b 45 fc             	mov    -0x4(%ebp),%eax
    155b:	2b 45 0c             	sub    0xc(%ebp),%eax
    155e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1561:	7d 81                	jge    14e4 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1563:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1567:	8b 45 f8             	mov    -0x8(%ebp),%eax
    156a:	2b 45 10             	sub    0x10(%ebp),%eax
    156d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1570:	0f 8d 35 ff ff ff    	jge    14ab <APDcCopy+0xd1>
    1576:	eb 04                	jmp    157c <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1578:	90                   	nop
    1579:	eb 01                	jmp    157c <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    157b:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    157c:	c9                   	leave  
    157d:	c3                   	ret    

0000157e <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    157e:	55                   	push   %ebp
    157f:	89 e5                	mov    %esp,%ebp
    1581:	83 ec 1c             	sub    $0x1c,%esp
    1584:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1587:	8b 55 10             	mov    0x10(%ebp),%edx
    158a:	8b 45 14             	mov    0x14(%ebp),%eax
    158d:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1590:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1593:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1596:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    159a:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    159d:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    15a1:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    15a4:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    15a8:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    15ab:	8b 45 08             	mov    0x8(%ebp),%eax
    15ae:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    15b2:	66 89 10             	mov    %dx,(%eax)
    15b5:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    15b9:	88 50 02             	mov    %dl,0x2(%eax)
}
    15bc:	8b 45 08             	mov    0x8(%ebp),%eax
    15bf:	c9                   	leave  
    15c0:	c2 04 00             	ret    $0x4

000015c3 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    15c3:	55                   	push   %ebp
    15c4:	89 e5                	mov    %esp,%ebp
    15c6:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    15c9:	8b 45 08             	mov    0x8(%ebp),%eax
    15cc:	8b 00                	mov    (%eax),%eax
    15ce:	83 ec 08             	sub    $0x8,%esp
    15d1:	8d 55 0c             	lea    0xc(%ebp),%edx
    15d4:	52                   	push   %edx
    15d5:	50                   	push   %eax
    15d6:	e8 8d ef ff ff       	call   568 <sendMessage>
    15db:	83 c4 10             	add    $0x10,%esp
}
    15de:	90                   	nop
    15df:	c9                   	leave  
    15e0:	c3                   	ret    

000015e1 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    15e1:	55                   	push   %ebp
    15e2:	89 e5                	mov    %esp,%ebp
    15e4:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    15e7:	83 ec 0c             	sub    $0xc,%esp
    15ea:	68 90 00 00 00       	push   $0x90
    15ef:	e8 3e f3 ff ff       	call   932 <malloc>
    15f4:	83 c4 10             	add    $0x10,%esp
    15f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    15fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15fe:	75 15                	jne    1615 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1600:	83 ec 04             	sub    $0x4,%esp
    1603:	ff 75 08             	pushl  0x8(%ebp)
    1606:	68 a8 23 00 00       	push   $0x23a8
    160b:	6a 01                	push   $0x1
    160d:	e8 4d f0 ff ff       	call   65f <printf>
    1612:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1615:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1618:	83 c0 7c             	add    $0x7c,%eax
    161b:	83 ec 08             	sub    $0x8,%esp
    161e:	ff 75 08             	pushl  0x8(%ebp)
    1621:	50                   	push   %eax
    1622:	e8 60 ec ff ff       	call   287 <strcpy>
    1627:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    162a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162d:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1634:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1637:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    163e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1641:	8b 40 34             	mov    0x34(%eax),%eax
    1644:	89 c2                	mov    %eax,%edx
    1646:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1649:	8b 40 38             	mov    0x38(%eax),%eax
    164c:	0f af d0             	imul   %eax,%edx
    164f:	89 d0                	mov    %edx,%eax
    1651:	01 c0                	add    %eax,%eax
    1653:	01 d0                	add    %edx,%eax
    1655:	83 ec 0c             	sub    $0xc,%esp
    1658:	50                   	push   %eax
    1659:	e8 d4 f2 ff ff       	call   932 <malloc>
    165e:	83 c4 10             	add    $0x10,%esp
    1661:	89 c2                	mov    %eax,%edx
    1663:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1666:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1669:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166c:	8b 40 4c             	mov    0x4c(%eax),%eax
    166f:	85 c0                	test   %eax,%eax
    1671:	75 15                	jne    1688 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1673:	83 ec 04             	sub    $0x4,%esp
    1676:	ff 75 08             	pushl  0x8(%ebp)
    1679:	68 c8 23 00 00       	push   $0x23c8
    167e:	6a 01                	push   $0x1
    1680:	e8 da ef ff ff       	call   65f <printf>
    1685:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1688:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168b:	8b 40 34             	mov    0x34(%eax),%eax
    168e:	89 c2                	mov    %eax,%edx
    1690:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1693:	8b 40 38             	mov    0x38(%eax),%eax
    1696:	0f af d0             	imul   %eax,%edx
    1699:	89 d0                	mov    %edx,%eax
    169b:	01 c0                	add    %eax,%eax
    169d:	01 c2                	add    %eax,%edx
    169f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a2:	8b 40 4c             	mov    0x4c(%eax),%eax
    16a5:	83 ec 04             	sub    $0x4,%esp
    16a8:	52                   	push   %edx
    16a9:	68 ff ff ff 00       	push   $0xffffff
    16ae:	50                   	push   %eax
    16af:	e8 69 ec ff ff       	call   31d <memset>
    16b4:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    16b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ba:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    16c1:	e8 72 ee ff ff       	call   538 <getpid>
    16c6:	89 c2                	mov    %eax,%edx
    16c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16cb:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    16ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d1:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    16d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16db:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    16e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e5:	8b 40 50             	mov    0x50(%eax),%eax
    16e8:	89 c2                	mov    %eax,%edx
    16ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ed:	8b 40 54             	mov    0x54(%eax),%eax
    16f0:	0f af d0             	imul   %eax,%edx
    16f3:	89 d0                	mov    %edx,%eax
    16f5:	01 c0                	add    %eax,%eax
    16f7:	01 d0                	add    %edx,%eax
    16f9:	83 ec 0c             	sub    $0xc,%esp
    16fc:	50                   	push   %eax
    16fd:	e8 30 f2 ff ff       	call   932 <malloc>
    1702:	83 c4 10             	add    $0x10,%esp
    1705:	89 c2                	mov    %eax,%edx
    1707:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170a:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    170d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1710:	8b 40 68             	mov    0x68(%eax),%eax
    1713:	85 c0                	test   %eax,%eax
    1715:	75 15                	jne    172c <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1717:	83 ec 04             	sub    $0x4,%esp
    171a:	ff 75 08             	pushl  0x8(%ebp)
    171d:	68 ec 23 00 00       	push   $0x23ec
    1722:	6a 01                	push   $0x1
    1724:	e8 36 ef ff ff       	call   65f <printf>
    1729:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    172c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172f:	8b 40 34             	mov    0x34(%eax),%eax
    1732:	89 c2                	mov    %eax,%edx
    1734:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1737:	8b 40 38             	mov    0x38(%eax),%eax
    173a:	0f af d0             	imul   %eax,%edx
    173d:	89 d0                	mov    %edx,%eax
    173f:	01 c0                	add    %eax,%eax
    1741:	01 c2                	add    %eax,%edx
    1743:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1746:	8b 40 4c             	mov    0x4c(%eax),%eax
    1749:	83 ec 04             	sub    $0x4,%esp
    174c:	52                   	push   %edx
    174d:	68 ff 00 00 00       	push   $0xff
    1752:	50                   	push   %eax
    1753:	e8 c5 eb ff ff       	call   31d <memset>
    1758:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    175b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1761:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1764:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1768:	74 35                	je     179f <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    176a:	8b 45 10             	mov    0x10(%ebp),%eax
    176d:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1773:	83 ec 0c             	sub    $0xc,%esp
    1776:	50                   	push   %eax
    1777:	e8 b6 f1 ff ff       	call   932 <malloc>
    177c:	83 c4 10             	add    $0x10,%esp
    177f:	89 c2                	mov    %eax,%edx
    1781:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1784:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1787:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178a:	8b 55 10             	mov    0x10(%ebp),%edx
    178d:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1790:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1793:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    179a:	e9 8d 00 00 00       	jmp    182c <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    179f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a2:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    17a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ac:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    17b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b6:	8b 40 18             	mov    0x18(%eax),%eax
    17b9:	89 c2                	mov    %eax,%edx
    17bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17be:	8b 40 1c             	mov    0x1c(%eax),%eax
    17c1:	0f af d0             	imul   %eax,%edx
    17c4:	89 d0                	mov    %edx,%eax
    17c6:	01 c0                	add    %eax,%eax
    17c8:	01 d0                	add    %edx,%eax
    17ca:	83 ec 0c             	sub    $0xc,%esp
    17cd:	50                   	push   %eax
    17ce:	e8 5f f1 ff ff       	call   932 <malloc>
    17d3:	83 c4 10             	add    $0x10,%esp
    17d6:	89 c2                	mov    %eax,%edx
    17d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17db:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    17de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e1:	8b 40 30             	mov    0x30(%eax),%eax
    17e4:	85 c0                	test   %eax,%eax
    17e6:	75 15                	jne    17fd <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    17e8:	83 ec 04             	sub    $0x4,%esp
    17eb:	ff 75 08             	pushl  0x8(%ebp)
    17ee:	68 14 24 00 00       	push   $0x2414
    17f3:	6a 01                	push   $0x1
    17f5:	e8 65 ee ff ff       	call   65f <printf>
    17fa:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    17fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1800:	8b 40 18             	mov    0x18(%eax),%eax
    1803:	89 c2                	mov    %eax,%edx
    1805:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1808:	8b 40 1c             	mov    0x1c(%eax),%eax
    180b:	0f af d0             	imul   %eax,%edx
    180e:	89 d0                	mov    %edx,%eax
    1810:	01 c0                	add    %eax,%eax
    1812:	01 c2                	add    %eax,%edx
    1814:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1817:	8b 40 30             	mov    0x30(%eax),%eax
    181a:	83 ec 04             	sub    $0x4,%esp
    181d:	52                   	push   %edx
    181e:	68 ff ff ff 00       	push   $0xffffff
    1823:	50                   	push   %eax
    1824:	e8 f4 ea ff ff       	call   31d <memset>
    1829:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    182c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    182f:	c9                   	leave  
    1830:	c3                   	ret    

00001831 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1831:	55                   	push   %ebp
    1832:	89 e5                	mov    %esp,%ebp
    1834:	53                   	push   %ebx
    1835:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1838:	8b 45 0c             	mov    0xc(%ebp),%eax
    183b:	83 f8 03             	cmp    $0x3,%eax
    183e:	74 02                	je     1842 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1840:	eb 33                	jmp    1875 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1842:	8b 45 08             	mov    0x8(%ebp),%eax
    1845:	8b 48 08             	mov    0x8(%eax),%ecx
    1848:	8b 45 08             	mov    0x8(%ebp),%eax
    184b:	8b 50 38             	mov    0x38(%eax),%edx
    184e:	8b 45 08             	mov    0x8(%ebp),%eax
    1851:	8b 40 34             	mov    0x34(%eax),%eax
    1854:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1857:	83 c3 34             	add    $0x34,%ebx
    185a:	83 ec 0c             	sub    $0xc,%esp
    185d:	51                   	push   %ecx
    185e:	52                   	push   %edx
    185f:	50                   	push   %eax
    1860:	6a 00                	push   $0x0
    1862:	6a 00                	push   $0x0
    1864:	53                   	push   %ebx
    1865:	6a 32                	push   $0x32
    1867:	6a 00                	push   $0x0
    1869:	ff 75 08             	pushl  0x8(%ebp)
    186c:	e8 e7 ec ff ff       	call   558 <paintWindow>
    1871:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1874:	90                   	nop
        default: break;
            
            
    }
    return False;
    1875:	b8 00 00 00 00       	mov    $0x0,%eax
}
    187a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    187d:	c9                   	leave  
    187e:	c3                   	ret    

0000187f <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    187f:	55                   	push   %ebp
    1880:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1882:	8b 45 0c             	mov    0xc(%ebp),%eax
    1885:	8b 50 08             	mov    0x8(%eax),%edx
    1888:	8b 45 08             	mov    0x8(%ebp),%eax
    188b:	8b 00                	mov    (%eax),%eax
    188d:	39 c2                	cmp    %eax,%edx
    188f:	74 07                	je     1898 <APPreJudge+0x19>
        return False;
    1891:	b8 00 00 00 00       	mov    $0x0,%eax
    1896:	eb 05                	jmp    189d <APPreJudge+0x1e>
    return True;
    1898:	b8 01 00 00 00       	mov    $0x1,%eax
}
    189d:	5d                   	pop    %ebp
    189e:	c3                   	ret    

0000189f <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    189f:	55                   	push   %ebp
    18a0:	89 e5                	mov    %esp,%ebp
    18a2:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    18a5:	8b 45 08             	mov    0x8(%ebp),%eax
    18a8:	8b 55 0c             	mov    0xc(%ebp),%edx
    18ab:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    18ae:	83 ec 0c             	sub    $0xc,%esp
    18b1:	ff 75 08             	pushl  0x8(%ebp)
    18b4:	e8 bf ec ff ff       	call   578 <registWindow>
    18b9:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    18bc:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    18c3:	8b 45 08             	mov    0x8(%ebp),%eax
    18c6:	8b 00                	mov    (%eax),%eax
    18c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    18cb:	ff 75 f4             	pushl  -0xc(%ebp)
    18ce:	ff 75 f0             	pushl  -0x10(%ebp)
    18d1:	ff 75 ec             	pushl  -0x14(%ebp)
    18d4:	ff 75 08             	pushl  0x8(%ebp)
    18d7:	e8 e7 fc ff ff       	call   15c3 <APSendMessage>
    18dc:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    18df:	83 ec 0c             	sub    $0xc,%esp
    18e2:	ff 75 08             	pushl  0x8(%ebp)
    18e5:	e8 86 ec ff ff       	call   570 <getMessage>
    18ea:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    18ed:	8b 45 08             	mov    0x8(%ebp),%eax
    18f0:	83 c0 6c             	add    $0x6c,%eax
    18f3:	83 ec 08             	sub    $0x8,%esp
    18f6:	50                   	push   %eax
    18f7:	ff 75 08             	pushl  0x8(%ebp)
    18fa:	e8 80 ff ff ff       	call   187f <APPreJudge>
    18ff:	83 c4 10             	add    $0x10,%esp
    1902:	84 c0                	test   %al,%al
    1904:	74 1b                	je     1921 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    1906:	8b 45 08             	mov    0x8(%ebp),%eax
    1909:	ff 70 74             	pushl  0x74(%eax)
    190c:	ff 70 70             	pushl  0x70(%eax)
    190f:	ff 70 6c             	pushl  0x6c(%eax)
    1912:	ff 75 08             	pushl  0x8(%ebp)
    1915:	8b 45 0c             	mov    0xc(%ebp),%eax
    1918:	ff d0                	call   *%eax
    191a:	83 c4 10             	add    $0x10,%esp
    191d:	84 c0                	test   %al,%al
    191f:	75 0c                	jne    192d <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1921:	8b 45 08             	mov    0x8(%ebp),%eax
    1924:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    192b:	eb b2                	jmp    18df <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    192d:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    192e:	90                   	nop
    192f:	c9                   	leave  
    1930:	c3                   	ret    

00001931 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1931:	55                   	push   %ebp
    1932:	89 e5                	mov    %esp,%ebp
    1934:	57                   	push   %edi
    1935:	56                   	push   %esi
    1936:	53                   	push   %ebx
    1937:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    193a:	a1 98 2d 00 00       	mov    0x2d98,%eax
    193f:	85 c0                	test   %eax,%eax
    1941:	0f 85 2c 02 00 00    	jne    1b73 <APGridPaint+0x242>
    {
        iconReady = 1;
    1947:	c7 05 98 2d 00 00 01 	movl   $0x1,0x2d98
    194e:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1951:	8d 45 98             	lea    -0x68(%ebp),%eax
    1954:	83 ec 08             	sub    $0x8,%esp
    1957:	68 3b 24 00 00       	push   $0x243b
    195c:	50                   	push   %eax
    195d:	e8 83 f1 ff ff       	call   ae5 <APLoadBitmap>
    1962:	83 c4 0c             	add    $0xc,%esp
    1965:	8b 45 98             	mov    -0x68(%ebp),%eax
    1968:	a3 bc 2d 00 00       	mov    %eax,0x2dbc
    196d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1970:	a3 c0 2d 00 00       	mov    %eax,0x2dc0
    1975:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1978:	a3 c4 2d 00 00       	mov    %eax,0x2dc4
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    197d:	83 ec 04             	sub    $0x4,%esp
    1980:	ff 35 c4 2d 00 00    	pushl  0x2dc4
    1986:	ff 35 c0 2d 00 00    	pushl  0x2dc0
    198c:	ff 35 bc 2d 00 00    	pushl  0x2dbc
    1992:	e8 88 f3 ff ff       	call   d1f <APCreateCompatibleDCFromBitmap>
    1997:	83 c4 10             	add    $0x10,%esp
    199a:	a3 c8 2d 00 00       	mov    %eax,0x2dc8
        grid_river = APLoadBitmap ("grid_river.bmp");
    199f:	8d 45 98             	lea    -0x68(%ebp),%eax
    19a2:	83 ec 08             	sub    $0x8,%esp
    19a5:	68 49 24 00 00       	push   $0x2449
    19aa:	50                   	push   %eax
    19ab:	e8 35 f1 ff ff       	call   ae5 <APLoadBitmap>
    19b0:	83 c4 0c             	add    $0xc,%esp
    19b3:	8b 45 98             	mov    -0x68(%ebp),%eax
    19b6:	a3 f8 2d 00 00       	mov    %eax,0x2df8
    19bb:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19be:	a3 fc 2d 00 00       	mov    %eax,0x2dfc
    19c3:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19c6:	a3 00 2e 00 00       	mov    %eax,0x2e00
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    19cb:	83 ec 04             	sub    $0x4,%esp
    19ce:	ff 35 00 2e 00 00    	pushl  0x2e00
    19d4:	ff 35 fc 2d 00 00    	pushl  0x2dfc
    19da:	ff 35 f8 2d 00 00    	pushl  0x2df8
    19e0:	e8 3a f3 ff ff       	call   d1f <APCreateCompatibleDCFromBitmap>
    19e5:	83 c4 10             	add    $0x10,%esp
    19e8:	a3 e8 2d 00 00       	mov    %eax,0x2de8
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    19ed:	8d 45 98             	lea    -0x68(%ebp),%eax
    19f0:	83 ec 08             	sub    $0x8,%esp
    19f3:	68 58 24 00 00       	push   $0x2458
    19f8:	50                   	push   %eax
    19f9:	e8 e7 f0 ff ff       	call   ae5 <APLoadBitmap>
    19fe:	83 c4 0c             	add    $0xc,%esp
    1a01:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a04:	a3 ec 2d 00 00       	mov    %eax,0x2dec
    1a09:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a0c:	a3 f0 2d 00 00       	mov    %eax,0x2df0
    1a11:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a14:	a3 f4 2d 00 00       	mov    %eax,0x2df4
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1a19:	83 ec 04             	sub    $0x4,%esp
    1a1c:	ff 35 f4 2d 00 00    	pushl  0x2df4
    1a22:	ff 35 f0 2d 00 00    	pushl  0x2df0
    1a28:	ff 35 ec 2d 00 00    	pushl  0x2dec
    1a2e:	e8 ec f2 ff ff       	call   d1f <APCreateCompatibleDCFromBitmap>
    1a33:	83 c4 10             	add    $0x10,%esp
    1a36:	a3 9c 2d 00 00       	mov    %eax,0x2d9c
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1a3b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a3e:	83 ec 08             	sub    $0x8,%esp
    1a41:	68 67 24 00 00       	push   $0x2467
    1a46:	50                   	push   %eax
    1a47:	e8 99 f0 ff ff       	call   ae5 <APLoadBitmap>
    1a4c:	83 c4 0c             	add    $0xc,%esp
    1a4f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a52:	a3 d0 2d 00 00       	mov    %eax,0x2dd0
    1a57:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a5a:	a3 d4 2d 00 00       	mov    %eax,0x2dd4
    1a5f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a62:	a3 d8 2d 00 00       	mov    %eax,0x2dd8
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1a67:	83 ec 04             	sub    $0x4,%esp
    1a6a:	ff 35 d8 2d 00 00    	pushl  0x2dd8
    1a70:	ff 35 d4 2d 00 00    	pushl  0x2dd4
    1a76:	ff 35 d0 2d 00 00    	pushl  0x2dd0
    1a7c:	e8 9e f2 ff ff       	call   d1f <APCreateCompatibleDCFromBitmap>
    1a81:	83 c4 10             	add    $0x10,%esp
    1a84:	a3 04 2e 00 00       	mov    %eax,0x2e04
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1a89:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a8c:	83 ec 08             	sub    $0x8,%esp
    1a8f:	68 75 24 00 00       	push   $0x2475
    1a94:	50                   	push   %eax
    1a95:	e8 4b f0 ff ff       	call   ae5 <APLoadBitmap>
    1a9a:	83 c4 0c             	add    $0xc,%esp
    1a9d:	8b 45 98             	mov    -0x68(%ebp),%eax
    1aa0:	a3 ac 2d 00 00       	mov    %eax,0x2dac
    1aa5:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1aa8:	a3 b0 2d 00 00       	mov    %eax,0x2db0
    1aad:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ab0:	a3 b4 2d 00 00       	mov    %eax,0x2db4
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1ab5:	83 ec 04             	sub    $0x4,%esp
    1ab8:	ff 35 b4 2d 00 00    	pushl  0x2db4
    1abe:	ff 35 b0 2d 00 00    	pushl  0x2db0
    1ac4:	ff 35 ac 2d 00 00    	pushl  0x2dac
    1aca:	e8 50 f2 ff ff       	call   d1f <APCreateCompatibleDCFromBitmap>
    1acf:	83 c4 10             	add    $0x10,%esp
    1ad2:	a3 cc 2d 00 00       	mov    %eax,0x2dcc
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1ad7:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ada:	83 ec 08             	sub    $0x8,%esp
    1add:	68 85 24 00 00       	push   $0x2485
    1ae2:	50                   	push   %eax
    1ae3:	e8 fd ef ff ff       	call   ae5 <APLoadBitmap>
    1ae8:	83 c4 0c             	add    $0xc,%esp
    1aeb:	8b 45 98             	mov    -0x68(%ebp),%eax
    1aee:	a3 a0 2d 00 00       	mov    %eax,0x2da0
    1af3:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1af6:	a3 a4 2d 00 00       	mov    %eax,0x2da4
    1afb:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1afe:	a3 a8 2d 00 00       	mov    %eax,0x2da8
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1b03:	83 ec 04             	sub    $0x4,%esp
    1b06:	ff 35 a8 2d 00 00    	pushl  0x2da8
    1b0c:	ff 35 a4 2d 00 00    	pushl  0x2da4
    1b12:	ff 35 a0 2d 00 00    	pushl  0x2da0
    1b18:	e8 02 f2 ff ff       	call   d1f <APCreateCompatibleDCFromBitmap>
    1b1d:	83 c4 10             	add    $0x10,%esp
    1b20:	a3 b8 2d 00 00       	mov    %eax,0x2db8
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1b25:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b28:	83 ec 08             	sub    $0x8,%esp
    1b2b:	68 97 24 00 00       	push   $0x2497
    1b30:	50                   	push   %eax
    1b31:	e8 af ef ff ff       	call   ae5 <APLoadBitmap>
    1b36:	83 c4 0c             	add    $0xc,%esp
    1b39:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b3c:	a3 dc 2d 00 00       	mov    %eax,0x2ddc
    1b41:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b44:	a3 e0 2d 00 00       	mov    %eax,0x2de0
    1b49:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b4c:	a3 e4 2d 00 00       	mov    %eax,0x2de4
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1b51:	83 ec 04             	sub    $0x4,%esp
    1b54:	ff 35 e4 2d 00 00    	pushl  0x2de4
    1b5a:	ff 35 e0 2d 00 00    	pushl  0x2de0
    1b60:	ff 35 dc 2d 00 00    	pushl  0x2ddc
    1b66:	e8 b4 f1 ff ff       	call   d1f <APCreateCompatibleDCFromBitmap>
    1b6b:	83 c4 10             	add    $0x10,%esp
    1b6e:	a3 08 2e 00 00       	mov    %eax,0x2e08
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1b73:	8b 45 08             	mov    0x8(%ebp),%eax
    1b76:	8b 40 08             	mov    0x8(%eax),%eax
    1b79:	85 c0                	test   %eax,%eax
    1b7b:	75 17                	jne    1b94 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1b7d:	83 ec 08             	sub    $0x8,%esp
    1b80:	68 a8 24 00 00       	push   $0x24a8
    1b85:	6a 01                	push   $0x1
    1b87:	e8 d3 ea ff ff       	call   65f <printf>
    1b8c:	83 c4 10             	add    $0x10,%esp
        return;
    1b8f:	e9 f2 03 00 00       	jmp    1f86 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1b94:	8b 45 08             	mov    0x8(%ebp),%eax
    1b97:	8b 40 10             	mov    0x10(%eax),%eax
    1b9a:	85 c0                	test   %eax,%eax
    1b9c:	7e 10                	jle    1bae <APGridPaint+0x27d>
    1b9e:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba1:	8b 50 14             	mov    0x14(%eax),%edx
    1ba4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba7:	8b 40 10             	mov    0x10(%eax),%eax
    1baa:	39 c2                	cmp    %eax,%edx
    1bac:	7c 17                	jl     1bc5 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1bae:	83 ec 08             	sub    $0x8,%esp
    1bb1:	68 ce 24 00 00       	push   $0x24ce
    1bb6:	6a 01                	push   $0x1
    1bb8:	e8 a2 ea ff ff       	call   65f <printf>
    1bbd:	83 c4 10             	add    $0x10,%esp
        return;
    1bc0:	e9 c1 03 00 00       	jmp    1f86 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1bc5:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc8:	8b 40 14             	mov    0x14(%eax),%eax
    1bcb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1bd1:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1bd4:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1bd7:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1bda:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1be1:	e9 96 03 00 00       	jmp    1f7c <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1be6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1bed:	e9 7c 03 00 00       	jmp    1f6e <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1bf2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bf5:	c1 e0 04             	shl    $0x4,%eax
    1bf8:	89 c2                	mov    %eax,%edx
    1bfa:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1bfd:	01 c2                	add    %eax,%edx
    1bff:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c02:	01 d0                	add    %edx,%eax
    1c04:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1c07:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0a:	8b 40 0c             	mov    0xc(%eax),%eax
    1c0d:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1c10:	c1 e2 02             	shl    $0x2,%edx
    1c13:	01 d0                	add    %edx,%eax
    1c15:	8b 00                	mov    (%eax),%eax
    1c17:	83 f8 07             	cmp    $0x7,%eax
    1c1a:	0f 87 49 03 00 00    	ja     1f69 <APGridPaint+0x638>
    1c20:	8b 04 85 e4 24 00 00 	mov    0x24e4(,%eax,4),%eax
    1c27:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c29:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1c2c:	6a 0c                	push   $0xc
    1c2e:	6a 0c                	push   $0xc
    1c30:	6a 0c                	push   $0xc
    1c32:	50                   	push   %eax
    1c33:	e8 46 f9 ff ff       	call   157e <RGB>
    1c38:	83 c4 0c             	add    $0xc,%esp
    1c3b:	8b 1d c8 2d 00 00    	mov    0x2dc8,%ebx
    1c41:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c44:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c47:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c4a:	6b c0 32             	imul   $0x32,%eax,%eax
    1c4d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c50:	8b 45 08             	mov    0x8(%ebp),%eax
    1c53:	8d 78 34             	lea    0x34(%eax),%edi
    1c56:	83 ec 0c             	sub    $0xc,%esp
    1c59:	83 ec 04             	sub    $0x4,%esp
    1c5c:	89 e0                	mov    %esp,%eax
    1c5e:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1c62:	66 89 30             	mov    %si,(%eax)
    1c65:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1c69:	88 50 02             	mov    %dl,0x2(%eax)
    1c6c:	6a 32                	push   $0x32
    1c6e:	6a 32                	push   $0x32
    1c70:	6a 00                	push   $0x0
    1c72:	6a 00                	push   $0x0
    1c74:	53                   	push   %ebx
    1c75:	51                   	push   %ecx
    1c76:	ff 75 94             	pushl  -0x6c(%ebp)
    1c79:	57                   	push   %edi
    1c7a:	e8 5b f7 ff ff       	call   13da <APDcCopy>
    1c7f:	83 c4 30             	add    $0x30,%esp
                    break;
    1c82:	e9 e3 02 00 00       	jmp    1f6a <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1c87:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c8a:	6a 69                	push   $0x69
    1c8c:	6a 69                	push   $0x69
    1c8e:	6a 69                	push   $0x69
    1c90:	50                   	push   %eax
    1c91:	e8 e8 f8 ff ff       	call   157e <RGB>
    1c96:	83 c4 0c             	add    $0xc,%esp
    1c99:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1c9d:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1ca1:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ca5:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1ca8:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1caf:	8d 45 98             	lea    -0x68(%ebp),%eax
    1cb2:	6a 69                	push   $0x69
    1cb4:	6a 69                	push   $0x69
    1cb6:	6a 69                	push   $0x69
    1cb8:	50                   	push   %eax
    1cb9:	e8 c0 f8 ff ff       	call   157e <RGB>
    1cbe:	83 c4 0c             	add    $0xc,%esp
    1cc1:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1cc5:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1cc9:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ccd:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1cd0:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd3:	8d 50 34             	lea    0x34(%eax),%edx
    1cd6:	8d 45 98             	lea    -0x68(%ebp),%eax
    1cd9:	ff 75 bc             	pushl  -0x44(%ebp)
    1cdc:	ff 75 b8             	pushl  -0x48(%ebp)
    1cdf:	52                   	push   %edx
    1ce0:	50                   	push   %eax
    1ce1:	e8 ce f0 ff ff       	call   db4 <APSetPen>
    1ce6:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1ce9:	8b 45 08             	mov    0x8(%ebp),%eax
    1cec:	8d 58 34             	lea    0x34(%eax),%ebx
    1cef:	8d 55 98             	lea    -0x68(%ebp),%edx
    1cf2:	83 ec 04             	sub    $0x4,%esp
    1cf5:	83 ec 04             	sub    $0x4,%esp
    1cf8:	89 e0                	mov    %esp,%eax
    1cfa:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1cfe:	66 89 08             	mov    %cx,(%eax)
    1d01:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1d05:	88 48 02             	mov    %cl,0x2(%eax)
    1d08:	53                   	push   %ebx
    1d09:	52                   	push   %edx
    1d0a:	e8 de f0 ff ff       	call   ded <APSetBrush>
    1d0f:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1d12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d15:	6b d0 32             	imul   $0x32,%eax,%edx
    1d18:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d1b:	6b c0 32             	imul   $0x32,%eax,%eax
    1d1e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1d21:	83 c1 34             	add    $0x34,%ecx
    1d24:	83 ec 0c             	sub    $0xc,%esp
    1d27:	6a 32                	push   $0x32
    1d29:	6a 32                	push   $0x32
    1d2b:	52                   	push   %edx
    1d2c:	50                   	push   %eax
    1d2d:	51                   	push   %ecx
    1d2e:	e8 a2 f4 ff ff       	call   11d5 <APDrawRect>
    1d33:	83 c4 20             	add    $0x20,%esp
                    break;
    1d36:	e9 2f 02 00 00       	jmp    1f6a <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d3b:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1d3e:	6a 0c                	push   $0xc
    1d40:	6a 0c                	push   $0xc
    1d42:	6a 0c                	push   $0xc
    1d44:	50                   	push   %eax
    1d45:	e8 34 f8 ff ff       	call   157e <RGB>
    1d4a:	83 c4 0c             	add    $0xc,%esp
    1d4d:	8b 1d 08 2e 00 00    	mov    0x2e08,%ebx
    1d53:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d56:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d59:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d5c:	6b c0 32             	imul   $0x32,%eax,%eax
    1d5f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d62:	8b 45 08             	mov    0x8(%ebp),%eax
    1d65:	8d 78 34             	lea    0x34(%eax),%edi
    1d68:	83 ec 0c             	sub    $0xc,%esp
    1d6b:	83 ec 04             	sub    $0x4,%esp
    1d6e:	89 e0                	mov    %esp,%eax
    1d70:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1d74:	66 89 30             	mov    %si,(%eax)
    1d77:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1d7b:	88 50 02             	mov    %dl,0x2(%eax)
    1d7e:	6a 32                	push   $0x32
    1d80:	6a 32                	push   $0x32
    1d82:	6a 00                	push   $0x0
    1d84:	6a 00                	push   $0x0
    1d86:	53                   	push   %ebx
    1d87:	51                   	push   %ecx
    1d88:	ff 75 94             	pushl  -0x6c(%ebp)
    1d8b:	57                   	push   %edi
    1d8c:	e8 49 f6 ff ff       	call   13da <APDcCopy>
    1d91:	83 c4 30             	add    $0x30,%esp
                    break;
    1d94:	e9 d1 01 00 00       	jmp    1f6a <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d99:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1d9c:	6a 0c                	push   $0xc
    1d9e:	6a 0c                	push   $0xc
    1da0:	6a 0c                	push   $0xc
    1da2:	50                   	push   %eax
    1da3:	e8 d6 f7 ff ff       	call   157e <RGB>
    1da8:	83 c4 0c             	add    $0xc,%esp
    1dab:	8b 1d e8 2d 00 00    	mov    0x2de8,%ebx
    1db1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1db4:	6b c8 32             	imul   $0x32,%eax,%ecx
    1db7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dba:	6b c0 32             	imul   $0x32,%eax,%eax
    1dbd:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dc0:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc3:	8d 78 34             	lea    0x34(%eax),%edi
    1dc6:	83 ec 0c             	sub    $0xc,%esp
    1dc9:	83 ec 04             	sub    $0x4,%esp
    1dcc:	89 e0                	mov    %esp,%eax
    1dce:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1dd2:	66 89 30             	mov    %si,(%eax)
    1dd5:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1dd9:	88 50 02             	mov    %dl,0x2(%eax)
    1ddc:	6a 32                	push   $0x32
    1dde:	6a 32                	push   $0x32
    1de0:	6a 00                	push   $0x0
    1de2:	6a 00                	push   $0x0
    1de4:	53                   	push   %ebx
    1de5:	51                   	push   %ecx
    1de6:	ff 75 94             	pushl  -0x6c(%ebp)
    1de9:	57                   	push   %edi
    1dea:	e8 eb f5 ff ff       	call   13da <APDcCopy>
    1def:	83 c4 30             	add    $0x30,%esp
                    break;
    1df2:	e9 73 01 00 00       	jmp    1f6a <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1df7:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1dfa:	6a 0c                	push   $0xc
    1dfc:	6a 0c                	push   $0xc
    1dfe:	6a 0c                	push   $0xc
    1e00:	50                   	push   %eax
    1e01:	e8 78 f7 ff ff       	call   157e <RGB>
    1e06:	83 c4 0c             	add    $0xc,%esp
    1e09:	8b 1d cc 2d 00 00    	mov    0x2dcc,%ebx
    1e0f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e12:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e15:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e18:	6b c0 32             	imul   $0x32,%eax,%eax
    1e1b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e1e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e21:	8d 78 34             	lea    0x34(%eax),%edi
    1e24:	83 ec 0c             	sub    $0xc,%esp
    1e27:	83 ec 04             	sub    $0x4,%esp
    1e2a:	89 e0                	mov    %esp,%eax
    1e2c:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1e30:	66 89 30             	mov    %si,(%eax)
    1e33:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1e37:	88 50 02             	mov    %dl,0x2(%eax)
    1e3a:	6a 32                	push   $0x32
    1e3c:	6a 32                	push   $0x32
    1e3e:	6a 00                	push   $0x0
    1e40:	6a 00                	push   $0x0
    1e42:	53                   	push   %ebx
    1e43:	51                   	push   %ecx
    1e44:	ff 75 94             	pushl  -0x6c(%ebp)
    1e47:	57                   	push   %edi
    1e48:	e8 8d f5 ff ff       	call   13da <APDcCopy>
    1e4d:	83 c4 30             	add    $0x30,%esp
                    break;
    1e50:	e9 15 01 00 00       	jmp    1f6a <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e55:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1e58:	6a 0c                	push   $0xc
    1e5a:	6a 0c                	push   $0xc
    1e5c:	6a 0c                	push   $0xc
    1e5e:	50                   	push   %eax
    1e5f:	e8 1a f7 ff ff       	call   157e <RGB>
    1e64:	83 c4 0c             	add    $0xc,%esp
    1e67:	8b 1d 04 2e 00 00    	mov    0x2e04,%ebx
    1e6d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e70:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e73:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e76:	6b c0 32             	imul   $0x32,%eax,%eax
    1e79:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e7c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e7f:	8d 78 34             	lea    0x34(%eax),%edi
    1e82:	83 ec 0c             	sub    $0xc,%esp
    1e85:	83 ec 04             	sub    $0x4,%esp
    1e88:	89 e0                	mov    %esp,%eax
    1e8a:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1e8e:	66 89 30             	mov    %si,(%eax)
    1e91:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1e95:	88 50 02             	mov    %dl,0x2(%eax)
    1e98:	6a 32                	push   $0x32
    1e9a:	6a 32                	push   $0x32
    1e9c:	6a 00                	push   $0x0
    1e9e:	6a 00                	push   $0x0
    1ea0:	53                   	push   %ebx
    1ea1:	51                   	push   %ecx
    1ea2:	ff 75 94             	pushl  -0x6c(%ebp)
    1ea5:	57                   	push   %edi
    1ea6:	e8 2f f5 ff ff       	call   13da <APDcCopy>
    1eab:	83 c4 30             	add    $0x30,%esp
                    break;
    1eae:	e9 b7 00 00 00       	jmp    1f6a <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1eb3:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1eb6:	6a 0c                	push   $0xc
    1eb8:	6a 0c                	push   $0xc
    1eba:	6a 0c                	push   $0xc
    1ebc:	50                   	push   %eax
    1ebd:	e8 bc f6 ff ff       	call   157e <RGB>
    1ec2:	83 c4 0c             	add    $0xc,%esp
    1ec5:	8b 1d 9c 2d 00 00    	mov    0x2d9c,%ebx
    1ecb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ece:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ed1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ed4:	6b c0 32             	imul   $0x32,%eax,%eax
    1ed7:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1eda:	8b 45 08             	mov    0x8(%ebp),%eax
    1edd:	8d 78 34             	lea    0x34(%eax),%edi
    1ee0:	83 ec 0c             	sub    $0xc,%esp
    1ee3:	83 ec 04             	sub    $0x4,%esp
    1ee6:	89 e0                	mov    %esp,%eax
    1ee8:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1eec:	66 89 30             	mov    %si,(%eax)
    1eef:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1ef3:	88 50 02             	mov    %dl,0x2(%eax)
    1ef6:	6a 32                	push   $0x32
    1ef8:	6a 32                	push   $0x32
    1efa:	6a 00                	push   $0x0
    1efc:	6a 00                	push   $0x0
    1efe:	53                   	push   %ebx
    1eff:	51                   	push   %ecx
    1f00:	ff 75 94             	pushl  -0x6c(%ebp)
    1f03:	57                   	push   %edi
    1f04:	e8 d1 f4 ff ff       	call   13da <APDcCopy>
    1f09:	83 c4 30             	add    $0x30,%esp
                    break;
    1f0c:	eb 5c                	jmp    1f6a <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f0e:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1f11:	6a 0c                	push   $0xc
    1f13:	6a 0c                	push   $0xc
    1f15:	6a 0c                	push   $0xc
    1f17:	50                   	push   %eax
    1f18:	e8 61 f6 ff ff       	call   157e <RGB>
    1f1d:	83 c4 0c             	add    $0xc,%esp
    1f20:	8b 1d b8 2d 00 00    	mov    0x2db8,%ebx
    1f26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f29:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f2c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f2f:	6b c0 32             	imul   $0x32,%eax,%eax
    1f32:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f35:	8b 45 08             	mov    0x8(%ebp),%eax
    1f38:	8d 78 34             	lea    0x34(%eax),%edi
    1f3b:	83 ec 0c             	sub    $0xc,%esp
    1f3e:	83 ec 04             	sub    $0x4,%esp
    1f41:	89 e0                	mov    %esp,%eax
    1f43:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1f47:	66 89 30             	mov    %si,(%eax)
    1f4a:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1f4e:	88 50 02             	mov    %dl,0x2(%eax)
    1f51:	6a 32                	push   $0x32
    1f53:	6a 32                	push   $0x32
    1f55:	6a 00                	push   $0x0
    1f57:	6a 00                	push   $0x0
    1f59:	53                   	push   %ebx
    1f5a:	51                   	push   %ecx
    1f5b:	ff 75 94             	pushl  -0x6c(%ebp)
    1f5e:	57                   	push   %edi
    1f5f:	e8 76 f4 ff ff       	call   13da <APDcCopy>
    1f64:	83 c4 30             	add    $0x30,%esp
                    break;
    1f67:	eb 01                	jmp    1f6a <APGridPaint+0x639>
                default: break;
    1f69:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1f6a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1f6e:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1f72:	0f 8e 7a fc ff ff    	jle    1bf2 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1f78:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1f7c:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1f80:	0f 8e 60 fc ff ff    	jle    1be6 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1f86:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1f89:	5b                   	pop    %ebx
    1f8a:	5e                   	pop    %esi
    1f8b:	5f                   	pop    %edi
    1f8c:	5d                   	pop    %ebp
    1f8d:	c3                   	ret    

00001f8e <random>:
//

#include "APLib.h"

int random(int seed)
{
    1f8e:	55                   	push   %ebp
    1f8f:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1f91:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1f95:	7e 08                	jle    1f9f <random+0x11>
{
rand_num = seed;
    1f97:	8b 45 08             	mov    0x8(%ebp),%eax
    1f9a:	a3 74 2d 00 00       	mov    %eax,0x2d74
}
rand_num *= 3;
    1f9f:	8b 15 74 2d 00 00    	mov    0x2d74,%edx
    1fa5:	89 d0                	mov    %edx,%eax
    1fa7:	01 c0                	add    %eax,%eax
    1fa9:	01 d0                	add    %edx,%eax
    1fab:	a3 74 2d 00 00       	mov    %eax,0x2d74
if (rand_num < 0)
    1fb0:	a1 74 2d 00 00       	mov    0x2d74,%eax
    1fb5:	85 c0                	test   %eax,%eax
    1fb7:	79 0c                	jns    1fc5 <random+0x37>
{
rand_num *= (-1);
    1fb9:	a1 74 2d 00 00       	mov    0x2d74,%eax
    1fbe:	f7 d8                	neg    %eax
    1fc0:	a3 74 2d 00 00       	mov    %eax,0x2d74
}
return rand_num % 997;
    1fc5:	8b 0d 74 2d 00 00    	mov    0x2d74,%ecx
    1fcb:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1fd0:	89 c8                	mov    %ecx,%eax
    1fd2:	f7 ea                	imul   %edx
    1fd4:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1fd7:	c1 f8 09             	sar    $0x9,%eax
    1fda:	89 c2                	mov    %eax,%edx
    1fdc:	89 c8                	mov    %ecx,%eax
    1fde:	c1 f8 1f             	sar    $0x1f,%eax
    1fe1:	29 c2                	sub    %eax,%edx
    1fe3:	89 d0                	mov    %edx,%eax
    1fe5:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1feb:	29 c1                	sub    %eax,%ecx
    1fed:	89 c8                	mov    %ecx,%eax
}
    1fef:	5d                   	pop    %ebp
    1ff0:	c3                   	ret    

00001ff1 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1ff1:	55                   	push   %ebp
    1ff2:	89 e5                	mov    %esp,%ebp
    1ff4:	53                   	push   %ebx
    1ff5:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1ff8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1fff:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2003:	74 17                	je     201c <sprintint+0x2b>
    2005:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2009:	79 11                	jns    201c <sprintint+0x2b>
        neg = 1;
    200b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2012:	8b 45 10             	mov    0x10(%ebp),%eax
    2015:	f7 d8                	neg    %eax
    2017:	89 45 f0             	mov    %eax,-0x10(%ebp)
    201a:	eb 06                	jmp    2022 <sprintint+0x31>
    } else {
        x = xx;
    201c:	8b 45 10             	mov    0x10(%ebp),%eax
    201f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2022:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2029:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    202c:	8d 41 01             	lea    0x1(%ecx),%eax
    202f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2032:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2035:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2038:	ba 00 00 00 00       	mov    $0x0,%edx
    203d:	f7 f3                	div    %ebx
    203f:	89 d0                	mov    %edx,%eax
    2041:	0f b6 80 78 2d 00 00 	movzbl 0x2d78(%eax),%eax
    2048:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    204c:	8b 5d 14             	mov    0x14(%ebp),%ebx
    204f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2052:	ba 00 00 00 00       	mov    $0x0,%edx
    2057:	f7 f3                	div    %ebx
    2059:	89 45 f0             	mov    %eax,-0x10(%ebp)
    205c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2060:	75 c7                	jne    2029 <sprintint+0x38>
    if(neg)
    2062:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2066:	74 0e                	je     2076 <sprintint+0x85>
        buf[i++] = '-';
    2068:	8b 45 f8             	mov    -0x8(%ebp),%eax
    206b:	8d 50 01             	lea    0x1(%eax),%edx
    206e:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2071:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2076:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2079:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    207c:	eb 1b                	jmp    2099 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    207e:	8b 45 0c             	mov    0xc(%ebp),%eax
    2081:	8b 00                	mov    (%eax),%eax
    2083:	8d 48 01             	lea    0x1(%eax),%ecx
    2086:	8b 55 0c             	mov    0xc(%ebp),%edx
    2089:	89 0a                	mov    %ecx,(%edx)
    208b:	89 c2                	mov    %eax,%edx
    208d:	8b 45 08             	mov    0x8(%ebp),%eax
    2090:	01 d0                	add    %edx,%eax
    2092:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2095:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2099:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    209d:	7f df                	jg     207e <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    209f:	eb 21                	jmp    20c2 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    20a1:	8b 45 0c             	mov    0xc(%ebp),%eax
    20a4:	8b 00                	mov    (%eax),%eax
    20a6:	8d 48 01             	lea    0x1(%eax),%ecx
    20a9:	8b 55 0c             	mov    0xc(%ebp),%edx
    20ac:	89 0a                	mov    %ecx,(%edx)
    20ae:	89 c2                	mov    %eax,%edx
    20b0:	8b 45 08             	mov    0x8(%ebp),%eax
    20b3:	01 c2                	add    %eax,%edx
    20b5:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    20b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20bb:	01 c8                	add    %ecx,%eax
    20bd:	0f b6 00             	movzbl (%eax),%eax
    20c0:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    20c2:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    20c6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    20ca:	79 d5                	jns    20a1 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    20cc:	90                   	nop
    20cd:	83 c4 20             	add    $0x20,%esp
    20d0:	5b                   	pop    %ebx
    20d1:	5d                   	pop    %ebp
    20d2:	c3                   	ret    

000020d3 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    20d3:	55                   	push   %ebp
    20d4:	89 e5                	mov    %esp,%ebp
    20d6:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    20d9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    20e0:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    20e7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    20ee:	8d 45 0c             	lea    0xc(%ebp),%eax
    20f1:	83 c0 04             	add    $0x4,%eax
    20f4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    20f7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    20fe:	e9 d9 01 00 00       	jmp    22dc <sprintf+0x209>
        c = fmt[i] & 0xff;
    2103:	8b 55 0c             	mov    0xc(%ebp),%edx
    2106:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2109:	01 d0                	add    %edx,%eax
    210b:	0f b6 00             	movzbl (%eax),%eax
    210e:	0f be c0             	movsbl %al,%eax
    2111:	25 ff 00 00 00       	and    $0xff,%eax
    2116:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2119:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    211d:	75 2c                	jne    214b <sprintf+0x78>
            if(c == '%'){
    211f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2123:	75 0c                	jne    2131 <sprintf+0x5e>
                state = '%';
    2125:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    212c:	e9 a7 01 00 00       	jmp    22d8 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2131:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2134:	8d 50 01             	lea    0x1(%eax),%edx
    2137:	89 55 c8             	mov    %edx,-0x38(%ebp)
    213a:	89 c2                	mov    %eax,%edx
    213c:	8b 45 08             	mov    0x8(%ebp),%eax
    213f:	01 d0                	add    %edx,%eax
    2141:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2144:	88 10                	mov    %dl,(%eax)
    2146:	e9 8d 01 00 00       	jmp    22d8 <sprintf+0x205>
            }
        } else if(state == '%'){
    214b:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    214f:	0f 85 83 01 00 00    	jne    22d8 <sprintf+0x205>
            if(c == 'd'){
    2155:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2159:	75 4c                	jne    21a7 <sprintf+0xd4>
                buf[bi] = '\0';
    215b:	8d 55 ce             	lea    -0x32(%ebp),%edx
    215e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2161:	01 d0                	add    %edx,%eax
    2163:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2166:	83 ec 0c             	sub    $0xc,%esp
    2169:	8d 45 ce             	lea    -0x32(%ebp),%eax
    216c:	50                   	push   %eax
    216d:	e8 b4 e2 ff ff       	call   426 <atoi>
    2172:	83 c4 10             	add    $0x10,%esp
    2175:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2178:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    217f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2182:	8b 00                	mov    (%eax),%eax
    2184:	83 ec 08             	sub    $0x8,%esp
    2187:	ff 75 d8             	pushl  -0x28(%ebp)
    218a:	6a 01                	push   $0x1
    218c:	6a 0a                	push   $0xa
    218e:	50                   	push   %eax
    218f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2192:	50                   	push   %eax
    2193:	ff 75 08             	pushl  0x8(%ebp)
    2196:	e8 56 fe ff ff       	call   1ff1 <sprintint>
    219b:	83 c4 20             	add    $0x20,%esp
                ap++;
    219e:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    21a2:	e9 2a 01 00 00       	jmp    22d1 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    21a7:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    21ab:	74 06                	je     21b3 <sprintf+0xe0>
    21ad:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    21b1:	75 4c                	jne    21ff <sprintf+0x12c>
                buf[bi] = '\0';
    21b3:	8d 55 ce             	lea    -0x32(%ebp),%edx
    21b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21b9:	01 d0                	add    %edx,%eax
    21bb:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    21be:	83 ec 0c             	sub    $0xc,%esp
    21c1:	8d 45 ce             	lea    -0x32(%ebp),%eax
    21c4:	50                   	push   %eax
    21c5:	e8 5c e2 ff ff       	call   426 <atoi>
    21ca:	83 c4 10             	add    $0x10,%esp
    21cd:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    21d0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    21d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21da:	8b 00                	mov    (%eax),%eax
    21dc:	83 ec 08             	sub    $0x8,%esp
    21df:	ff 75 dc             	pushl  -0x24(%ebp)
    21e2:	6a 00                	push   $0x0
    21e4:	6a 10                	push   $0x10
    21e6:	50                   	push   %eax
    21e7:	8d 45 c8             	lea    -0x38(%ebp),%eax
    21ea:	50                   	push   %eax
    21eb:	ff 75 08             	pushl  0x8(%ebp)
    21ee:	e8 fe fd ff ff       	call   1ff1 <sprintint>
    21f3:	83 c4 20             	add    $0x20,%esp
                ap++;
    21f6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    21fa:	e9 d2 00 00 00       	jmp    22d1 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    21ff:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2203:	75 46                	jne    224b <sprintf+0x178>
                s = (char*)*ap;
    2205:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2208:	8b 00                	mov    (%eax),%eax
    220a:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    220d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2211:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2215:	75 25                	jne    223c <sprintf+0x169>
                    s = "(null)";
    2217:	c7 45 f4 04 25 00 00 	movl   $0x2504,-0xc(%ebp)
                while(*s != 0){
    221e:	eb 1c                	jmp    223c <sprintf+0x169>
                    dst[j++] = *s;
    2220:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2223:	8d 50 01             	lea    0x1(%eax),%edx
    2226:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2229:	89 c2                	mov    %eax,%edx
    222b:	8b 45 08             	mov    0x8(%ebp),%eax
    222e:	01 c2                	add    %eax,%edx
    2230:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2233:	0f b6 00             	movzbl (%eax),%eax
    2236:	88 02                	mov    %al,(%edx)
                    s++;
    2238:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    223c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    223f:	0f b6 00             	movzbl (%eax),%eax
    2242:	84 c0                	test   %al,%al
    2244:	75 da                	jne    2220 <sprintf+0x14d>
    2246:	e9 86 00 00 00       	jmp    22d1 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    224b:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    224f:	75 1d                	jne    226e <sprintf+0x19b>
                dst[j++] = *ap;
    2251:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2254:	8d 50 01             	lea    0x1(%eax),%edx
    2257:	89 55 c8             	mov    %edx,-0x38(%ebp)
    225a:	89 c2                	mov    %eax,%edx
    225c:	8b 45 08             	mov    0x8(%ebp),%eax
    225f:	01 c2                	add    %eax,%edx
    2261:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2264:	8b 00                	mov    (%eax),%eax
    2266:	88 02                	mov    %al,(%edx)
                ap++;
    2268:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    226c:	eb 63                	jmp    22d1 <sprintf+0x1fe>
            } else if(c == '%'){
    226e:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2272:	75 17                	jne    228b <sprintf+0x1b8>
                dst[j++] = c;
    2274:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2277:	8d 50 01             	lea    0x1(%eax),%edx
    227a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    227d:	89 c2                	mov    %eax,%edx
    227f:	8b 45 08             	mov    0x8(%ebp),%eax
    2282:	01 d0                	add    %edx,%eax
    2284:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2287:	88 10                	mov    %dl,(%eax)
    2289:	eb 46                	jmp    22d1 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    228b:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    228f:	7e 18                	jle    22a9 <sprintf+0x1d6>
    2291:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2295:	7f 12                	jg     22a9 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2297:	8b 45 f0             	mov    -0x10(%ebp),%eax
    229a:	8d 50 01             	lea    0x1(%eax),%edx
    229d:	89 55 f0             	mov    %edx,-0x10(%ebp)
    22a0:	8b 55 e0             	mov    -0x20(%ebp),%edx
    22a3:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    22a7:	eb 2f                	jmp    22d8 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    22a9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22ac:	8d 50 01             	lea    0x1(%eax),%edx
    22af:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22b2:	89 c2                	mov    %eax,%edx
    22b4:	8b 45 08             	mov    0x8(%ebp),%eax
    22b7:	01 d0                	add    %edx,%eax
    22b9:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    22bc:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22bf:	8d 50 01             	lea    0x1(%eax),%edx
    22c2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22c5:	89 c2                	mov    %eax,%edx
    22c7:	8b 45 08             	mov    0x8(%ebp),%eax
    22ca:	01 d0                	add    %edx,%eax
    22cc:	8b 55 e0             	mov    -0x20(%ebp),%edx
    22cf:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    22d1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    22d8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    22dc:	8b 55 0c             	mov    0xc(%ebp),%edx
    22df:	8b 45 ec             	mov    -0x14(%ebp),%eax
    22e2:	01 d0                	add    %edx,%eax
    22e4:	0f b6 00             	movzbl (%eax),%eax
    22e7:	84 c0                	test   %al,%al
    22e9:	0f 85 14 fe ff ff    	jne    2103 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    22ef:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22f2:	8d 50 01             	lea    0x1(%eax),%edx
    22f5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22f8:	89 c2                	mov    %eax,%edx
    22fa:	8b 45 08             	mov    0x8(%ebp),%eax
    22fd:	01 d0                	add    %edx,%eax
    22ff:	c6 00 00             	movb   $0x0,(%eax)
}
    2302:	90                   	nop
    2303:	c9                   	leave  
    2304:	c3                   	ret    
