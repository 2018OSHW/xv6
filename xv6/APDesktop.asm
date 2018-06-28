
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
       9:	68 c4 22 00 00       	push   $0x22c4
       e:	6a 01                	push   $0x1
      10:	e8 6a 06 00 00       	call   67f <printf>
      15:	83 c4 10             	add    $0x10,%esp
    int fd = open("ASCII", O_RDONLY);
      18:	83 ec 08             	sub    $0x8,%esp
      1b:	6a 00                	push   $0x0
      1d:	68 d0 22 00 00       	push   $0x22d0
      22:	e8 f1 04 00 00       	call   518 <open>
      27:	83 c4 10             	add    $0x10,%esp
      2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (fd < 0)
      2d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      31:	79 14                	jns    47 <desktopInitStringFigure+0x47>
    {
        printf(1, "Cannot open file\n");
      33:	83 ec 08             	sub    $0x8,%esp
      36:	68 d6 22 00 00       	push   $0x22d6
      3b:	6a 01                	push   $0x1
      3d:	e8 3d 06 00 00       	call   67f <printf>
      42:	83 c4 10             	add    $0x10,%esp
        return;
      45:	eb 7d                	jmp    c4 <desktopInitStringFigure+0xc4>
    }
    char * ASCII = (char *)malloc(sizeof(char) * ASCII_SIZE);
      47:	83 ec 0c             	sub    $0xc,%esp
      4a:	68 00 08 00 00       	push   $0x800
      4f:	e8 fe 08 00 00       	call   952 <malloc>
      54:	83 c4 10             	add    $0x10,%esp
      57:	89 45 f0             	mov    %eax,-0x10(%ebp)
    read(fd, ASCII, sizeof(char) * ASCII_SIZE);
      5a:	83 ec 04             	sub    $0x4,%esp
      5d:	68 00 08 00 00       	push   $0x800
      62:	ff 75 f0             	pushl  -0x10(%ebp)
      65:	ff 75 f4             	pushl  -0xc(%ebp)
      68:	e8 83 04 00 00       	call   4f0 <read>
      6d:	83 c4 10             	add    $0x10,%esp
    close(fd);
      70:	83 ec 0c             	sub    $0xc,%esp
      73:	ff 75 f4             	pushl  -0xc(%ebp)
      76:	e8 85 04 00 00       	call   500 <close>
      7b:	83 c4 10             	add    $0x10,%esp
    printf(1, "read ASCII complete\n");
      7e:	83 ec 08             	sub    $0x8,%esp
      81:	68 e8 22 00 00       	push   $0x22e8
      86:	6a 01                	push   $0x1
      88:	e8 f2 05 00 00       	call   67f <printf>
      8d:	83 c4 10             	add    $0x10,%esp
    
    initStringFigure(0, 0, ASCII, ASCII_SIZE);
      90:	68 00 08 00 00       	push   $0x800
      95:	ff 75 f0             	pushl  -0x10(%ebp)
      98:	6a 00                	push   $0x0
      9a:	6a 00                	push   $0x0
      9c:	e8 df 04 00 00       	call   580 <initStringFigure>
      a1:	83 c4 10             	add    $0x10,%esp
    //free(GBK2312);
    free(ASCII);
      a4:	83 ec 0c             	sub    $0xc,%esp
      a7:	ff 75 f0             	pushl  -0x10(%ebp)
      aa:	e8 61 07 00 00       	call   810 <free>
      af:	83 c4 10             	add    $0x10,%esp
    printf(1, "init string figure complete\n");
      b2:	83 ec 08             	sub    $0x8,%esp
      b5:	68 fd 22 00 00       	push   $0x22fd
      ba:	6a 01                	push   $0x1
      bc:	e8 be 05 00 00       	call   67f <printf>
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
      cc:	e8 ff 03 00 00       	call   4d0 <fork>
      d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    char temp[30];
    if (pid == 0)
      d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      d8:	75 37                	jne    111 <runApp+0x4b>
    {
        sprintf(temp, "AP%s", (char *)param);
      da:	83 ec 04             	sub    $0x4,%esp
      dd:	ff 75 08             	pushl  0x8(%ebp)
      e0:	68 1a 23 00 00       	push   $0x231a
      e5:	8d 45 d6             	lea    -0x2a(%ebp),%eax
      e8:	50                   	push   %eax
      e9:	e8 a2 1f 00 00       	call   2090 <sprintf>
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
     109:	e8 02 04 00 00       	call   510 <exec>
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
     18d:	8b 04 85 40 2a 00 00 	mov    0x2a40(,%eax,4),%eax
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
     1bd:	e8 21 14 00 00       	call   15e3 <APSendMessage>
     1c2:	83 c4 10             	add    $0x10,%esp
            return False;
     1c5:	b8 00 00 00 00       	mov    $0x0,%eax
     1ca:	eb 56                	jmp    222 <wndProc+0x10e>
        case MSG_PAINT:
            APGridPaint(hwnd);
     1cc:	83 ec 0c             	sub    $0xc,%esp
     1cf:	ff 75 08             	pushl  0x8(%ebp)
     1d2:	e8 7a 17 00 00       	call   1951 <APGridPaint>
     1d7:	83 c4 10             	add    $0x10,%esp
            break;
     1da:	eb 32                	jmp    20e <wndProc+0xfa>
        case MSG_KEY_DOWN:
            printf(1,"kbd message received!\n");
     1dc:	83 ec 08             	sub    $0x8,%esp
     1df:	68 1f 23 00 00       	push   $0x231f
     1e4:	6a 01                	push   $0x1
     1e6:	e8 94 04 00 00       	call   67f <printf>
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
     204:	e8 97 03 00 00       	call   5a0 <changePosition>
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
     21a:	e8 32 16 00 00       	call   1851 <APWndProc>
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
     232:	83 ec 14             	sub    $0x14,%esp
    desktopInitStringFigure();
     235:	e8 c6 fd ff ff       	call   0 <desktopInitStringFigure>
    AHwnd r = APCreateWindow("desktop",True,3);
     23a:	83 ec 04             	sub    $0x4,%esp
     23d:	6a 03                	push   $0x3
     23f:	6a 01                	push   $0x1
     241:	68 36 23 00 00       	push   $0x2336
     246:	e8 b6 13 00 00       	call   1601 <APCreateWindow>
     24b:	83 c4 10             	add    $0x10,%esp
     24e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    AHwnd hwnd = r;
     251:	8b 45 f4             	mov    -0xc(%ebp),%eax
     254:	89 45 f0             	mov    %eax,-0x10(%ebp)
    printf(1,"desktop initialized!\n");
     257:	83 ec 08             	sub    $0x8,%esp
     25a:	68 3e 23 00 00       	push   $0x233e
     25f:	6a 01                	push   $0x1
     261:	e8 19 04 00 00       	call   67f <printf>
     266:	83 c4 10             	add    $0x10,%esp
    APWndExec(hwnd, wndProc);
     269:	83 ec 08             	sub    $0x8,%esp
     26c:	68 14 01 00 00       	push   $0x114
     271:	ff 75 f0             	pushl  -0x10(%ebp)
     274:	e8 46 16 00 00       	call   18bf <APWndExec>
     279:	83 c4 10             	add    $0x10,%esp
    exit();
     27c:	e8 57 02 00 00       	call   4d8 <exit>

00000281 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     281:	55                   	push   %ebp
     282:	89 e5                	mov    %esp,%ebp
     284:	57                   	push   %edi
     285:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     286:	8b 4d 08             	mov    0x8(%ebp),%ecx
     289:	8b 55 10             	mov    0x10(%ebp),%edx
     28c:	8b 45 0c             	mov    0xc(%ebp),%eax
     28f:	89 cb                	mov    %ecx,%ebx
     291:	89 df                	mov    %ebx,%edi
     293:	89 d1                	mov    %edx,%ecx
     295:	fc                   	cld    
     296:	f3 aa                	rep stos %al,%es:(%edi)
     298:	89 ca                	mov    %ecx,%edx
     29a:	89 fb                	mov    %edi,%ebx
     29c:	89 5d 08             	mov    %ebx,0x8(%ebp)
     29f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     2a2:	90                   	nop
     2a3:	5b                   	pop    %ebx
     2a4:	5f                   	pop    %edi
     2a5:	5d                   	pop    %ebp
     2a6:	c3                   	ret    

000002a7 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     2a7:	55                   	push   %ebp
     2a8:	89 e5                	mov    %esp,%ebp
     2aa:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     2ad:	8b 45 08             	mov    0x8(%ebp),%eax
     2b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     2b3:	90                   	nop
     2b4:	8b 45 08             	mov    0x8(%ebp),%eax
     2b7:	8d 50 01             	lea    0x1(%eax),%edx
     2ba:	89 55 08             	mov    %edx,0x8(%ebp)
     2bd:	8b 55 0c             	mov    0xc(%ebp),%edx
     2c0:	8d 4a 01             	lea    0x1(%edx),%ecx
     2c3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     2c6:	0f b6 12             	movzbl (%edx),%edx
     2c9:	88 10                	mov    %dl,(%eax)
     2cb:	0f b6 00             	movzbl (%eax),%eax
     2ce:	84 c0                	test   %al,%al
     2d0:	75 e2                	jne    2b4 <strcpy+0xd>
    ;
  return os;
     2d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     2d5:	c9                   	leave  
     2d6:	c3                   	ret    

000002d7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     2d7:	55                   	push   %ebp
     2d8:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     2da:	eb 08                	jmp    2e4 <strcmp+0xd>
    p++, q++;
     2dc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2e0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     2e4:	8b 45 08             	mov    0x8(%ebp),%eax
     2e7:	0f b6 00             	movzbl (%eax),%eax
     2ea:	84 c0                	test   %al,%al
     2ec:	74 10                	je     2fe <strcmp+0x27>
     2ee:	8b 45 08             	mov    0x8(%ebp),%eax
     2f1:	0f b6 10             	movzbl (%eax),%edx
     2f4:	8b 45 0c             	mov    0xc(%ebp),%eax
     2f7:	0f b6 00             	movzbl (%eax),%eax
     2fa:	38 c2                	cmp    %al,%dl
     2fc:	74 de                	je     2dc <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     2fe:	8b 45 08             	mov    0x8(%ebp),%eax
     301:	0f b6 00             	movzbl (%eax),%eax
     304:	0f b6 d0             	movzbl %al,%edx
     307:	8b 45 0c             	mov    0xc(%ebp),%eax
     30a:	0f b6 00             	movzbl (%eax),%eax
     30d:	0f b6 c0             	movzbl %al,%eax
     310:	29 c2                	sub    %eax,%edx
     312:	89 d0                	mov    %edx,%eax
}
     314:	5d                   	pop    %ebp
     315:	c3                   	ret    

00000316 <strlen>:

