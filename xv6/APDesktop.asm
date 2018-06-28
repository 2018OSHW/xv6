
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
       9:	68 88 20 00 00       	push   $0x2088
       e:	6a 01                	push   $0x1
      10:	e8 2e 06 00 00       	call   643 <printf>
      15:	83 c4 10             	add    $0x10,%esp
    int fd = open("ASCII", O_RDONLY);
      18:	83 ec 08             	sub    $0x8,%esp
      1b:	6a 00                	push   $0x0
      1d:	68 94 20 00 00       	push   $0x2094
      22:	e8 bd 04 00 00       	call   4e4 <open>
      27:	83 c4 10             	add    $0x10,%esp
      2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (fd < 0)
      2d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      31:	79 14                	jns    47 <desktopInitStringFigure+0x47>
    {
        printf(1, "Cannot open file\n");
      33:	83 ec 08             	sub    $0x8,%esp
      36:	68 9a 20 00 00       	push   $0x209a
      3b:	6a 01                	push   $0x1
      3d:	e8 01 06 00 00       	call   643 <printf>
      42:	83 c4 10             	add    $0x10,%esp
        return;
      45:	eb 7d                	jmp    c4 <desktopInitStringFigure+0xc4>
    }
    char * ASCII = (char *)malloc(sizeof(char) * ASCII_SIZE);
      47:	83 ec 0c             	sub    $0xc,%esp
      4a:	68 00 08 00 00       	push   $0x800
      4f:	e8 c2 08 00 00       	call   916 <malloc>
      54:	83 c4 10             	add    $0x10,%esp
      57:	89 45 f0             	mov    %eax,-0x10(%ebp)
    read(fd, ASCII, sizeof(char) * ASCII_SIZE);
      5a:	83 ec 04             	sub    $0x4,%esp
      5d:	68 00 08 00 00       	push   $0x800
      62:	ff 75 f0             	pushl  -0x10(%ebp)
      65:	ff 75 f4             	pushl  -0xc(%ebp)
      68:	e8 4f 04 00 00       	call   4bc <read>
      6d:	83 c4 10             	add    $0x10,%esp
    close(fd);
      70:	83 ec 0c             	sub    $0xc,%esp
      73:	ff 75 f4             	pushl  -0xc(%ebp)
      76:	e8 51 04 00 00       	call   4cc <close>
      7b:	83 c4 10             	add    $0x10,%esp
    printf(1, "read ASCII complete\n");
      7e:	83 ec 08             	sub    $0x8,%esp
      81:	68 ac 20 00 00       	push   $0x20ac
      86:	6a 01                	push   $0x1
      88:	e8 b6 05 00 00       	call   643 <printf>
      8d:	83 c4 10             	add    $0x10,%esp
    
    initStringFigure(0, 0, ASCII, ASCII_SIZE);
      90:	68 00 08 00 00       	push   $0x800
      95:	ff 75 f0             	pushl  -0x10(%ebp)
      98:	6a 00                	push   $0x0
      9a:	6a 00                	push   $0x0
      9c:	e8 ab 04 00 00       	call   54c <initStringFigure>
      a1:	83 c4 10             	add    $0x10,%esp
    //free(GBK2312);
    free(ASCII);
      a4:	83 ec 0c             	sub    $0xc,%esp
      a7:	ff 75 f0             	pushl  -0x10(%ebp)
      aa:	e8 25 07 00 00       	call   7d4 <free>
      af:	83 c4 10             	add    $0x10,%esp
    printf(1, "init string figure complete\n");
      b2:	83 ec 08             	sub    $0x8,%esp
      b5:	68 c1 20 00 00       	push   $0x20c1
      ba:	6a 01                	push   $0x1
      bc:	e8 82 05 00 00       	call   643 <printf>
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
      cc:	e8 cb 03 00 00       	call   49c <fork>
      d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    char temp[30];
    if (pid == 0)
      d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      d8:	75 37                	jne    111 <runApp+0x4b>
    {
        sprintf(temp, "AP%s", (char *)param);
      da:	83 ec 04             	sub    $0x4,%esp
      dd:	ff 75 08             	pushl  0x8(%ebp)
      e0:	68 de 20 00 00       	push   $0x20de
      e5:	8d 45 d6             	lea    -0x2a(%ebp),%eax
      e8:	50                   	push   %eax
      e9:	e8 65 1d 00 00       	call   1e53 <sprintf>
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
     109:	e8 ce 03 00 00       	call   4dc <exec>
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
    printf(1,"desktop processing!\n");
     11a:	83 ec 08             	sub    $0x8,%esp
     11d:	68 e3 20 00 00       	push   $0x20e3
     122:	6a 01                	push   $0x1
     124:	e8 1a 05 00 00       	call   643 <printf>
     129:	83 c4 10             	add    $0x10,%esp
    switch(msg.type)
     12c:	8b 45 0c             	mov    0xc(%ebp),%eax
     12f:	83 f8 02             	cmp    $0x2,%eax
     132:	74 1d                	je     151 <wndProc+0x3d>
     134:	83 f8 03             	cmp    $0x3,%eax
     137:	0f 84 8e 00 00 00    	je     1cb <wndProc+0xb7>
     13d:	83 f8 01             	cmp    $0x1,%eax
     140:	74 05                	je     147 <wndProc+0x33>
            APSendMessage(hwnd,msg);
            return False;
        case MSG_PAINT:
            APGridPaint(hwnd);
            break;
        default: break;
     142:	e9 93 00 00 00       	jmp    1da <wndProc+0xc6>
    printf(1,"desktop processing!\n");
    switch(msg.type)
    {
	case MSG_DRAWMAINWINDOW:

            return False;
     147:	b8 00 00 00 00       	mov    $0x0,%eax
     14c:	e9 9d 00 00 00       	jmp    1ee <wndProc+0xda>
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
     151:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     158:	eb 49                	jmp    1a3 <wndProc+0x8f>
            {
                int off = j * GRID_W_NUMBER;
     15a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     15d:	c1 e0 04             	shl    $0x4,%eax
     160:	89 45 ec             	mov    %eax,-0x14(%ebp)
                for (int i = 0; i< GRID_W_NUMBER; i++)
     163:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     16a:	eb 2d                	jmp    199 <wndProc+0x85>
                    hwnd->Grid[off + i] = desktop_layout[j][i];
     16c:	8b 45 08             	mov    0x8(%ebp),%eax
     16f:	8b 40 0c             	mov    0xc(%eax),%eax
     172:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     175:	8b 55 f0             	mov    -0x10(%ebp),%edx
     178:	01 ca                	add    %ecx,%edx
     17a:	c1 e2 02             	shl    $0x2,%edx
     17d:	01 c2                	add    %eax,%edx
     17f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     182:	c1 e0 04             	shl    $0x4,%eax
     185:	89 c1                	mov    %eax,%ecx
     187:	8b 45 f0             	mov    -0x10(%ebp),%eax
     18a:	01 c8                	add    %ecx,%eax
     18c:	8b 04 85 00 28 00 00 	mov    0x2800(,%eax,4),%eax
     193:	89 02                	mov    %eax,(%edx)
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
            {
                int off = j * GRID_W_NUMBER;
                for (int i = 0; i< GRID_W_NUMBER; i++)
     195:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     199:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
     19d:	7e cd                	jle    16c <wndProc+0x58>
	case MSG_DRAWMAINWINDOW:

            return False;
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
     19f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     1a3:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
     1a7:	7e b1                	jle    15a <wndProc+0x46>
            {
                int off = j * GRID_W_NUMBER;
                for (int i = 0; i< GRID_W_NUMBER; i++)
                    hwnd->Grid[off + i] = desktop_layout[j][i];
            }
            msg.type = MSG_PAINT;
     1a9:	c7 45 0c 03 00 00 00 	movl   $0x3,0xc(%ebp)
            APSendMessage(hwnd,msg);
     1b0:	ff 75 14             	pushl  0x14(%ebp)
     1b3:	ff 75 10             	pushl  0x10(%ebp)
     1b6:	ff 75 0c             	pushl  0xc(%ebp)
     1b9:	ff 75 08             	pushl  0x8(%ebp)
     1bc:	e8 36 14 00 00       	call   15f7 <APSendMessage>
     1c1:	83 c4 10             	add    $0x10,%esp
            return False;
     1c4:	b8 00 00 00 00       	mov    $0x0,%eax
     1c9:	eb 23                	jmp    1ee <wndProc+0xda>
        case MSG_PAINT:
            APGridPaint(hwnd);
     1cb:	83 ec 0c             	sub    $0xc,%esp
     1ce:	ff 75 08             	pushl  0x8(%ebp)
     1d1:	e8 8f 17 00 00       	call   1965 <APGridPaint>
     1d6:	83 c4 10             	add    $0x10,%esp
            break;
     1d9:	90                   	nop
        default: break;
            
            
            
    }
    return APWndProc(hwnd, msg);
     1da:	ff 75 14             	pushl  0x14(%ebp)
     1dd:	ff 75 10             	pushl  0x10(%ebp)
     1e0:	ff 75 0c             	pushl  0xc(%ebp)
     1e3:	ff 75 08             	pushl  0x8(%ebp)
     1e6:	e8 7a 16 00 00       	call   1865 <APWndProc>
     1eb:	83 c4 10             	add    $0x10,%esp
}
     1ee:	c9                   	leave  
     1ef:	c3                   	ret    

000001f0 <main>:

int main(void)
{
     1f0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     1f4:	83 e4 f0             	and    $0xfffffff0,%esp
     1f7:	ff 71 fc             	pushl  -0x4(%ecx)
     1fa:	55                   	push   %ebp
     1fb:	89 e5                	mov    %esp,%ebp
     1fd:	51                   	push   %ecx
     1fe:	83 ec 14             	sub    $0x14,%esp
    desktopInitStringFigure();
     201:	e8 fa fd ff ff       	call   0 <desktopInitStringFigure>
    AHwnd r = APCreateWindow("desktop",True,3);
     206:	83 ec 04             	sub    $0x4,%esp
     209:	6a 03                	push   $0x3
     20b:	6a 01                	push   $0x1
     20d:	68 f8 20 00 00       	push   $0x20f8
     212:	e8 fe 13 00 00       	call   1615 <APCreateWindow>
     217:	83 c4 10             	add    $0x10,%esp
     21a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    AHwnd hwnd = r;
     21d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     220:	89 45 f0             	mov    %eax,-0x10(%ebp)
    printf(1,"desktop initialized!\n");
     223:	83 ec 08             	sub    $0x8,%esp
     226:	68 00 21 00 00       	push   $0x2100
     22b:	6a 01                	push   $0x1
     22d:	e8 11 04 00 00       	call   643 <printf>
     232:	83 c4 10             	add    $0x10,%esp
    APWndExec(hwnd, wndProc);
     235:	83 ec 08             	sub    $0x8,%esp
     238:	68 14 01 00 00       	push   $0x114
     23d:	ff 75 f0             	pushl  -0x10(%ebp)
     240:	e8 8e 16 00 00       	call   18d3 <APWndExec>
     245:	83 c4 10             	add    $0x10,%esp
    exit();
     248:	e8 57 02 00 00       	call   4a4 <exit>

0000024d <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     24d:	55                   	push   %ebp
     24e:	89 e5                	mov    %esp,%ebp
     250:	57                   	push   %edi
     251:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     252:	8b 4d 08             	mov    0x8(%ebp),%ecx
     255:	8b 55 10             	mov    0x10(%ebp),%edx
     258:	8b 45 0c             	mov    0xc(%ebp),%eax
     25b:	89 cb                	mov    %ecx,%ebx
     25d:	89 df                	mov    %ebx,%edi
     25f:	89 d1                	mov    %edx,%ecx
     261:	fc                   	cld    
     262:	f3 aa                	rep stos %al,%es:(%edi)
     264:	89 ca                	mov    %ecx,%edx
     266:	89 fb                	mov    %edi,%ebx
     268:	89 5d 08             	mov    %ebx,0x8(%ebp)
     26b:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     26e:	90                   	nop
     26f:	5b                   	pop    %ebx
     270:	5f                   	pop    %edi
     271:	5d                   	pop    %ebp
     272:	c3                   	ret    

00000273 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     273:	55                   	push   %ebp
     274:	89 e5                	mov    %esp,%ebp
     276:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     279:	8b 45 08             	mov    0x8(%ebp),%eax
     27c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     27f:	90                   	nop
     280:	8b 45 08             	mov    0x8(%ebp),%eax
     283:	8d 50 01             	lea    0x1(%eax),%edx
     286:	89 55 08             	mov    %edx,0x8(%ebp)
     289:	8b 55 0c             	mov    0xc(%ebp),%edx
     28c:	8d 4a 01             	lea    0x1(%edx),%ecx
     28f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     292:	0f b6 12             	movzbl (%edx),%edx
     295:	88 10                	mov    %dl,(%eax)
     297:	0f b6 00             	movzbl (%eax),%eax
     29a:	84 c0                	test   %al,%al
     29c:	75 e2                	jne    280 <strcpy+0xd>
    ;
  return os;
     29e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     2a1:	c9                   	leave  
     2a2:	c3                   	ret    

000002a3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     2a3:	55                   	push   %ebp
     2a4:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     2a6:	eb 08                	jmp    2b0 <strcmp+0xd>
    p++, q++;
     2a8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2ac:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     2b0:	8b 45 08             	mov    0x8(%ebp),%eax
     2b3:	0f b6 00             	movzbl (%eax),%eax
     2b6:	84 c0                	test   %al,%al
     2b8:	74 10                	je     2ca <strcmp+0x27>
     2ba:	8b 45 08             	mov    0x8(%ebp),%eax
     2bd:	0f b6 10             	movzbl (%eax),%edx
     2c0:	8b 45 0c             	mov    0xc(%ebp),%eax
     2c3:	0f b6 00             	movzbl (%eax),%eax
     2c6:	38 c2                	cmp    %al,%dl
     2c8:	74 de                	je     2a8 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     2ca:	8b 45 08             	mov    0x8(%ebp),%eax
     2cd:	0f b6 00             	movzbl (%eax),%eax
     2d0:	0f b6 d0             	movzbl %al,%edx
     2d3:	8b 45 0c             	mov    0xc(%ebp),%eax
     2d6:	0f b6 00             	movzbl (%eax),%eax
     2d9:	0f b6 c0             	movzbl %al,%eax
     2dc:	29 c2                	sub    %eax,%edx
     2de:	89 d0                	mov    %edx,%eax
}
     2e0:	5d                   	pop    %ebp
     2e1:	c3                   	ret    

000002e2 <strlen>:

uint
strlen(char *s)
{
     2e2:	55                   	push   %ebp
     2e3:	89 e5                	mov    %esp,%ebp
     2e5:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     2e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     2ef:	eb 04                	jmp    2f5 <strlen+0x13>
     2f1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     2f5:	8b 55 fc             	mov    -0x4(%ebp),%edx
     2f8:	8b 45 08             	mov    0x8(%ebp),%eax
     2fb:	01 d0                	add    %edx,%eax
     2fd:	0f b6 00             	movzbl (%eax),%eax
     300:	84 c0                	test   %al,%al
     302:	75 ed                	jne    2f1 <strlen+0xf>
    ;
  return n;
     304:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     307:	c9                   	leave  
     308:	c3                   	ret    

00000309 <memset>:

void*
memset(void *dst, int c, uint n)
{
     309:	55                   	push   %ebp
     30a:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     30c:	8b 45 10             	mov    0x10(%ebp),%eax
     30f:	50                   	push   %eax
     310:	ff 75 0c             	pushl  0xc(%ebp)
     313:	ff 75 08             	pushl  0x8(%ebp)
     316:	e8 32 ff ff ff       	call   24d <stosb>
     31b:	83 c4 0c             	add    $0xc,%esp
  return dst;
     31e:	8b 45 08             	mov    0x8(%ebp),%eax
}
     321:	c9                   	leave  
     322:	c3                   	ret    

00000323 <strchr>:

char*
strchr(const char *s, char c)
{
     323:	55                   	push   %ebp
     324:	89 e5                	mov    %esp,%ebp
     326:	83 ec 04             	sub    $0x4,%esp
     329:	8b 45 0c             	mov    0xc(%ebp),%eax
     32c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     32f:	eb 14                	jmp    345 <strchr+0x22>
    if(*s == c)
     331:	8b 45 08             	mov    0x8(%ebp),%eax
     334:	0f b6 00             	movzbl (%eax),%eax
     337:	3a 45 fc             	cmp    -0x4(%ebp),%al
     33a:	75 05                	jne    341 <strchr+0x1e>
      return (char*)s;
     33c:	8b 45 08             	mov    0x8(%ebp),%eax
     33f:	eb 13                	jmp    354 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     341:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     345:	8b 45 08             	mov    0x8(%ebp),%eax
     348:	0f b6 00             	movzbl (%eax),%eax
     34b:	84 c0                	test   %al,%al
     34d:	75 e2                	jne    331 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     34f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     354:	c9                   	leave  
     355:	c3                   	ret    

00000356 <gets>:

char*
gets(char *buf, int max)
{
     356:	55                   	push   %ebp
     357:	89 e5                	mov    %esp,%ebp
     359:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     35c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     363:	eb 42                	jmp    3a7 <gets+0x51>
    cc = read(0, &c, 1);
     365:	83 ec 04             	sub    $0x4,%esp
     368:	6a 01                	push   $0x1
     36a:	8d 45 ef             	lea    -0x11(%ebp),%eax
     36d:	50                   	push   %eax
     36e:	6a 00                	push   $0x0
     370:	e8 47 01 00 00       	call   4bc <read>
     375:	83 c4 10             	add    $0x10,%esp
     378:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     37b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     37f:	7e 33                	jle    3b4 <gets+0x5e>
      break;
    buf[i++] = c;
     381:	8b 45 f4             	mov    -0xc(%ebp),%eax
     384:	8d 50 01             	lea    0x1(%eax),%edx
     387:	89 55 f4             	mov    %edx,-0xc(%ebp)
     38a:	89 c2                	mov    %eax,%edx
     38c:	8b 45 08             	mov    0x8(%ebp),%eax
     38f:	01 c2                	add    %eax,%edx
     391:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     395:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     397:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     39b:	3c 0a                	cmp    $0xa,%al
     39d:	74 16                	je     3b5 <gets+0x5f>
     39f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     3a3:	3c 0d                	cmp    $0xd,%al
     3a5:	74 0e                	je     3b5 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     3a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3aa:	83 c0 01             	add    $0x1,%eax
     3ad:	3b 45 0c             	cmp    0xc(%ebp),%eax
     3b0:	7c b3                	jl     365 <gets+0xf>
     3b2:	eb 01                	jmp    3b5 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     3b4:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     3b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     3b8:	8b 45 08             	mov    0x8(%ebp),%eax
     3bb:	01 d0                	add    %edx,%eax
     3bd:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     3c0:	8b 45 08             	mov    0x8(%ebp),%eax
}
     3c3:	c9                   	leave  
     3c4:	c3                   	ret    

000003c5 <stat>:

int
stat(char *n, struct stat *st)
{
     3c5:	55                   	push   %ebp
     3c6:	89 e5                	mov    %esp,%ebp
     3c8:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3cb:	83 ec 08             	sub    $0x8,%esp
     3ce:	6a 00                	push   $0x0
     3d0:	ff 75 08             	pushl  0x8(%ebp)
     3d3:	e8 0c 01 00 00       	call   4e4 <open>
     3d8:	83 c4 10             	add    $0x10,%esp
     3db:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     3de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3e2:	79 07                	jns    3eb <stat+0x26>
    return -1;
     3e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     3e9:	eb 25                	jmp    410 <stat+0x4b>
  r = fstat(fd, st);
     3eb:	83 ec 08             	sub    $0x8,%esp
     3ee:	ff 75 0c             	pushl  0xc(%ebp)
     3f1:	ff 75 f4             	pushl  -0xc(%ebp)
     3f4:	e8 03 01 00 00       	call   4fc <fstat>
     3f9:	83 c4 10             	add    $0x10,%esp
     3fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     3ff:	83 ec 0c             	sub    $0xc,%esp
     402:	ff 75 f4             	pushl  -0xc(%ebp)
     405:	e8 c2 00 00 00       	call   4cc <close>
     40a:	83 c4 10             	add    $0x10,%esp
  return r;
     40d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     410:	c9                   	leave  
     411:	c3                   	ret    

00000412 <atoi>:

int
atoi(const char *s)
{
     412:	55                   	push   %ebp
     413:	89 e5                	mov    %esp,%ebp
     415:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     418:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     41f:	eb 25                	jmp    446 <atoi+0x34>
    n = n*10 + *s++ - '0';
     421:	8b 55 fc             	mov    -0x4(%ebp),%edx
     424:	89 d0                	mov    %edx,%eax
     426:	c1 e0 02             	shl    $0x2,%eax
     429:	01 d0                	add    %edx,%eax
     42b:	01 c0                	add    %eax,%eax
     42d:	89 c1                	mov    %eax,%ecx
     42f:	8b 45 08             	mov    0x8(%ebp),%eax
     432:	8d 50 01             	lea    0x1(%eax),%edx
     435:	89 55 08             	mov    %edx,0x8(%ebp)
     438:	0f b6 00             	movzbl (%eax),%eax
     43b:	0f be c0             	movsbl %al,%eax
     43e:	01 c8                	add    %ecx,%eax
     440:	83 e8 30             	sub    $0x30,%eax
     443:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     446:	8b 45 08             	mov    0x8(%ebp),%eax
     449:	0f b6 00             	movzbl (%eax),%eax
     44c:	3c 2f                	cmp    $0x2f,%al
     44e:	7e 0a                	jle    45a <atoi+0x48>
     450:	8b 45 08             	mov    0x8(%ebp),%eax
     453:	0f b6 00             	movzbl (%eax),%eax
     456:	3c 39                	cmp    $0x39,%al
     458:	7e c7                	jle    421 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     45a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     45d:	c9                   	leave  
     45e:	c3                   	ret    

0000045f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     45f:	55                   	push   %ebp
     460:	89 e5                	mov    %esp,%ebp
     462:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     465:	8b 45 08             	mov    0x8(%ebp),%eax
     468:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     46b:	8b 45 0c             	mov    0xc(%ebp),%eax
     46e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     471:	eb 17                	jmp    48a <memmove+0x2b>
    *dst++ = *src++;
     473:	8b 45 fc             	mov    -0x4(%ebp),%eax
     476:	8d 50 01             	lea    0x1(%eax),%edx
     479:	89 55 fc             	mov    %edx,-0x4(%ebp)
     47c:	8b 55 f8             	mov    -0x8(%ebp),%edx
     47f:	8d 4a 01             	lea    0x1(%edx),%ecx
     482:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     485:	0f b6 12             	movzbl (%edx),%edx
     488:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     48a:	8b 45 10             	mov    0x10(%ebp),%eax
     48d:	8d 50 ff             	lea    -0x1(%eax),%edx
     490:	89 55 10             	mov    %edx,0x10(%ebp)
     493:	85 c0                	test   %eax,%eax
     495:	7f dc                	jg     473 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     497:	8b 45 08             	mov    0x8(%ebp),%eax
}
     49a:	c9                   	leave  
     49b:	c3                   	ret    

0000049c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     49c:	b8 01 00 00 00       	mov    $0x1,%eax
     4a1:	cd 40                	int    $0x40
     4a3:	c3                   	ret    

000004a4 <exit>:
SYSCALL(exit)
     4a4:	b8 02 00 00 00       	mov    $0x2,%eax
     4a9:	cd 40                	int    $0x40
     4ab:	c3                   	ret    

000004ac <wait>:
SYSCALL(wait)
     4ac:	b8 03 00 00 00       	mov    $0x3,%eax
     4b1:	cd 40                	int    $0x40
     4b3:	c3                   	ret    

000004b4 <pipe>:
SYSCALL(pipe)
     4b4:	b8 04 00 00 00       	mov    $0x4,%eax
     4b9:	cd 40                	int    $0x40
     4bb:	c3                   	ret    

000004bc <read>:
SYSCALL(read)
     4bc:	b8 05 00 00 00       	mov    $0x5,%eax
     4c1:	cd 40                	int    $0x40
     4c3:	c3                   	ret    

000004c4 <write>:
SYSCALL(write)
     4c4:	b8 10 00 00 00       	mov    $0x10,%eax
     4c9:	cd 40                	int    $0x40
     4cb:	c3                   	ret    

000004cc <close>:
SYSCALL(close)
     4cc:	b8 15 00 00 00       	mov    $0x15,%eax
     4d1:	cd 40                	int    $0x40
     4d3:	c3                   	ret    

000004d4 <kill>:
SYSCALL(kill)
     4d4:	b8 06 00 00 00       	mov    $0x6,%eax
     4d9:	cd 40                	int    $0x40
     4db:	c3                   	ret    

000004dc <exec>:
SYSCALL(exec)
     4dc:	b8 07 00 00 00       	mov    $0x7,%eax
     4e1:	cd 40                	int    $0x40
     4e3:	c3                   	ret    

000004e4 <open>:
SYSCALL(open)
     4e4:	b8 0f 00 00 00       	mov    $0xf,%eax
     4e9:	cd 40                	int    $0x40
     4eb:	c3                   	ret    

000004ec <mknod>:
SYSCALL(mknod)
     4ec:	b8 11 00 00 00       	mov    $0x11,%eax
     4f1:	cd 40                	int    $0x40
     4f3:	c3                   	ret    

000004f4 <unlink>:
SYSCALL(unlink)
     4f4:	b8 12 00 00 00       	mov    $0x12,%eax
     4f9:	cd 40                	int    $0x40
     4fb:	c3                   	ret    

000004fc <fstat>:
SYSCALL(fstat)
     4fc:	b8 08 00 00 00       	mov    $0x8,%eax
     501:	cd 40                	int    $0x40
     503:	c3                   	ret    

00000504 <link>:
SYSCALL(link)
     504:	b8 13 00 00 00       	mov    $0x13,%eax
     509:	cd 40                	int    $0x40
     50b:	c3                   	ret    

0000050c <mkdir>:
SYSCALL(mkdir)
     50c:	b8 14 00 00 00       	mov    $0x14,%eax
     511:	cd 40                	int    $0x40
     513:	c3                   	ret    

00000514 <chdir>:
SYSCALL(chdir)
     514:	b8 09 00 00 00       	mov    $0x9,%eax
     519:	cd 40                	int    $0x40
     51b:	c3                   	ret    

0000051c <dup>:
SYSCALL(dup)
     51c:	b8 0a 00 00 00       	mov    $0xa,%eax
     521:	cd 40                	int    $0x40
     523:	c3                   	ret    

00000524 <getpid>:
SYSCALL(getpid)
     524:	b8 0b 00 00 00       	mov    $0xb,%eax
     529:	cd 40                	int    $0x40
     52b:	c3                   	ret    

0000052c <sbrk>:
SYSCALL(sbrk)
     52c:	b8 0c 00 00 00       	mov    $0xc,%eax
     531:	cd 40                	int    $0x40
     533:	c3                   	ret    

00000534 <sleep>:
SYSCALL(sleep)
     534:	b8 0d 00 00 00       	mov    $0xd,%eax
     539:	cd 40                	int    $0x40
     53b:	c3                   	ret    

0000053c <uptime>:
SYSCALL(uptime)
     53c:	b8 0e 00 00 00       	mov    $0xe,%eax
     541:	cd 40                	int    $0x40
     543:	c3                   	ret    

00000544 <paintWindow>:

SYSCALL(paintWindow)
     544:	b8 16 00 00 00       	mov    $0x16,%eax
     549:	cd 40                	int    $0x40
     54b:	c3                   	ret    

0000054c <initStringFigure>:
SYSCALL(initStringFigure)
     54c:	b8 17 00 00 00       	mov    $0x17,%eax
     551:	cd 40                	int    $0x40
     553:	c3                   	ret    

00000554 <sendMessage>:
SYSCALL(sendMessage)
     554:	b8 18 00 00 00       	mov    $0x18,%eax
     559:	cd 40                	int    $0x40
     55b:	c3                   	ret    

0000055c <getMessage>:
SYSCALL(getMessage)
     55c:	b8 1a 00 00 00       	mov    $0x1a,%eax
     561:	cd 40                	int    $0x40
     563:	c3                   	ret    

00000564 <registWindow>:
SYSCALL(registWindow)
     564:	b8 19 00 00 00       	mov    $0x19,%eax
     569:	cd 40                	int    $0x40
     56b:	c3                   	ret    

0000056c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     56c:	55                   	push   %ebp
     56d:	89 e5                	mov    %esp,%ebp
     56f:	83 ec 18             	sub    $0x18,%esp
     572:	8b 45 0c             	mov    0xc(%ebp),%eax
     575:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     578:	83 ec 04             	sub    $0x4,%esp
     57b:	6a 01                	push   $0x1
     57d:	8d 45 f4             	lea    -0xc(%ebp),%eax
     580:	50                   	push   %eax
     581:	ff 75 08             	pushl  0x8(%ebp)
     584:	e8 3b ff ff ff       	call   4c4 <write>
     589:	83 c4 10             	add    $0x10,%esp
}
     58c:	90                   	nop
     58d:	c9                   	leave  
     58e:	c3                   	ret    

0000058f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     58f:	55                   	push   %ebp
     590:	89 e5                	mov    %esp,%ebp
     592:	53                   	push   %ebx
     593:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     596:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     59d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     5a1:	74 17                	je     5ba <printint+0x2b>
     5a3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     5a7:	79 11                	jns    5ba <printint+0x2b>
    neg = 1;
     5a9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     5b0:	8b 45 0c             	mov    0xc(%ebp),%eax
     5b3:	f7 d8                	neg    %eax
     5b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
     5b8:	eb 06                	jmp    5c0 <printint+0x31>
  } else {
    x = xx;
     5ba:	8b 45 0c             	mov    0xc(%ebp),%eax
     5bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     5c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     5c7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     5ca:	8d 41 01             	lea    0x1(%ecx),%eax
     5cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
     5d0:	8b 5d 10             	mov    0x10(%ebp),%ebx
     5d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     5d6:	ba 00 00 00 00       	mov    $0x0,%edx
     5db:	f7 f3                	div    %ebx
     5dd:	89 d0                	mov    %edx,%eax
     5df:	0f b6 80 c0 2a 00 00 	movzbl 0x2ac0(%eax),%eax
     5e6:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     5ea:	8b 5d 10             	mov    0x10(%ebp),%ebx
     5ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
     5f0:	ba 00 00 00 00       	mov    $0x0,%edx
     5f5:	f7 f3                	div    %ebx
     5f7:	89 45 ec             	mov    %eax,-0x14(%ebp)
     5fa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     5fe:	75 c7                	jne    5c7 <printint+0x38>
  if(neg)
     600:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     604:	74 2d                	je     633 <printint+0xa4>
    buf[i++] = '-';
     606:	8b 45 f4             	mov    -0xc(%ebp),%eax
     609:	8d 50 01             	lea    0x1(%eax),%edx
     60c:	89 55 f4             	mov    %edx,-0xc(%ebp)
     60f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     614:	eb 1d                	jmp    633 <printint+0xa4>
    putc(fd, buf[i]);
     616:	8d 55 dc             	lea    -0x24(%ebp),%edx
     619:	8b 45 f4             	mov    -0xc(%ebp),%eax
     61c:	01 d0                	add    %edx,%eax
     61e:	0f b6 00             	movzbl (%eax),%eax
     621:	0f be c0             	movsbl %al,%eax
     624:	83 ec 08             	sub    $0x8,%esp
     627:	50                   	push   %eax
     628:	ff 75 08             	pushl  0x8(%ebp)
     62b:	e8 3c ff ff ff       	call   56c <putc>
     630:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     633:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     637:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     63b:	79 d9                	jns    616 <printint+0x87>
    putc(fd, buf[i]);
}
     63d:	90                   	nop
     63e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     641:	c9                   	leave  
     642:	c3                   	ret    

00000643 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     643:	55                   	push   %ebp
     644:	89 e5                	mov    %esp,%ebp
     646:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     649:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     650:	8d 45 0c             	lea    0xc(%ebp),%eax
     653:	83 c0 04             	add    $0x4,%eax
     656:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     659:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     660:	e9 59 01 00 00       	jmp    7be <printf+0x17b>
    c = fmt[i] & 0xff;
     665:	8b 55 0c             	mov    0xc(%ebp),%edx
     668:	8b 45 f0             	mov    -0x10(%ebp),%eax
     66b:	01 d0                	add    %edx,%eax
     66d:	0f b6 00             	movzbl (%eax),%eax
     670:	0f be c0             	movsbl %al,%eax
     673:	25 ff 00 00 00       	and    $0xff,%eax
     678:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     67b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     67f:	75 2c                	jne    6ad <printf+0x6a>
      if(c == '%'){
     681:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     685:	75 0c                	jne    693 <printf+0x50>
        state = '%';
     687:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     68e:	e9 27 01 00 00       	jmp    7ba <printf+0x177>
      } else {
        putc(fd, c);
     693:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     696:	0f be c0             	movsbl %al,%eax
     699:	83 ec 08             	sub    $0x8,%esp
     69c:	50                   	push   %eax
     69d:	ff 75 08             	pushl  0x8(%ebp)
     6a0:	e8 c7 fe ff ff       	call   56c <putc>
     6a5:	83 c4 10             	add    $0x10,%esp
     6a8:	e9 0d 01 00 00       	jmp    7ba <printf+0x177>
      }
    } else if(state == '%'){
     6ad:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     6b1:	0f 85 03 01 00 00    	jne    7ba <printf+0x177>
      if(c == 'd'){
     6b7:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     6bb:	75 1e                	jne    6db <printf+0x98>
        printint(fd, *ap, 10, 1);
     6bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6c0:	8b 00                	mov    (%eax),%eax
     6c2:	6a 01                	push   $0x1
     6c4:	6a 0a                	push   $0xa
     6c6:	50                   	push   %eax
     6c7:	ff 75 08             	pushl  0x8(%ebp)
     6ca:	e8 c0 fe ff ff       	call   58f <printint>
     6cf:	83 c4 10             	add    $0x10,%esp
        ap++;
     6d2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     6d6:	e9 d8 00 00 00       	jmp    7b3 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     6db:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     6df:	74 06                	je     6e7 <printf+0xa4>
     6e1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     6e5:	75 1e                	jne    705 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     6e7:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6ea:	8b 00                	mov    (%eax),%eax
     6ec:	6a 00                	push   $0x0
     6ee:	6a 10                	push   $0x10
     6f0:	50                   	push   %eax
     6f1:	ff 75 08             	pushl  0x8(%ebp)
     6f4:	e8 96 fe ff ff       	call   58f <printint>
     6f9:	83 c4 10             	add    $0x10,%esp
        ap++;
     6fc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     700:	e9 ae 00 00 00       	jmp    7b3 <printf+0x170>
      } else if(c == 's'){
     705:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     709:	75 43                	jne    74e <printf+0x10b>
        s = (char*)*ap;
     70b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     70e:	8b 00                	mov    (%eax),%eax
     710:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     713:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     717:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     71b:	75 25                	jne    742 <printf+0xff>
          s = "(null)";
     71d:	c7 45 f4 16 21 00 00 	movl   $0x2116,-0xc(%ebp)
        while(*s != 0){
     724:	eb 1c                	jmp    742 <printf+0xff>
          putc(fd, *s);
     726:	8b 45 f4             	mov    -0xc(%ebp),%eax
     729:	0f b6 00             	movzbl (%eax),%eax
     72c:	0f be c0             	movsbl %al,%eax
     72f:	83 ec 08             	sub    $0x8,%esp
     732:	50                   	push   %eax
     733:	ff 75 08             	pushl  0x8(%ebp)
     736:	e8 31 fe ff ff       	call   56c <putc>
     73b:	83 c4 10             	add    $0x10,%esp
          s++;
     73e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     742:	8b 45 f4             	mov    -0xc(%ebp),%eax
     745:	0f b6 00             	movzbl (%eax),%eax
     748:	84 c0                	test   %al,%al
     74a:	75 da                	jne    726 <printf+0xe3>
     74c:	eb 65                	jmp    7b3 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     74e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     752:	75 1d                	jne    771 <printf+0x12e>
        putc(fd, *ap);
     754:	8b 45 e8             	mov    -0x18(%ebp),%eax
     757:	8b 00                	mov    (%eax),%eax
     759:	0f be c0             	movsbl %al,%eax
     75c:	83 ec 08             	sub    $0x8,%esp
     75f:	50                   	push   %eax
     760:	ff 75 08             	pushl  0x8(%ebp)
     763:	e8 04 fe ff ff       	call   56c <putc>
     768:	83 c4 10             	add    $0x10,%esp
        ap++;
     76b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     76f:	eb 42                	jmp    7b3 <printf+0x170>
      } else if(c == '%'){
     771:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     775:	75 17                	jne    78e <printf+0x14b>
        putc(fd, c);
     777:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     77a:	0f be c0             	movsbl %al,%eax
     77d:	83 ec 08             	sub    $0x8,%esp
     780:	50                   	push   %eax
     781:	ff 75 08             	pushl  0x8(%ebp)
     784:	e8 e3 fd ff ff       	call   56c <putc>
     789:	83 c4 10             	add    $0x10,%esp
     78c:	eb 25                	jmp    7b3 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     78e:	83 ec 08             	sub    $0x8,%esp
     791:	6a 25                	push   $0x25
     793:	ff 75 08             	pushl  0x8(%ebp)
     796:	e8 d1 fd ff ff       	call   56c <putc>
     79b:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     79e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7a1:	0f be c0             	movsbl %al,%eax
     7a4:	83 ec 08             	sub    $0x8,%esp
     7a7:	50                   	push   %eax
     7a8:	ff 75 08             	pushl  0x8(%ebp)
     7ab:	e8 bc fd ff ff       	call   56c <putc>
     7b0:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     7b3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     7ba:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     7be:	8b 55 0c             	mov    0xc(%ebp),%edx
     7c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7c4:	01 d0                	add    %edx,%eax
     7c6:	0f b6 00             	movzbl (%eax),%eax
     7c9:	84 c0                	test   %al,%al
     7cb:	0f 85 94 fe ff ff    	jne    665 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     7d1:	90                   	nop
     7d2:	c9                   	leave  
     7d3:	c3                   	ret    

000007d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     7d4:	55                   	push   %ebp
     7d5:	89 e5                	mov    %esp,%ebp
     7d7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     7da:	8b 45 08             	mov    0x8(%ebp),%eax
     7dd:	83 e8 08             	sub    $0x8,%eax
     7e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     7e3:	a1 f0 2a 00 00       	mov    0x2af0,%eax
     7e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
     7eb:	eb 24                	jmp    811 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     7ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7f0:	8b 00                	mov    (%eax),%eax
     7f2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     7f5:	77 12                	ja     809 <free+0x35>
     7f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     7fd:	77 24                	ja     823 <free+0x4f>
     7ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
     802:	8b 00                	mov    (%eax),%eax
     804:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     807:	77 1a                	ja     823 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     809:	8b 45 fc             	mov    -0x4(%ebp),%eax
     80c:	8b 00                	mov    (%eax),%eax
     80e:	89 45 fc             	mov    %eax,-0x4(%ebp)
     811:	8b 45 f8             	mov    -0x8(%ebp),%eax
     814:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     817:	76 d4                	jbe    7ed <free+0x19>
     819:	8b 45 fc             	mov    -0x4(%ebp),%eax
     81c:	8b 00                	mov    (%eax),%eax
     81e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     821:	76 ca                	jbe    7ed <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     823:	8b 45 f8             	mov    -0x8(%ebp),%eax
     826:	8b 40 04             	mov    0x4(%eax),%eax
     829:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     830:	8b 45 f8             	mov    -0x8(%ebp),%eax
     833:	01 c2                	add    %eax,%edx
     835:	8b 45 fc             	mov    -0x4(%ebp),%eax
     838:	8b 00                	mov    (%eax),%eax
     83a:	39 c2                	cmp    %eax,%edx
     83c:	75 24                	jne    862 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     83e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     841:	8b 50 04             	mov    0x4(%eax),%edx
     844:	8b 45 fc             	mov    -0x4(%ebp),%eax
     847:	8b 00                	mov    (%eax),%eax
     849:	8b 40 04             	mov    0x4(%eax),%eax
     84c:	01 c2                	add    %eax,%edx
     84e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     851:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     854:	8b 45 fc             	mov    -0x4(%ebp),%eax
     857:	8b 00                	mov    (%eax),%eax
     859:	8b 10                	mov    (%eax),%edx
     85b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     85e:	89 10                	mov    %edx,(%eax)
     860:	eb 0a                	jmp    86c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     862:	8b 45 fc             	mov    -0x4(%ebp),%eax
     865:	8b 10                	mov    (%eax),%edx
     867:	8b 45 f8             	mov    -0x8(%ebp),%eax
     86a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     86c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     86f:	8b 40 04             	mov    0x4(%eax),%eax
     872:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     879:	8b 45 fc             	mov    -0x4(%ebp),%eax
     87c:	01 d0                	add    %edx,%eax
     87e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     881:	75 20                	jne    8a3 <free+0xcf>
    p->s.size += bp->s.size;
     883:	8b 45 fc             	mov    -0x4(%ebp),%eax
     886:	8b 50 04             	mov    0x4(%eax),%edx
     889:	8b 45 f8             	mov    -0x8(%ebp),%eax
     88c:	8b 40 04             	mov    0x4(%eax),%eax
     88f:	01 c2                	add    %eax,%edx
     891:	8b 45 fc             	mov    -0x4(%ebp),%eax
     894:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     897:	8b 45 f8             	mov    -0x8(%ebp),%eax
     89a:	8b 10                	mov    (%eax),%edx
     89c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     89f:	89 10                	mov    %edx,(%eax)
     8a1:	eb 08                	jmp    8ab <free+0xd7>
  } else
    p->s.ptr = bp;
     8a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8a6:	8b 55 f8             	mov    -0x8(%ebp),%edx
     8a9:	89 10                	mov    %edx,(%eax)
  freep = p;
     8ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8ae:	a3 f0 2a 00 00       	mov    %eax,0x2af0
}
     8b3:	90                   	nop
     8b4:	c9                   	leave  
     8b5:	c3                   	ret    

000008b6 <morecore>:

static Header*
morecore(uint nu)
{
     8b6:	55                   	push   %ebp
     8b7:	89 e5                	mov    %esp,%ebp
     8b9:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     8bc:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     8c3:	77 07                	ja     8cc <morecore+0x16>
    nu = 4096;
     8c5:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     8cc:	8b 45 08             	mov    0x8(%ebp),%eax
     8cf:	c1 e0 03             	shl    $0x3,%eax
     8d2:	83 ec 0c             	sub    $0xc,%esp
     8d5:	50                   	push   %eax
     8d6:	e8 51 fc ff ff       	call   52c <sbrk>
     8db:	83 c4 10             	add    $0x10,%esp
     8de:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     8e1:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     8e5:	75 07                	jne    8ee <morecore+0x38>
    return 0;
     8e7:	b8 00 00 00 00       	mov    $0x0,%eax
     8ec:	eb 26                	jmp    914 <morecore+0x5e>
  hp = (Header*)p;
     8ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     8f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8f7:	8b 55 08             	mov    0x8(%ebp),%edx
     8fa:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     8fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     900:	83 c0 08             	add    $0x8,%eax
     903:	83 ec 0c             	sub    $0xc,%esp
     906:	50                   	push   %eax
     907:	e8 c8 fe ff ff       	call   7d4 <free>
     90c:	83 c4 10             	add    $0x10,%esp
  return freep;
     90f:	a1 f0 2a 00 00       	mov    0x2af0,%eax
}
     914:	c9                   	leave  
     915:	c3                   	ret    

00000916 <malloc>:

void*
malloc(uint nbytes)
{
     916:	55                   	push   %ebp
     917:	89 e5                	mov    %esp,%ebp
     919:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     91c:	8b 45 08             	mov    0x8(%ebp),%eax
     91f:	83 c0 07             	add    $0x7,%eax
     922:	c1 e8 03             	shr    $0x3,%eax
     925:	83 c0 01             	add    $0x1,%eax
     928:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     92b:	a1 f0 2a 00 00       	mov    0x2af0,%eax
     930:	89 45 f0             	mov    %eax,-0x10(%ebp)
     933:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     937:	75 23                	jne    95c <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     939:	c7 45 f0 e8 2a 00 00 	movl   $0x2ae8,-0x10(%ebp)
     940:	8b 45 f0             	mov    -0x10(%ebp),%eax
     943:	a3 f0 2a 00 00       	mov    %eax,0x2af0
     948:	a1 f0 2a 00 00       	mov    0x2af0,%eax
     94d:	a3 e8 2a 00 00       	mov    %eax,0x2ae8
    base.s.size = 0;
     952:	c7 05 ec 2a 00 00 00 	movl   $0x0,0x2aec
     959:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     95c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     95f:	8b 00                	mov    (%eax),%eax
     961:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     964:	8b 45 f4             	mov    -0xc(%ebp),%eax
     967:	8b 40 04             	mov    0x4(%eax),%eax
     96a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     96d:	72 4d                	jb     9bc <malloc+0xa6>
      if(p->s.size == nunits)
     96f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     972:	8b 40 04             	mov    0x4(%eax),%eax
     975:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     978:	75 0c                	jne    986 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     97a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     97d:	8b 10                	mov    (%eax),%edx
     97f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     982:	89 10                	mov    %edx,(%eax)
     984:	eb 26                	jmp    9ac <malloc+0x96>
      else {
        p->s.size -= nunits;
     986:	8b 45 f4             	mov    -0xc(%ebp),%eax
     989:	8b 40 04             	mov    0x4(%eax),%eax
     98c:	2b 45 ec             	sub    -0x14(%ebp),%eax
     98f:	89 c2                	mov    %eax,%edx
     991:	8b 45 f4             	mov    -0xc(%ebp),%eax
     994:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     997:	8b 45 f4             	mov    -0xc(%ebp),%eax
     99a:	8b 40 04             	mov    0x4(%eax),%eax
     99d:	c1 e0 03             	shl    $0x3,%eax
     9a0:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     9a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9a6:	8b 55 ec             	mov    -0x14(%ebp),%edx
     9a9:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     9ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9af:	a3 f0 2a 00 00       	mov    %eax,0x2af0
      return (void*)(p + 1);
     9b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9b7:	83 c0 08             	add    $0x8,%eax
     9ba:	eb 3b                	jmp    9f7 <malloc+0xe1>
    }
    if(p == freep)
     9bc:	a1 f0 2a 00 00       	mov    0x2af0,%eax
     9c1:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     9c4:	75 1e                	jne    9e4 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     9c6:	83 ec 0c             	sub    $0xc,%esp
     9c9:	ff 75 ec             	pushl  -0x14(%ebp)
     9cc:	e8 e5 fe ff ff       	call   8b6 <morecore>
     9d1:	83 c4 10             	add    $0x10,%esp
     9d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
     9d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     9db:	75 07                	jne    9e4 <malloc+0xce>
        return 0;
     9dd:	b8 00 00 00 00       	mov    $0x0,%eax
     9e2:	eb 13                	jmp    9f7 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     9e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
     9ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9ed:	8b 00                	mov    (%eax),%eax
     9ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     9f2:	e9 6d ff ff ff       	jmp    964 <malloc+0x4e>
}
     9f7:	c9                   	leave  
     9f8:	c3                   	ret    

000009f9 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     9f9:	55                   	push   %ebp
     9fa:	89 e5                	mov    %esp,%ebp
     9fc:	83 ec 1c             	sub    $0x1c,%esp
     9ff:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     a02:	8b 55 10             	mov    0x10(%ebp),%edx
     a05:	8b 45 14             	mov    0x14(%ebp),%eax
     a08:	88 4d ec             	mov    %cl,-0x14(%ebp)
     a0b:	88 55 e8             	mov    %dl,-0x18(%ebp)
     a0e:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     a11:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     a15:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     a18:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     a1c:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     a1f:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     a23:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     a26:	8b 45 08             	mov    0x8(%ebp),%eax
     a29:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     a2d:	66 89 10             	mov    %dx,(%eax)
     a30:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     a34:	88 50 02             	mov    %dl,0x2(%eax)
}
     a37:	8b 45 08             	mov    0x8(%ebp),%eax
     a3a:	c9                   	leave  
     a3b:	c2 04 00             	ret    $0x4

00000a3e <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     a3e:	55                   	push   %ebp
     a3f:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     a41:	8b 45 08             	mov    0x8(%ebp),%eax
     a44:	2b 45 10             	sub    0x10(%ebp),%eax
     a47:	89 c2                	mov    %eax,%edx
     a49:	8b 45 08             	mov    0x8(%ebp),%eax
     a4c:	2b 45 10             	sub    0x10(%ebp),%eax
     a4f:	0f af d0             	imul   %eax,%edx
     a52:	8b 45 0c             	mov    0xc(%ebp),%eax
     a55:	2b 45 14             	sub    0x14(%ebp),%eax
     a58:	89 c1                	mov    %eax,%ecx
     a5a:	8b 45 0c             	mov    0xc(%ebp),%eax
     a5d:	2b 45 14             	sub    0x14(%ebp),%eax
     a60:	0f af c1             	imul   %ecx,%eax
     a63:	01 d0                	add    %edx,%eax
}
     a65:	5d                   	pop    %ebp
     a66:	c3                   	ret    

00000a67 <abs_int>:

static inline int abs_int(int x)
{
     a67:	55                   	push   %ebp
     a68:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     a6a:	8b 45 08             	mov    0x8(%ebp),%eax
     a6d:	99                   	cltd   
     a6e:	89 d0                	mov    %edx,%eax
     a70:	33 45 08             	xor    0x8(%ebp),%eax
     a73:	29 d0                	sub    %edx,%eax
}
     a75:	5d                   	pop    %ebp
     a76:	c3                   	ret    

00000a77 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     a77:	55                   	push   %ebp
     a78:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     a7a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     a7e:	79 07                	jns    a87 <APGetIndex+0x10>
        return X_SMALLER;
     a80:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     a85:	eb 40                	jmp    ac7 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     a87:	8b 45 08             	mov    0x8(%ebp),%eax
     a8a:	8b 00                	mov    (%eax),%eax
     a8c:	3b 45 0c             	cmp    0xc(%ebp),%eax
     a8f:	7f 07                	jg     a98 <APGetIndex+0x21>
        return X_BIGGER;
     a91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a96:	eb 2f                	jmp    ac7 <APGetIndex+0x50>
    if (y < 0)
     a98:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     a9c:	79 07                	jns    aa5 <APGetIndex+0x2e>
        return Y_SMALLER;
     a9e:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     aa3:	eb 22                	jmp    ac7 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     aa5:	8b 45 08             	mov    0x8(%ebp),%eax
     aa8:	8b 40 04             	mov    0x4(%eax),%eax
     aab:	3b 45 10             	cmp    0x10(%ebp),%eax
     aae:	7f 07                	jg     ab7 <APGetIndex+0x40>
        return Y_BIGGER;
     ab0:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     ab5:	eb 10                	jmp    ac7 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     ab7:	8b 45 08             	mov    0x8(%ebp),%eax
     aba:	8b 00                	mov    (%eax),%eax
     abc:	0f af 45 10          	imul   0x10(%ebp),%eax
     ac0:	89 c2                	mov    %eax,%edx
     ac2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ac5:	01 d0                	add    %edx,%eax
}
     ac7:	5d                   	pop    %ebp
     ac8:	c3                   	ret    