uint
strlen(char *s)
{
     316:	55                   	push   %ebp
     317:	89 e5                	mov    %esp,%ebp
     319:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     31c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     323:	eb 04                	jmp    329 <strlen+0x13>
     325:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     329:	8b 55 fc             	mov    -0x4(%ebp),%edx
     32c:	8b 45 08             	mov    0x8(%ebp),%eax
     32f:	01 d0                	add    %edx,%eax
     331:	0f b6 00             	movzbl (%eax),%eax
     334:	84 c0                	test   %al,%al
     336:	75 ed                	jne    325 <strlen+0xf>
    ;
  return n;
     338:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     33b:	c9                   	leave  
     33c:	c3                   	ret    

0000033d <memset>:

void*
memset(void *dst, int c, uint n)
{
     33d:	55                   	push   %ebp
     33e:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     340:	8b 45 10             	mov    0x10(%ebp),%eax
     343:	50                   	push   %eax
     344:	ff 75 0c             	pushl  0xc(%ebp)
     347:	ff 75 08             	pushl  0x8(%ebp)
     34a:	e8 32 ff ff ff       	call   281 <stosb>
     34f:	83 c4 0c             	add    $0xc,%esp
  return dst;
     352:	8b 45 08             	mov    0x8(%ebp),%eax
}
     355:	c9                   	leave  
     356:	c3                   	ret    

00000357 <strchr>:

char*
strchr(const char *s, char c)
{
     357:	55                   	push   %ebp
     358:	89 e5                	mov    %esp,%ebp
     35a:	83 ec 04             	sub    $0x4,%esp
     35d:	8b 45 0c             	mov    0xc(%ebp),%eax
     360:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     363:	eb 14                	jmp    379 <strchr+0x22>
    if(*s == c)
     365:	8b 45 08             	mov    0x8(%ebp),%eax
     368:	0f b6 00             	movzbl (%eax),%eax
     36b:	3a 45 fc             	cmp    -0x4(%ebp),%al
     36e:	75 05                	jne    375 <strchr+0x1e>
      return (char*)s;
     370:	8b 45 08             	mov    0x8(%ebp),%eax
     373:	eb 13                	jmp    388 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     375:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     379:	8b 45 08             	mov    0x8(%ebp),%eax
     37c:	0f b6 00             	movzbl (%eax),%eax
     37f:	84 c0                	test   %al,%al
     381:	75 e2                	jne    365 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     383:	b8 00 00 00 00       	mov    $0x0,%eax
}
     388:	c9                   	leave  
     389:	c3                   	ret    

0000038a <gets>:

char*
gets(char *buf, int max)
{
     38a:	55                   	push   %ebp
     38b:	89 e5                	mov    %esp,%ebp
     38d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     390:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     397:	eb 42                	jmp    3db <gets+0x51>
    cc = read(0, &c, 1);
     399:	83 ec 04             	sub    $0x4,%esp
     39c:	6a 01                	push   $0x1
     39e:	8d 45 ef             	lea    -0x11(%ebp),%eax
     3a1:	50                   	push   %eax
     3a2:	6a 00                	push   $0x0
     3a4:	e8 47 01 00 00       	call   4f0 <read>
     3a9:	83 c4 10             	add    $0x10,%esp
     3ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     3af:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3b3:	7e 33                	jle    3e8 <gets+0x5e>
      break;
    buf[i++] = c;
     3b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3b8:	8d 50 01             	lea    0x1(%eax),%edx
     3bb:	89 55 f4             	mov    %edx,-0xc(%ebp)
     3be:	89 c2                	mov    %eax,%edx
     3c0:	8b 45 08             	mov    0x8(%ebp),%eax
     3c3:	01 c2                	add    %eax,%edx
     3c5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     3c9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     3cb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     3cf:	3c 0a                	cmp    $0xa,%al
     3d1:	74 16                	je     3e9 <gets+0x5f>
     3d3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     3d7:	3c 0d                	cmp    $0xd,%al
     3d9:	74 0e                	je     3e9 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     3db:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3de:	83 c0 01             	add    $0x1,%eax
     3e1:	3b 45 0c             	cmp    0xc(%ebp),%eax
     3e4:	7c b3                	jl     399 <gets+0xf>
     3e6:	eb 01                	jmp    3e9 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     3e8:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     3e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     3ec:	8b 45 08             	mov    0x8(%ebp),%eax
     3ef:	01 d0                	add    %edx,%eax
     3f1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     3f4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     3f7:	c9                   	leave  
     3f8:	c3                   	ret    

000003f9 <stat>:

int
stat(char *n, struct stat *st)
{
     3f9:	55                   	push   %ebp
     3fa:	89 e5                	mov    %esp,%ebp
     3fc:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3ff:	83 ec 08             	sub    $0x8,%esp
     402:	6a 00                	push   $0x0
     404:	ff 75 08             	pushl  0x8(%ebp)
     407:	e8 0c 01 00 00       	call   518 <open>
     40c:	83 c4 10             	add    $0x10,%esp
     40f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     412:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     416:	79 07                	jns    41f <stat+0x26>
    return -1;
     418:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     41d:	eb 25                	jmp    444 <stat+0x4b>
  r = fstat(fd, st);
     41f:	83 ec 08             	sub    $0x8,%esp
     422:	ff 75 0c             	pushl  0xc(%ebp)
     425:	ff 75 f4             	pushl  -0xc(%ebp)
     428:	e8 03 01 00 00       	call   530 <fstat>
     42d:	83 c4 10             	add    $0x10,%esp
     430:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     433:	83 ec 0c             	sub    $0xc,%esp
     436:	ff 75 f4             	pushl  -0xc(%ebp)
     439:	e8 c2 00 00 00       	call   500 <close>
     43e:	83 c4 10             	add    $0x10,%esp
  return r;
     441:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     444:	c9                   	leave  
     445:	c3                   	ret    

00000446 <atoi>:

int
atoi(const char *s)
{
     446:	55                   	push   %ebp
     447:	89 e5                	mov    %esp,%ebp
     449:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     44c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     453:	eb 25                	jmp    47a <atoi+0x34>
    n = n*10 + *s++ - '0';
     455:	8b 55 fc             	mov    -0x4(%ebp),%edx
     458:	89 d0                	mov    %edx,%eax
     45a:	c1 e0 02             	shl    $0x2,%eax
     45d:	01 d0                	add    %edx,%eax
     45f:	01 c0                	add    %eax,%eax
     461:	89 c1                	mov    %eax,%ecx
     463:	8b 45 08             	mov    0x8(%ebp),%eax
     466:	8d 50 01             	lea    0x1(%eax),%edx
     469:	89 55 08             	mov    %edx,0x8(%ebp)
     46c:	0f b6 00             	movzbl (%eax),%eax
     46f:	0f be c0             	movsbl %al,%eax
     472:	01 c8                	add    %ecx,%eax
     474:	83 e8 30             	sub    $0x30,%eax
     477:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     47a:	8b 45 08             	mov    0x8(%ebp),%eax
     47d:	0f b6 00             	movzbl (%eax),%eax
     480:	3c 2f                	cmp    $0x2f,%al
     482:	7e 0a                	jle    48e <atoi+0x48>
     484:	8b 45 08             	mov    0x8(%ebp),%eax
     487:	0f b6 00             	movzbl (%eax),%eax
     48a:	3c 39                	cmp    $0x39,%al
     48c:	7e c7                	jle    455 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     48e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     491:	c9                   	leave  
     492:	c3                   	ret    

00000493 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     493:	55                   	push   %ebp
     494:	89 e5                	mov    %esp,%ebp
     496:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     499:	8b 45 08             	mov    0x8(%ebp),%eax
     49c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     49f:	8b 45 0c             	mov    0xc(%ebp),%eax
     4a2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     4a5:	eb 17                	jmp    4be <memmove+0x2b>
    *dst++ = *src++;
     4a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4aa:	8d 50 01             	lea    0x1(%eax),%edx
     4ad:	89 55 fc             	mov    %edx,-0x4(%ebp)
     4b0:	8b 55 f8             	mov    -0x8(%ebp),%edx
     4b3:	8d 4a 01             	lea    0x1(%edx),%ecx
     4b6:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     4b9:	0f b6 12             	movzbl (%edx),%edx
     4bc:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     4be:	8b 45 10             	mov    0x10(%ebp),%eax
     4c1:	8d 50 ff             	lea    -0x1(%eax),%edx
     4c4:	89 55 10             	mov    %edx,0x10(%ebp)
     4c7:	85 c0                	test   %eax,%eax
     4c9:	7f dc                	jg     4a7 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     4cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
     4ce:	c9                   	leave  
     4cf:	c3                   	ret    

000004d0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     4d0:	b8 01 00 00 00       	mov    $0x1,%eax
     4d5:	cd 40                	int    $0x40
     4d7:	c3                   	ret    

000004d8 <exit>:
SYSCALL(exit)
     4d8:	b8 02 00 00 00       	mov    $0x2,%eax
     4dd:	cd 40                	int    $0x40
     4df:	c3                   	ret    

000004e0 <wait>:
SYSCALL(wait)
     4e0:	b8 03 00 00 00       	mov    $0x3,%eax
     4e5:	cd 40                	int    $0x40
     4e7:	c3                   	ret    

000004e8 <pipe>:
SYSCALL(pipe)
     4e8:	b8 04 00 00 00       	mov    $0x4,%eax
     4ed:	cd 40                	int    $0x40
     4ef:	c3                   	ret    

000004f0 <read>:
SYSCALL(read)
     4f0:	b8 05 00 00 00       	mov    $0x5,%eax
     4f5:	cd 40                	int    $0x40
     4f7:	c3                   	ret    

000004f8 <write>:
SYSCALL(write)
     4f8:	b8 10 00 00 00       	mov    $0x10,%eax
     4fd:	cd 40                	int    $0x40
     4ff:	c3                   	ret    

00000500 <close>:
SYSCALL(close)
     500:	b8 15 00 00 00       	mov    $0x15,%eax
     505:	cd 40                	int    $0x40
     507:	c3                   	ret    

00000508 <kill>:
SYSCALL(kill)
     508:	b8 06 00 00 00       	mov    $0x6,%eax
     50d:	cd 40                	int    $0x40
     50f:	c3                   	ret    

00000510 <exec>:
SYSCALL(exec)
     510:	b8 07 00 00 00       	mov    $0x7,%eax
     515:	cd 40                	int    $0x40
     517:	c3                   	ret    

00000518 <open>:
SYSCALL(open)
     518:	b8 0f 00 00 00       	mov    $0xf,%eax
     51d:	cd 40                	int    $0x40
     51f:	c3                   	ret    

00000520 <mknod>:
SYSCALL(mknod)
     520:	b8 11 00 00 00       	mov    $0x11,%eax
     525:	cd 40                	int    $0x40
     527:	c3                   	ret    

00000528 <unlink>:
SYSCALL(unlink)
     528:	b8 12 00 00 00       	mov    $0x12,%eax
     52d:	cd 40                	int    $0x40
     52f:	c3                   	ret    

00000530 <fstat>:
SYSCALL(fstat)
     530:	b8 08 00 00 00       	mov    $0x8,%eax
     535:	cd 40                	int    $0x40
     537:	c3                   	ret    

00000538 <link>:
SYSCALL(link)
     538:	b8 13 00 00 00       	mov    $0x13,%eax
     53d:	cd 40                	int    $0x40
     53f:	c3                   	ret    

00000540 <mkdir>:
SYSCALL(mkdir)
     540:	b8 14 00 00 00       	mov    $0x14,%eax
     545:	cd 40                	int    $0x40
     547:	c3                   	ret    

00000548 <chdir>:
SYSCALL(chdir)
     548:	b8 09 00 00 00       	mov    $0x9,%eax
     54d:	cd 40                	int    $0x40
     54f:	c3                   	ret    

00000550 <dup>:
SYSCALL(dup)
     550:	b8 0a 00 00 00       	mov    $0xa,%eax
     555:	cd 40                	int    $0x40
     557:	c3                   	ret    

00000558 <getpid>:
SYSCALL(getpid)
     558:	b8 0b 00 00 00       	mov    $0xb,%eax
     55d:	cd 40                	int    $0x40
     55f:	c3                   	ret    

00000560 <sbrk>:
SYSCALL(sbrk)
     560:	b8 0c 00 00 00       	mov    $0xc,%eax
     565:	cd 40                	int    $0x40
     567:	c3                   	ret    

00000568 <sleep>:
SYSCALL(sleep)
     568:	b8 0d 00 00 00       	mov    $0xd,%eax
     56d:	cd 40                	int    $0x40
     56f:	c3                   	ret    

00000570 <uptime>:
SYSCALL(uptime)
     570:	b8 0e 00 00 00       	mov    $0xe,%eax
     575:	cd 40                	int    $0x40
     577:	c3                   	ret    

00000578 <paintWindow>:

SYSCALL(paintWindow)
     578:	b8 16 00 00 00       	mov    $0x16,%eax
     57d:	cd 40                	int    $0x40
     57f:	c3                   	ret    

00000580 <initStringFigure>:
SYSCALL(initStringFigure)
     580:	b8 17 00 00 00       	mov    $0x17,%eax
     585:	cd 40                	int    $0x40
     587:	c3                   	ret    

00000588 <sendMessage>:
SYSCALL(sendMessage)
     588:	b8 18 00 00 00       	mov    $0x18,%eax
     58d:	cd 40                	int    $0x40
     58f:	c3                   	ret    

00000590 <getMessage>:
SYSCALL(getMessage)
     590:	b8 1a 00 00 00       	mov    $0x1a,%eax
     595:	cd 40                	int    $0x40
     597:	c3                   	ret    

00000598 <registWindow>:
SYSCALL(registWindow)
     598:	b8 19 00 00 00       	mov    $0x19,%eax
     59d:	cd 40                	int    $0x40
     59f:	c3                   	ret    

000005a0 <changePosition>:
SYSCALL(changePosition)
     5a0:	b8 1b 00 00 00       	mov    $0x1b,%eax
     5a5:	cd 40                	int    $0x40
     5a7:	c3                   	ret    

000005a8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     5a8:	55                   	push   %ebp
     5a9:	89 e5                	mov    %esp,%ebp
     5ab:	83 ec 18             	sub    $0x18,%esp
     5ae:	8b 45 0c             	mov    0xc(%ebp),%eax
     5b1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     5b4:	83 ec 04             	sub    $0x4,%esp
     5b7:	6a 01                	push   $0x1
     5b9:	8d 45 f4             	lea    -0xc(%ebp),%eax
     5bc:	50                   	push   %eax
     5bd:	ff 75 08             	pushl  0x8(%ebp)
     5c0:	e8 33 ff ff ff       	call   4f8 <write>
     5c5:	83 c4 10             	add    $0x10,%esp
}
     5c8:	90                   	nop
     5c9:	c9                   	leave  
     5ca:	c3                   	ret    

000005cb <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     5cb:	55                   	push   %ebp
     5cc:	89 e5                	mov    %esp,%ebp
     5ce:	53                   	push   %ebx
     5cf:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     5d2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     5d9:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     5dd:	74 17                	je     5f6 <printint+0x2b>
     5df:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     5e3:	79 11                	jns    5f6 <printint+0x2b>
    neg = 1;
     5e5:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     5ec:	8b 45 0c             	mov    0xc(%ebp),%eax
     5ef:	f7 d8                	neg    %eax
     5f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
     5f4:	eb 06                	jmp    5fc <printint+0x31>
  } else {
    x = xx;
     5f6:	8b 45 0c             	mov    0xc(%ebp),%eax
     5f9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     5fc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     603:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     606:	8d 41 01             	lea    0x1(%ecx),%eax
     609:	89 45 f4             	mov    %eax,-0xc(%ebp)
     60c:	8b 5d 10             	mov    0x10(%ebp),%ebx
     60f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     612:	ba 00 00 00 00       	mov    $0x0,%edx
     617:	f7 f3                	div    %ebx
     619:	89 d0                	mov    %edx,%eax
     61b:	0f b6 80 00 2d 00 00 	movzbl 0x2d00(%eax),%eax
     622:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     626:	8b 5d 10             	mov    0x10(%ebp),%ebx
     629:	8b 45 ec             	mov    -0x14(%ebp),%eax
     62c:	ba 00 00 00 00       	mov    $0x0,%edx
     631:	f7 f3                	div    %ebx
     633:	89 45 ec             	mov    %eax,-0x14(%ebp)
     636:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     63a:	75 c7                	jne    603 <printint+0x38>
  if(neg)
     63c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     640:	74 2d                	je     66f <printint+0xa4>
    buf[i++] = '-';
     642:	8b 45 f4             	mov    -0xc(%ebp),%eax
     645:	8d 50 01             	lea    0x1(%eax),%edx
     648:	89 55 f4             	mov    %edx,-0xc(%ebp)
     64b:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     650:	eb 1d                	jmp    66f <printint+0xa4>
    putc(fd, buf[i]);
     652:	8d 55 dc             	lea    -0x24(%ebp),%edx
     655:	8b 45 f4             	mov    -0xc(%ebp),%eax
     658:	01 d0                	add    %edx,%eax
     65a:	0f b6 00             	movzbl (%eax),%eax
     65d:	0f be c0             	movsbl %al,%eax
     660:	83 ec 08             	sub    $0x8,%esp
     663:	50                   	push   %eax
     664:	ff 75 08             	pushl  0x8(%ebp)
     667:	e8 3c ff ff ff       	call   5a8 <putc>
     66c:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     66f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     673:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     677:	79 d9                	jns    652 <printint+0x87>
    putc(fd, buf[i]);
}
     679:	90                   	nop
     67a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     67d:	c9                   	leave  
     67e:	c3                   	ret    

0000067f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     67f:	55                   	push   %ebp
     680:	89 e5                	mov    %esp,%ebp
     682:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     685:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     68c:	8d 45 0c             	lea    0xc(%ebp),%eax
     68f:	83 c0 04             	add    $0x4,%eax
     692:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     695:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     69c:	e9 59 01 00 00       	jmp    7fa <printf+0x17b>
    c = fmt[i] & 0xff;
     6a1:	8b 55 0c             	mov    0xc(%ebp),%edx
     6a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6a7:	01 d0                	add    %edx,%eax
     6a9:	0f b6 00             	movzbl (%eax),%eax
     6ac:	0f be c0             	movsbl %al,%eax
     6af:	25 ff 00 00 00       	and    $0xff,%eax
     6b4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     6b7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     6bb:	75 2c                	jne    6e9 <printf+0x6a>
      if(c == '%'){
     6bd:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     6c1:	75 0c                	jne    6cf <printf+0x50>
        state = '%';
     6c3:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     6ca:	e9 27 01 00 00       	jmp    7f6 <printf+0x177>
      } else {
        putc(fd, c);
     6cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6d2:	0f be c0             	movsbl %al,%eax
     6d5:	83 ec 08             	sub    $0x8,%esp
     6d8:	50                   	push   %eax
     6d9:	ff 75 08             	pushl  0x8(%ebp)
     6dc:	e8 c7 fe ff ff       	call   5a8 <putc>
     6e1:	83 c4 10             	add    $0x10,%esp
     6e4:	e9 0d 01 00 00       	jmp    7f6 <printf+0x177>
      }
    } else if(state == '%'){
     6e9:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     6ed:	0f 85 03 01 00 00    	jne    7f6 <printf+0x177>
      if(c == 'd'){
     6f3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     6f7:	75 1e                	jne    717 <printf+0x98>
        printint(fd, *ap, 10, 1);
     6f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6fc:	8b 00                	mov    (%eax),%eax
     6fe:	6a 01                	push   $0x1
     700:	6a 0a                	push   $0xa
     702:	50                   	push   %eax
     703:	ff 75 08             	pushl  0x8(%ebp)
     706:	e8 c0 fe ff ff       	call   5cb <printint>
     70b:	83 c4 10             	add    $0x10,%esp
        ap++;
     70e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     712:	e9 d8 00 00 00       	jmp    7ef <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     717:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     71b:	74 06                	je     723 <printf+0xa4>
     71d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     721:	75 1e                	jne    741 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     723:	8b 45 e8             	mov    -0x18(%ebp),%eax
     726:	8b 00                	mov    (%eax),%eax
     728:	6a 00                	push   $0x0
     72a:	6a 10                	push   $0x10
     72c:	50                   	push   %eax
     72d:	ff 75 08             	pushl  0x8(%ebp)
     730:	e8 96 fe ff ff       	call   5cb <printint>
     735:	83 c4 10             	add    $0x10,%esp
        ap++;
     738:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     73c:	e9 ae 00 00 00       	jmp    7ef <printf+0x170>
      } else if(c == 's'){
     741:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     745:	75 43                	jne    78a <printf+0x10b>
        s = (char*)*ap;
     747:	8b 45 e8             	mov    -0x18(%ebp),%eax
     74a:	8b 00                	mov    (%eax),%eax
     74c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     74f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     753:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     757:	75 25                	jne    77e <printf+0xff>
          s = "(null)";
     759:	c7 45 f4 54 23 00 00 	movl   $0x2354,-0xc(%ebp)
        while(*s != 0){
     760:	eb 1c                	jmp    77e <printf+0xff>
          putc(fd, *s);
     762:	8b 45 f4             	mov    -0xc(%ebp),%eax
     765:	0f b6 00             	movzbl (%eax),%eax
     768:	0f be c0             	movsbl %al,%eax
     76b:	83 ec 08             	sub    $0x8,%esp
     76e:	50                   	push   %eax
     76f:	ff 75 08             	pushl  0x8(%ebp)
     772:	e8 31 fe ff ff       	call   5a8 <putc>
     777:	83 c4 10             	add    $0x10,%esp
          s++;
     77a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     77e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     781:	0f b6 00             	movzbl (%eax),%eax
     784:	84 c0                	test   %al,%al
     786:	75 da                	jne    762 <printf+0xe3>
     788:	eb 65                	jmp    7ef <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     78a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     78e:	75 1d                	jne    7ad <printf+0x12e>
        putc(fd, *ap);
     790:	8b 45 e8             	mov    -0x18(%ebp),%eax
     793:	8b 00                	mov    (%eax),%eax
     795:	0f be c0             	movsbl %al,%eax
     798:	83 ec 08             	sub    $0x8,%esp
     79b:	50                   	push   %eax
     79c:	ff 75 08             	pushl  0x8(%ebp)
     79f:	e8 04 fe ff ff       	call   5a8 <putc>
     7a4:	83 c4 10             	add    $0x10,%esp
        ap++;
     7a7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7ab:	eb 42                	jmp    7ef <printf+0x170>
      } else if(c == '%'){
     7ad:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     7b1:	75 17                	jne    7ca <printf+0x14b>
        putc(fd, c);
     7b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7b6:	0f be c0             	movsbl %al,%eax
     7b9:	83 ec 08             	sub    $0x8,%esp
     7bc:	50                   	push   %eax
     7bd:	ff 75 08             	pushl  0x8(%ebp)
     7c0:	e8 e3 fd ff ff       	call   5a8 <putc>
     7c5:	83 c4 10             	add    $0x10,%esp
     7c8:	eb 25                	jmp    7ef <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     7ca:	83 ec 08             	sub    $0x8,%esp
     7cd:	6a 25                	push   $0x25
     7cf:	ff 75 08             	pushl  0x8(%ebp)
     7d2:	e8 d1 fd ff ff       	call   5a8 <putc>
     7d7:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     7da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7dd:	0f be c0             	movsbl %al,%eax
     7e0:	83 ec 08             	sub    $0x8,%esp
     7e3:	50                   	push   %eax
     7e4:	ff 75 08             	pushl  0x8(%ebp)
     7e7:	e8 bc fd ff ff       	call   5a8 <putc>
     7ec:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     7ef:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     7f6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     7fa:	8b 55 0c             	mov    0xc(%ebp),%edx
     7fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     800:	01 d0                	add    %edx,%eax
     802:	0f b6 00             	movzbl (%eax),%eax
     805:	84 c0                	test   %al,%al
     807:	0f 85 94 fe ff ff    	jne    6a1 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     80d:	90                   	nop
     80e:	c9                   	leave  
     80f:	c3                   	ret    

00000810 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     810:	55                   	push   %ebp
     811:	89 e5                	mov    %esp,%ebp
     813:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     816:	8b 45 08             	mov    0x8(%ebp),%eax
     819:	83 e8 08             	sub    $0x8,%eax
     81c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     81f:	a1 30 2d 00 00       	mov    0x2d30,%eax
     824:	89 45 fc             	mov    %eax,-0x4(%ebp)
     827:	eb 24                	jmp    84d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     829:	8b 45 fc             	mov    -0x4(%ebp),%eax
     82c:	8b 00                	mov    (%eax),%eax
     82e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     831:	77 12                	ja     845 <free+0x35>
     833:	8b 45 f8             	mov    -0x8(%ebp),%eax
     836:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     839:	77 24                	ja     85f <free+0x4f>
     83b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     83e:	8b 00                	mov    (%eax),%eax
     840:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     843:	77 1a                	ja     85f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     845:	8b 45 fc             	mov    -0x4(%ebp),%eax
     848:	8b 00                	mov    (%eax),%eax
     84a:	89 45 fc             	mov    %eax,-0x4(%ebp)
     84d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     850:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     853:	76 d4                	jbe    829 <free+0x19>
     855:	8b 45 fc             	mov    -0x4(%ebp),%eax
     858:	8b 00                	mov    (%eax),%eax
     85a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     85d:	76 ca                	jbe    829 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     85f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     862:	8b 40 04             	mov    0x4(%eax),%eax
     865:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     86c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     86f:	01 c2                	add    %eax,%edx
     871:	8b 45 fc             	mov    -0x4(%ebp),%eax
     874:	8b 00                	mov    (%eax),%eax
     876:	39 c2                	cmp    %eax,%edx
     878:	75 24                	jne    89e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     87a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     87d:	8b 50 04             	mov    0x4(%eax),%edx
     880:	8b 45 fc             	mov    -0x4(%ebp),%eax
     883:	8b 00                	mov    (%eax),%eax
     885:	8b 40 04             	mov    0x4(%eax),%eax
     888:	01 c2                	add    %eax,%edx
     88a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     88d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     890:	8b 45 fc             	mov    -0x4(%ebp),%eax
     893:	8b 00                	mov    (%eax),%eax
     895:	8b 10                	mov    (%eax),%edx
     897:	8b 45 f8             	mov    -0x8(%ebp),%eax
     89a:	89 10                	mov    %edx,(%eax)
     89c:	eb 0a                	jmp    8a8 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     89e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8a1:	8b 10                	mov    (%eax),%edx
     8a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8a6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     8a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8ab:	8b 40 04             	mov    0x4(%eax),%eax
     8ae:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     8b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8b8:	01 d0                	add    %edx,%eax
     8ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     8bd:	75 20                	jne    8df <free+0xcf>
    p->s.size += bp->s.size;
     8bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8c2:	8b 50 04             	mov    0x4(%eax),%edx
     8c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8c8:	8b 40 04             	mov    0x4(%eax),%eax
     8cb:	01 c2                	add    %eax,%edx
     8cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8d0:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     8d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8d6:	8b 10                	mov    (%eax),%edx
     8d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8db:	89 10                	mov    %edx,(%eax)
     8dd:	eb 08                	jmp    8e7 <free+0xd7>
  } else
    p->s.ptr = bp;
     8df:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8e2:	8b 55 f8             	mov    -0x8(%ebp),%edx
     8e5:	89 10                	mov    %edx,(%eax)
  freep = p;
     8e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8ea:	a3 30 2d 00 00       	mov    %eax,0x2d30
}
     8ef:	90                   	nop
     8f0:	c9                   	leave  
     8f1:	c3                   	ret    

000008f2 <morecore>:

static Header*
morecore(uint nu)
{
     8f2:	55                   	push   %ebp
     8f3:	89 e5                	mov    %esp,%ebp
     8f5:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     8f8:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     8ff:	77 07                	ja     908 <morecore+0x16>
    nu = 4096;
     901:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     908:	8b 45 08             	mov    0x8(%ebp),%eax
     90b:	c1 e0 03             	shl    $0x3,%eax
     90e:	83 ec 0c             	sub    $0xc,%esp
     911:	50                   	push   %eax
     912:	e8 49 fc ff ff       	call   560 <sbrk>
     917:	83 c4 10             	add    $0x10,%esp
     91a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     91d:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     921:	75 07                	jne    92a <morecore+0x38>
    return 0;
     923:	b8 00 00 00 00       	mov    $0x0,%eax
     928:	eb 26                	jmp    950 <morecore+0x5e>
  hp = (Header*)p;
     92a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     92d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     930:	8b 45 f0             	mov    -0x10(%ebp),%eax
     933:	8b 55 08             	mov    0x8(%ebp),%edx
     936:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     939:	8b 45 f0             	mov    -0x10(%ebp),%eax
     93c:	83 c0 08             	add    $0x8,%eax
     93f:	83 ec 0c             	sub    $0xc,%esp
     942:	50                   	push   %eax
     943:	e8 c8 fe ff ff       	call   810 <free>
     948:	83 c4 10             	add    $0x10,%esp
  return freep;
     94b:	a1 30 2d 00 00       	mov    0x2d30,%eax
}
     950:	c9                   	leave  
     951:	c3                   	ret    

00000952 <malloc>:

void*
malloc(uint nbytes)
{
     952:	55                   	push   %ebp
     953:	89 e5                	mov    %esp,%ebp
     955:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     958:	8b 45 08             	mov    0x8(%ebp),%eax
     95b:	83 c0 07             	add    $0x7,%eax
     95e:	c1 e8 03             	shr    $0x3,%eax
     961:	83 c0 01             	add    $0x1,%eax
     964:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     967:	a1 30 2d 00 00       	mov    0x2d30,%eax
     96c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     96f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     973:	75 23                	jne    998 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     975:	c7 45 f0 28 2d 00 00 	movl   $0x2d28,-0x10(%ebp)
     97c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     97f:	a3 30 2d 00 00       	mov    %eax,0x2d30
     984:	a1 30 2d 00 00       	mov    0x2d30,%eax
     989:	a3 28 2d 00 00       	mov    %eax,0x2d28
    base.s.size = 0;
     98e:	c7 05 2c 2d 00 00 00 	movl   $0x0,0x2d2c
     995:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     998:	8b 45 f0             	mov    -0x10(%ebp),%eax
     99b:	8b 00                	mov    (%eax),%eax
     99d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     9a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9a3:	8b 40 04             	mov    0x4(%eax),%eax
     9a6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     9a9:	72 4d                	jb     9f8 <malloc+0xa6>
      if(p->s.size == nunits)
     9ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9ae:	8b 40 04             	mov    0x4(%eax),%eax
     9b1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     9b4:	75 0c                	jne    9c2 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     9b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9b9:	8b 10                	mov    (%eax),%edx
     9bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9be:	89 10                	mov    %edx,(%eax)
     9c0:	eb 26                	jmp    9e8 <malloc+0x96>
      else {
        p->s.size -= nunits;
     9c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9c5:	8b 40 04             	mov    0x4(%eax),%eax
     9c8:	2b 45 ec             	sub    -0x14(%ebp),%eax
     9cb:	89 c2                	mov    %eax,%edx
     9cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9d0:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     9d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9d6:	8b 40 04             	mov    0x4(%eax),%eax
     9d9:	c1 e0 03             	shl    $0x3,%eax
     9dc:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     9df:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9e2:	8b 55 ec             	mov    -0x14(%ebp),%edx
     9e5:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     9e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9eb:	a3 30 2d 00 00       	mov    %eax,0x2d30
      return (void*)(p + 1);
     9f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9f3:	83 c0 08             	add    $0x8,%eax
     9f6:	eb 3b                	jmp    a33 <malloc+0xe1>
    }
    if(p == freep)
     9f8:	a1 30 2d 00 00       	mov    0x2d30,%eax
     9fd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     a00:	75 1e                	jne    a20 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     a02:	83 ec 0c             	sub    $0xc,%esp
     a05:	ff 75 ec             	pushl  -0x14(%ebp)
     a08:	e8 e5 fe ff ff       	call   8f2 <morecore>
     a0d:	83 c4 10             	add    $0x10,%esp
     a10:	89 45 f4             	mov    %eax,-0xc(%ebp)
     a13:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a17:	75 07                	jne    a20 <malloc+0xce>
        return 0;
     a19:	b8 00 00 00 00       	mov    $0x0,%eax
     a1e:	eb 13                	jmp    a33 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a20:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a23:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a26:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a29:	8b 00                	mov    (%eax),%eax
     a2b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     a2e:	e9 6d ff ff ff       	jmp    9a0 <malloc+0x4e>
}
     a33:	c9                   	leave  
     a34:	c3                   	ret    

00000a35 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     a35:	55                   	push   %ebp
     a36:	89 e5                	mov    %esp,%ebp
     a38:	83 ec 1c             	sub    $0x1c,%esp
     a3b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     a3e:	8b 55 10             	mov    0x10(%ebp),%edx
     a41:	8b 45 14             	mov    0x14(%ebp),%eax
     a44:	88 4d ec             	mov    %cl,-0x14(%ebp)
     a47:	88 55 e8             	mov    %dl,-0x18(%ebp)
     a4a:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     a4d:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     a51:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     a54:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     a58:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     a5b:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     a5f:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     a62:	8b 45 08             	mov    0x8(%ebp),%eax
     a65:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     a69:	66 89 10             	mov    %dx,(%eax)
     a6c:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     a70:	88 50 02             	mov    %dl,0x2(%eax)
}
     a73:	8b 45 08             	mov    0x8(%ebp),%eax
     a76:	c9                   	leave  
     a77:	c2 04 00             	ret    $0x4

00000a7a <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     a7a:	55                   	push   %ebp
     a7b:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     a7d:	8b 45 08             	mov    0x8(%ebp),%eax
     a80:	2b 45 10             	sub    0x10(%ebp),%eax
     a83:	89 c2                	mov    %eax,%edx
     a85:	8b 45 08             	mov    0x8(%ebp),%eax
     a88:	2b 45 10             	sub    0x10(%ebp),%eax
     a8b:	0f af d0             	imul   %eax,%edx
     a8e:	8b 45 0c             	mov    0xc(%ebp),%eax
     a91:	2b 45 14             	sub    0x14(%ebp),%eax
     a94:	89 c1                	mov    %eax,%ecx
     a96:	8b 45 0c             	mov    0xc(%ebp),%eax
     a99:	2b 45 14             	sub    0x14(%ebp),%eax
     a9c:	0f af c1             	imul   %ecx,%eax
     a9f:	01 d0                	add    %edx,%eax
}
     aa1:	5d                   	pop    %ebp
     aa2:	c3                   	ret    

00000aa3 <abs_int>:

static inline int abs_int(int x)
{
     aa3:	55                   	push   %ebp
     aa4:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     aa6:	8b 45 08             	mov    0x8(%ebp),%eax
     aa9:	99                   	cltd   
     aaa:	89 d0                	mov    %edx,%eax
     aac:	33 45 08             	xor    0x8(%ebp),%eax
     aaf:	29 d0                	sub    %edx,%eax
}
     ab1:	5d                   	pop    %ebp
     ab2:	c3                   	ret    

00000ab3 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     ab3:	55                   	push   %ebp
     ab4:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     ab6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     aba:	79 07                	jns    ac3 <APGetIndex+0x10>
        return X_SMALLER;
     abc:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     ac1:	eb 40                	jmp    b03 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     ac3:	8b 45 08             	mov    0x8(%ebp),%eax
     ac6:	8b 00                	mov    (%eax),%eax
     ac8:	3b 45 0c             	cmp    0xc(%ebp),%eax
     acb:	7f 07                	jg     ad4 <APGetIndex+0x21>
        return X_BIGGER;
     acd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     ad2:	eb 2f                	jmp    b03 <APGetIndex+0x50>
    if (y < 0)
     ad4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     ad8:	79 07                	jns    ae1 <APGetIndex+0x2e>
        return Y_SMALLER;
     ada:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     adf:	eb 22                	jmp    b03 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     ae1:	8b 45 08             	mov    0x8(%ebp),%eax
     ae4:	8b 40 04             	mov    0x4(%eax),%eax
     ae7:	3b 45 10             	cmp    0x10(%ebp),%eax
     aea:	7f 07                	jg     af3 <APGetIndex+0x40>
        return Y_BIGGER;
     aec:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     af1:	eb 10                	jmp    b03 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     af3:	8b 45 08             	mov    0x8(%ebp),%eax
     af6:	8b 00                	mov    (%eax),%eax
     af8:	0f af 45 10          	imul   0x10(%ebp),%eax
     afc:	89 c2                	mov    %eax,%edx
     afe:	8b 45 0c             	mov    0xc(%ebp),%eax
     b01:	01 d0                	add    %edx,%eax
}
     b03:	5d                   	pop    %ebp
     b04:	c3                   	ret    

00000b05 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     b05:	55                   	push   %ebp
     b06:	89 e5                	mov    %esp,%ebp
     b08:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     b0b:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     b12:	8b 45 cc             	mov    -0x34(%ebp),%eax
     b15:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     b18:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     b1f:	83 ec 08             	sub    $0x8,%esp
     b22:	6a 00                	push   $0x0
     b24:	ff 75 0c             	pushl  0xc(%ebp)
     b27:	e8 ec f9 ff ff       	call   518 <open>
     b2c:	83 c4 10             	add    $0x10,%esp
     b2f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     b32:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     b36:	79 2e                	jns    b66 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     b38:	83 ec 04             	sub    $0x4,%esp
     b3b:	ff 75 0c             	pushl  0xc(%ebp)
     b3e:	68 5b 23 00 00       	push   $0x235b
     b43:	6a 01                	push   $0x1
     b45:	e8 35 fb ff ff       	call   67f <printf>
     b4a:	83 c4 10             	add    $0x10,%esp
        return bmp;
     b4d:	8b 45 08             	mov    0x8(%ebp),%eax
     b50:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b53:	89 10                	mov    %edx,(%eax)
     b55:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b58:	89 50 04             	mov    %edx,0x4(%eax)
     b5b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b5e:	89 50 08             	mov    %edx,0x8(%eax)
     b61:	e9 d2 01 00 00       	jmp    d38 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     b66:	83 ec 04             	sub    $0x4,%esp
     b69:	6a 0e                	push   $0xe
     b6b:	8d 45 ba             	lea    -0x46(%ebp),%eax
     b6e:	50                   	push   %eax
     b6f:	ff 75 ec             	pushl  -0x14(%ebp)
     b72:	e8 79 f9 ff ff       	call   4f0 <read>
     b77:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     b7a:	83 ec 04             	sub    $0x4,%esp
     b7d:	6a 28                	push   $0x28
     b7f:	8d 45 92             	lea    -0x6e(%ebp),%eax
     b82:	50                   	push   %eax
     b83:	ff 75 ec             	pushl  -0x14(%ebp)
     b86:	e8 65 f9 ff ff       	call   4f0 <read>
     b8b:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     b8e:	8b 45 96             	mov    -0x6a(%ebp),%eax
     b91:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     b94:	8b 45 9a             	mov    -0x66(%ebp),%eax
     b97:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     b9a:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b9d:	8b 45 cc             	mov    -0x34(%ebp),%eax
     ba0:	0f af d0             	imul   %eax,%edx
     ba3:	89 d0                	mov    %edx,%eax
     ba5:	01 c0                	add    %eax,%eax
     ba7:	01 d0                	add    %edx,%eax
     ba9:	83 ec 0c             	sub    $0xc,%esp
     bac:	50                   	push   %eax
     bad:	e8 a0 fd ff ff       	call   952 <malloc>
     bb2:	83 c4 10             	add    $0x10,%esp
     bb5:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     bb8:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     bbc:	0f b7 c0             	movzwl %ax,%eax
     bbf:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     bc2:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bc5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     bc8:	0f af c2             	imul   %edx,%eax
     bcb:	83 c0 1f             	add    $0x1f,%eax
     bce:	c1 e8 05             	shr    $0x5,%eax
     bd1:	c1 e0 02             	shl    $0x2,%eax
     bd4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     bd7:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bda:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     bdd:	0f af c2             	imul   %edx,%eax
     be0:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     be3:	8b 45 e0             	mov    -0x20(%ebp),%eax
     be6:	83 ec 0c             	sub    $0xc,%esp
     be9:	50                   	push   %eax
     bea:	e8 63 fd ff ff       	call   952 <malloc>
     bef:	83 c4 10             	add    $0x10,%esp
     bf2:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     bf5:	83 ec 04             	sub    $0x4,%esp
     bf8:	ff 75 e0             	pushl  -0x20(%ebp)
     bfb:	ff 75 dc             	pushl  -0x24(%ebp)
     bfe:	ff 75 ec             	pushl  -0x14(%ebp)
     c01:	e8 ea f8 ff ff       	call   4f0 <read>
     c06:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     c09:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     c0d:	66 c1 e8 03          	shr    $0x3,%ax
     c11:	0f b7 c0             	movzwl %ax,%eax
     c14:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     c17:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c1e:	e9 e5 00 00 00       	jmp    d08 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     c23:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c26:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c29:	29 c2                	sub    %eax,%edx
     c2b:	89 d0                	mov    %edx,%eax
     c2d:	8d 50 ff             	lea    -0x1(%eax),%edx
     c30:	8b 45 c8             	mov    -0x38(%ebp),%eax
     c33:	0f af c2             	imul   %edx,%eax
     c36:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     c39:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     c40:	e9 b1 00 00 00       	jmp    cf6 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     c45:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c48:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     c4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c4e:	01 c8                	add    %ecx,%eax
     c50:	89 c1                	mov    %eax,%ecx
     c52:	89 c8                	mov    %ecx,%eax
     c54:	01 c0                	add    %eax,%eax
     c56:	01 c8                	add    %ecx,%eax
     c58:	01 c2                	add    %eax,%edx
     c5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5d:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     c61:	89 c1                	mov    %eax,%ecx
     c63:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c66:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     c6a:	01 c1                	add    %eax,%ecx
     c6c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c6f:	01 c8                	add    %ecx,%eax
     c71:	8d 48 ff             	lea    -0x1(%eax),%ecx
     c74:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c77:	01 c8                	add    %ecx,%eax
     c79:	0f b6 00             	movzbl (%eax),%eax
     c7c:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     c7f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c82:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     c85:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c88:	01 c8                	add    %ecx,%eax
     c8a:	89 c1                	mov    %eax,%ecx
     c8c:	89 c8                	mov    %ecx,%eax
     c8e:	01 c0                	add    %eax,%eax
     c90:	01 c8                	add    %ecx,%eax
     c92:	01 c2                	add    %eax,%edx
     c94:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c97:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     c9b:	89 c1                	mov    %eax,%ecx
     c9d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ca0:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ca4:	01 c1                	add    %eax,%ecx
     ca6:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ca9:	01 c8                	add    %ecx,%eax
     cab:	8d 48 fe             	lea    -0x2(%eax),%ecx
     cae:	8b 45 dc             	mov    -0x24(%ebp),%eax
     cb1:	01 c8                	add    %ecx,%eax
     cb3:	0f b6 00             	movzbl (%eax),%eax
     cb6:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     cb9:	8b 55 d0             	mov    -0x30(%ebp),%edx
     cbc:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     cbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cc2:	01 c8                	add    %ecx,%eax
     cc4:	89 c1                	mov    %eax,%ecx
     cc6:	89 c8                	mov    %ecx,%eax
     cc8:	01 c0                	add    %eax,%eax
     cca:	01 c8                	add    %ecx,%eax
     ccc:	01 c2                	add    %eax,%edx
     cce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cd1:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     cd5:	89 c1                	mov    %eax,%ecx
     cd7:	8b 45 d8             	mov    -0x28(%ebp),%eax
     cda:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     cde:	01 c1                	add    %eax,%ecx
     ce0:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ce3:	01 c8                	add    %ecx,%eax
     ce5:	8d 48 fd             	lea    -0x3(%eax),%ecx
     ce8:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ceb:	01 c8                	add    %ecx,%eax
     ced:	0f b6 00             	movzbl (%eax),%eax
     cf0:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     cf2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     cf6:	8b 55 c8             	mov    -0x38(%ebp),%edx
     cf9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cfc:	39 c2                	cmp    %eax,%edx
     cfe:	0f 87 41 ff ff ff    	ja     c45 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     d04:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d08:	8b 55 cc             	mov    -0x34(%ebp),%edx
     d0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d0e:	39 c2                	cmp    %eax,%edx
     d10:	0f 87 0d ff ff ff    	ja     c23 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     d16:	83 ec 0c             	sub    $0xc,%esp
     d19:	ff 75 ec             	pushl  -0x14(%ebp)
     d1c:	e8 df f7 ff ff       	call   500 <close>
     d21:	83 c4 10             	add    $0x10,%esp
    return bmp;
     d24:	8b 45 08             	mov    0x8(%ebp),%eax
     d27:	8b 55 c8             	mov    -0x38(%ebp),%edx
     d2a:	89 10                	mov    %edx,(%eax)
     d2c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     d2f:	89 50 04             	mov    %edx,0x4(%eax)
     d32:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d35:	89 50 08             	mov    %edx,0x8(%eax)
}
     d38:	8b 45 08             	mov    0x8(%ebp),%eax
     d3b:	c9                   	leave  
     d3c:	c2 04 00             	ret    $0x4