00000ac9 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     ac9:	55                   	push   %ebp
     aca:	89 e5                	mov    %esp,%ebp
     acc:	56                   	push   %esi
     acd:	53                   	push   %ebx
     ace:	83 ec 70             	sub    $0x70,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     ad1:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     ad8:	8b 45 cc             	mov    -0x34(%ebp),%eax
     adb:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     ade:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     ae5:	83 ec 08             	sub    $0x8,%esp
     ae8:	6a 00                	push   $0x0
     aea:	ff 75 0c             	pushl  0xc(%ebp)
     aed:	e8 f2 f9 ff ff       	call   4e4 <open>
     af2:	83 c4 10             	add    $0x10,%esp
     af5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     af8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     afc:	79 2e                	jns    b2c <APLoadBitmap+0x63>
    {
        printf(1, "Cannot open %s\n", filename);
     afe:	83 ec 04             	sub    $0x4,%esp
     b01:	ff 75 0c             	pushl  0xc(%ebp)
     b04:	68 20 21 00 00       	push   $0x2120
     b09:	6a 01                	push   $0x1
     b0b:	e8 33 fb ff ff       	call   643 <printf>
     b10:	83 c4 10             	add    $0x10,%esp
        return bmp;
     b13:	8b 45 08             	mov    0x8(%ebp),%eax
     b16:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b19:	89 10                	mov    %edx,(%eax)
     b1b:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b1e:	89 50 04             	mov    %edx,0x4(%eax)
     b21:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b24:	89 50 08             	mov    %edx,0x8(%eax)
     b27:	e9 1b 02 00 00       	jmp    d47 <APLoadBitmap+0x27e>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     b2c:	83 ec 04             	sub    $0x4,%esp
     b2f:	6a 10                	push   $0x10
     b31:	8d 45 b8             	lea    -0x48(%ebp),%eax
     b34:	50                   	push   %eax
     b35:	ff 75 ec             	pushl  -0x14(%ebp)
     b38:	e8 7f f9 ff ff       	call   4bc <read>
     b3d:	83 c4 10             	add    $0x10,%esp
    printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
     b40:	0f b7 45 c2          	movzwl -0x3e(%ebp),%eax
     b44:	0f b7 f0             	movzwl %ax,%esi
     b47:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
     b4b:	0f b7 d8             	movzwl %ax,%ebx
     b4e:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
     b51:	8b 55 bc             	mov    -0x44(%ebp),%edx
     b54:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
     b58:	0f b7 c0             	movzwl %ax,%eax
     b5b:	83 ec 04             	sub    $0x4,%esp
     b5e:	56                   	push   %esi
     b5f:	53                   	push   %ebx
     b60:	51                   	push   %ecx
     b61:	52                   	push   %edx
     b62:	50                   	push   %eax
     b63:	68 30 21 00 00       	push   $0x2130
     b68:	6a 01                	push   $0x1
     b6a:	e8 d4 fa ff ff       	call   643 <printf>
     b6f:	83 c4 20             	add    $0x20,%esp
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     b72:	83 ec 04             	sub    $0x4,%esp
     b75:	6a 28                	push   $0x28
     b77:	8d 45 90             	lea    -0x70(%ebp),%eax
     b7a:	50                   	push   %eax
     b7b:	ff 75 ec             	pushl  -0x14(%ebp)
     b7e:	e8 39 f9 ff ff       	call   4bc <read>
     b83:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     b86:	8b 45 94             	mov    -0x6c(%ebp),%eax
     b89:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     b8c:	8b 45 98             	mov    -0x68(%ebp),%eax
     b8f:	89 45 cc             	mov    %eax,-0x34(%ebp)
    printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
     b92:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b95:	8b 45 cc             	mov    -0x34(%ebp),%eax
     b98:	52                   	push   %edx
     b99:	50                   	push   %eax
     b9a:	68 40 21 00 00       	push   $0x2140
     b9f:	6a 01                	push   $0x1
     ba1:	e8 9d fa ff ff       	call   643 <printf>
     ba6:	83 c4 10             	add    $0x10,%esp
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     ba9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bac:	8b 45 cc             	mov    -0x34(%ebp),%eax
     baf:	0f af d0             	imul   %eax,%edx
     bb2:	89 d0                	mov    %edx,%eax
     bb4:	01 c0                	add    %eax,%eax
     bb6:	01 d0                	add    %edx,%eax
     bb8:	83 ec 0c             	sub    $0xc,%esp
     bbb:	50                   	push   %eax
     bbc:	e8 55 fd ff ff       	call   916 <malloc>
     bc1:	83 c4 10             	add    $0x10,%esp
     bc4:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     bc7:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     bcb:	0f b7 c0             	movzwl %ax,%eax
     bce:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     bd1:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bd4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     bd7:	0f af c2             	imul   %edx,%eax
     bda:	83 c0 1f             	add    $0x1f,%eax
     bdd:	c1 e8 05             	shr    $0x5,%eax
     be0:	c1 e0 02             	shl    $0x2,%eax
     be3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     be6:	8b 55 cc             	mov    -0x34(%ebp),%edx
     be9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     bec:	0f af c2             	imul   %edx,%eax
     bef:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     bf2:	8b 45 e0             	mov    -0x20(%ebp),%eax
     bf5:	83 ec 0c             	sub    $0xc,%esp
     bf8:	50                   	push   %eax
     bf9:	e8 18 fd ff ff       	call   916 <malloc>
     bfe:	83 c4 10             	add    $0x10,%esp
     c01:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     c04:	83 ec 04             	sub    $0x4,%esp
     c07:	ff 75 e0             	pushl  -0x20(%ebp)
     c0a:	ff 75 dc             	pushl  -0x24(%ebp)
     c0d:	ff 75 ec             	pushl  -0x14(%ebp)
     c10:	e8 a7 f8 ff ff       	call   4bc <read>
     c15:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     c18:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     c1c:	66 c1 e8 03          	shr    $0x3,%ax
     c20:	0f b7 c0             	movzwl %ax,%eax
     c23:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     c26:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c2d:	e9 e5 00 00 00       	jmp    d17 <APLoadBitmap+0x24e>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     c32:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c35:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c38:	29 c2                	sub    %eax,%edx
     c3a:	89 d0                	mov    %edx,%eax
     c3c:	8d 50 ff             	lea    -0x1(%eax),%edx
     c3f:	8b 45 c8             	mov    -0x38(%ebp),%eax
     c42:	0f af c2             	imul   %edx,%eax
     c45:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     c48:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     c4f:	e9 b1 00 00 00       	jmp    d05 <APLoadBitmap+0x23c>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     c54:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c57:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     c5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c5d:	01 c8                	add    %ecx,%eax
     c5f:	89 c1                	mov    %eax,%ecx
     c61:	89 c8                	mov    %ecx,%eax
     c63:	01 c0                	add    %eax,%eax
     c65:	01 c8                	add    %ecx,%eax
     c67:	01 c2                	add    %eax,%edx
     c69:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c6c:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     c70:	89 c1                	mov    %eax,%ecx
     c72:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c75:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     c79:	01 c1                	add    %eax,%ecx
     c7b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c7e:	01 c8                	add    %ecx,%eax
     c80:	8d 48 ff             	lea    -0x1(%eax),%ecx
     c83:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c86:	01 c8                	add    %ecx,%eax
     c88:	0f b6 00             	movzbl (%eax),%eax
     c8b:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     c8e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c91:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     c94:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c97:	01 c8                	add    %ecx,%eax
     c99:	89 c1                	mov    %eax,%ecx
     c9b:	89 c8                	mov    %ecx,%eax
     c9d:	01 c0                	add    %eax,%eax
     c9f:	01 c8                	add    %ecx,%eax
     ca1:	01 c2                	add    %eax,%edx
     ca3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca6:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     caa:	89 c1                	mov    %eax,%ecx
     cac:	8b 45 d8             	mov    -0x28(%ebp),%eax
     caf:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     cb3:	01 c1                	add    %eax,%ecx
     cb5:	8b 45 d8             	mov    -0x28(%ebp),%eax
     cb8:	01 c8                	add    %ecx,%eax
     cba:	8d 48 fe             	lea    -0x2(%eax),%ecx
     cbd:	8b 45 dc             	mov    -0x24(%ebp),%eax
     cc0:	01 c8                	add    %ecx,%eax
     cc2:	0f b6 00             	movzbl (%eax),%eax
     cc5:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     cc8:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ccb:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     cce:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cd1:	01 c8                	add    %ecx,%eax
     cd3:	89 c1                	mov    %eax,%ecx
     cd5:	89 c8                	mov    %ecx,%eax
     cd7:	01 c0                	add    %eax,%eax
     cd9:	01 c8                	add    %ecx,%eax
     cdb:	01 c2                	add    %eax,%edx
     cdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ce0:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ce4:	89 c1                	mov    %eax,%ecx
     ce6:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ce9:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ced:	01 c1                	add    %eax,%ecx
     cef:	8b 45 d8             	mov    -0x28(%ebp),%eax
     cf2:	01 c8                	add    %ecx,%eax
     cf4:	8d 48 fd             	lea    -0x3(%eax),%ecx
     cf7:	8b 45 dc             	mov    -0x24(%ebp),%eax
     cfa:	01 c8                	add    %ecx,%eax
     cfc:	0f b6 00             	movzbl (%eax),%eax
     cff:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     d01:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     d05:	8b 55 c8             	mov    -0x38(%ebp),%edx
     d08:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d0b:	39 c2                	cmp    %eax,%edx
     d0d:	0f 87 41 ff ff ff    	ja     c54 <APLoadBitmap+0x18b>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     d13:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d17:	8b 55 cc             	mov    -0x34(%ebp),%edx
     d1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d1d:	39 c2                	cmp    %eax,%edx
     d1f:	0f 87 0d ff ff ff    	ja     c32 <APLoadBitmap+0x169>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     d25:	83 ec 0c             	sub    $0xc,%esp
     d28:	ff 75 ec             	pushl  -0x14(%ebp)
     d2b:	e8 9c f7 ff ff       	call   4cc <close>
     d30:	83 c4 10             	add    $0x10,%esp
    return bmp;
     d33:	8b 45 08             	mov    0x8(%ebp),%eax
     d36:	8b 55 c8             	mov    -0x38(%ebp),%edx
     d39:	89 10                	mov    %edx,(%eax)
     d3b:	8b 55 cc             	mov    -0x34(%ebp),%edx
     d3e:	89 50 04             	mov    %edx,0x4(%eax)
     d41:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d44:	89 50 08             	mov    %edx,0x8(%eax)
}
     d47:	8b 45 08             	mov    0x8(%ebp),%eax
     d4a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d4d:	5b                   	pop    %ebx
     d4e:	5e                   	pop    %esi
     d4f:	5d                   	pop    %ebp
     d50:	c2 04 00             	ret    $0x4

00000d53 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     d53:	55                   	push   %ebp
     d54:	89 e5                	mov    %esp,%ebp
     d56:	53                   	push   %ebx
     d57:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     d5a:	83 ec 0c             	sub    $0xc,%esp
     d5d:	6a 1c                	push   $0x1c
     d5f:	e8 b2 fb ff ff       	call   916 <malloc>
     d64:	83 c4 10             	add    $0x10,%esp
     d67:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     d6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d6d:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     d74:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     d77:	8d 45 d8             	lea    -0x28(%ebp),%eax
     d7a:	6a 0c                	push   $0xc
     d7c:	6a 0c                	push   $0xc
     d7e:	6a 0c                	push   $0xc
     d80:	50                   	push   %eax
     d81:	e8 73 fc ff ff       	call   9f9 <RGB>
     d86:	83 c4 0c             	add    $0xc,%esp
     d89:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     d8d:	66 89 43 13          	mov    %ax,0x13(%ebx)
     d91:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     d95:	88 43 15             	mov    %al,0x15(%ebx)
     d98:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d9b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d9e:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     da2:	66 89 48 10          	mov    %cx,0x10(%eax)
     da6:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     daa:	88 50 12             	mov    %dl,0x12(%eax)
     dad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     db0:	8b 55 f4             	mov    -0xc(%ebp),%edx
     db3:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     db7:	66 89 48 08          	mov    %cx,0x8(%eax)
     dbb:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     dbf:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     dc2:	8b 45 08             	mov    0x8(%ebp),%eax
     dc5:	89 c2                	mov    %eax,%edx
     dc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dca:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     dcc:	8b 45 0c             	mov    0xc(%ebp),%eax
     dcf:	89 c2                	mov    %eax,%edx
     dd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dd4:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     dd7:	8b 55 10             	mov    0x10(%ebp),%edx
     dda:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ddd:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "%d %d\n", hdc->size.cx, hdc->size.cy);
    return hdc;
     de0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     de3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     de6:	c9                   	leave  
     de7:	c3                   	ret    