00000d3f <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     d3f:	55                   	push   %ebp
     d40:	89 e5                	mov    %esp,%ebp
     d42:	53                   	push   %ebx
     d43:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     d46:	83 ec 0c             	sub    $0xc,%esp
     d49:	6a 1c                	push   $0x1c
     d4b:	e8 02 fc ff ff       	call   952 <malloc>
     d50:	83 c4 10             	add    $0x10,%esp
     d53:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     d56:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d59:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     d60:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     d63:	8d 45 d8             	lea    -0x28(%ebp),%eax
     d66:	6a 0c                	push   $0xc
     d68:	6a 0c                	push   $0xc
     d6a:	6a 0c                	push   $0xc
     d6c:	50                   	push   %eax
     d6d:	e8 c3 fc ff ff       	call   a35 <RGB>
     d72:	83 c4 0c             	add    $0xc,%esp
     d75:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     d79:	66 89 43 13          	mov    %ax,0x13(%ebx)
     d7d:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     d81:	88 43 15             	mov    %al,0x15(%ebx)
     d84:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d87:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d8a:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     d8e:	66 89 48 10          	mov    %cx,0x10(%eax)
     d92:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     d96:	88 50 12             	mov    %dl,0x12(%eax)
     d99:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d9c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d9f:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     da3:	66 89 48 08          	mov    %cx,0x8(%eax)
     da7:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     dab:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     dae:	8b 45 08             	mov    0x8(%ebp),%eax
     db1:	89 c2                	mov    %eax,%edx
     db3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     db6:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     db8:	8b 45 0c             	mov    0xc(%ebp),%eax
     dbb:	89 c2                	mov    %eax,%edx
     dbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dc0:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     dc3:	8b 55 10             	mov    0x10(%ebp),%edx
     dc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dc9:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     dcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     dcf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     dd2:	c9                   	leave  
     dd3:	c3                   	ret    

00000dd4 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     dd4:	55                   	push   %ebp
     dd5:	89 e5                	mov    %esp,%ebp
     dd7:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     dda:	8b 45 0c             	mov    0xc(%ebp),%eax
     ddd:	8b 50 08             	mov    0x8(%eax),%edx
     de0:	89 55 f8             	mov    %edx,-0x8(%ebp)
     de3:	8b 40 0c             	mov    0xc(%eax),%eax
     de6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     de9:	8b 45 0c             	mov    0xc(%ebp),%eax
     dec:	8b 55 10             	mov    0x10(%ebp),%edx
     def:	89 50 08             	mov    %edx,0x8(%eax)
     df2:	8b 55 14             	mov    0x14(%ebp),%edx
     df5:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     df8:	8b 45 08             	mov    0x8(%ebp),%eax
     dfb:	8b 55 f8             	mov    -0x8(%ebp),%edx
     dfe:	89 10                	mov    %edx,(%eax)
     e00:	8b 55 fc             	mov    -0x4(%ebp),%edx
     e03:	89 50 04             	mov    %edx,0x4(%eax)
}
     e06:	8b 45 08             	mov    0x8(%ebp),%eax
     e09:	c9                   	leave  
     e0a:	c2 04 00             	ret    $0x4

00000e0d <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     e0d:	55                   	push   %ebp
     e0e:	89 e5                	mov    %esp,%ebp
     e10:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     e13:	8b 45 0c             	mov    0xc(%ebp),%eax
     e16:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     e1a:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     e1e:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     e22:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     e25:	8b 45 0c             	mov    0xc(%ebp),%eax
     e28:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     e2c:	66 89 50 10          	mov    %dx,0x10(%eax)
     e30:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     e34:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     e37:	8b 45 08             	mov    0x8(%ebp),%eax
     e3a:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     e3e:	66 89 10             	mov    %dx,(%eax)
     e41:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     e45:	88 50 02             	mov    %dl,0x2(%eax)
}
     e48:	8b 45 08             	mov    0x8(%ebp),%eax
     e4b:	c9                   	leave  
     e4c:	c2 04 00             	ret    $0x4