00000de8 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     de8:	55                   	push   %ebp
     de9:	89 e5                	mov    %esp,%ebp
     deb:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     dee:	8b 45 0c             	mov    0xc(%ebp),%eax
     df1:	8b 50 08             	mov    0x8(%eax),%edx
     df4:	89 55 f8             	mov    %edx,-0x8(%ebp)
     df7:	8b 40 0c             	mov    0xc(%eax),%eax
     dfa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
     e00:	8b 55 10             	mov    0x10(%ebp),%edx
     e03:	89 50 08             	mov    %edx,0x8(%eax)
     e06:	8b 55 14             	mov    0x14(%ebp),%edx
     e09:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     e0c:	8b 45 08             	mov    0x8(%ebp),%eax
     e0f:	8b 55 f8             	mov    -0x8(%ebp),%edx
     e12:	89 10                	mov    %edx,(%eax)
     e14:	8b 55 fc             	mov    -0x4(%ebp),%edx
     e17:	89 50 04             	mov    %edx,0x4(%eax)
}
     e1a:	8b 45 08             	mov    0x8(%ebp),%eax
     e1d:	c9                   	leave  
     e1e:	c2 04 00             	ret    $0x4

00000e21 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     e21:	55                   	push   %ebp
     e22:	89 e5                	mov    %esp,%ebp
     e24:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     e27:	8b 45 0c             	mov    0xc(%ebp),%eax
     e2a:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     e2e:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     e32:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     e36:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     e39:	8b 45 0c             	mov    0xc(%ebp),%eax
     e3c:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     e40:	66 89 50 10          	mov    %dx,0x10(%eax)
     e44:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     e48:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     e4b:	8b 45 08             	mov    0x8(%ebp),%eax
     e4e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     e52:	66 89 10             	mov    %dx,(%eax)
     e55:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     e59:	88 50 02             	mov    %dl,0x2(%eax)
}
     e5c:	8b 45 08             	mov    0x8(%ebp),%eax
     e5f:	c9                   	leave  
     e60:	c2 04 00             	ret    $0x4

00000e63 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     e63:	55                   	push   %ebp
     e64:	89 e5                	mov    %esp,%ebp
     e66:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     e69:	8b 45 08             	mov    0x8(%ebp),%eax
     e6c:	8b 40 0c             	mov    0xc(%eax),%eax
     e6f:	89 c2                	mov    %eax,%edx
     e71:	c1 ea 1f             	shr    $0x1f,%edx
     e74:	01 d0                	add    %edx,%eax
     e76:	d1 f8                	sar    %eax
     e78:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     e7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e7e:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     e82:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     e85:	8b 45 10             	mov    0x10(%ebp),%eax
     e88:	2b 45 f4             	sub    -0xc(%ebp),%eax
     e8b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     e8e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     e92:	0f 89 98 00 00 00    	jns    f30 <APDrawPoint+0xcd>
        i = 0;
     e98:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     e9f:	e9 8c 00 00 00       	jmp    f30 <APDrawPoint+0xcd>
    {
        j = x - off;
     ea4:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea7:	2b 45 f4             	sub    -0xc(%ebp),%eax
     eaa:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     ead:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     eb1:	79 69                	jns    f1c <APDrawPoint+0xb9>
            j = 0;
     eb3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     eba:	eb 60                	jmp    f1c <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     ebc:	ff 75 fc             	pushl  -0x4(%ebp)
     ebf:	ff 75 f8             	pushl  -0x8(%ebp)
     ec2:	ff 75 08             	pushl  0x8(%ebp)
     ec5:	e8 ad fb ff ff       	call   a77 <APGetIndex>
     eca:	83 c4 0c             	add    $0xc,%esp
     ecd:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     ed0:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     ed4:	74 55                	je     f2b <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     ed6:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     eda:	74 67                	je     f43 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     edc:	ff 75 10             	pushl  0x10(%ebp)
     edf:	ff 75 0c             	pushl  0xc(%ebp)
     ee2:	ff 75 fc             	pushl  -0x4(%ebp)
     ee5:	ff 75 f8             	pushl  -0x8(%ebp)
     ee8:	e8 51 fb ff ff       	call   a3e <distance_2>
     eed:	83 c4 10             	add    $0x10,%esp
     ef0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     ef3:	7f 23                	jg     f18 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     ef5:	8b 45 08             	mov    0x8(%ebp),%eax
     ef8:	8b 48 18             	mov    0x18(%eax),%ecx
     efb:	8b 55 ec             	mov    -0x14(%ebp),%edx
     efe:	89 d0                	mov    %edx,%eax
     f00:	01 c0                	add    %eax,%eax
     f02:	01 d0                	add    %edx,%eax
     f04:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     f07:	8b 45 08             	mov    0x8(%ebp),%eax
     f0a:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     f0e:	66 89 0a             	mov    %cx,(%edx)
     f11:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     f15:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     f18:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     f1c:	8b 55 0c             	mov    0xc(%ebp),%edx
     f1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f22:	01 d0                	add    %edx,%eax
     f24:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     f27:	7d 93                	jge    ebc <APDrawPoint+0x59>
     f29:	eb 01                	jmp    f2c <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     f2b:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     f2c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     f30:	8b 55 10             	mov    0x10(%ebp),%edx
     f33:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f36:	01 d0                	add    %edx,%eax
     f38:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     f3b:	0f 8d 63 ff ff ff    	jge    ea4 <APDrawPoint+0x41>
     f41:	eb 01                	jmp    f44 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     f43:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     f44:	c9                   	leave  
     f45:	c3                   	ret    

00000f46 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     f46:	55                   	push   %ebp
     f47:	89 e5                	mov    %esp,%ebp
     f49:	53                   	push   %ebx
     f4a:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     f4d:	8b 45 0c             	mov    0xc(%ebp),%eax
     f50:	3b 45 14             	cmp    0x14(%ebp),%eax
     f53:	0f 85 80 00 00 00    	jne    fd9 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     f59:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f5d:	0f 88 9d 02 00 00    	js     1200 <APDrawLine+0x2ba>
     f63:	8b 45 08             	mov    0x8(%ebp),%eax
     f66:	8b 00                	mov    (%eax),%eax
     f68:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f6b:	0f 8e 8f 02 00 00    	jle    1200 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     f71:	8b 45 10             	mov    0x10(%ebp),%eax
     f74:	3b 45 18             	cmp    0x18(%ebp),%eax
     f77:	7e 12                	jle    f8b <APDrawLine+0x45>
        {
            int tmp = y2;
     f79:	8b 45 18             	mov    0x18(%ebp),%eax
     f7c:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     f7f:	8b 45 10             	mov    0x10(%ebp),%eax
     f82:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     f85:	8b 45 dc             	mov    -0x24(%ebp),%eax
     f88:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     f8b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     f8f:	79 07                	jns    f98 <APDrawLine+0x52>
     f91:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     f98:	8b 45 08             	mov    0x8(%ebp),%eax
     f9b:	8b 40 04             	mov    0x4(%eax),%eax
     f9e:	3b 45 18             	cmp    0x18(%ebp),%eax
     fa1:	7d 0c                	jge    faf <APDrawLine+0x69>
     fa3:	8b 45 08             	mov    0x8(%ebp),%eax
     fa6:	8b 40 04             	mov    0x4(%eax),%eax
     fa9:	83 e8 01             	sub    $0x1,%eax
     fac:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     faf:	8b 45 10             	mov    0x10(%ebp),%eax
     fb2:	89 45 f4             	mov    %eax,-0xc(%ebp)
     fb5:	eb 15                	jmp    fcc <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     fb7:	ff 75 f4             	pushl  -0xc(%ebp)
     fba:	ff 75 0c             	pushl  0xc(%ebp)
     fbd:	ff 75 08             	pushl  0x8(%ebp)
     fc0:	e8 9e fe ff ff       	call   e63 <APDrawPoint>
     fc5:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     fc8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     fcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fcf:	3b 45 18             	cmp    0x18(%ebp),%eax
     fd2:	7e e3                	jle    fb7 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     fd4:	e9 2b 02 00 00       	jmp    1204 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     fd9:	8b 45 10             	mov    0x10(%ebp),%eax
     fdc:	3b 45 18             	cmp    0x18(%ebp),%eax
     fdf:	75 7f                	jne    1060 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     fe1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     fe5:	0f 88 18 02 00 00    	js     1203 <APDrawLine+0x2bd>
     feb:	8b 45 08             	mov    0x8(%ebp),%eax
     fee:	8b 40 04             	mov    0x4(%eax),%eax
     ff1:	3b 45 10             	cmp    0x10(%ebp),%eax
     ff4:	0f 8e 09 02 00 00    	jle    1203 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     ffa:	8b 45 0c             	mov    0xc(%ebp),%eax
     ffd:	3b 45 14             	cmp    0x14(%ebp),%eax
    1000:	7e 12                	jle    1014 <APDrawLine+0xce>
        {
            int tmp = x2;
    1002:	8b 45 14             	mov    0x14(%ebp),%eax
    1005:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1008:	8b 45 0c             	mov    0xc(%ebp),%eax
    100b:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    100e:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1011:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    1014:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1018:	79 07                	jns    1021 <APDrawLine+0xdb>
    101a:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1021:	8b 45 08             	mov    0x8(%ebp),%eax
    1024:	8b 00                	mov    (%eax),%eax
    1026:	3b 45 14             	cmp    0x14(%ebp),%eax
    1029:	7d 0b                	jge    1036 <APDrawLine+0xf0>
    102b:	8b 45 08             	mov    0x8(%ebp),%eax
    102e:	8b 00                	mov    (%eax),%eax
    1030:	83 e8 01             	sub    $0x1,%eax
    1033:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1036:	8b 45 0c             	mov    0xc(%ebp),%eax
    1039:	89 45 f0             	mov    %eax,-0x10(%ebp)
    103c:	eb 15                	jmp    1053 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    103e:	ff 75 10             	pushl  0x10(%ebp)
    1041:	ff 75 f0             	pushl  -0x10(%ebp)
    1044:	ff 75 08             	pushl  0x8(%ebp)
    1047:	e8 17 fe ff ff       	call   e63 <APDrawPoint>
    104c:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    104f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1053:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1056:	3b 45 14             	cmp    0x14(%ebp),%eax
    1059:	7e e3                	jle    103e <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    105b:	e9 a4 01 00 00       	jmp    1204 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1060:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1067:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    106e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1071:	2b 45 14             	sub    0x14(%ebp),%eax
    1074:	50                   	push   %eax
    1075:	e8 ed f9 ff ff       	call   a67 <abs_int>
    107a:	83 c4 04             	add    $0x4,%esp
    107d:	89 c3                	mov    %eax,%ebx
    107f:	8b 45 10             	mov    0x10(%ebp),%eax
    1082:	2b 45 18             	sub    0x18(%ebp),%eax
    1085:	50                   	push   %eax
    1086:	e8 dc f9 ff ff       	call   a67 <abs_int>
    108b:	83 c4 04             	add    $0x4,%esp
    108e:	39 c3                	cmp    %eax,%ebx
    1090:	0f 8e b5 00 00 00    	jle    114b <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1096:	8b 45 10             	mov    0x10(%ebp),%eax
    1099:	2b 45 18             	sub    0x18(%ebp),%eax
    109c:	89 45 b0             	mov    %eax,-0x50(%ebp)
    109f:	db 45 b0             	fildl  -0x50(%ebp)
    10a2:	8b 45 0c             	mov    0xc(%ebp),%eax
    10a5:	2b 45 14             	sub    0x14(%ebp),%eax
    10a8:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10ab:	db 45 b0             	fildl  -0x50(%ebp)
    10ae:	de f9                	fdivrp %st,%st(1)
    10b0:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    10b3:	8b 45 14             	mov    0x14(%ebp),%eax
    10b6:	3b 45 0c             	cmp    0xc(%ebp),%eax
    10b9:	7e 0e                	jle    10c9 <APDrawLine+0x183>
        {
            s = x1;
    10bb:	8b 45 0c             	mov    0xc(%ebp),%eax
    10be:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    10c1:	8b 45 14             	mov    0x14(%ebp),%eax
    10c4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    10c7:	eb 0c                	jmp    10d5 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    10c9:	8b 45 14             	mov    0x14(%ebp),%eax
    10cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    10cf:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d2:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    10d5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10d9:	79 07                	jns    10e2 <APDrawLine+0x19c>
    10db:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    10e2:	8b 45 08             	mov    0x8(%ebp),%eax
    10e5:	8b 00                	mov    (%eax),%eax
    10e7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10ea:	7f 0b                	jg     10f7 <APDrawLine+0x1b1>
    10ec:	8b 45 08             	mov    0x8(%ebp),%eax
    10ef:	8b 00                	mov    (%eax),%eax
    10f1:	83 e8 01             	sub    $0x1,%eax
    10f4:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    10f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    10fd:	eb 3f                	jmp    113e <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    10ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1102:	2b 45 0c             	sub    0xc(%ebp),%eax
    1105:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1108:	db 45 b0             	fildl  -0x50(%ebp)
    110b:	dc 4d d0             	fmull  -0x30(%ebp)
    110e:	db 45 10             	fildl  0x10(%ebp)
    1111:	de c1                	faddp  %st,%st(1)
    1113:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1116:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    111a:	b4 0c                	mov    $0xc,%ah
    111c:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1120:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1123:	db 5d cc             	fistpl -0x34(%ebp)
    1126:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1129:	ff 75 cc             	pushl  -0x34(%ebp)
    112c:	ff 75 e4             	pushl  -0x1c(%ebp)
    112f:	ff 75 08             	pushl  0x8(%ebp)
    1132:	e8 2c fd ff ff       	call   e63 <APDrawPoint>
    1137:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    113a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    113e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1141:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1144:	7e b9                	jle    10ff <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1146:	e9 b9 00 00 00       	jmp    1204 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    114b:	8b 45 0c             	mov    0xc(%ebp),%eax
    114e:	2b 45 14             	sub    0x14(%ebp),%eax
    1151:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1154:	db 45 b0             	fildl  -0x50(%ebp)
    1157:	8b 45 10             	mov    0x10(%ebp),%eax
    115a:	2b 45 18             	sub    0x18(%ebp),%eax
    115d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1160:	db 45 b0             	fildl  -0x50(%ebp)
    1163:	de f9                	fdivrp %st,%st(1)
    1165:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1168:	8b 45 10             	mov    0x10(%ebp),%eax
    116b:	3b 45 18             	cmp    0x18(%ebp),%eax
    116e:	7e 0e                	jle    117e <APDrawLine+0x238>
    {
        s = y2;
    1170:	8b 45 18             	mov    0x18(%ebp),%eax
    1173:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1176:	8b 45 10             	mov    0x10(%ebp),%eax
    1179:	89 45 e8             	mov    %eax,-0x18(%ebp)
    117c:	eb 0c                	jmp    118a <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    117e:	8b 45 10             	mov    0x10(%ebp),%eax
    1181:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1184:	8b 45 18             	mov    0x18(%ebp),%eax
    1187:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    118a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    118e:	79 07                	jns    1197 <APDrawLine+0x251>
    1190:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1197:	8b 45 08             	mov    0x8(%ebp),%eax
    119a:	8b 40 04             	mov    0x4(%eax),%eax
    119d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11a0:	7f 0c                	jg     11ae <APDrawLine+0x268>
    11a2:	8b 45 08             	mov    0x8(%ebp),%eax
    11a5:	8b 40 04             	mov    0x4(%eax),%eax
    11a8:	83 e8 01             	sub    $0x1,%eax
    11ab:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    11ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11b1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    11b4:	eb 3f                	jmp    11f5 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    11b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11b9:	2b 45 10             	sub    0x10(%ebp),%eax
    11bc:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11bf:	db 45 b0             	fildl  -0x50(%ebp)
    11c2:	dc 4d c0             	fmull  -0x40(%ebp)
    11c5:	db 45 0c             	fildl  0xc(%ebp)
    11c8:	de c1                	faddp  %st,%st(1)
    11ca:	d9 7d b6             	fnstcw -0x4a(%ebp)
    11cd:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    11d1:	b4 0c                	mov    $0xc,%ah
    11d3:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    11d7:	d9 6d b4             	fldcw  -0x4c(%ebp)
    11da:	db 5d bc             	fistpl -0x44(%ebp)
    11dd:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    11e0:	ff 75 e0             	pushl  -0x20(%ebp)
    11e3:	ff 75 bc             	pushl  -0x44(%ebp)
    11e6:	ff 75 08             	pushl  0x8(%ebp)
    11e9:	e8 75 fc ff ff       	call   e63 <APDrawPoint>
    11ee:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    11f1:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    11f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11f8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11fb:	7e b9                	jle    11b6 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    11fd:	90                   	nop
    11fe:	eb 04                	jmp    1204 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1200:	90                   	nop
    1201:	eb 01                	jmp    1204 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1203:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1204:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1207:	c9                   	leave  
    1208:	c3                   	ret    

00001209 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1209:	55                   	push   %ebp
    120a:	89 e5                	mov    %esp,%ebp
    120c:	53                   	push   %ebx
    120d:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1210:	8b 55 10             	mov    0x10(%ebp),%edx
    1213:	8b 45 18             	mov    0x18(%ebp),%eax
    1216:	01 d0                	add    %edx,%eax
    1218:	83 e8 01             	sub    $0x1,%eax
    121b:	83 ec 04             	sub    $0x4,%esp
    121e:	50                   	push   %eax
    121f:	ff 75 0c             	pushl  0xc(%ebp)
    1222:	ff 75 10             	pushl  0x10(%ebp)
    1225:	ff 75 0c             	pushl  0xc(%ebp)
    1228:	ff 75 08             	pushl  0x8(%ebp)
    122b:	e8 16 fd ff ff       	call   f46 <APDrawLine>
    1230:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1233:	8b 55 0c             	mov    0xc(%ebp),%edx
    1236:	8b 45 14             	mov    0x14(%ebp),%eax
    1239:	01 d0                	add    %edx,%eax
    123b:	83 e8 01             	sub    $0x1,%eax
    123e:	83 ec 04             	sub    $0x4,%esp
    1241:	ff 75 10             	pushl  0x10(%ebp)
    1244:	50                   	push   %eax
    1245:	ff 75 10             	pushl  0x10(%ebp)
    1248:	ff 75 0c             	pushl  0xc(%ebp)
    124b:	ff 75 08             	pushl  0x8(%ebp)
    124e:	e8 f3 fc ff ff       	call   f46 <APDrawLine>
    1253:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1256:	8b 55 10             	mov    0x10(%ebp),%edx
    1259:	8b 45 18             	mov    0x18(%ebp),%eax
    125c:	01 d0                	add    %edx,%eax
    125e:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1261:	8b 55 0c             	mov    0xc(%ebp),%edx
    1264:	8b 45 14             	mov    0x14(%ebp),%eax
    1267:	01 d0                	add    %edx,%eax
    1269:	8d 50 ff             	lea    -0x1(%eax),%edx
    126c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    126f:	8b 45 14             	mov    0x14(%ebp),%eax
    1272:	01 d8                	add    %ebx,%eax
    1274:	83 e8 01             	sub    $0x1,%eax
    1277:	83 ec 04             	sub    $0x4,%esp
    127a:	51                   	push   %ecx
    127b:	52                   	push   %edx
    127c:	ff 75 10             	pushl  0x10(%ebp)
    127f:	50                   	push   %eax
    1280:	ff 75 08             	pushl  0x8(%ebp)
    1283:	e8 be fc ff ff       	call   f46 <APDrawLine>
    1288:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    128b:	8b 55 10             	mov    0x10(%ebp),%edx
    128e:	8b 45 18             	mov    0x18(%ebp),%eax
    1291:	01 d0                	add    %edx,%eax
    1293:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1296:	8b 55 0c             	mov    0xc(%ebp),%edx
    1299:	8b 45 14             	mov    0x14(%ebp),%eax
    129c:	01 d0                	add    %edx,%eax
    129e:	8d 50 ff             	lea    -0x1(%eax),%edx
    12a1:	8b 5d 10             	mov    0x10(%ebp),%ebx
    12a4:	8b 45 18             	mov    0x18(%ebp),%eax
    12a7:	01 d8                	add    %ebx,%eax
    12a9:	83 e8 01             	sub    $0x1,%eax
    12ac:	83 ec 04             	sub    $0x4,%esp
    12af:	51                   	push   %ecx
    12b0:	52                   	push   %edx
    12b1:	50                   	push   %eax
    12b2:	ff 75 0c             	pushl  0xc(%ebp)
    12b5:	ff 75 08             	pushl  0x8(%ebp)
    12b8:	e8 89 fc ff ff       	call   f46 <APDrawLine>
    12bd:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    12c0:	8b 55 0c             	mov    0xc(%ebp),%edx
    12c3:	8b 45 14             	mov    0x14(%ebp),%eax
    12c6:	01 d0                	add    %edx,%eax
    12c8:	8d 50 ff             	lea    -0x1(%eax),%edx
    12cb:	8b 45 08             	mov    0x8(%ebp),%eax
    12ce:	8b 40 0c             	mov    0xc(%eax),%eax
    12d1:	89 c1                	mov    %eax,%ecx
    12d3:	c1 e9 1f             	shr    $0x1f,%ecx
    12d6:	01 c8                	add    %ecx,%eax
    12d8:	d1 f8                	sar    %eax
    12da:	29 c2                	sub    %eax,%edx
    12dc:	89 d0                	mov    %edx,%eax
    12de:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    12e1:	8b 55 10             	mov    0x10(%ebp),%edx
    12e4:	8b 45 18             	mov    0x18(%ebp),%eax
    12e7:	01 d0                	add    %edx,%eax
    12e9:	8d 50 ff             	lea    -0x1(%eax),%edx
    12ec:	8b 45 08             	mov    0x8(%ebp),%eax
    12ef:	8b 40 0c             	mov    0xc(%eax),%eax
    12f2:	89 c1                	mov    %eax,%ecx
    12f4:	c1 e9 1f             	shr    $0x1f,%ecx
    12f7:	01 c8                	add    %ecx,%eax
    12f9:	d1 f8                	sar    %eax
    12fb:	29 c2                	sub    %eax,%edx
    12fd:	89 d0                	mov    %edx,%eax
    12ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1302:	8b 45 08             	mov    0x8(%ebp),%eax
    1305:	8b 40 0c             	mov    0xc(%eax),%eax
    1308:	89 c2                	mov    %eax,%edx
    130a:	c1 ea 1f             	shr    $0x1f,%edx
    130d:	01 d0                	add    %edx,%eax
    130f:	d1 f8                	sar    %eax
    1311:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1314:	8b 45 08             	mov    0x8(%ebp),%eax
    1317:	8b 40 0c             	mov    0xc(%eax),%eax
    131a:	89 c2                	mov    %eax,%edx
    131c:	c1 ea 1f             	shr    $0x1f,%edx
    131f:	01 d0                	add    %edx,%eax
    1321:	d1 f8                	sar    %eax
    1323:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1326:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    132a:	0f 88 d8 00 00 00    	js     1408 <APDrawRect+0x1ff>
    1330:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1334:	0f 88 ce 00 00 00    	js     1408 <APDrawRect+0x1ff>
    133a:	8b 45 08             	mov    0x8(%ebp),%eax
    133d:	8b 00                	mov    (%eax),%eax
    133f:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1342:	0f 8e c0 00 00 00    	jle    1408 <APDrawRect+0x1ff>
    1348:	8b 45 08             	mov    0x8(%ebp),%eax
    134b:	8b 40 04             	mov    0x4(%eax),%eax
    134e:	3b 45 10             	cmp    0x10(%ebp),%eax
    1351:	0f 8e b1 00 00 00    	jle    1408 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1357:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    135b:	79 07                	jns    1364 <APDrawRect+0x15b>
    135d:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1364:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1368:	79 07                	jns    1371 <APDrawRect+0x168>
    136a:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1371:	8b 45 08             	mov    0x8(%ebp),%eax
    1374:	8b 00                	mov    (%eax),%eax
    1376:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1379:	7f 0b                	jg     1386 <APDrawRect+0x17d>
    137b:	8b 45 08             	mov    0x8(%ebp),%eax
    137e:	8b 00                	mov    (%eax),%eax
    1380:	83 e8 01             	sub    $0x1,%eax
    1383:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1386:	8b 45 08             	mov    0x8(%ebp),%eax
    1389:	8b 40 04             	mov    0x4(%eax),%eax
    138c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    138f:	7f 0c                	jg     139d <APDrawRect+0x194>
    1391:	8b 45 08             	mov    0x8(%ebp),%eax
    1394:	8b 40 04             	mov    0x4(%eax),%eax
    1397:	83 e8 01             	sub    $0x1,%eax
    139a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    139d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    13a4:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13aa:	eb 52                	jmp    13fe <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    13ac:	8b 45 10             	mov    0x10(%ebp),%eax
    13af:	89 45 e8             	mov    %eax,-0x18(%ebp)
    13b2:	eb 3e                	jmp    13f2 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    13b4:	83 ec 04             	sub    $0x4,%esp
    13b7:	ff 75 e8             	pushl  -0x18(%ebp)
    13ba:	ff 75 ec             	pushl  -0x14(%ebp)
    13bd:	ff 75 08             	pushl  0x8(%ebp)
    13c0:	e8 b2 f6 ff ff       	call   a77 <APGetIndex>
    13c5:	83 c4 10             	add    $0x10,%esp
    13c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    13cb:	8b 45 08             	mov    0x8(%ebp),%eax
    13ce:	8b 48 18             	mov    0x18(%eax),%ecx
    13d1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    13d4:	89 d0                	mov    %edx,%eax
    13d6:	01 c0                	add    %eax,%eax
    13d8:	01 d0                	add    %edx,%eax
    13da:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    13dd:	8b 45 08             	mov    0x8(%ebp),%eax
    13e0:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    13e4:	66 89 0a             	mov    %cx,(%edx)
    13e7:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    13eb:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    13ee:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    13f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13f5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    13f8:	7e ba                	jle    13b4 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    13fa:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    13fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1401:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1404:	7e a6                	jle    13ac <APDrawRect+0x1a3>
    1406:	eb 01                	jmp    1409 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1408:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1409:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    140c:	c9                   	leave  
    140d:	c3                   	ret    

0000140e <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    140e:	55                   	push   %ebp
    140f:	89 e5                	mov    %esp,%ebp
    1411:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1414:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1418:	0f 88 8e 01 00 00    	js     15ac <APDcCopy+0x19e>
    141e:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1422:	0f 88 84 01 00 00    	js     15ac <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1428:	8b 55 0c             	mov    0xc(%ebp),%edx
    142b:	8b 45 20             	mov    0x20(%ebp),%eax
    142e:	01 d0                	add    %edx,%eax
    1430:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1433:	8b 55 10             	mov    0x10(%ebp),%edx
    1436:	8b 45 24             	mov    0x24(%ebp),%eax
    1439:	01 d0                	add    %edx,%eax
    143b:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w, y_r = y + h;
    143e:	8b 55 18             	mov    0x18(%ebp),%edx
    1441:	8b 45 20             	mov    0x20(%ebp),%eax
    1444:	01 d0                	add    %edx,%eax
    1446:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1449:	8b 55 1c             	mov    0x1c(%ebp),%edx
    144c:	8b 45 24             	mov    0x24(%ebp),%eax
    144f:	01 d0                	add    %edx,%eax
    1451:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
    1454:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1458:	0f 88 51 01 00 00    	js     15af <APDcCopy+0x1a1>
    145e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1462:	0f 88 47 01 00 00    	js     15af <APDcCopy+0x1a1>
    1468:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    146c:	0f 88 3d 01 00 00    	js     15af <APDcCopy+0x1a1>
    1472:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1476:	0f 88 33 01 00 00    	js     15af <APDcCopy+0x1a1>
    147c:	8b 45 14             	mov    0x14(%ebp),%eax
    147f:	8b 00                	mov    (%eax),%eax
    1481:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1484:	0f 8e 25 01 00 00    	jle    15af <APDcCopy+0x1a1>
    148a:	8b 45 14             	mov    0x14(%ebp),%eax
    148d:	8b 40 04             	mov    0x4(%eax),%eax
    1490:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1493:	0f 8e 16 01 00 00    	jle    15af <APDcCopy+0x1a1>
        return;
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    1499:	8b 45 08             	mov    0x8(%ebp),%eax
    149c:	8b 00                	mov    (%eax),%eax
    149e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    14a1:	7d 0b                	jge    14ae <APDcCopy+0xa0>
    14a3:	8b 45 08             	mov    0x8(%ebp),%eax
    14a6:	8b 00                	mov    (%eax),%eax
    14a8:	83 e8 01             	sub    $0x1,%eax
    14ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    14ae:	8b 45 08             	mov    0x8(%ebp),%eax
    14b1:	8b 40 04             	mov    0x4(%eax),%eax
    14b4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    14b7:	7d 0c                	jge    14c5 <APDcCopy+0xb7>
    14b9:	8b 45 08             	mov    0x8(%ebp),%eax
    14bc:	8b 40 04             	mov    0x4(%eax),%eax
    14bf:	83 e8 01             	sub    $0x1,%eax
    14c2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    14c5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    14cc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j < wy_r - wy; j++)
    14d3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14da:	e9 bc 00 00 00       	jmp    159b <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    14df:	8b 45 08             	mov    0x8(%ebp),%eax
    14e2:	8b 00                	mov    (%eax),%eax
    14e4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14e7:	8b 55 10             	mov    0x10(%ebp),%edx
    14ea:	01 ca                	add    %ecx,%edx
    14ec:	0f af d0             	imul   %eax,%edx
    14ef:	8b 45 0c             	mov    0xc(%ebp),%eax
    14f2:	01 d0                	add    %edx,%eax
    14f4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    14f7:	8b 45 14             	mov    0x14(%ebp),%eax
    14fa:	8b 00                	mov    (%eax),%eax
    14fc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14ff:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1502:	01 ca                	add    %ecx,%edx
    1504:	0f af d0             	imul   %eax,%edx
    1507:	8b 45 18             	mov    0x18(%ebp),%eax
    150a:	01 d0                	add    %edx,%eax
    150c:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i < wx_r - wx; i++)
    150f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1516:	eb 74                	jmp    158c <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1518:	8b 45 14             	mov    0x14(%ebp),%eax
    151b:	8b 50 18             	mov    0x18(%eax),%edx
    151e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1521:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1524:	01 c8                	add    %ecx,%eax
    1526:	89 c1                	mov    %eax,%ecx
    1528:	89 c8                	mov    %ecx,%eax
    152a:	01 c0                	add    %eax,%eax
    152c:	01 c8                	add    %ecx,%eax
    152e:	01 d0                	add    %edx,%eax
    1530:	0f b7 10             	movzwl (%eax),%edx
    1533:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1537:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    153b:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    153e:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1542:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1546:	38 c2                	cmp    %al,%dl
    1548:	75 18                	jne    1562 <APDcCopy+0x154>
    154a:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    154e:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1552:	38 c2                	cmp    %al,%dl
    1554:	75 0c                	jne    1562 <APDcCopy+0x154>
    1556:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    155a:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    155e:	38 c2                	cmp    %al,%dl
    1560:	74 26                	je     1588 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1562:	8b 45 08             	mov    0x8(%ebp),%eax
    1565:	8b 50 18             	mov    0x18(%eax),%edx
    1568:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    156b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    156e:	01 c8                	add    %ecx,%eax
    1570:	89 c1                	mov    %eax,%ecx
    1572:	89 c8                	mov    %ecx,%eax
    1574:	01 c0                	add    %eax,%eax
    1576:	01 c8                	add    %ecx,%eax
    1578:	01 d0                	add    %edx,%eax
    157a:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    157e:	66 89 10             	mov    %dx,(%eax)
    1581:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1585:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i < wx_r - wx; i++)
    1588:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    158c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    158f:	2b 45 0c             	sub    0xc(%ebp),%eax
    1592:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1595:	7f 81                	jg     1518 <APDcCopy+0x10a>
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    1597:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    159b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    159e:	2b 45 10             	sub    0x10(%ebp),%eax
    15a1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    15a4:	0f 8f 35 ff ff ff    	jg     14df <APDcCopy+0xd1>
    15aa:	eb 04                	jmp    15b0 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    15ac:	90                   	nop
    15ad:	eb 01                	jmp    15b0 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w, y_r = y + h;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
        return;
    15af:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    15b0:	c9                   	leave  
    15b1:	c3                   	ret    

000015b2 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    15b2:	55                   	push   %ebp
    15b3:	89 e5                	mov    %esp,%ebp
    15b5:	83 ec 1c             	sub    $0x1c,%esp
    15b8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    15bb:	8b 55 10             	mov    0x10(%ebp),%edx
    15be:	8b 45 14             	mov    0x14(%ebp),%eax
    15c1:	88 4d ec             	mov    %cl,-0x14(%ebp)
    15c4:	88 55 e8             	mov    %dl,-0x18(%ebp)
    15c7:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    15ca:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    15ce:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    15d1:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    15d5:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    15d8:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    15dc:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    15df:	8b 45 08             	mov    0x8(%ebp),%eax
    15e2:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    15e6:	66 89 10             	mov    %dx,(%eax)
    15e9:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    15ed:	88 50 02             	mov    %dl,0x2(%eax)
}
    15f0:	8b 45 08             	mov    0x8(%ebp),%eax
    15f3:	c9                   	leave  
    15f4:	c2 04 00             	ret    $0x4

000015f7 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    15f7:	55                   	push   %ebp
    15f8:	89 e5                	mov    %esp,%ebp
    15fa:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    15fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1600:	8b 00                	mov    (%eax),%eax
    1602:	83 ec 08             	sub    $0x8,%esp
    1605:	8d 55 0c             	lea    0xc(%ebp),%edx
    1608:	52                   	push   %edx
    1609:	50                   	push   %eax
    160a:	e8 45 ef ff ff       	call   554 <sendMessage>
    160f:	83 c4 10             	add    $0x10,%esp
}
    1612:	90                   	nop
    1613:	c9                   	leave  
    1614:	c3                   	ret    