00000e4f <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     e4f:	55                   	push   %ebp
     e50:	89 e5                	mov    %esp,%ebp
     e52:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     e55:	8b 45 08             	mov    0x8(%ebp),%eax
     e58:	8b 40 0c             	mov    0xc(%eax),%eax
     e5b:	89 c2                	mov    %eax,%edx
     e5d:	c1 ea 1f             	shr    $0x1f,%edx
     e60:	01 d0                	add    %edx,%eax
     e62:	d1 f8                	sar    %eax
     e64:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     e67:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e6a:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     e6e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     e71:	8b 45 10             	mov    0x10(%ebp),%eax
     e74:	2b 45 f4             	sub    -0xc(%ebp),%eax
     e77:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     e7a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     e7e:	0f 89 98 00 00 00    	jns    f1c <APDrawPoint+0xcd>
        i = 0;
     e84:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     e8b:	e9 8c 00 00 00       	jmp    f1c <APDrawPoint+0xcd>
    {
        j = x - off;
     e90:	8b 45 0c             	mov    0xc(%ebp),%eax
     e93:	2b 45 f4             	sub    -0xc(%ebp),%eax
     e96:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     e99:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     e9d:	79 69                	jns    f08 <APDrawPoint+0xb9>
            j = 0;
     e9f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     ea6:	eb 60                	jmp    f08 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     ea8:	ff 75 fc             	pushl  -0x4(%ebp)
     eab:	ff 75 f8             	pushl  -0x8(%ebp)
     eae:	ff 75 08             	pushl  0x8(%ebp)
     eb1:	e8 fd fb ff ff       	call   ab3 <APGetIndex>
     eb6:	83 c4 0c             	add    $0xc,%esp
     eb9:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     ebc:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     ec0:	74 55                	je     f17 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     ec2:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     ec6:	74 67                	je     f2f <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     ec8:	ff 75 10             	pushl  0x10(%ebp)
     ecb:	ff 75 0c             	pushl  0xc(%ebp)
     ece:	ff 75 fc             	pushl  -0x4(%ebp)
     ed1:	ff 75 f8             	pushl  -0x8(%ebp)
     ed4:	e8 a1 fb ff ff       	call   a7a <distance_2>
     ed9:	83 c4 10             	add    $0x10,%esp
     edc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     edf:	7f 23                	jg     f04 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     ee1:	8b 45 08             	mov    0x8(%ebp),%eax
     ee4:	8b 48 18             	mov    0x18(%eax),%ecx
     ee7:	8b 55 ec             	mov    -0x14(%ebp),%edx
     eea:	89 d0                	mov    %edx,%eax
     eec:	01 c0                	add    %eax,%eax
     eee:	01 d0                	add    %edx,%eax
     ef0:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     ef3:	8b 45 08             	mov    0x8(%ebp),%eax
     ef6:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     efa:	66 89 0a             	mov    %cx,(%edx)
     efd:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     f01:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     f04:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     f08:	8b 55 0c             	mov    0xc(%ebp),%edx
     f0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f0e:	01 d0                	add    %edx,%eax
     f10:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     f13:	7d 93                	jge    ea8 <APDrawPoint+0x59>
     f15:	eb 01                	jmp    f18 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     f17:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     f18:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     f1c:	8b 55 10             	mov    0x10(%ebp),%edx
     f1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f22:	01 d0                	add    %edx,%eax
     f24:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     f27:	0f 8d 63 ff ff ff    	jge    e90 <APDrawPoint+0x41>
     f2d:	eb 01                	jmp    f30 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     f2f:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     f30:	c9                   	leave  
     f31:	c3                   	ret    

00000f32 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     f32:	55                   	push   %ebp
     f33:	89 e5                	mov    %esp,%ebp
     f35:	53                   	push   %ebx
     f36:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     f39:	8b 45 0c             	mov    0xc(%ebp),%eax
     f3c:	3b 45 14             	cmp    0x14(%ebp),%eax
     f3f:	0f 85 80 00 00 00    	jne    fc5 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     f45:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f49:	0f 88 9d 02 00 00    	js     11ec <APDrawLine+0x2ba>
     f4f:	8b 45 08             	mov    0x8(%ebp),%eax
     f52:	8b 00                	mov    (%eax),%eax
     f54:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f57:	0f 8e 8f 02 00 00    	jle    11ec <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     f5d:	8b 45 10             	mov    0x10(%ebp),%eax
     f60:	3b 45 18             	cmp    0x18(%ebp),%eax
     f63:	7e 12                	jle    f77 <APDrawLine+0x45>
        {
            int tmp = y2;
     f65:	8b 45 18             	mov    0x18(%ebp),%eax
     f68:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     f6b:	8b 45 10             	mov    0x10(%ebp),%eax
     f6e:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     f71:	8b 45 dc             	mov    -0x24(%ebp),%eax
     f74:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     f77:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     f7b:	79 07                	jns    f84 <APDrawLine+0x52>
     f7d:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     f84:	8b 45 08             	mov    0x8(%ebp),%eax
     f87:	8b 40 04             	mov    0x4(%eax),%eax
     f8a:	3b 45 18             	cmp    0x18(%ebp),%eax
     f8d:	7d 0c                	jge    f9b <APDrawLine+0x69>
     f8f:	8b 45 08             	mov    0x8(%ebp),%eax
     f92:	8b 40 04             	mov    0x4(%eax),%eax
     f95:	83 e8 01             	sub    $0x1,%eax
     f98:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     f9b:	8b 45 10             	mov    0x10(%ebp),%eax
     f9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
     fa1:	eb 15                	jmp    fb8 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     fa3:	ff 75 f4             	pushl  -0xc(%ebp)
     fa6:	ff 75 0c             	pushl  0xc(%ebp)
     fa9:	ff 75 08             	pushl  0x8(%ebp)
     fac:	e8 9e fe ff ff       	call   e4f <APDrawPoint>
     fb1:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     fb4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     fb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fbb:	3b 45 18             	cmp    0x18(%ebp),%eax
     fbe:	7e e3                	jle    fa3 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     fc0:	e9 2b 02 00 00       	jmp    11f0 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     fc5:	8b 45 10             	mov    0x10(%ebp),%eax
     fc8:	3b 45 18             	cmp    0x18(%ebp),%eax
     fcb:	75 7f                	jne    104c <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     fcd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     fd1:	0f 88 18 02 00 00    	js     11ef <APDrawLine+0x2bd>
     fd7:	8b 45 08             	mov    0x8(%ebp),%eax
     fda:	8b 40 04             	mov    0x4(%eax),%eax
     fdd:	3b 45 10             	cmp    0x10(%ebp),%eax
     fe0:	0f 8e 09 02 00 00    	jle    11ef <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     fe6:	8b 45 0c             	mov    0xc(%ebp),%eax
     fe9:	3b 45 14             	cmp    0x14(%ebp),%eax
     fec:	7e 12                	jle    1000 <APDrawLine+0xce>
        {
            int tmp = x2;
     fee:	8b 45 14             	mov    0x14(%ebp),%eax
     ff1:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     ff4:	8b 45 0c             	mov    0xc(%ebp),%eax
     ff7:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     ffa:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ffd:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    1000:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1004:	79 07                	jns    100d <APDrawLine+0xdb>
    1006:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    100d:	8b 45 08             	mov    0x8(%ebp),%eax
    1010:	8b 00                	mov    (%eax),%eax
    1012:	3b 45 14             	cmp    0x14(%ebp),%eax
    1015:	7d 0b                	jge    1022 <APDrawLine+0xf0>
    1017:	8b 45 08             	mov    0x8(%ebp),%eax
    101a:	8b 00                	mov    (%eax),%eax
    101c:	83 e8 01             	sub    $0x1,%eax
    101f:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1022:	8b 45 0c             	mov    0xc(%ebp),%eax
    1025:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1028:	eb 15                	jmp    103f <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    102a:	ff 75 10             	pushl  0x10(%ebp)
    102d:	ff 75 f0             	pushl  -0x10(%ebp)
    1030:	ff 75 08             	pushl  0x8(%ebp)
    1033:	e8 17 fe ff ff       	call   e4f <APDrawPoint>
    1038:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    103b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    103f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1042:	3b 45 14             	cmp    0x14(%ebp),%eax
    1045:	7e e3                	jle    102a <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1047:	e9 a4 01 00 00       	jmp    11f0 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    104c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1053:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    105a:	8b 45 0c             	mov    0xc(%ebp),%eax
    105d:	2b 45 14             	sub    0x14(%ebp),%eax
    1060:	50                   	push   %eax
    1061:	e8 3d fa ff ff       	call   aa3 <abs_int>
    1066:	83 c4 04             	add    $0x4,%esp
    1069:	89 c3                	mov    %eax,%ebx
    106b:	8b 45 10             	mov    0x10(%ebp),%eax
    106e:	2b 45 18             	sub    0x18(%ebp),%eax
    1071:	50                   	push   %eax
    1072:	e8 2c fa ff ff       	call   aa3 <abs_int>
    1077:	83 c4 04             	add    $0x4,%esp
    107a:	39 c3                	cmp    %eax,%ebx
    107c:	0f 8e b5 00 00 00    	jle    1137 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1082:	8b 45 10             	mov    0x10(%ebp),%eax
    1085:	2b 45 18             	sub    0x18(%ebp),%eax
    1088:	89 45 b0             	mov    %eax,-0x50(%ebp)
    108b:	db 45 b0             	fildl  -0x50(%ebp)
    108e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1091:	2b 45 14             	sub    0x14(%ebp),%eax
    1094:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1097:	db 45 b0             	fildl  -0x50(%ebp)
    109a:	de f9                	fdivrp %st,%st(1)
    109c:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    109f:	8b 45 14             	mov    0x14(%ebp),%eax
    10a2:	3b 45 0c             	cmp    0xc(%ebp),%eax
    10a5:	7e 0e                	jle    10b5 <APDrawLine+0x183>
        {
            s = x1;
    10a7:	8b 45 0c             	mov    0xc(%ebp),%eax
    10aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    10ad:	8b 45 14             	mov    0x14(%ebp),%eax
    10b0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    10b3:	eb 0c                	jmp    10c1 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    10b5:	8b 45 14             	mov    0x14(%ebp),%eax
    10b8:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    10bb:	8b 45 0c             	mov    0xc(%ebp),%eax
    10be:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    10c1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10c5:	79 07                	jns    10ce <APDrawLine+0x19c>
    10c7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    10ce:	8b 45 08             	mov    0x8(%ebp),%eax
    10d1:	8b 00                	mov    (%eax),%eax
    10d3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10d6:	7f 0b                	jg     10e3 <APDrawLine+0x1b1>
    10d8:	8b 45 08             	mov    0x8(%ebp),%eax
    10db:	8b 00                	mov    (%eax),%eax
    10dd:	83 e8 01             	sub    $0x1,%eax
    10e0:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    10e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    10e9:	eb 3f                	jmp    112a <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    10eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10ee:	2b 45 0c             	sub    0xc(%ebp),%eax
    10f1:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10f4:	db 45 b0             	fildl  -0x50(%ebp)
    10f7:	dc 4d d0             	fmull  -0x30(%ebp)
    10fa:	db 45 10             	fildl  0x10(%ebp)
    10fd:	de c1                	faddp  %st,%st(1)
    10ff:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1102:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1106:	b4 0c                	mov    $0xc,%ah
    1108:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    110c:	d9 6d b4             	fldcw  -0x4c(%ebp)
    110f:	db 5d cc             	fistpl -0x34(%ebp)
    1112:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1115:	ff 75 cc             	pushl  -0x34(%ebp)
    1118:	ff 75 e4             	pushl  -0x1c(%ebp)
    111b:	ff 75 08             	pushl  0x8(%ebp)
    111e:	e8 2c fd ff ff       	call   e4f <APDrawPoint>
    1123:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1126:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    112a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    112d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1130:	7e b9                	jle    10eb <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1132:	e9 b9 00 00 00       	jmp    11f0 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1137:	8b 45 0c             	mov    0xc(%ebp),%eax
    113a:	2b 45 14             	sub    0x14(%ebp),%eax
    113d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1140:	db 45 b0             	fildl  -0x50(%ebp)
    1143:	8b 45 10             	mov    0x10(%ebp),%eax
    1146:	2b 45 18             	sub    0x18(%ebp),%eax
    1149:	89 45 b0             	mov    %eax,-0x50(%ebp)
    114c:	db 45 b0             	fildl  -0x50(%ebp)
    114f:	de f9                	fdivrp %st,%st(1)
    1151:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1154:	8b 45 10             	mov    0x10(%ebp),%eax
    1157:	3b 45 18             	cmp    0x18(%ebp),%eax
    115a:	7e 0e                	jle    116a <APDrawLine+0x238>
    {
        s = y2;
    115c:	8b 45 18             	mov    0x18(%ebp),%eax
    115f:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1162:	8b 45 10             	mov    0x10(%ebp),%eax
    1165:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1168:	eb 0c                	jmp    1176 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    116a:	8b 45 10             	mov    0x10(%ebp),%eax
    116d:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1170:	8b 45 18             	mov    0x18(%ebp),%eax
    1173:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1176:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    117a:	79 07                	jns    1183 <APDrawLine+0x251>
    117c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1183:	8b 45 08             	mov    0x8(%ebp),%eax
    1186:	8b 40 04             	mov    0x4(%eax),%eax
    1189:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    118c:	7f 0c                	jg     119a <APDrawLine+0x268>
    118e:	8b 45 08             	mov    0x8(%ebp),%eax
    1191:	8b 40 04             	mov    0x4(%eax),%eax
    1194:	83 e8 01             	sub    $0x1,%eax
    1197:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    119a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    119d:	89 45 e0             	mov    %eax,-0x20(%ebp)
    11a0:	eb 3f                	jmp    11e1 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    11a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11a5:	2b 45 10             	sub    0x10(%ebp),%eax
    11a8:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11ab:	db 45 b0             	fildl  -0x50(%ebp)
    11ae:	dc 4d c0             	fmull  -0x40(%ebp)
    11b1:	db 45 0c             	fildl  0xc(%ebp)
    11b4:	de c1                	faddp  %st,%st(1)
    11b6:	d9 7d b6             	fnstcw -0x4a(%ebp)
    11b9:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    11bd:	b4 0c                	mov    $0xc,%ah
    11bf:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    11c3:	d9 6d b4             	fldcw  -0x4c(%ebp)
    11c6:	db 5d bc             	fistpl -0x44(%ebp)
    11c9:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    11cc:	ff 75 e0             	pushl  -0x20(%ebp)
    11cf:	ff 75 bc             	pushl  -0x44(%ebp)
    11d2:	ff 75 08             	pushl  0x8(%ebp)
    11d5:	e8 75 fc ff ff       	call   e4f <APDrawPoint>
    11da:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    11dd:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    11e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11e4:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11e7:	7e b9                	jle    11a2 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    11e9:	90                   	nop
    11ea:	eb 04                	jmp    11f0 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    11ec:	90                   	nop
    11ed:	eb 01                	jmp    11f0 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    11ef:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    11f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11f3:	c9                   	leave  
    11f4:	c3                   	ret    

000011f5 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    11f5:	55                   	push   %ebp
    11f6:	89 e5                	mov    %esp,%ebp
    11f8:	53                   	push   %ebx
    11f9:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    11fc:	8b 55 10             	mov    0x10(%ebp),%edx
    11ff:	8b 45 18             	mov    0x18(%ebp),%eax
    1202:	01 d0                	add    %edx,%eax
    1204:	83 e8 01             	sub    $0x1,%eax
    1207:	83 ec 04             	sub    $0x4,%esp
    120a:	50                   	push   %eax
    120b:	ff 75 0c             	pushl  0xc(%ebp)
    120e:	ff 75 10             	pushl  0x10(%ebp)
    1211:	ff 75 0c             	pushl  0xc(%ebp)
    1214:	ff 75 08             	pushl  0x8(%ebp)
    1217:	e8 16 fd ff ff       	call   f32 <APDrawLine>
    121c:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    121f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1222:	8b 45 14             	mov    0x14(%ebp),%eax
    1225:	01 d0                	add    %edx,%eax
    1227:	83 e8 01             	sub    $0x1,%eax
    122a:	83 ec 04             	sub    $0x4,%esp
    122d:	ff 75 10             	pushl  0x10(%ebp)
    1230:	50                   	push   %eax
    1231:	ff 75 10             	pushl  0x10(%ebp)
    1234:	ff 75 0c             	pushl  0xc(%ebp)
    1237:	ff 75 08             	pushl  0x8(%ebp)
    123a:	e8 f3 fc ff ff       	call   f32 <APDrawLine>
    123f:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1242:	8b 55 10             	mov    0x10(%ebp),%edx
    1245:	8b 45 18             	mov    0x18(%ebp),%eax
    1248:	01 d0                	add    %edx,%eax
    124a:	8d 48 ff             	lea    -0x1(%eax),%ecx
    124d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1250:	8b 45 14             	mov    0x14(%ebp),%eax
    1253:	01 d0                	add    %edx,%eax
    1255:	8d 50 ff             	lea    -0x1(%eax),%edx
    1258:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    125b:	8b 45 14             	mov    0x14(%ebp),%eax
    125e:	01 d8                	add    %ebx,%eax
    1260:	83 e8 01             	sub    $0x1,%eax
    1263:	83 ec 04             	sub    $0x4,%esp
    1266:	51                   	push   %ecx
    1267:	52                   	push   %edx
    1268:	ff 75 10             	pushl  0x10(%ebp)
    126b:	50                   	push   %eax
    126c:	ff 75 08             	pushl  0x8(%ebp)
    126f:	e8 be fc ff ff       	call   f32 <APDrawLine>
    1274:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1277:	8b 55 10             	mov    0x10(%ebp),%edx
    127a:	8b 45 18             	mov    0x18(%ebp),%eax
    127d:	01 d0                	add    %edx,%eax
    127f:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1282:	8b 55 0c             	mov    0xc(%ebp),%edx
    1285:	8b 45 14             	mov    0x14(%ebp),%eax
    1288:	01 d0                	add    %edx,%eax
    128a:	8d 50 ff             	lea    -0x1(%eax),%edx
    128d:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1290:	8b 45 18             	mov    0x18(%ebp),%eax
    1293:	01 d8                	add    %ebx,%eax
    1295:	83 e8 01             	sub    $0x1,%eax
    1298:	83 ec 04             	sub    $0x4,%esp
    129b:	51                   	push   %ecx
    129c:	52                   	push   %edx
    129d:	50                   	push   %eax
    129e:	ff 75 0c             	pushl  0xc(%ebp)
    12a1:	ff 75 08             	pushl  0x8(%ebp)
    12a4:	e8 89 fc ff ff       	call   f32 <APDrawLine>
    12a9:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    12ac:	8b 55 0c             	mov    0xc(%ebp),%edx
    12af:	8b 45 14             	mov    0x14(%ebp),%eax
    12b2:	01 d0                	add    %edx,%eax
    12b4:	8d 50 ff             	lea    -0x1(%eax),%edx
    12b7:	8b 45 08             	mov    0x8(%ebp),%eax
    12ba:	8b 40 0c             	mov    0xc(%eax),%eax
    12bd:	89 c1                	mov    %eax,%ecx
    12bf:	c1 e9 1f             	shr    $0x1f,%ecx
    12c2:	01 c8                	add    %ecx,%eax
    12c4:	d1 f8                	sar    %eax
    12c6:	29 c2                	sub    %eax,%edx
    12c8:	89 d0                	mov    %edx,%eax
    12ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    12cd:	8b 55 10             	mov    0x10(%ebp),%edx
    12d0:	8b 45 18             	mov    0x18(%ebp),%eax
    12d3:	01 d0                	add    %edx,%eax
    12d5:	8d 50 ff             	lea    -0x1(%eax),%edx
    12d8:	8b 45 08             	mov    0x8(%ebp),%eax
    12db:	8b 40 0c             	mov    0xc(%eax),%eax
    12de:	89 c1                	mov    %eax,%ecx
    12e0:	c1 e9 1f             	shr    $0x1f,%ecx
    12e3:	01 c8                	add    %ecx,%eax
    12e5:	d1 f8                	sar    %eax
    12e7:	29 c2                	sub    %eax,%edx
    12e9:	89 d0                	mov    %edx,%eax
    12eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    12ee:	8b 45 08             	mov    0x8(%ebp),%eax
    12f1:	8b 40 0c             	mov    0xc(%eax),%eax
    12f4:	89 c2                	mov    %eax,%edx
    12f6:	c1 ea 1f             	shr    $0x1f,%edx
    12f9:	01 d0                	add    %edx,%eax
    12fb:	d1 f8                	sar    %eax
    12fd:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1300:	8b 45 08             	mov    0x8(%ebp),%eax
    1303:	8b 40 0c             	mov    0xc(%eax),%eax
    1306:	89 c2                	mov    %eax,%edx
    1308:	c1 ea 1f             	shr    $0x1f,%edx
    130b:	01 d0                	add    %edx,%eax
    130d:	d1 f8                	sar    %eax
    130f:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1312:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1316:	0f 88 d8 00 00 00    	js     13f4 <APDrawRect+0x1ff>
    131c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1320:	0f 88 ce 00 00 00    	js     13f4 <APDrawRect+0x1ff>
    1326:	8b 45 08             	mov    0x8(%ebp),%eax
    1329:	8b 00                	mov    (%eax),%eax
    132b:	3b 45 0c             	cmp    0xc(%ebp),%eax
    132e:	0f 8e c0 00 00 00    	jle    13f4 <APDrawRect+0x1ff>
    1334:	8b 45 08             	mov    0x8(%ebp),%eax
    1337:	8b 40 04             	mov    0x4(%eax),%eax
    133a:	3b 45 10             	cmp    0x10(%ebp),%eax
    133d:	0f 8e b1 00 00 00    	jle    13f4 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1343:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1347:	79 07                	jns    1350 <APDrawRect+0x15b>
    1349:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1350:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1354:	79 07                	jns    135d <APDrawRect+0x168>
    1356:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    135d:	8b 45 08             	mov    0x8(%ebp),%eax
    1360:	8b 00                	mov    (%eax),%eax
    1362:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1365:	7f 0b                	jg     1372 <APDrawRect+0x17d>
    1367:	8b 45 08             	mov    0x8(%ebp),%eax
    136a:	8b 00                	mov    (%eax),%eax
    136c:	83 e8 01             	sub    $0x1,%eax
    136f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1372:	8b 45 08             	mov    0x8(%ebp),%eax
    1375:	8b 40 04             	mov    0x4(%eax),%eax
    1378:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    137b:	7f 0c                	jg     1389 <APDrawRect+0x194>
    137d:	8b 45 08             	mov    0x8(%ebp),%eax
    1380:	8b 40 04             	mov    0x4(%eax),%eax
    1383:	83 e8 01             	sub    $0x1,%eax
    1386:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1389:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1390:	8b 45 0c             	mov    0xc(%ebp),%eax
    1393:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1396:	eb 52                	jmp    13ea <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1398:	8b 45 10             	mov    0x10(%ebp),%eax
    139b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    139e:	eb 3e                	jmp    13de <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    13a0:	83 ec 04             	sub    $0x4,%esp
    13a3:	ff 75 e8             	pushl  -0x18(%ebp)
    13a6:	ff 75 ec             	pushl  -0x14(%ebp)
    13a9:	ff 75 08             	pushl  0x8(%ebp)
    13ac:	e8 02 f7 ff ff       	call   ab3 <APGetIndex>
    13b1:	83 c4 10             	add    $0x10,%esp
    13b4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    13b7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ba:	8b 48 18             	mov    0x18(%eax),%ecx
    13bd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    13c0:	89 d0                	mov    %edx,%eax
    13c2:	01 c0                	add    %eax,%eax
    13c4:	01 d0                	add    %edx,%eax
    13c6:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    13c9:	8b 45 08             	mov    0x8(%ebp),%eax
    13cc:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    13d0:	66 89 0a             	mov    %cx,(%edx)
    13d3:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    13d7:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    13da:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    13de:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13e1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    13e4:	7e ba                	jle    13a0 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    13e6:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    13ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13ed:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    13f0:	7e a6                	jle    1398 <APDrawRect+0x1a3>
    13f2:	eb 01                	jmp    13f5 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    13f4:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    13f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13f8:	c9                   	leave  
    13f9:	c3                   	ret    

000013fa <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    13fa:	55                   	push   %ebp
    13fb:	89 e5                	mov    %esp,%ebp
    13fd:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1400:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1404:	0f 88 8e 01 00 00    	js     1598 <APDcCopy+0x19e>
    140a:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    140e:	0f 88 84 01 00 00    	js     1598 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1414:	8b 55 0c             	mov    0xc(%ebp),%edx
    1417:	8b 45 20             	mov    0x20(%ebp),%eax
    141a:	01 d0                	add    %edx,%eax
    141c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    141f:	8b 55 10             	mov    0x10(%ebp),%edx
    1422:	8b 45 24             	mov    0x24(%ebp),%eax
    1425:	01 d0                	add    %edx,%eax
    1427:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    142a:	8b 55 18             	mov    0x18(%ebp),%edx
    142d:	8b 45 20             	mov    0x20(%ebp),%eax
    1430:	01 d0                	add    %edx,%eax
    1432:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1435:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1438:	8b 45 24             	mov    0x24(%ebp),%eax
    143b:	01 d0                	add    %edx,%eax
    143d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1440:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1444:	0f 88 51 01 00 00    	js     159b <APDcCopy+0x1a1>
    144a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    144e:	0f 88 47 01 00 00    	js     159b <APDcCopy+0x1a1>
    1454:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1458:	0f 88 3d 01 00 00    	js     159b <APDcCopy+0x1a1>
    145e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1462:	0f 88 33 01 00 00    	js     159b <APDcCopy+0x1a1>
    1468:	8b 45 14             	mov    0x14(%ebp),%eax
    146b:	8b 00                	mov    (%eax),%eax
    146d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1470:	0f 8c 25 01 00 00    	jl     159b <APDcCopy+0x1a1>
    1476:	8b 45 14             	mov    0x14(%ebp),%eax
    1479:	8b 40 04             	mov    0x4(%eax),%eax
    147c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    147f:	0f 8c 16 01 00 00    	jl     159b <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1485:	8b 45 08             	mov    0x8(%ebp),%eax
    1488:	8b 00                	mov    (%eax),%eax
    148a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    148d:	7f 0b                	jg     149a <APDcCopy+0xa0>
    148f:	8b 45 08             	mov    0x8(%ebp),%eax
    1492:	8b 00                	mov    (%eax),%eax
    1494:	83 e8 01             	sub    $0x1,%eax
    1497:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    149a:	8b 45 08             	mov    0x8(%ebp),%eax
    149d:	8b 40 04             	mov    0x4(%eax),%eax
    14a0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    14a3:	7f 0c                	jg     14b1 <APDcCopy+0xb7>
    14a5:	8b 45 08             	mov    0x8(%ebp),%eax
    14a8:	8b 40 04             	mov    0x4(%eax),%eax
    14ab:	83 e8 01             	sub    $0x1,%eax
    14ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    14b1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    14b8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    14bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14c6:	e9 bc 00 00 00       	jmp    1587 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    14cb:	8b 45 08             	mov    0x8(%ebp),%eax
    14ce:	8b 00                	mov    (%eax),%eax
    14d0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14d3:	8b 55 10             	mov    0x10(%ebp),%edx
    14d6:	01 ca                	add    %ecx,%edx
    14d8:	0f af d0             	imul   %eax,%edx
    14db:	8b 45 0c             	mov    0xc(%ebp),%eax
    14de:	01 d0                	add    %edx,%eax
    14e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    14e3:	8b 45 14             	mov    0x14(%ebp),%eax
    14e6:	8b 00                	mov    (%eax),%eax
    14e8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14eb:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14ee:	01 ca                	add    %ecx,%edx
    14f0:	0f af d0             	imul   %eax,%edx
    14f3:	8b 45 18             	mov    0x18(%ebp),%eax
    14f6:	01 d0                	add    %edx,%eax
    14f8:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    14fb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1502:	eb 74                	jmp    1578 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1504:	8b 45 14             	mov    0x14(%ebp),%eax
    1507:	8b 50 18             	mov    0x18(%eax),%edx
    150a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    150d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1510:	01 c8                	add    %ecx,%eax
    1512:	89 c1                	mov    %eax,%ecx
    1514:	89 c8                	mov    %ecx,%eax
    1516:	01 c0                	add    %eax,%eax
    1518:	01 c8                	add    %ecx,%eax
    151a:	01 d0                	add    %edx,%eax
    151c:	0f b7 10             	movzwl (%eax),%edx
    151f:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1523:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1527:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    152a:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    152e:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1532:	38 c2                	cmp    %al,%dl
    1534:	75 18                	jne    154e <APDcCopy+0x154>
    1536:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    153a:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    153e:	38 c2                	cmp    %al,%dl
    1540:	75 0c                	jne    154e <APDcCopy+0x154>
    1542:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1546:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    154a:	38 c2                	cmp    %al,%dl
    154c:	74 26                	je     1574 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    154e:	8b 45 08             	mov    0x8(%ebp),%eax
    1551:	8b 50 18             	mov    0x18(%eax),%edx
    1554:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1557:	8b 45 f0             	mov    -0x10(%ebp),%eax
    155a:	01 c8                	add    %ecx,%eax
    155c:	89 c1                	mov    %eax,%ecx
    155e:	89 c8                	mov    %ecx,%eax
    1560:	01 c0                	add    %eax,%eax
    1562:	01 c8                	add    %ecx,%eax
    1564:	01 d0                	add    %edx,%eax
    1566:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    156a:	66 89 10             	mov    %dx,(%eax)
    156d:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1571:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1574:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1578:	8b 45 fc             	mov    -0x4(%ebp),%eax
    157b:	2b 45 0c             	sub    0xc(%ebp),%eax
    157e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1581:	7d 81                	jge    1504 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1583:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1587:	8b 45 f8             	mov    -0x8(%ebp),%eax
    158a:	2b 45 10             	sub    0x10(%ebp),%eax
    158d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1590:	0f 8d 35 ff ff ff    	jge    14cb <APDcCopy+0xd1>
    1596:	eb 04                	jmp    159c <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1598:	90                   	nop
    1599:	eb 01                	jmp    159c <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    159b:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    159c:	c9                   	leave  
    159d:	c3                   	ret    

0000159e <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    159e:	55                   	push   %ebp
    159f:	89 e5                	mov    %esp,%ebp
    15a1:	83 ec 1c             	sub    $0x1c,%esp
    15a4:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    15a7:	8b 55 10             	mov    0x10(%ebp),%edx
    15aa:	8b 45 14             	mov    0x14(%ebp),%eax
    15ad:	88 4d ec             	mov    %cl,-0x14(%ebp)
    15b0:	88 55 e8             	mov    %dl,-0x18(%ebp)
    15b3:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    15b6:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    15ba:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    15bd:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    15c1:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    15c4:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    15c8:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    15cb:	8b 45 08             	mov    0x8(%ebp),%eax
    15ce:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    15d2:	66 89 10             	mov    %dx,(%eax)
    15d5:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    15d9:	88 50 02             	mov    %dl,0x2(%eax)
}
    15dc:	8b 45 08             	mov    0x8(%ebp),%eax
    15df:	c9                   	leave  
    15e0:	c2 04 00             	ret    $0x4

000015e3 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    15e3:	55                   	push   %ebp
    15e4:	89 e5                	mov    %esp,%ebp
    15e6:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    15e9:	8b 45 08             	mov    0x8(%ebp),%eax
    15ec:	8b 00                	mov    (%eax),%eax
    15ee:	83 ec 08             	sub    $0x8,%esp
    15f1:	8d 55 0c             	lea    0xc(%ebp),%edx
    15f4:	52                   	push   %edx
    15f5:	50                   	push   %eax
    15f6:	e8 8d ef ff ff       	call   588 <sendMessage>
    15fb:	83 c4 10             	add    $0x10,%esp
}
    15fe:	90                   	nop
    15ff:	c9                   	leave  
    1600:	c3                   	ret    

00001601 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1601:	55                   	push   %ebp
    1602:	89 e5                	mov    %esp,%ebp
    1604:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1607:	83 ec 0c             	sub    $0xc,%esp
    160a:	68 90 00 00 00       	push   $0x90
    160f:	e8 3e f3 ff ff       	call   952 <malloc>
    1614:	83 c4 10             	add    $0x10,%esp
    1617:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    161a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    161e:	75 15                	jne    1635 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1620:	83 ec 04             	sub    $0x4,%esp
    1623:	ff 75 08             	pushl  0x8(%ebp)
    1626:	68 6c 23 00 00       	push   $0x236c
    162b:	6a 01                	push   $0x1
    162d:	e8 4d f0 ff ff       	call   67f <printf>
    1632:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1635:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1638:	83 c0 7c             	add    $0x7c,%eax
    163b:	83 ec 08             	sub    $0x8,%esp
    163e:	ff 75 08             	pushl  0x8(%ebp)
    1641:	50                   	push   %eax
    1642:	e8 60 ec ff ff       	call   2a7 <strcpy>
    1647:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    164a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164d:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1654:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1657:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    165e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1661:	8b 40 34             	mov    0x34(%eax),%eax
    1664:	89 c2                	mov    %eax,%edx
    1666:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1669:	8b 40 38             	mov    0x38(%eax),%eax
    166c:	0f af d0             	imul   %eax,%edx
    166f:	89 d0                	mov    %edx,%eax
    1671:	01 c0                	add    %eax,%eax
    1673:	01 d0                	add    %edx,%eax
    1675:	83 ec 0c             	sub    $0xc,%esp
    1678:	50                   	push   %eax
    1679:	e8 d4 f2 ff ff       	call   952 <malloc>
    167e:	83 c4 10             	add    $0x10,%esp
    1681:	89 c2                	mov    %eax,%edx
    1683:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1686:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1689:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168c:	8b 40 4c             	mov    0x4c(%eax),%eax
    168f:	85 c0                	test   %eax,%eax
    1691:	75 15                	jne    16a8 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1693:	83 ec 04             	sub    $0x4,%esp
    1696:	ff 75 08             	pushl  0x8(%ebp)
    1699:	68 8c 23 00 00       	push   $0x238c
    169e:	6a 01                	push   $0x1
    16a0:	e8 da ef ff ff       	call   67f <printf>
    16a5:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    16a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ab:	8b 40 34             	mov    0x34(%eax),%eax
    16ae:	89 c2                	mov    %eax,%edx
    16b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b3:	8b 40 38             	mov    0x38(%eax),%eax
    16b6:	0f af d0             	imul   %eax,%edx
    16b9:	89 d0                	mov    %edx,%eax
    16bb:	01 c0                	add    %eax,%eax
    16bd:	01 c2                	add    %eax,%edx
    16bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c2:	8b 40 4c             	mov    0x4c(%eax),%eax
    16c5:	83 ec 04             	sub    $0x4,%esp
    16c8:	52                   	push   %edx
    16c9:	68 ff ff ff 00       	push   $0xffffff
    16ce:	50                   	push   %eax
    16cf:	e8 69 ec ff ff       	call   33d <memset>
    16d4:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    16d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16da:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    16e1:	e8 72 ee ff ff       	call   558 <getpid>
    16e6:	89 c2                	mov    %eax,%edx
    16e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16eb:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    16ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f1:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    16f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fb:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1702:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1705:	8b 40 50             	mov    0x50(%eax),%eax
    1708:	89 c2                	mov    %eax,%edx
    170a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170d:	8b 40 54             	mov    0x54(%eax),%eax
    1710:	0f af d0             	imul   %eax,%edx
    1713:	89 d0                	mov    %edx,%eax
    1715:	01 c0                	add    %eax,%eax
    1717:	01 d0                	add    %edx,%eax
    1719:	83 ec 0c             	sub    $0xc,%esp
    171c:	50                   	push   %eax
    171d:	e8 30 f2 ff ff       	call   952 <malloc>
    1722:	83 c4 10             	add    $0x10,%esp
    1725:	89 c2                	mov    %eax,%edx
    1727:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172a:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    172d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1730:	8b 40 68             	mov    0x68(%eax),%eax
    1733:	85 c0                	test   %eax,%eax
    1735:	75 15                	jne    174c <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1737:	83 ec 04             	sub    $0x4,%esp
    173a:	ff 75 08             	pushl  0x8(%ebp)
    173d:	68 b0 23 00 00       	push   $0x23b0
    1742:	6a 01                	push   $0x1
    1744:	e8 36 ef ff ff       	call   67f <printf>
    1749:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    174c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    174f:	8b 40 34             	mov    0x34(%eax),%eax
    1752:	89 c2                	mov    %eax,%edx
    1754:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1757:	8b 40 38             	mov    0x38(%eax),%eax
    175a:	0f af d0             	imul   %eax,%edx
    175d:	89 d0                	mov    %edx,%eax
    175f:	01 c0                	add    %eax,%eax
    1761:	01 c2                	add    %eax,%edx
    1763:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1766:	8b 40 4c             	mov    0x4c(%eax),%eax
    1769:	83 ec 04             	sub    $0x4,%esp
    176c:	52                   	push   %edx
    176d:	68 ff 00 00 00       	push   $0xff
    1772:	50                   	push   %eax
    1773:	e8 c5 eb ff ff       	call   33d <memset>
    1778:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    177b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1781:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1784:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1788:	74 35                	je     17bf <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    178a:	8b 45 10             	mov    0x10(%ebp),%eax
    178d:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1793:	83 ec 0c             	sub    $0xc,%esp
    1796:	50                   	push   %eax
    1797:	e8 b6 f1 ff ff       	call   952 <malloc>
    179c:	83 c4 10             	add    $0x10,%esp
    179f:	89 c2                	mov    %eax,%edx
    17a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a4:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    17a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17aa:	8b 55 10             	mov    0x10(%ebp),%edx
    17ad:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    17b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b3:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    17ba:	e9 8d 00 00 00       	jmp    184c <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    17bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c2:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    17c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17cc:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    17d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d6:	8b 40 18             	mov    0x18(%eax),%eax
    17d9:	89 c2                	mov    %eax,%edx
    17db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17de:	8b 40 1c             	mov    0x1c(%eax),%eax
    17e1:	0f af d0             	imul   %eax,%edx
    17e4:	89 d0                	mov    %edx,%eax
    17e6:	01 c0                	add    %eax,%eax
    17e8:	01 d0                	add    %edx,%eax
    17ea:	83 ec 0c             	sub    $0xc,%esp
    17ed:	50                   	push   %eax
    17ee:	e8 5f f1 ff ff       	call   952 <malloc>
    17f3:	83 c4 10             	add    $0x10,%esp
    17f6:	89 c2                	mov    %eax,%edx
    17f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17fb:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    17fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1801:	8b 40 30             	mov    0x30(%eax),%eax
    1804:	85 c0                	test   %eax,%eax
    1806:	75 15                	jne    181d <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1808:	83 ec 04             	sub    $0x4,%esp
    180b:	ff 75 08             	pushl  0x8(%ebp)
    180e:	68 d8 23 00 00       	push   $0x23d8
    1813:	6a 01                	push   $0x1
    1815:	e8 65 ee ff ff       	call   67f <printf>
    181a:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    181d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1820:	8b 40 18             	mov    0x18(%eax),%eax
    1823:	89 c2                	mov    %eax,%edx
    1825:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1828:	8b 40 1c             	mov    0x1c(%eax),%eax
    182b:	0f af d0             	imul   %eax,%edx
    182e:	89 d0                	mov    %edx,%eax
    1830:	01 c0                	add    %eax,%eax
    1832:	01 c2                	add    %eax,%edx
    1834:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1837:	8b 40 30             	mov    0x30(%eax),%eax
    183a:	83 ec 04             	sub    $0x4,%esp
    183d:	52                   	push   %edx
    183e:	68 ff ff ff 00       	push   $0xffffff
    1843:	50                   	push   %eax
    1844:	e8 f4 ea ff ff       	call   33d <memset>
    1849:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    184c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    184f:	c9                   	leave  
    1850:	c3                   	ret    

00001851 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1851:	55                   	push   %ebp
    1852:	89 e5                	mov    %esp,%ebp
    1854:	53                   	push   %ebx
    1855:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1858:	8b 45 0c             	mov    0xc(%ebp),%eax
    185b:	83 f8 03             	cmp    $0x3,%eax
    185e:	74 02                	je     1862 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1860:	eb 33                	jmp    1895 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1862:	8b 45 08             	mov    0x8(%ebp),%eax
    1865:	8b 48 08             	mov    0x8(%eax),%ecx
    1868:	8b 45 08             	mov    0x8(%ebp),%eax
    186b:	8b 50 38             	mov    0x38(%eax),%edx
    186e:	8b 45 08             	mov    0x8(%ebp),%eax
    1871:	8b 40 34             	mov    0x34(%eax),%eax
    1874:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1877:	83 c3 34             	add    $0x34,%ebx
    187a:	83 ec 0c             	sub    $0xc,%esp
    187d:	51                   	push   %ecx
    187e:	52                   	push   %edx
    187f:	50                   	push   %eax
    1880:	6a 00                	push   $0x0
    1882:	6a 00                	push   $0x0
    1884:	53                   	push   %ebx
    1885:	6a 32                	push   $0x32
    1887:	6a 00                	push   $0x0
    1889:	ff 75 08             	pushl  0x8(%ebp)
    188c:	e8 e7 ec ff ff       	call   578 <paintWindow>
    1891:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1894:	90                   	nop
        default: break;
            
            
    }
    return False;
    1895:	b8 00 00 00 00       	mov    $0x0,%eax
}
    189a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    189d:	c9                   	leave  
    189e:	c3                   	ret    

0000189f <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    189f:	55                   	push   %ebp
    18a0:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    18a2:	8b 45 0c             	mov    0xc(%ebp),%eax
    18a5:	8b 50 08             	mov    0x8(%eax),%edx
    18a8:	8b 45 08             	mov    0x8(%ebp),%eax
    18ab:	8b 00                	mov    (%eax),%eax
    18ad:	39 c2                	cmp    %eax,%edx
    18af:	74 07                	je     18b8 <APPreJudge+0x19>
        return False;
    18b1:	b8 00 00 00 00       	mov    $0x0,%eax
    18b6:	eb 05                	jmp    18bd <APPreJudge+0x1e>
    return True;
    18b8:	b8 01 00 00 00       	mov    $0x1,%eax
}
    18bd:	5d                   	pop    %ebp
    18be:	c3                   	ret    