00001615 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1615:	55                   	push   %ebp
    1616:	89 e5                	mov    %esp,%ebp
    1618:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    161b:	83 ec 0c             	sub    $0xc,%esp
    161e:	68 90 00 00 00       	push   $0x90
    1623:	e8 ee f2 ff ff       	call   916 <malloc>
    1628:	83 c4 10             	add    $0x10,%esp
    162b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    162e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1632:	75 15                	jne    1649 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1634:	83 ec 04             	sub    $0x4,%esp
    1637:	ff 75 08             	pushl  0x8(%ebp)
    163a:	68 64 21 00 00       	push   $0x2164
    163f:	6a 01                	push   $0x1
    1641:	e8 fd ef ff ff       	call   643 <printf>
    1646:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1649:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164c:	83 c0 7c             	add    $0x7c,%eax
    164f:	83 ec 08             	sub    $0x8,%esp
    1652:	ff 75 08             	pushl  0x8(%ebp)
    1655:	50                   	push   %eax
    1656:	e8 18 ec ff ff       	call   273 <strcpy>
    165b:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    165e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1661:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1668:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166b:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1672:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1675:	8b 40 34             	mov    0x34(%eax),%eax
    1678:	89 c2                	mov    %eax,%edx
    167a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167d:	8b 40 38             	mov    0x38(%eax),%eax
    1680:	0f af d0             	imul   %eax,%edx
    1683:	89 d0                	mov    %edx,%eax
    1685:	01 c0                	add    %eax,%eax
    1687:	01 d0                	add    %edx,%eax
    1689:	83 ec 0c             	sub    $0xc,%esp
    168c:	50                   	push   %eax
    168d:	e8 84 f2 ff ff       	call   916 <malloc>
    1692:	83 c4 10             	add    $0x10,%esp
    1695:	89 c2                	mov    %eax,%edx
    1697:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169a:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    169d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a0:	8b 40 4c             	mov    0x4c(%eax),%eax
    16a3:	85 c0                	test   %eax,%eax
    16a5:	75 15                	jne    16bc <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    16a7:	83 ec 04             	sub    $0x4,%esp
    16aa:	ff 75 08             	pushl  0x8(%ebp)
    16ad:	68 84 21 00 00       	push   $0x2184
    16b2:	6a 01                	push   $0x1
    16b4:	e8 8a ef ff ff       	call   643 <printf>
    16b9:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    16bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16bf:	8b 40 34             	mov    0x34(%eax),%eax
    16c2:	89 c2                	mov    %eax,%edx
    16c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c7:	8b 40 38             	mov    0x38(%eax),%eax
    16ca:	0f af d0             	imul   %eax,%edx
    16cd:	89 d0                	mov    %edx,%eax
    16cf:	01 c0                	add    %eax,%eax
    16d1:	01 c2                	add    %eax,%edx
    16d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d6:	8b 40 4c             	mov    0x4c(%eax),%eax
    16d9:	83 ec 04             	sub    $0x4,%esp
    16dc:	52                   	push   %edx
    16dd:	68 ff ff ff 00       	push   $0xffffff
    16e2:	50                   	push   %eax
    16e3:	e8 21 ec ff ff       	call   309 <memset>
    16e8:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    16eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ee:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    16f5:	e8 2a ee ff ff       	call   524 <getpid>
    16fa:	89 c2                	mov    %eax,%edx
    16fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ff:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1702:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1705:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    170c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170f:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1716:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1719:	8b 40 50             	mov    0x50(%eax),%eax
    171c:	89 c2                	mov    %eax,%edx
    171e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1721:	8b 40 54             	mov    0x54(%eax),%eax
    1724:	0f af d0             	imul   %eax,%edx
    1727:	89 d0                	mov    %edx,%eax
    1729:	01 c0                	add    %eax,%eax
    172b:	01 d0                	add    %edx,%eax
    172d:	83 ec 0c             	sub    $0xc,%esp
    1730:	50                   	push   %eax
    1731:	e8 e0 f1 ff ff       	call   916 <malloc>
    1736:	83 c4 10             	add    $0x10,%esp
    1739:	89 c2                	mov    %eax,%edx
    173b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    173e:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    1741:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1744:	8b 40 68             	mov    0x68(%eax),%eax
    1747:	85 c0                	test   %eax,%eax
    1749:	75 15                	jne    1760 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    174b:	83 ec 04             	sub    $0x4,%esp
    174e:	ff 75 08             	pushl  0x8(%ebp)
    1751:	68 a8 21 00 00       	push   $0x21a8
    1756:	6a 01                	push   $0x1
    1758:	e8 e6 ee ff ff       	call   643 <printf>
    175d:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1760:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1763:	8b 40 34             	mov    0x34(%eax),%eax
    1766:	89 c2                	mov    %eax,%edx
    1768:	8b 45 f4             	mov    -0xc(%ebp),%eax
    176b:	8b 40 38             	mov    0x38(%eax),%eax
    176e:	0f af d0             	imul   %eax,%edx
    1771:	89 d0                	mov    %edx,%eax
    1773:	01 c0                	add    %eax,%eax
    1775:	01 c2                	add    %eax,%edx
    1777:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177a:	8b 40 4c             	mov    0x4c(%eax),%eax
    177d:	83 ec 04             	sub    $0x4,%esp
    1780:	52                   	push   %edx
    1781:	68 ff 00 00 00       	push   $0xff
    1786:	50                   	push   %eax
    1787:	e8 7d eb ff ff       	call   309 <memset>
    178c:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    178f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1792:	8b 55 0c             	mov    0xc(%ebp),%edx
    1795:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1798:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    179c:	74 35                	je     17d3 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    179e:	8b 45 10             	mov    0x10(%ebp),%eax
    17a1:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    17a7:	83 ec 0c             	sub    $0xc,%esp
    17aa:	50                   	push   %eax
    17ab:	e8 66 f1 ff ff       	call   916 <malloc>
    17b0:	83 c4 10             	add    $0x10,%esp
    17b3:	89 c2                	mov    %eax,%edx
    17b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b8:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    17bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17be:	8b 55 10             	mov    0x10(%ebp),%edx
    17c1:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    17c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c7:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    17ce:	e9 8d 00 00 00       	jmp    1860 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    17d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d6:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    17dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e0:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    17e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ea:	8b 40 18             	mov    0x18(%eax),%eax
    17ed:	89 c2                	mov    %eax,%edx
    17ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f2:	8b 40 1c             	mov    0x1c(%eax),%eax
    17f5:	0f af d0             	imul   %eax,%edx
    17f8:	89 d0                	mov    %edx,%eax
    17fa:	01 c0                	add    %eax,%eax
    17fc:	01 d0                	add    %edx,%eax
    17fe:	83 ec 0c             	sub    $0xc,%esp
    1801:	50                   	push   %eax
    1802:	e8 0f f1 ff ff       	call   916 <malloc>
    1807:	83 c4 10             	add    $0x10,%esp
    180a:	89 c2                	mov    %eax,%edx
    180c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180f:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    1812:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1815:	8b 40 30             	mov    0x30(%eax),%eax
    1818:	85 c0                	test   %eax,%eax
    181a:	75 15                	jne    1831 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    181c:	83 ec 04             	sub    $0x4,%esp
    181f:	ff 75 08             	pushl  0x8(%ebp)
    1822:	68 d0 21 00 00       	push   $0x21d0
    1827:	6a 01                	push   $0x1
    1829:	e8 15 ee ff ff       	call   643 <printf>
    182e:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1831:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1834:	8b 40 18             	mov    0x18(%eax),%eax
    1837:	89 c2                	mov    %eax,%edx
    1839:	8b 45 f4             	mov    -0xc(%ebp),%eax
    183c:	8b 40 1c             	mov    0x1c(%eax),%eax
    183f:	0f af d0             	imul   %eax,%edx
    1842:	89 d0                	mov    %edx,%eax
    1844:	01 c0                	add    %eax,%eax
    1846:	01 c2                	add    %eax,%edx
    1848:	8b 45 f4             	mov    -0xc(%ebp),%eax
    184b:	8b 40 30             	mov    0x30(%eax),%eax
    184e:	83 ec 04             	sub    $0x4,%esp
    1851:	52                   	push   %edx
    1852:	68 ff ff ff 00       	push   $0xffffff
    1857:	50                   	push   %eax
    1858:	e8 ac ea ff ff       	call   309 <memset>
    185d:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1860:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1863:	c9                   	leave  
    1864:	c3                   	ret    

00001865 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1865:	55                   	push   %ebp
    1866:	89 e5                	mov    %esp,%ebp
    1868:	53                   	push   %ebx
    1869:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    186c:	8b 45 0c             	mov    0xc(%ebp),%eax
    186f:	83 f8 03             	cmp    $0x3,%eax
    1872:	74 02                	je     1876 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1874:	eb 33                	jmp    18a9 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1876:	8b 45 08             	mov    0x8(%ebp),%eax
    1879:	8b 48 08             	mov    0x8(%eax),%ecx
    187c:	8b 45 08             	mov    0x8(%ebp),%eax
    187f:	8b 50 38             	mov    0x38(%eax),%edx
    1882:	8b 45 08             	mov    0x8(%ebp),%eax
    1885:	8b 40 34             	mov    0x34(%eax),%eax
    1888:	8b 5d 08             	mov    0x8(%ebp),%ebx
    188b:	83 c3 34             	add    $0x34,%ebx
    188e:	83 ec 0c             	sub    $0xc,%esp
    1891:	51                   	push   %ecx
    1892:	52                   	push   %edx
    1893:	50                   	push   %eax
    1894:	6a 00                	push   $0x0
    1896:	6a 00                	push   $0x0
    1898:	53                   	push   %ebx
    1899:	6a 32                	push   $0x32
    189b:	6a 00                	push   $0x0
    189d:	ff 75 08             	pushl  0x8(%ebp)
    18a0:	e8 9f ec ff ff       	call   544 <paintWindow>
    18a5:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    18a8:	90                   	nop
        default: break;
            
            
    }
    return False;
    18a9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    18ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    18b1:	c9                   	leave  
    18b2:	c3                   	ret    

000018b3 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    18b3:	55                   	push   %ebp
    18b4:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    18b6:	8b 45 0c             	mov    0xc(%ebp),%eax
    18b9:	8b 50 08             	mov    0x8(%eax),%edx
    18bc:	8b 45 08             	mov    0x8(%ebp),%eax
    18bf:	8b 00                	mov    (%eax),%eax
    18c1:	39 c2                	cmp    %eax,%edx
    18c3:	74 07                	je     18cc <APPreJudge+0x19>
        return False;
    18c5:	b8 00 00 00 00       	mov    $0x0,%eax
    18ca:	eb 05                	jmp    18d1 <APPreJudge+0x1e>
    return True;
    18cc:	b8 01 00 00 00       	mov    $0x1,%eax
}
    18d1:	5d                   	pop    %ebp
    18d2:	c3                   	ret    

000018d3 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    18d3:	55                   	push   %ebp
    18d4:	89 e5                	mov    %esp,%ebp
    18d6:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    18d9:	8b 45 08             	mov    0x8(%ebp),%eax
    18dc:	8b 55 0c             	mov    0xc(%ebp),%edx
    18df:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    18e2:	83 ec 0c             	sub    $0xc,%esp
    18e5:	ff 75 08             	pushl  0x8(%ebp)
    18e8:	e8 77 ec ff ff       	call   564 <registWindow>
    18ed:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    18f0:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    18f7:	8b 45 08             	mov    0x8(%ebp),%eax
    18fa:	8b 00                	mov    (%eax),%eax
    18fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    18ff:	ff 75 f4             	pushl  -0xc(%ebp)
    1902:	ff 75 f0             	pushl  -0x10(%ebp)
    1905:	ff 75 ec             	pushl  -0x14(%ebp)
    1908:	ff 75 08             	pushl  0x8(%ebp)
    190b:	e8 e7 fc ff ff       	call   15f7 <APSendMessage>
    1910:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1913:	83 ec 0c             	sub    $0xc,%esp
    1916:	ff 75 08             	pushl  0x8(%ebp)
    1919:	e8 3e ec ff ff       	call   55c <getMessage>
    191e:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1921:	8b 45 08             	mov    0x8(%ebp),%eax
    1924:	83 c0 6c             	add    $0x6c,%eax
    1927:	83 ec 08             	sub    $0x8,%esp
    192a:	50                   	push   %eax
    192b:	ff 75 08             	pushl  0x8(%ebp)
    192e:	e8 80 ff ff ff       	call   18b3 <APPreJudge>
    1933:	83 c4 10             	add    $0x10,%esp
    1936:	84 c0                	test   %al,%al
    1938:	74 1b                	je     1955 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    193a:	8b 45 08             	mov    0x8(%ebp),%eax
    193d:	ff 70 74             	pushl  0x74(%eax)
    1940:	ff 70 70             	pushl  0x70(%eax)
    1943:	ff 70 6c             	pushl  0x6c(%eax)
    1946:	ff 75 08             	pushl  0x8(%ebp)
    1949:	8b 45 0c             	mov    0xc(%ebp),%eax
    194c:	ff d0                	call   *%eax
    194e:	83 c4 10             	add    $0x10,%esp
    1951:	84 c0                	test   %al,%al
    1953:	75 0c                	jne    1961 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1955:	8b 45 08             	mov    0x8(%ebp),%eax
    1958:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    195f:	eb b2                	jmp    1913 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1961:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1962:	90                   	nop
    1963:	c9                   	leave  
    1964:	c3                   	ret    

00001965 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1965:	55                   	push   %ebp
    1966:	89 e5                	mov    %esp,%ebp
    1968:	57                   	push   %edi
    1969:	56                   	push   %esi
    196a:	53                   	push   %ebx
    196b:	83 ec 4c             	sub    $0x4c,%esp
    if (!iconReady)
    196e:	a1 f4 2a 00 00       	mov    0x2af4,%eax
    1973:	85 c0                	test   %eax,%eax
    1975:	75 7c                	jne    19f3 <APGridPaint+0x8e>
    {
        iconReady = 1;
    1977:	c7 05 f4 2a 00 00 01 	movl   $0x1,0x2af4
    197e:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("Snake.bmp");
    1981:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1984:	83 ec 08             	sub    $0x8,%esp
    1987:	68 f7 21 00 00       	push   $0x21f7
    198c:	50                   	push   %eax
    198d:	e8 37 f1 ff ff       	call   ac9 <APLoadBitmap>
    1992:	83 c4 0c             	add    $0xc,%esp
    1995:	8b 45 b8             	mov    -0x48(%ebp),%eax
    1998:	a3 f8 2a 00 00       	mov    %eax,0x2af8
    199d:	8b 45 bc             	mov    -0x44(%ebp),%eax
    19a0:	a3 fc 2a 00 00       	mov    %eax,0x2afc
    19a5:	8b 45 c0             	mov    -0x40(%ebp),%eax
    19a8:	a3 00 2b 00 00       	mov    %eax,0x2b00
        printf(1,"bitmap loaded!\n");
    19ad:	83 ec 08             	sub    $0x8,%esp
    19b0:	68 01 22 00 00       	push   $0x2201
    19b5:	6a 01                	push   $0x1
    19b7:	e8 87 ec ff ff       	call   643 <printf>
    19bc:	83 c4 10             	add    $0x10,%esp
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    19bf:	83 ec 04             	sub    $0x4,%esp
    19c2:	ff 35 00 2b 00 00    	pushl  0x2b00
    19c8:	ff 35 fc 2a 00 00    	pushl  0x2afc
    19ce:	ff 35 f8 2a 00 00    	pushl  0x2af8
    19d4:	e8 7a f3 ff ff       	call   d53 <APCreateCompatibleDCFromBitmap>
    19d9:	83 c4 10             	add    $0x10,%esp
    19dc:	a3 04 2b 00 00       	mov    %eax,0x2b04
        printf(1,"bitmap DC created!\n");
    19e1:	83 ec 08             	sub    $0x8,%esp
    19e4:	68 11 22 00 00       	push   $0x2211
    19e9:	6a 01                	push   $0x1
    19eb:	e8 53 ec ff ff       	call   643 <printf>
    19f0:	83 c4 10             	add    $0x10,%esp
    }
    
    if (!wnd->is_grid)
    19f3:	8b 45 08             	mov    0x8(%ebp),%eax
    19f6:	8b 40 08             	mov    0x8(%eax),%eax
    19f9:	85 c0                	test   %eax,%eax
    19fb:	75 17                	jne    1a14 <APGridPaint+0xaf>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    19fd:	83 ec 08             	sub    $0x8,%esp
    1a00:	68 28 22 00 00       	push   $0x2228
    1a05:	6a 01                	push   $0x1
    1a07:	e8 37 ec ff ff       	call   643 <printf>
    1a0c:	83 c4 10             	add    $0x10,%esp
        return;
    1a0f:	e9 55 03 00 00       	jmp    1d69 <APGridPaint+0x404>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1a14:	8b 45 08             	mov    0x8(%ebp),%eax
    1a17:	8b 40 10             	mov    0x10(%eax),%eax
    1a1a:	85 c0                	test   %eax,%eax
    1a1c:	7e 10                	jle    1a2e <APGridPaint+0xc9>
    1a1e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a21:	8b 50 14             	mov    0x14(%eax),%edx
    1a24:	8b 45 08             	mov    0x8(%ebp),%eax
    1a27:	8b 40 10             	mov    0x10(%eax),%eax
    1a2a:	39 c2                	cmp    %eax,%edx
    1a2c:	7c 17                	jl     1a45 <APGridPaint+0xe0>
    {
        printf(1,"Grid mode page error!");
    1a2e:	83 ec 08             	sub    $0x8,%esp
    1a31:	68 4e 22 00 00       	push   $0x224e
    1a36:	6a 01                	push   $0x1
    1a38:	e8 06 ec ff ff       	call   643 <printf>
    1a3d:	83 c4 10             	add    $0x10,%esp
        return;
    1a40:	e9 24 03 00 00       	jmp    1d69 <APGridPaint+0x404>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1a45:	8b 45 08             	mov    0x8(%ebp),%eax
    1a48:	8b 40 14             	mov    0x14(%eax),%eax
    1a4b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a51:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a54:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a57:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a5a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a61:	e9 f9 02 00 00       	jmp    1d5f <APGridPaint+0x3fa>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a66:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a6d:	e9 df 02 00 00       	jmp    1d51 <APGridPaint+0x3ec>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a72:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a75:	c1 e0 04             	shl    $0x4,%eax
    1a78:	89 c2                	mov    %eax,%edx
    1a7a:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a7d:	01 c2                	add    %eax,%edx
    1a7f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a82:	01 d0                	add    %edx,%eax
    1a84:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a87:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8a:	8b 40 0c             	mov    0xc(%eax),%eax
    1a8d:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a90:	c1 e2 02             	shl    $0x2,%edx
    1a93:	01 d0                	add    %edx,%eax
    1a95:	8b 00                	mov    (%eax),%eax
    1a97:	83 f8 01             	cmp    $0x1,%eax
    1a9a:	0f 84 83 00 00 00    	je     1b23 <APGridPaint+0x1be>
    1aa0:	83 f8 01             	cmp    $0x1,%eax
    1aa3:	7f 09                	jg     1aae <APGridPaint+0x149>
    1aa5:	85 c0                	test   %eax,%eax
    1aa7:	74 1c                	je     1ac5 <APGridPaint+0x160>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    1aa9:	e9 9f 02 00 00       	jmp    1d4d <APGridPaint+0x3e8>
        for (int i = 0; i < GRID_W_NUMBER;i++)
        {
            index = start + GRID_W_NUMBER * j + i;
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1aae:	83 f8 02             	cmp    $0x2,%eax
    1ab1:	0f 84 20 01 00 00    	je     1bd7 <APGridPaint+0x272>
    1ab7:	83 f8 03             	cmp    $0x3,%eax
    1aba:	0f 84 d1 01 00 00    	je     1c91 <APGridPaint+0x32c>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    1ac0:	e9 88 02 00 00       	jmp    1d4d <APGridPaint+0x3e8>
                    pen.size = 1;
                    brush.color = RGB(0xd2,0x69,0x1e);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);*/
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ac5:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1ac8:	6a 0c                	push   $0xc
    1aca:	6a 0c                	push   $0xc
    1acc:	6a 0c                	push   $0xc
    1ace:	50                   	push   %eax
    1acf:	e8 de fa ff ff       	call   15b2 <RGB>
    1ad4:	83 c4 0c             	add    $0xc,%esp
    1ad7:	8b 1d 04 2b 00 00    	mov    0x2b04,%ebx
    1add:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ae0:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ae3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ae6:	6b c0 32             	imul   $0x32,%eax,%eax
    1ae9:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    1aec:	8b 45 08             	mov    0x8(%ebp),%eax
    1aef:	8d 78 34             	lea    0x34(%eax),%edi
    1af2:	83 ec 0c             	sub    $0xc,%esp
    1af5:	83 ec 04             	sub    $0x4,%esp
    1af8:	89 e0                	mov    %esp,%eax
    1afa:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1afe:	66 89 30             	mov    %si,(%eax)
    1b01:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1b05:	88 50 02             	mov    %dl,0x2(%eax)
    1b08:	6a 32                	push   $0x32
    1b0a:	6a 32                	push   $0x32
    1b0c:	6a 00                	push   $0x0
    1b0e:	6a 00                	push   $0x0
    1b10:	53                   	push   %ebx
    1b11:	51                   	push   %ecx
    1b12:	ff 75 b4             	pushl  -0x4c(%ebp)
    1b15:	57                   	push   %edi
    1b16:	e8 f3 f8 ff ff       	call   140e <APDcCopy>
    1b1b:	83 c4 30             	add    $0x30,%esp
                    break;
    1b1e:	e9 2a 02 00 00       	jmp    1d4d <APGridPaint+0x3e8>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1b23:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b26:	6a 69                	push   $0x69
    1b28:	6a 69                	push   $0x69
    1b2a:	6a 69                	push   $0x69
    1b2c:	50                   	push   %eax
    1b2d:	e8 80 fa ff ff       	call   15b2 <RGB>
    1b32:	83 c4 0c             	add    $0xc,%esp
    1b35:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1b39:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1b3d:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1b41:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1b44:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1b4b:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b4e:	6a 69                	push   $0x69
    1b50:	6a 69                	push   $0x69
    1b52:	6a 69                	push   $0x69
    1b54:	50                   	push   %eax
    1b55:	e8 58 fa ff ff       	call   15b2 <RGB>
    1b5a:	83 c4 0c             	add    $0xc,%esp
    1b5d:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1b61:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1b65:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1b69:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b6c:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6f:	8d 50 34             	lea    0x34(%eax),%edx
    1b72:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b75:	ff 75 d0             	pushl  -0x30(%ebp)
    1b78:	ff 75 cc             	pushl  -0x34(%ebp)
    1b7b:	52                   	push   %edx
    1b7c:	50                   	push   %eax
    1b7d:	e8 66 f2 ff ff       	call   de8 <APSetPen>
    1b82:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b85:	8b 45 08             	mov    0x8(%ebp),%eax
    1b88:	8d 58 34             	lea    0x34(%eax),%ebx
    1b8b:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1b8e:	83 ec 04             	sub    $0x4,%esp
    1b91:	83 ec 04             	sub    $0x4,%esp
    1b94:	89 e0                	mov    %esp,%eax
    1b96:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1b9a:	66 89 08             	mov    %cx,(%eax)
    1b9d:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1ba1:	88 48 02             	mov    %cl,0x2(%eax)
    1ba4:	53                   	push   %ebx
    1ba5:	52                   	push   %edx
    1ba6:	e8 76 f2 ff ff       	call   e21 <APSetBrush>
    1bab:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1bae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bb1:	6b d0 32             	imul   $0x32,%eax,%edx
    1bb4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bb7:	6b c0 32             	imul   $0x32,%eax,%eax
    1bba:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bbd:	83 c1 34             	add    $0x34,%ecx
    1bc0:	83 ec 0c             	sub    $0xc,%esp
    1bc3:	6a 32                	push   $0x32
    1bc5:	6a 32                	push   $0x32
    1bc7:	52                   	push   %edx
    1bc8:	50                   	push   %eax
    1bc9:	51                   	push   %ecx
    1bca:	e8 3a f6 ff ff       	call   1209 <APDrawRect>
    1bcf:	83 c4 20             	add    $0x20,%esp
                    break;
    1bd2:	e9 76 01 00 00       	jmp    1d4d <APGridPaint+0x3e8>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    pen.color = RGB(0x00,0x80,0x00);
    1bd7:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1bda:	6a 00                	push   $0x0
    1bdc:	68 80 00 00 00       	push   $0x80
    1be1:	6a 00                	push   $0x0
    1be3:	50                   	push   %eax
    1be4:	e8 c9 f9 ff ff       	call   15b2 <RGB>
    1be9:	83 c4 0c             	add    $0xc,%esp
    1bec:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1bf0:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1bf4:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1bf8:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1bfb:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0x80,0x00);
    1c02:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1c05:	6a 00                	push   $0x0
    1c07:	68 80 00 00 00       	push   $0x80
    1c0c:	6a 00                	push   $0x0
    1c0e:	50                   	push   %eax
    1c0f:	e8 9e f9 ff ff       	call   15b2 <RGB>
    1c14:	83 c4 0c             	add    $0xc,%esp
    1c17:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1c1b:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1c1f:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1c23:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1c26:	8b 45 08             	mov    0x8(%ebp),%eax
    1c29:	8d 50 34             	lea    0x34(%eax),%edx
    1c2c:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1c2f:	ff 75 d0             	pushl  -0x30(%ebp)
    1c32:	ff 75 cc             	pushl  -0x34(%ebp)
    1c35:	52                   	push   %edx
    1c36:	50                   	push   %eax
    1c37:	e8 ac f1 ff ff       	call   de8 <APSetPen>
    1c3c:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1c3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c42:	8d 58 34             	lea    0x34(%eax),%ebx
    1c45:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1c48:	83 ec 04             	sub    $0x4,%esp
    1c4b:	83 ec 04             	sub    $0x4,%esp
    1c4e:	89 e0                	mov    %esp,%eax
    1c50:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1c54:	66 89 08             	mov    %cx,(%eax)
    1c57:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1c5b:	88 48 02             	mov    %cl,0x2(%eax)
    1c5e:	53                   	push   %ebx
    1c5f:	52                   	push   %edx
    1c60:	e8 bc f1 ff ff       	call   e21 <APSetBrush>
    1c65:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1c68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c6b:	6b d0 32             	imul   $0x32,%eax,%edx
    1c6e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c71:	6b c0 32             	imul   $0x32,%eax,%eax
    1c74:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c77:	83 c1 34             	add    $0x34,%ecx
    1c7a:	83 ec 0c             	sub    $0xc,%esp
    1c7d:	6a 32                	push   $0x32
    1c7f:	6a 32                	push   $0x32
    1c81:	52                   	push   %edx
    1c82:	50                   	push   %eax
    1c83:	51                   	push   %ecx
    1c84:	e8 80 f5 ff ff       	call   1209 <APDrawRect>
    1c89:	83 c4 20             	add    $0x20,%esp
                    break;
    1c8c:	e9 bc 00 00 00       	jmp    1d4d <APGridPaint+0x3e8>
                case GRID_RIVER:
                    //printf(1,"Grid_River");
                    pen.color = RGB(0x00,0xbf,0xff);
    1c91:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1c94:	68 ff 00 00 00       	push   $0xff
    1c99:	68 bf 00 00 00       	push   $0xbf
    1c9e:	6a 00                	push   $0x0
    1ca0:	50                   	push   %eax
    1ca1:	e8 0c f9 ff ff       	call   15b2 <RGB>
    1ca6:	83 c4 0c             	add    $0xc,%esp
    1ca9:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1cad:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1cb1:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1cb5:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1cb8:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0xbf,0xff);
    1cbf:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1cc2:	68 ff 00 00 00       	push   $0xff
    1cc7:	68 bf 00 00 00       	push   $0xbf
    1ccc:	6a 00                	push   $0x0
    1cce:	50                   	push   %eax
    1ccf:	e8 de f8 ff ff       	call   15b2 <RGB>
    1cd4:	83 c4 0c             	add    $0xc,%esp
    1cd7:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1cdb:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1cdf:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1ce3:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1ce6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce9:	8d 50 34             	lea    0x34(%eax),%edx
    1cec:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1cef:	ff 75 d0             	pushl  -0x30(%ebp)
    1cf2:	ff 75 cc             	pushl  -0x34(%ebp)
    1cf5:	52                   	push   %edx
    1cf6:	50                   	push   %eax
    1cf7:	e8 ec f0 ff ff       	call   de8 <APSetPen>
    1cfc:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1cff:	8b 45 08             	mov    0x8(%ebp),%eax
    1d02:	8d 58 34             	lea    0x34(%eax),%ebx
    1d05:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1d08:	83 ec 04             	sub    $0x4,%esp
    1d0b:	83 ec 04             	sub    $0x4,%esp
    1d0e:	89 e0                	mov    %esp,%eax
    1d10:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1d14:	66 89 08             	mov    %cx,(%eax)
    1d17:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1d1b:	88 48 02             	mov    %cl,0x2(%eax)
    1d1e:	53                   	push   %ebx
    1d1f:	52                   	push   %edx
    1d20:	e8 fc f0 ff ff       	call   e21 <APSetBrush>
    1d25:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
    1d28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d2b:	6b d0 32             	imul   $0x32,%eax,%edx
    1d2e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d31:	6b c0 32             	imul   $0x32,%eax,%eax
    1d34:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1d37:	83 c1 34             	add    $0x34,%ecx
    1d3a:	83 ec 0c             	sub    $0xc,%esp
    1d3d:	6a 32                	push   $0x32
    1d3f:	6a 32                	push   $0x32
    1d41:	52                   	push   %edx
    1d42:	50                   	push   %eax
    1d43:	51                   	push   %ecx
    1d44:	e8 c0 f4 ff ff       	call   1209 <APDrawRect>
    1d49:	83 c4 20             	add    $0x20,%esp
                    break;
    1d4c:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d4d:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1d51:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1d55:	0f 8e 17 fd ff ff    	jle    1a72 <APGridPaint+0x10d>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d5b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1d5f:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1d63:	0f 8e fd fc ff ff    	jle    1a66 <APGridPaint+0x101>
                    break;
                default: break;
            }
        }
    }
}
    1d69:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1d6c:	5b                   	pop    %ebx
    1d6d:	5e                   	pop    %esi
    1d6e:	5f                   	pop    %edi
    1d6f:	5d                   	pop    %ebp
    1d70:	c3                   	ret    