000018bf <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    18bf:	55                   	push   %ebp
    18c0:	89 e5                	mov    %esp,%ebp
    18c2:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    18c5:	8b 45 08             	mov    0x8(%ebp),%eax
    18c8:	8b 55 0c             	mov    0xc(%ebp),%edx
    18cb:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    18ce:	83 ec 0c             	sub    $0xc,%esp
    18d1:	ff 75 08             	pushl  0x8(%ebp)
    18d4:	e8 bf ec ff ff       	call   598 <registWindow>
    18d9:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    18dc:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    18e3:	8b 45 08             	mov    0x8(%ebp),%eax
    18e6:	8b 00                	mov    (%eax),%eax
    18e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    18eb:	ff 75 f4             	pushl  -0xc(%ebp)
    18ee:	ff 75 f0             	pushl  -0x10(%ebp)
    18f1:	ff 75 ec             	pushl  -0x14(%ebp)
    18f4:	ff 75 08             	pushl  0x8(%ebp)
    18f7:	e8 e7 fc ff ff       	call   15e3 <APSendMessage>
    18fc:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    18ff:	83 ec 0c             	sub    $0xc,%esp
    1902:	ff 75 08             	pushl  0x8(%ebp)
    1905:	e8 86 ec ff ff       	call   590 <getMessage>
    190a:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    190d:	8b 45 08             	mov    0x8(%ebp),%eax
    1910:	83 c0 6c             	add    $0x6c,%eax
    1913:	83 ec 08             	sub    $0x8,%esp
    1916:	50                   	push   %eax
    1917:	ff 75 08             	pushl  0x8(%ebp)
    191a:	e8 80 ff ff ff       	call   189f <APPreJudge>
    191f:	83 c4 10             	add    $0x10,%esp
    1922:	84 c0                	test   %al,%al
    1924:	74 1b                	je     1941 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    1926:	8b 45 08             	mov    0x8(%ebp),%eax
    1929:	ff 70 74             	pushl  0x74(%eax)
    192c:	ff 70 70             	pushl  0x70(%eax)
    192f:	ff 70 6c             	pushl  0x6c(%eax)
    1932:	ff 75 08             	pushl  0x8(%ebp)
    1935:	8b 45 0c             	mov    0xc(%ebp),%eax
    1938:	ff d0                	call   *%eax
    193a:	83 c4 10             	add    $0x10,%esp
    193d:	84 c0                	test   %al,%al
    193f:	75 0c                	jne    194d <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1941:	8b 45 08             	mov    0x8(%ebp),%eax
    1944:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    194b:	eb b2                	jmp    18ff <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    194d:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    194e:	90                   	nop
    194f:	c9                   	leave  
    1950:	c3                   	ret    

00001951 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1951:	55                   	push   %ebp
    1952:	89 e5                	mov    %esp,%ebp
    1954:	57                   	push   %edi
    1955:	56                   	push   %esi
    1956:	53                   	push   %ebx
    1957:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    195a:	a1 34 2d 00 00       	mov    0x2d34,%eax
    195f:	85 c0                	test   %eax,%eax
    1961:	0f 85 2c 02 00 00    	jne    1b93 <APGridPaint+0x242>
    {
        iconReady = 1;
    1967:	c7 05 34 2d 00 00 01 	movl   $0x1,0x2d34
    196e:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1971:	8d 45 98             	lea    -0x68(%ebp),%eax
    1974:	83 ec 08             	sub    $0x8,%esp
    1977:	68 ff 23 00 00       	push   $0x23ff
    197c:	50                   	push   %eax
    197d:	e8 83 f1 ff ff       	call   b05 <APLoadBitmap>
    1982:	83 c4 0c             	add    $0xc,%esp
    1985:	8b 45 98             	mov    -0x68(%ebp),%eax
    1988:	a3 58 2d 00 00       	mov    %eax,0x2d58
    198d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1990:	a3 5c 2d 00 00       	mov    %eax,0x2d5c
    1995:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1998:	a3 60 2d 00 00       	mov    %eax,0x2d60
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    199d:	83 ec 04             	sub    $0x4,%esp
    19a0:	ff 35 60 2d 00 00    	pushl  0x2d60
    19a6:	ff 35 5c 2d 00 00    	pushl  0x2d5c
    19ac:	ff 35 58 2d 00 00    	pushl  0x2d58
    19b2:	e8 88 f3 ff ff       	call   d3f <APCreateCompatibleDCFromBitmap>
    19b7:	83 c4 10             	add    $0x10,%esp
    19ba:	a3 64 2d 00 00       	mov    %eax,0x2d64
        grid_river = APLoadBitmap ("grid_river.bmp");
    19bf:	8d 45 98             	lea    -0x68(%ebp),%eax
    19c2:	83 ec 08             	sub    $0x8,%esp
    19c5:	68 0d 24 00 00       	push   $0x240d
    19ca:	50                   	push   %eax
    19cb:	e8 35 f1 ff ff       	call   b05 <APLoadBitmap>
    19d0:	83 c4 0c             	add    $0xc,%esp
    19d3:	8b 45 98             	mov    -0x68(%ebp),%eax
    19d6:	a3 94 2d 00 00       	mov    %eax,0x2d94
    19db:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19de:	a3 98 2d 00 00       	mov    %eax,0x2d98
    19e3:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19e6:	a3 9c 2d 00 00       	mov    %eax,0x2d9c
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    19eb:	83 ec 04             	sub    $0x4,%esp
    19ee:	ff 35 9c 2d 00 00    	pushl  0x2d9c
    19f4:	ff 35 98 2d 00 00    	pushl  0x2d98
    19fa:	ff 35 94 2d 00 00    	pushl  0x2d94
    1a00:	e8 3a f3 ff ff       	call   d3f <APCreateCompatibleDCFromBitmap>
    1a05:	83 c4 10             	add    $0x10,%esp
    1a08:	a3 84 2d 00 00       	mov    %eax,0x2d84
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1a0d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a10:	83 ec 08             	sub    $0x8,%esp
    1a13:	68 1c 24 00 00       	push   $0x241c
    1a18:	50                   	push   %eax
    1a19:	e8 e7 f0 ff ff       	call   b05 <APLoadBitmap>
    1a1e:	83 c4 0c             	add    $0xc,%esp
    1a21:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a24:	a3 88 2d 00 00       	mov    %eax,0x2d88
    1a29:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a2c:	a3 8c 2d 00 00       	mov    %eax,0x2d8c
    1a31:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a34:	a3 90 2d 00 00       	mov    %eax,0x2d90
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1a39:	83 ec 04             	sub    $0x4,%esp
    1a3c:	ff 35 90 2d 00 00    	pushl  0x2d90
    1a42:	ff 35 8c 2d 00 00    	pushl  0x2d8c
    1a48:	ff 35 88 2d 00 00    	pushl  0x2d88
    1a4e:	e8 ec f2 ff ff       	call   d3f <APCreateCompatibleDCFromBitmap>
    1a53:	83 c4 10             	add    $0x10,%esp
    1a56:	a3 38 2d 00 00       	mov    %eax,0x2d38
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1a5b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a5e:	83 ec 08             	sub    $0x8,%esp
    1a61:	68 2b 24 00 00       	push   $0x242b
    1a66:	50                   	push   %eax
    1a67:	e8 99 f0 ff ff       	call   b05 <APLoadBitmap>
    1a6c:	83 c4 0c             	add    $0xc,%esp
    1a6f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a72:	a3 6c 2d 00 00       	mov    %eax,0x2d6c
    1a77:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a7a:	a3 70 2d 00 00       	mov    %eax,0x2d70
    1a7f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a82:	a3 74 2d 00 00       	mov    %eax,0x2d74
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1a87:	83 ec 04             	sub    $0x4,%esp
    1a8a:	ff 35 74 2d 00 00    	pushl  0x2d74
    1a90:	ff 35 70 2d 00 00    	pushl  0x2d70
    1a96:	ff 35 6c 2d 00 00    	pushl  0x2d6c
    1a9c:	e8 9e f2 ff ff       	call   d3f <APCreateCompatibleDCFromBitmap>
    1aa1:	83 c4 10             	add    $0x10,%esp
    1aa4:	a3 a0 2d 00 00       	mov    %eax,0x2da0
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1aa9:	8d 45 98             	lea    -0x68(%ebp),%eax
    1aac:	83 ec 08             	sub    $0x8,%esp
    1aaf:	68 39 24 00 00       	push   $0x2439
    1ab4:	50                   	push   %eax
    1ab5:	e8 4b f0 ff ff       	call   b05 <APLoadBitmap>
    1aba:	83 c4 0c             	add    $0xc,%esp
    1abd:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ac0:	a3 48 2d 00 00       	mov    %eax,0x2d48
    1ac5:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1ac8:	a3 4c 2d 00 00       	mov    %eax,0x2d4c
    1acd:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ad0:	a3 50 2d 00 00       	mov    %eax,0x2d50
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1ad5:	83 ec 04             	sub    $0x4,%esp
    1ad8:	ff 35 50 2d 00 00    	pushl  0x2d50
    1ade:	ff 35 4c 2d 00 00    	pushl  0x2d4c
    1ae4:	ff 35 48 2d 00 00    	pushl  0x2d48
    1aea:	e8 50 f2 ff ff       	call   d3f <APCreateCompatibleDCFromBitmap>
    1aef:	83 c4 10             	add    $0x10,%esp
    1af2:	a3 68 2d 00 00       	mov    %eax,0x2d68
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1af7:	8d 45 98             	lea    -0x68(%ebp),%eax
    1afa:	83 ec 08             	sub    $0x8,%esp
    1afd:	68 49 24 00 00       	push   $0x2449
    1b02:	50                   	push   %eax
    1b03:	e8 fd ef ff ff       	call   b05 <APLoadBitmap>
    1b08:	83 c4 0c             	add    $0xc,%esp
    1b0b:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b0e:	a3 3c 2d 00 00       	mov    %eax,0x2d3c
    1b13:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b16:	a3 40 2d 00 00       	mov    %eax,0x2d40
    1b1b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b1e:	a3 44 2d 00 00       	mov    %eax,0x2d44
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1b23:	83 ec 04             	sub    $0x4,%esp
    1b26:	ff 35 44 2d 00 00    	pushl  0x2d44
    1b2c:	ff 35 40 2d 00 00    	pushl  0x2d40
    1b32:	ff 35 3c 2d 00 00    	pushl  0x2d3c
    1b38:	e8 02 f2 ff ff       	call   d3f <APCreateCompatibleDCFromBitmap>
    1b3d:	83 c4 10             	add    $0x10,%esp
    1b40:	a3 54 2d 00 00       	mov    %eax,0x2d54
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1b45:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b48:	83 ec 08             	sub    $0x8,%esp
    1b4b:	68 5b 24 00 00       	push   $0x245b
    1b50:	50                   	push   %eax
    1b51:	e8 af ef ff ff       	call   b05 <APLoadBitmap>
    1b56:	83 c4 0c             	add    $0xc,%esp
    1b59:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b5c:	a3 78 2d 00 00       	mov    %eax,0x2d78
    1b61:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b64:	a3 7c 2d 00 00       	mov    %eax,0x2d7c
    1b69:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b6c:	a3 80 2d 00 00       	mov    %eax,0x2d80
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1b71:	83 ec 04             	sub    $0x4,%esp
    1b74:	ff 35 80 2d 00 00    	pushl  0x2d80
    1b7a:	ff 35 7c 2d 00 00    	pushl  0x2d7c
    1b80:	ff 35 78 2d 00 00    	pushl  0x2d78
    1b86:	e8 b4 f1 ff ff       	call   d3f <APCreateCompatibleDCFromBitmap>
    1b8b:	83 c4 10             	add    $0x10,%esp
    1b8e:	a3 a4 2d 00 00       	mov    %eax,0x2da4
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1b93:	8b 45 08             	mov    0x8(%ebp),%eax
    1b96:	8b 40 08             	mov    0x8(%eax),%eax
    1b99:	85 c0                	test   %eax,%eax
    1b9b:	75 17                	jne    1bb4 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1b9d:	83 ec 08             	sub    $0x8,%esp
    1ba0:	68 6c 24 00 00       	push   $0x246c
    1ba5:	6a 01                	push   $0x1
    1ba7:	e8 d3 ea ff ff       	call   67f <printf>
    1bac:	83 c4 10             	add    $0x10,%esp
        return;
    1baf:	e9 f2 03 00 00       	jmp    1fa6 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1bb4:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb7:	8b 40 10             	mov    0x10(%eax),%eax
    1bba:	85 c0                	test   %eax,%eax
    1bbc:	7e 10                	jle    1bce <APGridPaint+0x27d>
    1bbe:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc1:	8b 50 14             	mov    0x14(%eax),%edx
    1bc4:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc7:	8b 40 10             	mov    0x10(%eax),%eax
    1bca:	39 c2                	cmp    %eax,%edx
    1bcc:	7c 17                	jl     1be5 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1bce:	83 ec 08             	sub    $0x8,%esp
    1bd1:	68 92 24 00 00       	push   $0x2492
    1bd6:	6a 01                	push   $0x1
    1bd8:	e8 a2 ea ff ff       	call   67f <printf>
    1bdd:	83 c4 10             	add    $0x10,%esp
        return;
    1be0:	e9 c1 03 00 00       	jmp    1fa6 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1be5:	8b 45 08             	mov    0x8(%ebp),%eax
    1be8:	8b 40 14             	mov    0x14(%eax),%eax
    1beb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1bf1:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1bf4:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1bf7:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1bfa:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1c01:	e9 96 03 00 00       	jmp    1f9c <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1c06:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1c0d:	e9 7c 03 00 00       	jmp    1f8e <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1c12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c15:	c1 e0 04             	shl    $0x4,%eax
    1c18:	89 c2                	mov    %eax,%edx
    1c1a:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1c1d:	01 c2                	add    %eax,%edx
    1c1f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c22:	01 d0                	add    %edx,%eax
    1c24:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1c27:	8b 45 08             	mov    0x8(%ebp),%eax
    1c2a:	8b 40 0c             	mov    0xc(%eax),%eax
    1c2d:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1c30:	c1 e2 02             	shl    $0x2,%edx
    1c33:	01 d0                	add    %edx,%eax
    1c35:	8b 00                	mov    (%eax),%eax
    1c37:	83 f8 07             	cmp    $0x7,%eax
    1c3a:	0f 87 49 03 00 00    	ja     1f89 <APGridPaint+0x638>
    1c40:	8b 04 85 a8 24 00 00 	mov    0x24a8(,%eax,4),%eax
    1c47:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c49:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1c4c:	6a 0c                	push   $0xc
    1c4e:	6a 0c                	push   $0xc
    1c50:	6a 0c                	push   $0xc
    1c52:	50                   	push   %eax
    1c53:	e8 46 f9 ff ff       	call   159e <RGB>
    1c58:	83 c4 0c             	add    $0xc,%esp
    1c5b:	8b 1d 64 2d 00 00    	mov    0x2d64,%ebx
    1c61:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c64:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c67:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c6a:	6b c0 32             	imul   $0x32,%eax,%eax
    1c6d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c70:	8b 45 08             	mov    0x8(%ebp),%eax
    1c73:	8d 78 34             	lea    0x34(%eax),%edi
    1c76:	83 ec 0c             	sub    $0xc,%esp
    1c79:	83 ec 04             	sub    $0x4,%esp
    1c7c:	89 e0                	mov    %esp,%eax
    1c7e:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1c82:	66 89 30             	mov    %si,(%eax)
    1c85:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1c89:	88 50 02             	mov    %dl,0x2(%eax)
    1c8c:	6a 32                	push   $0x32
    1c8e:	6a 32                	push   $0x32
    1c90:	6a 00                	push   $0x0
    1c92:	6a 00                	push   $0x0
    1c94:	53                   	push   %ebx
    1c95:	51                   	push   %ecx
    1c96:	ff 75 94             	pushl  -0x6c(%ebp)
    1c99:	57                   	push   %edi
    1c9a:	e8 5b f7 ff ff       	call   13fa <APDcCopy>
    1c9f:	83 c4 30             	add    $0x30,%esp
                    break;
    1ca2:	e9 e3 02 00 00       	jmp    1f8a <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1ca7:	8d 45 98             	lea    -0x68(%ebp),%eax
    1caa:	6a 69                	push   $0x69
    1cac:	6a 69                	push   $0x69
    1cae:	6a 69                	push   $0x69
    1cb0:	50                   	push   %eax
    1cb1:	e8 e8 f8 ff ff       	call   159e <RGB>
    1cb6:	83 c4 0c             	add    $0xc,%esp
    1cb9:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1cbd:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1cc1:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1cc5:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1cc8:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1ccf:	8d 45 98             	lea    -0x68(%ebp),%eax
    1cd2:	6a 69                	push   $0x69
    1cd4:	6a 69                	push   $0x69
    1cd6:	6a 69                	push   $0x69
    1cd8:	50                   	push   %eax
    1cd9:	e8 c0 f8 ff ff       	call   159e <RGB>
    1cde:	83 c4 0c             	add    $0xc,%esp
    1ce1:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ce5:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1ce9:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ced:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1cf0:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf3:	8d 50 34             	lea    0x34(%eax),%edx
    1cf6:	8d 45 98             	lea    -0x68(%ebp),%eax
    1cf9:	ff 75 bc             	pushl  -0x44(%ebp)
    1cfc:	ff 75 b8             	pushl  -0x48(%ebp)
    1cff:	52                   	push   %edx
    1d00:	50                   	push   %eax
    1d01:	e8 ce f0 ff ff       	call   dd4 <APSetPen>
    1d06:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1d09:	8b 45 08             	mov    0x8(%ebp),%eax
    1d0c:	8d 58 34             	lea    0x34(%eax),%ebx
    1d0f:	8d 55 98             	lea    -0x68(%ebp),%edx
    1d12:	83 ec 04             	sub    $0x4,%esp
    1d15:	83 ec 04             	sub    $0x4,%esp
    1d18:	89 e0                	mov    %esp,%eax
    1d1a:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1d1e:	66 89 08             	mov    %cx,(%eax)
    1d21:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1d25:	88 48 02             	mov    %cl,0x2(%eax)
    1d28:	53                   	push   %ebx
    1d29:	52                   	push   %edx
    1d2a:	e8 de f0 ff ff       	call   e0d <APSetBrush>
    1d2f:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1d32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d35:	6b d0 32             	imul   $0x32,%eax,%edx
    1d38:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d3b:	6b c0 32             	imul   $0x32,%eax,%eax
    1d3e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1d41:	83 c1 34             	add    $0x34,%ecx
    1d44:	83 ec 0c             	sub    $0xc,%esp
    1d47:	6a 32                	push   $0x32
    1d49:	6a 32                	push   $0x32
    1d4b:	52                   	push   %edx
    1d4c:	50                   	push   %eax
    1d4d:	51                   	push   %ecx
    1d4e:	e8 a2 f4 ff ff       	call   11f5 <APDrawRect>
    1d53:	83 c4 20             	add    $0x20,%esp
                    break;
    1d56:	e9 2f 02 00 00       	jmp    1f8a <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d5b:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1d5e:	6a 0c                	push   $0xc
    1d60:	6a 0c                	push   $0xc
    1d62:	6a 0c                	push   $0xc
    1d64:	50                   	push   %eax
    1d65:	e8 34 f8 ff ff       	call   159e <RGB>
    1d6a:	83 c4 0c             	add    $0xc,%esp
    1d6d:	8b 1d a4 2d 00 00    	mov    0x2da4,%ebx
    1d73:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d76:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d79:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d7c:	6b c0 32             	imul   $0x32,%eax,%eax
    1d7f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d82:	8b 45 08             	mov    0x8(%ebp),%eax
    1d85:	8d 78 34             	lea    0x34(%eax),%edi
    1d88:	83 ec 0c             	sub    $0xc,%esp
    1d8b:	83 ec 04             	sub    $0x4,%esp
    1d8e:	89 e0                	mov    %esp,%eax
    1d90:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1d94:	66 89 30             	mov    %si,(%eax)
    1d97:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1d9b:	88 50 02             	mov    %dl,0x2(%eax)
    1d9e:	6a 32                	push   $0x32
    1da0:	6a 32                	push   $0x32
    1da2:	6a 00                	push   $0x0
    1da4:	6a 00                	push   $0x0
    1da6:	53                   	push   %ebx
    1da7:	51                   	push   %ecx
    1da8:	ff 75 94             	pushl  -0x6c(%ebp)
    1dab:	57                   	push   %edi
    1dac:	e8 49 f6 ff ff       	call   13fa <APDcCopy>
    1db1:	83 c4 30             	add    $0x30,%esp
                    break;
    1db4:	e9 d1 01 00 00       	jmp    1f8a <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1db9:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1dbc:	6a 0c                	push   $0xc
    1dbe:	6a 0c                	push   $0xc
    1dc0:	6a 0c                	push   $0xc
    1dc2:	50                   	push   %eax
    1dc3:	e8 d6 f7 ff ff       	call   159e <RGB>
    1dc8:	83 c4 0c             	add    $0xc,%esp
    1dcb:	8b 1d 84 2d 00 00    	mov    0x2d84,%ebx
    1dd1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dd4:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dd7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dda:	6b c0 32             	imul   $0x32,%eax,%eax
    1ddd:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1de0:	8b 45 08             	mov    0x8(%ebp),%eax
    1de3:	8d 78 34             	lea    0x34(%eax),%edi
    1de6:	83 ec 0c             	sub    $0xc,%esp
    1de9:	83 ec 04             	sub    $0x4,%esp
    1dec:	89 e0                	mov    %esp,%eax
    1dee:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1df2:	66 89 30             	mov    %si,(%eax)
    1df5:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1df9:	88 50 02             	mov    %dl,0x2(%eax)
    1dfc:	6a 32                	push   $0x32
    1dfe:	6a 32                	push   $0x32
    1e00:	6a 00                	push   $0x0
    1e02:	6a 00                	push   $0x0
    1e04:	53                   	push   %ebx
    1e05:	51                   	push   %ecx
    1e06:	ff 75 94             	pushl  -0x6c(%ebp)
    1e09:	57                   	push   %edi
    1e0a:	e8 eb f5 ff ff       	call   13fa <APDcCopy>
    1e0f:	83 c4 30             	add    $0x30,%esp
                    break;
    1e12:	e9 73 01 00 00       	jmp    1f8a <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e17:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1e1a:	6a 0c                	push   $0xc
    1e1c:	6a 0c                	push   $0xc
    1e1e:	6a 0c                	push   $0xc
    1e20:	50                   	push   %eax
    1e21:	e8 78 f7 ff ff       	call   159e <RGB>
    1e26:	83 c4 0c             	add    $0xc,%esp
    1e29:	8b 1d 68 2d 00 00    	mov    0x2d68,%ebx
    1e2f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e32:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e35:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e38:	6b c0 32             	imul   $0x32,%eax,%eax
    1e3b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e41:	8d 78 34             	lea    0x34(%eax),%edi
    1e44:	83 ec 0c             	sub    $0xc,%esp
    1e47:	83 ec 04             	sub    $0x4,%esp
    1e4a:	89 e0                	mov    %esp,%eax
    1e4c:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1e50:	66 89 30             	mov    %si,(%eax)
    1e53:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1e57:	88 50 02             	mov    %dl,0x2(%eax)
    1e5a:	6a 32                	push   $0x32
    1e5c:	6a 32                	push   $0x32
    1e5e:	6a 00                	push   $0x0
    1e60:	6a 00                	push   $0x0
    1e62:	53                   	push   %ebx
    1e63:	51                   	push   %ecx
    1e64:	ff 75 94             	pushl  -0x6c(%ebp)
    1e67:	57                   	push   %edi
    1e68:	e8 8d f5 ff ff       	call   13fa <APDcCopy>
    1e6d:	83 c4 30             	add    $0x30,%esp
                    break;
    1e70:	e9 15 01 00 00       	jmp    1f8a <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e75:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1e78:	6a 0c                	push   $0xc
    1e7a:	6a 0c                	push   $0xc
    1e7c:	6a 0c                	push   $0xc
    1e7e:	50                   	push   %eax
    1e7f:	e8 1a f7 ff ff       	call   159e <RGB>
    1e84:	83 c4 0c             	add    $0xc,%esp
    1e87:	8b 1d a0 2d 00 00    	mov    0x2da0,%ebx
    1e8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e90:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e93:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e96:	6b c0 32             	imul   $0x32,%eax,%eax
    1e99:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e9c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e9f:	8d 78 34             	lea    0x34(%eax),%edi
    1ea2:	83 ec 0c             	sub    $0xc,%esp
    1ea5:	83 ec 04             	sub    $0x4,%esp
    1ea8:	89 e0                	mov    %esp,%eax
    1eaa:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1eae:	66 89 30             	mov    %si,(%eax)
    1eb1:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1eb5:	88 50 02             	mov    %dl,0x2(%eax)
    1eb8:	6a 32                	push   $0x32
    1eba:	6a 32                	push   $0x32
    1ebc:	6a 00                	push   $0x0
    1ebe:	6a 00                	push   $0x0
    1ec0:	53                   	push   %ebx
    1ec1:	51                   	push   %ecx
    1ec2:	ff 75 94             	pushl  -0x6c(%ebp)
    1ec5:	57                   	push   %edi
    1ec6:	e8 2f f5 ff ff       	call   13fa <APDcCopy>
    1ecb:	83 c4 30             	add    $0x30,%esp
                    break;
    1ece:	e9 b7 00 00 00       	jmp    1f8a <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ed3:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1ed6:	6a 0c                	push   $0xc
    1ed8:	6a 0c                	push   $0xc
    1eda:	6a 0c                	push   $0xc
    1edc:	50                   	push   %eax
    1edd:	e8 bc f6 ff ff       	call   159e <RGB>
    1ee2:	83 c4 0c             	add    $0xc,%esp
    1ee5:	8b 1d 38 2d 00 00    	mov    0x2d38,%ebx
    1eeb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1eee:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ef1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ef4:	6b c0 32             	imul   $0x32,%eax,%eax
    1ef7:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1efa:	8b 45 08             	mov    0x8(%ebp),%eax
    1efd:	8d 78 34             	lea    0x34(%eax),%edi
    1f00:	83 ec 0c             	sub    $0xc,%esp
    1f03:	83 ec 04             	sub    $0x4,%esp
    1f06:	89 e0                	mov    %esp,%eax
    1f08:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1f0c:	66 89 30             	mov    %si,(%eax)
    1f0f:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1f13:	88 50 02             	mov    %dl,0x2(%eax)
    1f16:	6a 32                	push   $0x32
    1f18:	6a 32                	push   $0x32
    1f1a:	6a 00                	push   $0x0
    1f1c:	6a 00                	push   $0x0
    1f1e:	53                   	push   %ebx
    1f1f:	51                   	push   %ecx
    1f20:	ff 75 94             	pushl  -0x6c(%ebp)
    1f23:	57                   	push   %edi
    1f24:	e8 d1 f4 ff ff       	call   13fa <APDcCopy>
    1f29:	83 c4 30             	add    $0x30,%esp
                    break;
    1f2c:	eb 5c                	jmp    1f8a <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f2e:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1f31:	6a 0c                	push   $0xc
    1f33:	6a 0c                	push   $0xc
    1f35:	6a 0c                	push   $0xc
    1f37:	50                   	push   %eax
    1f38:	e8 61 f6 ff ff       	call   159e <RGB>
    1f3d:	83 c4 0c             	add    $0xc,%esp
    1f40:	8b 1d 54 2d 00 00    	mov    0x2d54,%ebx
    1f46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f49:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f4c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f4f:	6b c0 32             	imul   $0x32,%eax,%eax
    1f52:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f55:	8b 45 08             	mov    0x8(%ebp),%eax
    1f58:	8d 78 34             	lea    0x34(%eax),%edi
    1f5b:	83 ec 0c             	sub    $0xc,%esp
    1f5e:	83 ec 04             	sub    $0x4,%esp
    1f61:	89 e0                	mov    %esp,%eax
    1f63:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1f67:	66 89 30             	mov    %si,(%eax)
    1f6a:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1f6e:	88 50 02             	mov    %dl,0x2(%eax)
    1f71:	6a 32                	push   $0x32
    1f73:	6a 32                	push   $0x32
    1f75:	6a 00                	push   $0x0
    1f77:	6a 00                	push   $0x0
    1f79:	53                   	push   %ebx
    1f7a:	51                   	push   %ecx
    1f7b:	ff 75 94             	pushl  -0x6c(%ebp)
    1f7e:	57                   	push   %edi
    1f7f:	e8 76 f4 ff ff       	call   13fa <APDcCopy>
    1f84:	83 c4 30             	add    $0x30,%esp
                    break;
    1f87:	eb 01                	jmp    1f8a <APGridPaint+0x639>
                default: break;
    1f89:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1f8a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1f8e:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1f92:	0f 8e 7a fc ff ff    	jle    1c12 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1f98:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1f9c:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1fa0:	0f 8e 60 fc ff ff    	jle    1c06 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1fa6:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1fa9:	5b                   	pop    %ebx
    1faa:	5e                   	pop    %esi
    1fab:	5f                   	pop    %edi
    1fac:	5d                   	pop    %ebp
    1fad:	c3                   	ret    

00001fae <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1fae:	55                   	push   %ebp
    1faf:	89 e5                	mov    %esp,%ebp
    1fb1:	53                   	push   %ebx
    1fb2:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1fb5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1fbc:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1fc0:	74 17                	je     1fd9 <sprintint+0x2b>
    1fc2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1fc6:	79 11                	jns    1fd9 <sprintint+0x2b>
        neg = 1;
    1fc8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1fcf:	8b 45 10             	mov    0x10(%ebp),%eax
    1fd2:	f7 d8                	neg    %eax
    1fd4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1fd7:	eb 06                	jmp    1fdf <sprintint+0x31>
    } else {
        x = xx;
    1fd9:	8b 45 10             	mov    0x10(%ebp),%eax
    1fdc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1fdf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1fe6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1fe9:	8d 41 01             	lea    0x1(%ecx),%eax
    1fec:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1fef:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1ff2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ff5:	ba 00 00 00 00       	mov    $0x0,%edx
    1ffa:	f7 f3                	div    %ebx
    1ffc:	89 d0                	mov    %edx,%eax
    1ffe:	0f b6 80 14 2d 00 00 	movzbl 0x2d14(%eax),%eax
    2005:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2009:	8b 5d 14             	mov    0x14(%ebp),%ebx
    200c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    200f:	ba 00 00 00 00       	mov    $0x0,%edx
    2014:	f7 f3                	div    %ebx
    2016:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2019:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    201d:	75 c7                	jne    1fe6 <sprintint+0x38>
    if(neg)
    201f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2023:	74 0e                	je     2033 <sprintint+0x85>
        buf[i++] = '-';
    2025:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2028:	8d 50 01             	lea    0x1(%eax),%edx
    202b:	89 55 f8             	mov    %edx,-0x8(%ebp)
    202e:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2033:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2036:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2039:	eb 1b                	jmp    2056 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    203b:	8b 45 0c             	mov    0xc(%ebp),%eax
    203e:	8b 00                	mov    (%eax),%eax
    2040:	8d 48 01             	lea    0x1(%eax),%ecx
    2043:	8b 55 0c             	mov    0xc(%ebp),%edx
    2046:	89 0a                	mov    %ecx,(%edx)
    2048:	89 c2                	mov    %eax,%edx
    204a:	8b 45 08             	mov    0x8(%ebp),%eax
    204d:	01 d0                	add    %edx,%eax
    204f:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2052:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2056:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    205a:	7f df                	jg     203b <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    205c:	eb 21                	jmp    207f <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    205e:	8b 45 0c             	mov    0xc(%ebp),%eax
    2061:	8b 00                	mov    (%eax),%eax
    2063:	8d 48 01             	lea    0x1(%eax),%ecx
    2066:	8b 55 0c             	mov    0xc(%ebp),%edx
    2069:	89 0a                	mov    %ecx,(%edx)
    206b:	89 c2                	mov    %eax,%edx
    206d:	8b 45 08             	mov    0x8(%ebp),%eax
    2070:	01 c2                	add    %eax,%edx
    2072:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2075:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2078:	01 c8                	add    %ecx,%eax
    207a:	0f b6 00             	movzbl (%eax),%eax
    207d:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    207f:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2083:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2087:	79 d5                	jns    205e <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2089:	90                   	nop
    208a:	83 c4 20             	add    $0x20,%esp
    208d:	5b                   	pop    %ebx
    208e:	5d                   	pop    %ebp
    208f:	c3                   	ret    

00002090 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2090:	55                   	push   %ebp
    2091:	89 e5                	mov    %esp,%ebp
    2093:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2096:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    209d:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    20a4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    20ab:	8d 45 0c             	lea    0xc(%ebp),%eax
    20ae:	83 c0 04             	add    $0x4,%eax
    20b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    20b4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    20bb:	e9 d9 01 00 00       	jmp    2299 <sprintf+0x209>
        c = fmt[i] & 0xff;
    20c0:	8b 55 0c             	mov    0xc(%ebp),%edx
    20c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    20c6:	01 d0                	add    %edx,%eax
    20c8:	0f b6 00             	movzbl (%eax),%eax
    20cb:	0f be c0             	movsbl %al,%eax
    20ce:	25 ff 00 00 00       	and    $0xff,%eax
    20d3:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    20d6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    20da:	75 2c                	jne    2108 <sprintf+0x78>
            if(c == '%'){
    20dc:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    20e0:	75 0c                	jne    20ee <sprintf+0x5e>
                state = '%';
    20e2:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    20e9:	e9 a7 01 00 00       	jmp    2295 <sprintf+0x205>
            } else {
                dst[j++] = c;
    20ee:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20f1:	8d 50 01             	lea    0x1(%eax),%edx
    20f4:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20f7:	89 c2                	mov    %eax,%edx
    20f9:	8b 45 08             	mov    0x8(%ebp),%eax
    20fc:	01 d0                	add    %edx,%eax
    20fe:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2101:	88 10                	mov    %dl,(%eax)
    2103:	e9 8d 01 00 00       	jmp    2295 <sprintf+0x205>
            }
        } else if(state == '%'){
    2108:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    210c:	0f 85 83 01 00 00    	jne    2295 <sprintf+0x205>
            if(c == 'd'){
    2112:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2116:	75 4c                	jne    2164 <sprintf+0xd4>
                buf[bi] = '\0';
    2118:	8d 55 ce             	lea    -0x32(%ebp),%edx
    211b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    211e:	01 d0                	add    %edx,%eax
    2120:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2123:	83 ec 0c             	sub    $0xc,%esp
    2126:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2129:	50                   	push   %eax
    212a:	e8 17 e3 ff ff       	call   446 <atoi>
    212f:	83 c4 10             	add    $0x10,%esp
    2132:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2135:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    213c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    213f:	8b 00                	mov    (%eax),%eax
    2141:	83 ec 08             	sub    $0x8,%esp
    2144:	ff 75 d8             	pushl  -0x28(%ebp)
    2147:	6a 01                	push   $0x1
    2149:	6a 0a                	push   $0xa
    214b:	50                   	push   %eax
    214c:	8d 45 c8             	lea    -0x38(%ebp),%eax
    214f:	50                   	push   %eax
    2150:	ff 75 08             	pushl  0x8(%ebp)
    2153:	e8 56 fe ff ff       	call   1fae <sprintint>
    2158:	83 c4 20             	add    $0x20,%esp
                ap++;
    215b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    215f:	e9 2a 01 00 00       	jmp    228e <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2164:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2168:	74 06                	je     2170 <sprintf+0xe0>
    216a:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    216e:	75 4c                	jne    21bc <sprintf+0x12c>
                buf[bi] = '\0';
    2170:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2173:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2176:	01 d0                	add    %edx,%eax
    2178:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    217b:	83 ec 0c             	sub    $0xc,%esp
    217e:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2181:	50                   	push   %eax
    2182:	e8 bf e2 ff ff       	call   446 <atoi>
    2187:	83 c4 10             	add    $0x10,%esp
    218a:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    218d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2194:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2197:	8b 00                	mov    (%eax),%eax
    2199:	83 ec 08             	sub    $0x8,%esp
    219c:	ff 75 dc             	pushl  -0x24(%ebp)
    219f:	6a 00                	push   $0x0
    21a1:	6a 10                	push   $0x10
    21a3:	50                   	push   %eax
    21a4:	8d 45 c8             	lea    -0x38(%ebp),%eax
    21a7:	50                   	push   %eax
    21a8:	ff 75 08             	pushl  0x8(%ebp)
    21ab:	e8 fe fd ff ff       	call   1fae <sprintint>
    21b0:	83 c4 20             	add    $0x20,%esp
                ap++;
    21b3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    21b7:	e9 d2 00 00 00       	jmp    228e <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    21bc:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    21c0:	75 46                	jne    2208 <sprintf+0x178>
                s = (char*)*ap;
    21c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21c5:	8b 00                	mov    (%eax),%eax
    21c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    21ca:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    21ce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    21d2:	75 25                	jne    21f9 <sprintf+0x169>
                    s = "(null)";
    21d4:	c7 45 f4 c8 24 00 00 	movl   $0x24c8,-0xc(%ebp)
                while(*s != 0){
    21db:	eb 1c                	jmp    21f9 <sprintf+0x169>
                    dst[j++] = *s;
    21dd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21e0:	8d 50 01             	lea    0x1(%eax),%edx
    21e3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21e6:	89 c2                	mov    %eax,%edx
    21e8:	8b 45 08             	mov    0x8(%ebp),%eax
    21eb:	01 c2                	add    %eax,%edx
    21ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21f0:	0f b6 00             	movzbl (%eax),%eax
    21f3:	88 02                	mov    %al,(%edx)
                    s++;
    21f5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    21f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21fc:	0f b6 00             	movzbl (%eax),%eax
    21ff:	84 c0                	test   %al,%al
    2201:	75 da                	jne    21dd <sprintf+0x14d>
    2203:	e9 86 00 00 00       	jmp    228e <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2208:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    220c:	75 1d                	jne    222b <sprintf+0x19b>
                dst[j++] = *ap;
    220e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2211:	8d 50 01             	lea    0x1(%eax),%edx
    2214:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2217:	89 c2                	mov    %eax,%edx
    2219:	8b 45 08             	mov    0x8(%ebp),%eax
    221c:	01 c2                	add    %eax,%edx
    221e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2221:	8b 00                	mov    (%eax),%eax
    2223:	88 02                	mov    %al,(%edx)
                ap++;
    2225:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2229:	eb 63                	jmp    228e <sprintf+0x1fe>
            } else if(c == '%'){
    222b:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    222f:	75 17                	jne    2248 <sprintf+0x1b8>
                dst[j++] = c;
    2231:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2234:	8d 50 01             	lea    0x1(%eax),%edx
    2237:	89 55 c8             	mov    %edx,-0x38(%ebp)
    223a:	89 c2                	mov    %eax,%edx
    223c:	8b 45 08             	mov    0x8(%ebp),%eax
    223f:	01 d0                	add    %edx,%eax
    2241:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2244:	88 10                	mov    %dl,(%eax)
    2246:	eb 46                	jmp    228e <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2248:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    224c:	7e 18                	jle    2266 <sprintf+0x1d6>
    224e:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2252:	7f 12                	jg     2266 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2254:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2257:	8d 50 01             	lea    0x1(%eax),%edx
    225a:	89 55 f0             	mov    %edx,-0x10(%ebp)
    225d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2260:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2264:	eb 2f                	jmp    2295 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2266:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2269:	8d 50 01             	lea    0x1(%eax),%edx
    226c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    226f:	89 c2                	mov    %eax,%edx
    2271:	8b 45 08             	mov    0x8(%ebp),%eax
    2274:	01 d0                	add    %edx,%eax
    2276:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2279:	8b 45 c8             	mov    -0x38(%ebp),%eax
    227c:	8d 50 01             	lea    0x1(%eax),%edx
    227f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2282:	89 c2                	mov    %eax,%edx
    2284:	8b 45 08             	mov    0x8(%ebp),%eax
    2287:	01 d0                	add    %edx,%eax
    2289:	8b 55 e0             	mov    -0x20(%ebp),%edx
    228c:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    228e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2295:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2299:	8b 55 0c             	mov    0xc(%ebp),%edx
    229c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    229f:	01 d0                	add    %edx,%eax
    22a1:	0f b6 00             	movzbl (%eax),%eax
    22a4:	84 c0                	test   %al,%al
    22a6:	0f 85 14 fe ff ff    	jne    20c0 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    22ac:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22af:	8d 50 01             	lea    0x1(%eax),%edx
    22b2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22b5:	89 c2                	mov    %eax,%edx
    22b7:	8b 45 08             	mov    0x8(%ebp),%eax
    22ba:	01 d0                	add    %edx,%eax
    22bc:	c6 00 00             	movb   $0x0,(%eax)
}
    22bf:	90                   	nop
    22c0:	c9                   	leave  
    22c1:	c3                   	ret    