00001d71 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1d71:	55                   	push   %ebp
    1d72:	89 e5                	mov    %esp,%ebp
    1d74:	53                   	push   %ebx
    1d75:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1d78:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1d7f:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1d83:	74 17                	je     1d9c <sprintint+0x2b>
    1d85:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1d89:	79 11                	jns    1d9c <sprintint+0x2b>
        neg = 1;
    1d8b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1d92:	8b 45 10             	mov    0x10(%ebp),%eax
    1d95:	f7 d8                	neg    %eax
    1d97:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1d9a:	eb 06                	jmp    1da2 <sprintint+0x31>
    } else {
        x = xx;
    1d9c:	8b 45 10             	mov    0x10(%ebp),%eax
    1d9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1da2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1da9:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1dac:	8d 41 01             	lea    0x1(%ecx),%eax
    1daf:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1db2:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1db5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1db8:	ba 00 00 00 00       	mov    $0x0,%edx
    1dbd:	f7 f3                	div    %ebx
    1dbf:	89 d0                	mov    %edx,%eax
    1dc1:	0f b6 80 d4 2a 00 00 	movzbl 0x2ad4(%eax),%eax
    1dc8:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1dcc:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1dcf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1dd2:	ba 00 00 00 00       	mov    $0x0,%edx
    1dd7:	f7 f3                	div    %ebx
    1dd9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1ddc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1de0:	75 c7                	jne    1da9 <sprintint+0x38>
    if(neg)
    1de2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1de6:	74 0e                	je     1df6 <sprintint+0x85>
        buf[i++] = '-';
    1de8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1deb:	8d 50 01             	lea    0x1(%eax),%edx
    1dee:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1df1:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1df6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1df9:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1dfc:	eb 1b                	jmp    1e19 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1dfe:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e01:	8b 00                	mov    (%eax),%eax
    1e03:	8d 48 01             	lea    0x1(%eax),%ecx
    1e06:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e09:	89 0a                	mov    %ecx,(%edx)
    1e0b:	89 c2                	mov    %eax,%edx
    1e0d:	8b 45 08             	mov    0x8(%ebp),%eax
    1e10:	01 d0                	add    %edx,%eax
    1e12:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1e15:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1e19:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1e1d:	7f df                	jg     1dfe <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1e1f:	eb 21                	jmp    1e42 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1e21:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e24:	8b 00                	mov    (%eax),%eax
    1e26:	8d 48 01             	lea    0x1(%eax),%ecx
    1e29:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e2c:	89 0a                	mov    %ecx,(%edx)
    1e2e:	89 c2                	mov    %eax,%edx
    1e30:	8b 45 08             	mov    0x8(%ebp),%eax
    1e33:	01 c2                	add    %eax,%edx
    1e35:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1e38:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e3b:	01 c8                	add    %ecx,%eax
    1e3d:	0f b6 00             	movzbl (%eax),%eax
    1e40:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1e42:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1e46:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1e4a:	79 d5                	jns    1e21 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1e4c:	90                   	nop
    1e4d:	83 c4 20             	add    $0x20,%esp
    1e50:	5b                   	pop    %ebx
    1e51:	5d                   	pop    %ebp
    1e52:	c3                   	ret    

00001e53 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1e53:	55                   	push   %ebp
    1e54:	89 e5                	mov    %esp,%ebp
    1e56:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1e59:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1e60:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1e67:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1e6e:	8d 45 0c             	lea    0xc(%ebp),%eax
    1e71:	83 c0 04             	add    $0x4,%eax
    1e74:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1e77:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1e7e:	e9 d9 01 00 00       	jmp    205c <sprintf+0x209>
        c = fmt[i] & 0xff;
    1e83:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e86:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e89:	01 d0                	add    %edx,%eax
    1e8b:	0f b6 00             	movzbl (%eax),%eax
    1e8e:	0f be c0             	movsbl %al,%eax
    1e91:	25 ff 00 00 00       	and    $0xff,%eax
    1e96:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1e99:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1e9d:	75 2c                	jne    1ecb <sprintf+0x78>
            if(c == '%'){
    1e9f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1ea3:	75 0c                	jne    1eb1 <sprintf+0x5e>
                state = '%';
    1ea5:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1eac:	e9 a7 01 00 00       	jmp    2058 <sprintf+0x205>
            } else {
                dst[j++] = c;
    1eb1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1eb4:	8d 50 01             	lea    0x1(%eax),%edx
    1eb7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1eba:	89 c2                	mov    %eax,%edx
    1ebc:	8b 45 08             	mov    0x8(%ebp),%eax
    1ebf:	01 d0                	add    %edx,%eax
    1ec1:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1ec4:	88 10                	mov    %dl,(%eax)
    1ec6:	e9 8d 01 00 00       	jmp    2058 <sprintf+0x205>
            }
        } else if(state == '%'){
    1ecb:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1ecf:	0f 85 83 01 00 00    	jne    2058 <sprintf+0x205>
            if(c == 'd'){
    1ed5:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1ed9:	75 4c                	jne    1f27 <sprintf+0xd4>
                buf[bi] = '\0';
    1edb:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1ede:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ee1:	01 d0                	add    %edx,%eax
    1ee3:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1ee6:	83 ec 0c             	sub    $0xc,%esp
    1ee9:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1eec:	50                   	push   %eax
    1eed:	e8 20 e5 ff ff       	call   412 <atoi>
    1ef2:	83 c4 10             	add    $0x10,%esp
    1ef5:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1ef8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1eff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f02:	8b 00                	mov    (%eax),%eax
    1f04:	83 ec 08             	sub    $0x8,%esp
    1f07:	ff 75 d8             	pushl  -0x28(%ebp)
    1f0a:	6a 01                	push   $0x1
    1f0c:	6a 0a                	push   $0xa
    1f0e:	50                   	push   %eax
    1f0f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1f12:	50                   	push   %eax
    1f13:	ff 75 08             	pushl  0x8(%ebp)
    1f16:	e8 56 fe ff ff       	call   1d71 <sprintint>
    1f1b:	83 c4 20             	add    $0x20,%esp
                ap++;
    1f1e:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1f22:	e9 2a 01 00 00       	jmp    2051 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1f27:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1f2b:	74 06                	je     1f33 <sprintf+0xe0>
    1f2d:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1f31:	75 4c                	jne    1f7f <sprintf+0x12c>
                buf[bi] = '\0';
    1f33:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f36:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f39:	01 d0                	add    %edx,%eax
    1f3b:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f3e:	83 ec 0c             	sub    $0xc,%esp
    1f41:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f44:	50                   	push   %eax
    1f45:	e8 c8 e4 ff ff       	call   412 <atoi>
    1f4a:	83 c4 10             	add    $0x10,%esp
    1f4d:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1f50:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1f57:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f5a:	8b 00                	mov    (%eax),%eax
    1f5c:	83 ec 08             	sub    $0x8,%esp
    1f5f:	ff 75 dc             	pushl  -0x24(%ebp)
    1f62:	6a 00                	push   $0x0
    1f64:	6a 10                	push   $0x10
    1f66:	50                   	push   %eax
    1f67:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1f6a:	50                   	push   %eax
    1f6b:	ff 75 08             	pushl  0x8(%ebp)
    1f6e:	e8 fe fd ff ff       	call   1d71 <sprintint>
    1f73:	83 c4 20             	add    $0x20,%esp
                ap++;
    1f76:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1f7a:	e9 d2 00 00 00       	jmp    2051 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1f7f:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1f83:	75 46                	jne    1fcb <sprintf+0x178>
                s = (char*)*ap;
    1f85:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f88:	8b 00                	mov    (%eax),%eax
    1f8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1f8d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1f91:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f95:	75 25                	jne    1fbc <sprintf+0x169>
                    s = "(null)";
    1f97:	c7 45 f4 64 22 00 00 	movl   $0x2264,-0xc(%ebp)
                while(*s != 0){
    1f9e:	eb 1c                	jmp    1fbc <sprintf+0x169>
                    dst[j++] = *s;
    1fa0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1fa3:	8d 50 01             	lea    0x1(%eax),%edx
    1fa6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1fa9:	89 c2                	mov    %eax,%edx
    1fab:	8b 45 08             	mov    0x8(%ebp),%eax
    1fae:	01 c2                	add    %eax,%edx
    1fb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fb3:	0f b6 00             	movzbl (%eax),%eax
    1fb6:	88 02                	mov    %al,(%edx)
                    s++;
    1fb8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    1fbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fbf:	0f b6 00             	movzbl (%eax),%eax
    1fc2:	84 c0                	test   %al,%al
    1fc4:	75 da                	jne    1fa0 <sprintf+0x14d>
    1fc6:	e9 86 00 00 00       	jmp    2051 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    1fcb:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    1fcf:	75 1d                	jne    1fee <sprintf+0x19b>
                dst[j++] = *ap;
    1fd1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1fd4:	8d 50 01             	lea    0x1(%eax),%edx
    1fd7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1fda:	89 c2                	mov    %eax,%edx
    1fdc:	8b 45 08             	mov    0x8(%ebp),%eax
    1fdf:	01 c2                	add    %eax,%edx
    1fe1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fe4:	8b 00                	mov    (%eax),%eax
    1fe6:	88 02                	mov    %al,(%edx)
                ap++;
    1fe8:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1fec:	eb 63                	jmp    2051 <sprintf+0x1fe>
            } else if(c == '%'){
    1fee:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1ff2:	75 17                	jne    200b <sprintf+0x1b8>
                dst[j++] = c;
    1ff4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1ff7:	8d 50 01             	lea    0x1(%eax),%edx
    1ffa:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1ffd:	89 c2                	mov    %eax,%edx
    1fff:	8b 45 08             	mov    0x8(%ebp),%eax
    2002:	01 d0                	add    %edx,%eax
    2004:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2007:	88 10                	mov    %dl,(%eax)
    2009:	eb 46                	jmp    2051 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    200b:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    200f:	7e 18                	jle    2029 <sprintf+0x1d6>
    2011:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2015:	7f 12                	jg     2029 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2017:	8b 45 f0             	mov    -0x10(%ebp),%eax
    201a:	8d 50 01             	lea    0x1(%eax),%edx
    201d:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2020:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2023:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2027:	eb 2f                	jmp    2058 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2029:	8b 45 c8             	mov    -0x38(%ebp),%eax
    202c:	8d 50 01             	lea    0x1(%eax),%edx
    202f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2032:	89 c2                	mov    %eax,%edx
    2034:	8b 45 08             	mov    0x8(%ebp),%eax
    2037:	01 d0                	add    %edx,%eax
    2039:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    203c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    203f:	8d 50 01             	lea    0x1(%eax),%edx
    2042:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2045:	89 c2                	mov    %eax,%edx
    2047:	8b 45 08             	mov    0x8(%ebp),%eax
    204a:	01 d0                	add    %edx,%eax
    204c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    204f:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2051:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2058:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    205c:	8b 55 0c             	mov    0xc(%ebp),%edx
    205f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2062:	01 d0                	add    %edx,%eax
    2064:	0f b6 00             	movzbl (%eax),%eax
    2067:	84 c0                	test   %al,%al
    2069:	0f 85 14 fe ff ff    	jne    1e83 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    206f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2072:	8d 50 01             	lea    0x1(%eax),%edx
    2075:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2078:	89 c2                	mov    %eax,%edx
    207a:	8b 45 08             	mov    0x8(%ebp),%eax
    207d:	01 d0                	add    %edx,%eax
    207f:	c6 00 00             	movb   $0x0,(%eax)
}
    2082:	90                   	nop
    2083:	c9                   	leave  
    2084:	c3                   	ret    
