
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
       9:	68 74 22 00 00       	push   $0x2274
       e:	6a 01                	push   $0x1
      10:	e8 1c 06 00 00       	call   631 <printf>
      15:	83 c4 10             	add    $0x10,%esp
    int fd = open("ASCII", O_RDONLY);
      18:	83 ec 08             	sub    $0x8,%esp
      1b:	6a 00                	push   $0x0
      1d:	68 80 22 00 00       	push   $0x2280
      22:	e8 ab 04 00 00       	call   4d2 <open>
      27:	83 c4 10             	add    $0x10,%esp
      2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (fd < 0)
      2d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      31:	79 14                	jns    47 <desktopInitStringFigure+0x47>
    {
        printf(1, "Cannot open file\n");
      33:	83 ec 08             	sub    $0x8,%esp
      36:	68 86 22 00 00       	push   $0x2286
      3b:	6a 01                	push   $0x1
      3d:	e8 ef 05 00 00       	call   631 <printf>
      42:	83 c4 10             	add    $0x10,%esp
        return;
      45:	eb 7d                	jmp    c4 <desktopInitStringFigure+0xc4>
    }
    char * ASCII = (char *)malloc(sizeof(char) * ASCII_SIZE);
      47:	83 ec 0c             	sub    $0xc,%esp
      4a:	68 00 08 00 00       	push   $0x800
      4f:	e8 b0 08 00 00       	call   904 <malloc>
      54:	83 c4 10             	add    $0x10,%esp
      57:	89 45 f0             	mov    %eax,-0x10(%ebp)
    read(fd, ASCII, sizeof(char) * ASCII_SIZE);
      5a:	83 ec 04             	sub    $0x4,%esp
      5d:	68 00 08 00 00       	push   $0x800
      62:	ff 75 f0             	pushl  -0x10(%ebp)
      65:	ff 75 f4             	pushl  -0xc(%ebp)
      68:	e8 3d 04 00 00       	call   4aa <read>
      6d:	83 c4 10             	add    $0x10,%esp
    close(fd);
      70:	83 ec 0c             	sub    $0xc,%esp
      73:	ff 75 f4             	pushl  -0xc(%ebp)
      76:	e8 3f 04 00 00       	call   4ba <close>
      7b:	83 c4 10             	add    $0x10,%esp
    printf(1, "read ASCII complete\n");
      7e:	83 ec 08             	sub    $0x8,%esp
      81:	68 98 22 00 00       	push   $0x2298
      86:	6a 01                	push   $0x1
      88:	e8 a4 05 00 00       	call   631 <printf>
      8d:	83 c4 10             	add    $0x10,%esp
    
    initStringFigure(0, 0, ASCII, ASCII_SIZE);
      90:	68 00 08 00 00       	push   $0x800
      95:	ff 75 f0             	pushl  -0x10(%ebp)
      98:	6a 00                	push   $0x0
      9a:	6a 00                	push   $0x0
      9c:	e8 99 04 00 00       	call   53a <initStringFigure>
      a1:	83 c4 10             	add    $0x10,%esp
    //free(GBK2312);
    free(ASCII);
      a4:	83 ec 0c             	sub    $0xc,%esp
      a7:	ff 75 f0             	pushl  -0x10(%ebp)
      aa:	e8 13 07 00 00       	call   7c2 <free>
      af:	83 c4 10             	add    $0x10,%esp
    printf(1, "init string figure complete\n");
      b2:	83 ec 08             	sub    $0x8,%esp
      b5:	68 ad 22 00 00       	push   $0x22ad
      ba:	6a 01                	push   $0x1
      bc:	e8 70 05 00 00       	call   631 <printf>
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
      cc:	e8 b9 03 00 00       	call   48a <fork>
      d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    char temp[30];
    if (pid == 0)
      d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      d8:	75 37                	jne    111 <runApp+0x4b>
    {
        sprintf(temp, "AP%s", (char *)param);
      da:	83 ec 04             	sub    $0x4,%esp
      dd:	ff 75 08             	pushl  0x8(%ebp)
      e0:	68 ca 22 00 00       	push   $0x22ca
      e5:	8d 45 d6             	lea    -0x2a(%ebp),%eax
      e8:	50                   	push   %eax
      e9:	e8 54 1f 00 00       	call   2042 <sprintf>
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
     109:	e8 bc 03 00 00       	call   4ca <exec>
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
     120:	74 1d                	je     13f <wndProc+0x2b>
     122:	83 f8 03             	cmp    $0x3,%eax
     125:	0f 84 8e 00 00 00    	je     1b9 <wndProc+0xa5>
     12b:	83 f8 01             	cmp    $0x1,%eax
     12e:	74 05                	je     135 <wndProc+0x21>
            APSendMessage(hwnd,msg);
            return False;
        case MSG_PAINT:
            APGridPaint(hwnd);
            break;
        default: break;
     130:	e9 93 00 00 00       	jmp    1c8 <wndProc+0xb4>
    //printf(1,"desktop processing!\n");
    switch(msg.type)
    {
	case MSG_DRAWMAINWINDOW:

            return False;
     135:	b8 00 00 00 00       	mov    $0x0,%eax
     13a:	e9 9d 00 00 00       	jmp    1dc <wndProc+0xc8>
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
     13f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     146:	eb 49                	jmp    191 <wndProc+0x7d>
            {
                int off = j * GRID_W_NUMBER;
     148:	8b 45 f4             	mov    -0xc(%ebp),%eax
     14b:	c1 e0 04             	shl    $0x4,%eax
     14e:	89 45 ec             	mov    %eax,-0x14(%ebp)
                for (int i = 0; i< GRID_W_NUMBER; i++)
     151:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     158:	eb 2d                	jmp    187 <wndProc+0x73>
                    hwnd->Grid[off + i] = desktop_layout[j][i];
     15a:	8b 45 08             	mov    0x8(%ebp),%eax
     15d:	8b 40 0c             	mov    0xc(%eax),%eax
     160:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     163:	8b 55 f0             	mov    -0x10(%ebp),%edx
     166:	01 ca                	add    %ecx,%edx
     168:	c1 e2 02             	shl    $0x2,%edx
     16b:	01 c2                	add    %eax,%edx
     16d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     170:	c1 e0 04             	shl    $0x4,%eax
     173:	89 c1                	mov    %eax,%ecx
     175:	8b 45 f0             	mov    -0x10(%ebp),%eax
     178:	01 c8                	add    %ecx,%eax
     17a:	8b 04 85 e0 29 00 00 	mov    0x29e0(,%eax,4),%eax
     181:	89 02                	mov    %eax,(%edx)
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
            {
                int off = j * GRID_W_NUMBER;
                for (int i = 0; i< GRID_W_NUMBER; i++)
     183:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     187:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
     18b:	7e cd                	jle    15a <wndProc+0x46>
	case MSG_DRAWMAINWINDOW:

            return False;
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
     18d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     191:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
     195:	7e b1                	jle    148 <wndProc+0x34>
            {
                int off = j * GRID_W_NUMBER;
                for (int i = 0; i< GRID_W_NUMBER; i++)
                    hwnd->Grid[off + i] = desktop_layout[j][i];
            }
            msg.type = MSG_PAINT;
     197:	c7 45 0c 03 00 00 00 	movl   $0x3,0xc(%ebp)
            APSendMessage(hwnd,msg);
     19e:	ff 75 14             	pushl  0x14(%ebp)
     1a1:	ff 75 10             	pushl  0x10(%ebp)
     1a4:	ff 75 0c             	pushl  0xc(%ebp)
     1a7:	ff 75 08             	pushl  0x8(%ebp)
     1aa:	e8 e6 13 00 00       	call   1595 <APSendMessage>
     1af:	83 c4 10             	add    $0x10,%esp
            return False;
     1b2:	b8 00 00 00 00       	mov    $0x0,%eax
     1b7:	eb 23                	jmp    1dc <wndProc+0xc8>
        case MSG_PAINT:
            APGridPaint(hwnd);
     1b9:	83 ec 0c             	sub    $0xc,%esp
     1bc:	ff 75 08             	pushl  0x8(%ebp)
     1bf:	e8 3f 17 00 00       	call   1903 <APGridPaint>
     1c4:	83 c4 10             	add    $0x10,%esp
            break;
     1c7:	90                   	nop
        default: break;
            
            
            
    }
    return APWndProc(hwnd, msg);
     1c8:	ff 75 14             	pushl  0x14(%ebp)
     1cb:	ff 75 10             	pushl  0x10(%ebp)
     1ce:	ff 75 0c             	pushl  0xc(%ebp)
     1d1:	ff 75 08             	pushl  0x8(%ebp)
     1d4:	e8 2a 16 00 00       	call   1803 <APWndProc>
     1d9:	83 c4 10             	add    $0x10,%esp
}
     1dc:	c9                   	leave  
     1dd:	c3                   	ret    

000001de <main>:

int main(void)
{
     1de:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     1e2:	83 e4 f0             	and    $0xfffffff0,%esp
     1e5:	ff 71 fc             	pushl  -0x4(%ecx)
     1e8:	55                   	push   %ebp
     1e9:	89 e5                	mov    %esp,%ebp
     1eb:	51                   	push   %ecx
     1ec:	83 ec 14             	sub    $0x14,%esp
    desktopInitStringFigure();
     1ef:	e8 0c fe ff ff       	call   0 <desktopInitStringFigure>
    AHwnd r = APCreateWindow("desktop",True,3);
     1f4:	83 ec 04             	sub    $0x4,%esp
     1f7:	6a 03                	push   $0x3
     1f9:	6a 01                	push   $0x1
     1fb:	68 cf 22 00 00       	push   $0x22cf
     200:	e8 ae 13 00 00       	call   15b3 <APCreateWindow>
     205:	83 c4 10             	add    $0x10,%esp
     208:	89 45 f4             	mov    %eax,-0xc(%ebp)
    AHwnd hwnd = r;
     20b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     20e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    printf(1,"desktop initialized!\n");
     211:	83 ec 08             	sub    $0x8,%esp
     214:	68 d7 22 00 00       	push   $0x22d7
     219:	6a 01                	push   $0x1
     21b:	e8 11 04 00 00       	call   631 <printf>
     220:	83 c4 10             	add    $0x10,%esp
    APWndExec(hwnd, wndProc);
     223:	83 ec 08             	sub    $0x8,%esp
     226:	68 14 01 00 00       	push   $0x114
     22b:	ff 75 f0             	pushl  -0x10(%ebp)
     22e:	e8 3e 16 00 00       	call   1871 <APWndExec>
     233:	83 c4 10             	add    $0x10,%esp
    exit();
     236:	e8 57 02 00 00       	call   492 <exit>

0000023b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     23b:	55                   	push   %ebp
     23c:	89 e5                	mov    %esp,%ebp
     23e:	57                   	push   %edi
     23f:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     240:	8b 4d 08             	mov    0x8(%ebp),%ecx
     243:	8b 55 10             	mov    0x10(%ebp),%edx
     246:	8b 45 0c             	mov    0xc(%ebp),%eax
     249:	89 cb                	mov    %ecx,%ebx
     24b:	89 df                	mov    %ebx,%edi
     24d:	89 d1                	mov    %edx,%ecx
     24f:	fc                   	cld    
     250:	f3 aa                	rep stos %al,%es:(%edi)
     252:	89 ca                	mov    %ecx,%edx
     254:	89 fb                	mov    %edi,%ebx
     256:	89 5d 08             	mov    %ebx,0x8(%ebp)
     259:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     25c:	90                   	nop
     25d:	5b                   	pop    %ebx
     25e:	5f                   	pop    %edi
     25f:	5d                   	pop    %ebp
     260:	c3                   	ret    

00000261 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     261:	55                   	push   %ebp
     262:	89 e5                	mov    %esp,%ebp
     264:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     267:	8b 45 08             	mov    0x8(%ebp),%eax
     26a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     26d:	90                   	nop
     26e:	8b 45 08             	mov    0x8(%ebp),%eax
     271:	8d 50 01             	lea    0x1(%eax),%edx
     274:	89 55 08             	mov    %edx,0x8(%ebp)
     277:	8b 55 0c             	mov    0xc(%ebp),%edx
     27a:	8d 4a 01             	lea    0x1(%edx),%ecx
     27d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     280:	0f b6 12             	movzbl (%edx),%edx
     283:	88 10                	mov    %dl,(%eax)
     285:	0f b6 00             	movzbl (%eax),%eax
     288:	84 c0                	test   %al,%al
     28a:	75 e2                	jne    26e <strcpy+0xd>
    ;
  return os;
     28c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     28f:	c9                   	leave  
     290:	c3                   	ret    

00000291 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     291:	55                   	push   %ebp
     292:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     294:	eb 08                	jmp    29e <strcmp+0xd>
    p++, q++;
     296:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     29a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     29e:	8b 45 08             	mov    0x8(%ebp),%eax
     2a1:	0f b6 00             	movzbl (%eax),%eax
     2a4:	84 c0                	test   %al,%al
     2a6:	74 10                	je     2b8 <strcmp+0x27>
     2a8:	8b 45 08             	mov    0x8(%ebp),%eax
     2ab:	0f b6 10             	movzbl (%eax),%edx
     2ae:	8b 45 0c             	mov    0xc(%ebp),%eax
     2b1:	0f b6 00             	movzbl (%eax),%eax
     2b4:	38 c2                	cmp    %al,%dl
     2b6:	74 de                	je     296 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     2b8:	8b 45 08             	mov    0x8(%ebp),%eax
     2bb:	0f b6 00             	movzbl (%eax),%eax
     2be:	0f b6 d0             	movzbl %al,%edx
     2c1:	8b 45 0c             	mov    0xc(%ebp),%eax
     2c4:	0f b6 00             	movzbl (%eax),%eax
     2c7:	0f b6 c0             	movzbl %al,%eax
     2ca:	29 c2                	sub    %eax,%edx
     2cc:	89 d0                	mov    %edx,%eax
}
     2ce:	5d                   	pop    %ebp
     2cf:	c3                   	ret    

000002d0 <strlen>:

uint
strlen(char *s)
{
     2d0:	55                   	push   %ebp
     2d1:	89 e5                	mov    %esp,%ebp
     2d3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     2d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     2dd:	eb 04                	jmp    2e3 <strlen+0x13>
     2df:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     2e3:	8b 55 fc             	mov    -0x4(%ebp),%edx
     2e6:	8b 45 08             	mov    0x8(%ebp),%eax
     2e9:	01 d0                	add    %edx,%eax
     2eb:	0f b6 00             	movzbl (%eax),%eax
     2ee:	84 c0                	test   %al,%al
     2f0:	75 ed                	jne    2df <strlen+0xf>
    ;
  return n;
     2f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     2f5:	c9                   	leave  
     2f6:	c3                   	ret    

000002f7 <memset>:

void*
memset(void *dst, int c, uint n)
{
     2f7:	55                   	push   %ebp
     2f8:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     2fa:	8b 45 10             	mov    0x10(%ebp),%eax
     2fd:	50                   	push   %eax
     2fe:	ff 75 0c             	pushl  0xc(%ebp)
     301:	ff 75 08             	pushl  0x8(%ebp)
     304:	e8 32 ff ff ff       	call   23b <stosb>
     309:	83 c4 0c             	add    $0xc,%esp
  return dst;
     30c:	8b 45 08             	mov    0x8(%ebp),%eax
}
     30f:	c9                   	leave  
     310:	c3                   	ret    

00000311 <strchr>:

char*
strchr(const char *s, char c)
{
     311:	55                   	push   %ebp
     312:	89 e5                	mov    %esp,%ebp
     314:	83 ec 04             	sub    $0x4,%esp
     317:	8b 45 0c             	mov    0xc(%ebp),%eax
     31a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     31d:	eb 14                	jmp    333 <strchr+0x22>
    if(*s == c)
     31f:	8b 45 08             	mov    0x8(%ebp),%eax
     322:	0f b6 00             	movzbl (%eax),%eax
     325:	3a 45 fc             	cmp    -0x4(%ebp),%al
     328:	75 05                	jne    32f <strchr+0x1e>
      return (char*)s;
     32a:	8b 45 08             	mov    0x8(%ebp),%eax
     32d:	eb 13                	jmp    342 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     32f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     333:	8b 45 08             	mov    0x8(%ebp),%eax
     336:	0f b6 00             	movzbl (%eax),%eax
     339:	84 c0                	test   %al,%al
     33b:	75 e2                	jne    31f <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     33d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     342:	c9                   	leave  
     343:	c3                   	ret    

00000344 <gets>:

char*
gets(char *buf, int max)
{
     344:	55                   	push   %ebp
     345:	89 e5                	mov    %esp,%ebp
     347:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     34a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     351:	eb 42                	jmp    395 <gets+0x51>
    cc = read(0, &c, 1);
     353:	83 ec 04             	sub    $0x4,%esp
     356:	6a 01                	push   $0x1
     358:	8d 45 ef             	lea    -0x11(%ebp),%eax
     35b:	50                   	push   %eax
     35c:	6a 00                	push   $0x0
     35e:	e8 47 01 00 00       	call   4aa <read>
     363:	83 c4 10             	add    $0x10,%esp
     366:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     369:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     36d:	7e 33                	jle    3a2 <gets+0x5e>
      break;
    buf[i++] = c;
     36f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     372:	8d 50 01             	lea    0x1(%eax),%edx
     375:	89 55 f4             	mov    %edx,-0xc(%ebp)
     378:	89 c2                	mov    %eax,%edx
     37a:	8b 45 08             	mov    0x8(%ebp),%eax
     37d:	01 c2                	add    %eax,%edx
     37f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     383:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     385:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     389:	3c 0a                	cmp    $0xa,%al
     38b:	74 16                	je     3a3 <gets+0x5f>
     38d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     391:	3c 0d                	cmp    $0xd,%al
     393:	74 0e                	je     3a3 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     395:	8b 45 f4             	mov    -0xc(%ebp),%eax
     398:	83 c0 01             	add    $0x1,%eax
     39b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     39e:	7c b3                	jl     353 <gets+0xf>
     3a0:	eb 01                	jmp    3a3 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     3a2:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     3a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
     3a6:	8b 45 08             	mov    0x8(%ebp),%eax
     3a9:	01 d0                	add    %edx,%eax
     3ab:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     3ae:	8b 45 08             	mov    0x8(%ebp),%eax
}
     3b1:	c9                   	leave  
     3b2:	c3                   	ret    

000003b3 <stat>:

int
stat(char *n, struct stat *st)
{
     3b3:	55                   	push   %ebp
     3b4:	89 e5                	mov    %esp,%ebp
     3b6:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3b9:	83 ec 08             	sub    $0x8,%esp
     3bc:	6a 00                	push   $0x0
     3be:	ff 75 08             	pushl  0x8(%ebp)
     3c1:	e8 0c 01 00 00       	call   4d2 <open>
     3c6:	83 c4 10             	add    $0x10,%esp
     3c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     3cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3d0:	79 07                	jns    3d9 <stat+0x26>
    return -1;
     3d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     3d7:	eb 25                	jmp    3fe <stat+0x4b>
  r = fstat(fd, st);
     3d9:	83 ec 08             	sub    $0x8,%esp
     3dc:	ff 75 0c             	pushl  0xc(%ebp)
     3df:	ff 75 f4             	pushl  -0xc(%ebp)
     3e2:	e8 03 01 00 00       	call   4ea <fstat>
     3e7:	83 c4 10             	add    $0x10,%esp
     3ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     3ed:	83 ec 0c             	sub    $0xc,%esp
     3f0:	ff 75 f4             	pushl  -0xc(%ebp)
     3f3:	e8 c2 00 00 00       	call   4ba <close>
     3f8:	83 c4 10             	add    $0x10,%esp
  return r;
     3fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     3fe:	c9                   	leave  
     3ff:	c3                   	ret    

00000400 <atoi>:

int
atoi(const char *s)
{
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     406:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     40d:	eb 25                	jmp    434 <atoi+0x34>
    n = n*10 + *s++ - '0';
     40f:	8b 55 fc             	mov    -0x4(%ebp),%edx
     412:	89 d0                	mov    %edx,%eax
     414:	c1 e0 02             	shl    $0x2,%eax
     417:	01 d0                	add    %edx,%eax
     419:	01 c0                	add    %eax,%eax
     41b:	89 c1                	mov    %eax,%ecx
     41d:	8b 45 08             	mov    0x8(%ebp),%eax
     420:	8d 50 01             	lea    0x1(%eax),%edx
     423:	89 55 08             	mov    %edx,0x8(%ebp)
     426:	0f b6 00             	movzbl (%eax),%eax
     429:	0f be c0             	movsbl %al,%eax
     42c:	01 c8                	add    %ecx,%eax
     42e:	83 e8 30             	sub    $0x30,%eax
     431:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     434:	8b 45 08             	mov    0x8(%ebp),%eax
     437:	0f b6 00             	movzbl (%eax),%eax
     43a:	3c 2f                	cmp    $0x2f,%al
     43c:	7e 0a                	jle    448 <atoi+0x48>
     43e:	8b 45 08             	mov    0x8(%ebp),%eax
     441:	0f b6 00             	movzbl (%eax),%eax
     444:	3c 39                	cmp    $0x39,%al
     446:	7e c7                	jle    40f <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     448:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     44b:	c9                   	leave  
     44c:	c3                   	ret    

0000044d <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     44d:	55                   	push   %ebp
     44e:	89 e5                	mov    %esp,%ebp
     450:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     453:	8b 45 08             	mov    0x8(%ebp),%eax
     456:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     459:	8b 45 0c             	mov    0xc(%ebp),%eax
     45c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     45f:	eb 17                	jmp    478 <memmove+0x2b>
    *dst++ = *src++;
     461:	8b 45 fc             	mov    -0x4(%ebp),%eax
     464:	8d 50 01             	lea    0x1(%eax),%edx
     467:	89 55 fc             	mov    %edx,-0x4(%ebp)
     46a:	8b 55 f8             	mov    -0x8(%ebp),%edx
     46d:	8d 4a 01             	lea    0x1(%edx),%ecx
     470:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     473:	0f b6 12             	movzbl (%edx),%edx
     476:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     478:	8b 45 10             	mov    0x10(%ebp),%eax
     47b:	8d 50 ff             	lea    -0x1(%eax),%edx
     47e:	89 55 10             	mov    %edx,0x10(%ebp)
     481:	85 c0                	test   %eax,%eax
     483:	7f dc                	jg     461 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     485:	8b 45 08             	mov    0x8(%ebp),%eax
}
     488:	c9                   	leave  
     489:	c3                   	ret    

0000048a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     48a:	b8 01 00 00 00       	mov    $0x1,%eax
     48f:	cd 40                	int    $0x40
     491:	c3                   	ret    

00000492 <exit>:
SYSCALL(exit)
     492:	b8 02 00 00 00       	mov    $0x2,%eax
     497:	cd 40                	int    $0x40
     499:	c3                   	ret    

0000049a <wait>:
SYSCALL(wait)
     49a:	b8 03 00 00 00       	mov    $0x3,%eax
     49f:	cd 40                	int    $0x40
     4a1:	c3                   	ret    

000004a2 <pipe>:
SYSCALL(pipe)
     4a2:	b8 04 00 00 00       	mov    $0x4,%eax
     4a7:	cd 40                	int    $0x40
     4a9:	c3                   	ret    

000004aa <read>:
SYSCALL(read)
     4aa:	b8 05 00 00 00       	mov    $0x5,%eax
     4af:	cd 40                	int    $0x40
     4b1:	c3                   	ret    

000004b2 <write>:
SYSCALL(write)
     4b2:	b8 10 00 00 00       	mov    $0x10,%eax
     4b7:	cd 40                	int    $0x40
     4b9:	c3                   	ret    

000004ba <close>:
SYSCALL(close)
     4ba:	b8 15 00 00 00       	mov    $0x15,%eax
     4bf:	cd 40                	int    $0x40
     4c1:	c3                   	ret    

000004c2 <kill>:
SYSCALL(kill)
     4c2:	b8 06 00 00 00       	mov    $0x6,%eax
     4c7:	cd 40                	int    $0x40
     4c9:	c3                   	ret    

000004ca <exec>:
SYSCALL(exec)
     4ca:	b8 07 00 00 00       	mov    $0x7,%eax
     4cf:	cd 40                	int    $0x40
     4d1:	c3                   	ret    

000004d2 <open>:
SYSCALL(open)
     4d2:	b8 0f 00 00 00       	mov    $0xf,%eax
     4d7:	cd 40                	int    $0x40
     4d9:	c3                   	ret    

000004da <mknod>:
SYSCALL(mknod)
     4da:	b8 11 00 00 00       	mov    $0x11,%eax
     4df:	cd 40                	int    $0x40
     4e1:	c3                   	ret    

000004e2 <unlink>:
SYSCALL(unlink)
     4e2:	b8 12 00 00 00       	mov    $0x12,%eax
     4e7:	cd 40                	int    $0x40
     4e9:	c3                   	ret    

000004ea <fstat>:
SYSCALL(fstat)
     4ea:	b8 08 00 00 00       	mov    $0x8,%eax
     4ef:	cd 40                	int    $0x40
     4f1:	c3                   	ret    

000004f2 <link>:
SYSCALL(link)
     4f2:	b8 13 00 00 00       	mov    $0x13,%eax
     4f7:	cd 40                	int    $0x40
     4f9:	c3                   	ret    

000004fa <mkdir>:
SYSCALL(mkdir)
     4fa:	b8 14 00 00 00       	mov    $0x14,%eax
     4ff:	cd 40                	int    $0x40
     501:	c3                   	ret    

00000502 <chdir>:
SYSCALL(chdir)
     502:	b8 09 00 00 00       	mov    $0x9,%eax
     507:	cd 40                	int    $0x40
     509:	c3                   	ret    

0000050a <dup>:
SYSCALL(dup)
     50a:	b8 0a 00 00 00       	mov    $0xa,%eax
     50f:	cd 40                	int    $0x40
     511:	c3                   	ret    

00000512 <getpid>:
SYSCALL(getpid)
     512:	b8 0b 00 00 00       	mov    $0xb,%eax
     517:	cd 40                	int    $0x40
     519:	c3                   	ret    

0000051a <sbrk>:
SYSCALL(sbrk)
     51a:	b8 0c 00 00 00       	mov    $0xc,%eax
     51f:	cd 40                	int    $0x40
     521:	c3                   	ret    

00000522 <sleep>:
SYSCALL(sleep)
     522:	b8 0d 00 00 00       	mov    $0xd,%eax
     527:	cd 40                	int    $0x40
     529:	c3                   	ret    

0000052a <uptime>:
SYSCALL(uptime)
     52a:	b8 0e 00 00 00       	mov    $0xe,%eax
     52f:	cd 40                	int    $0x40
     531:	c3                   	ret    

00000532 <paintWindow>:

SYSCALL(paintWindow)
     532:	b8 16 00 00 00       	mov    $0x16,%eax
     537:	cd 40                	int    $0x40
     539:	c3                   	ret    

0000053a <initStringFigure>:
SYSCALL(initStringFigure)
     53a:	b8 17 00 00 00       	mov    $0x17,%eax
     53f:	cd 40                	int    $0x40
     541:	c3                   	ret    

00000542 <sendMessage>:
SYSCALL(sendMessage)
     542:	b8 18 00 00 00       	mov    $0x18,%eax
     547:	cd 40                	int    $0x40
     549:	c3                   	ret    

0000054a <getMessage>:
SYSCALL(getMessage)
     54a:	b8 1a 00 00 00       	mov    $0x1a,%eax
     54f:	cd 40                	int    $0x40
     551:	c3                   	ret    

00000552 <registWindow>:
SYSCALL(registWindow)
     552:	b8 19 00 00 00       	mov    $0x19,%eax
     557:	cd 40                	int    $0x40
     559:	c3                   	ret    

0000055a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     55a:	55                   	push   %ebp
     55b:	89 e5                	mov    %esp,%ebp
     55d:	83 ec 18             	sub    $0x18,%esp
     560:	8b 45 0c             	mov    0xc(%ebp),%eax
     563:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     566:	83 ec 04             	sub    $0x4,%esp
     569:	6a 01                	push   $0x1
     56b:	8d 45 f4             	lea    -0xc(%ebp),%eax
     56e:	50                   	push   %eax
     56f:	ff 75 08             	pushl  0x8(%ebp)
     572:	e8 3b ff ff ff       	call   4b2 <write>
     577:	83 c4 10             	add    $0x10,%esp
}
     57a:	90                   	nop
     57b:	c9                   	leave  
     57c:	c3                   	ret    

0000057d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     57d:	55                   	push   %ebp
     57e:	89 e5                	mov    %esp,%ebp
     580:	53                   	push   %ebx
     581:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     584:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     58b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     58f:	74 17                	je     5a8 <printint+0x2b>
     591:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     595:	79 11                	jns    5a8 <printint+0x2b>
    neg = 1;
     597:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     59e:	8b 45 0c             	mov    0xc(%ebp),%eax
     5a1:	f7 d8                	neg    %eax
     5a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
     5a6:	eb 06                	jmp    5ae <printint+0x31>
  } else {
    x = xx;
     5a8:	8b 45 0c             	mov    0xc(%ebp),%eax
     5ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     5ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     5b5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     5b8:	8d 41 01             	lea    0x1(%ecx),%eax
     5bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
     5be:	8b 5d 10             	mov    0x10(%ebp),%ebx
     5c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     5c4:	ba 00 00 00 00       	mov    $0x0,%edx
     5c9:	f7 f3                	div    %ebx
     5cb:	89 d0                	mov    %edx,%eax
     5cd:	0f b6 80 a0 2c 00 00 	movzbl 0x2ca0(%eax),%eax
     5d4:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     5d8:	8b 5d 10             	mov    0x10(%ebp),%ebx
     5db:	8b 45 ec             	mov    -0x14(%ebp),%eax
     5de:	ba 00 00 00 00       	mov    $0x0,%edx
     5e3:	f7 f3                	div    %ebx
     5e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
     5e8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     5ec:	75 c7                	jne    5b5 <printint+0x38>
  if(neg)
     5ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     5f2:	74 2d                	je     621 <printint+0xa4>
    buf[i++] = '-';
     5f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5f7:	8d 50 01             	lea    0x1(%eax),%edx
     5fa:	89 55 f4             	mov    %edx,-0xc(%ebp)
     5fd:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     602:	eb 1d                	jmp    621 <printint+0xa4>
    putc(fd, buf[i]);
     604:	8d 55 dc             	lea    -0x24(%ebp),%edx
     607:	8b 45 f4             	mov    -0xc(%ebp),%eax
     60a:	01 d0                	add    %edx,%eax
     60c:	0f b6 00             	movzbl (%eax),%eax
     60f:	0f be c0             	movsbl %al,%eax
     612:	83 ec 08             	sub    $0x8,%esp
     615:	50                   	push   %eax
     616:	ff 75 08             	pushl  0x8(%ebp)
     619:	e8 3c ff ff ff       	call   55a <putc>
     61e:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     621:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     625:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     629:	79 d9                	jns    604 <printint+0x87>
    putc(fd, buf[i]);
}
     62b:	90                   	nop
     62c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     62f:	c9                   	leave  
     630:	c3                   	ret    

00000631 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     631:	55                   	push   %ebp
     632:	89 e5                	mov    %esp,%ebp
     634:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     637:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     63e:	8d 45 0c             	lea    0xc(%ebp),%eax
     641:	83 c0 04             	add    $0x4,%eax
     644:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     647:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     64e:	e9 59 01 00 00       	jmp    7ac <printf+0x17b>
    c = fmt[i] & 0xff;
     653:	8b 55 0c             	mov    0xc(%ebp),%edx
     656:	8b 45 f0             	mov    -0x10(%ebp),%eax
     659:	01 d0                	add    %edx,%eax
     65b:	0f b6 00             	movzbl (%eax),%eax
     65e:	0f be c0             	movsbl %al,%eax
     661:	25 ff 00 00 00       	and    $0xff,%eax
     666:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     669:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     66d:	75 2c                	jne    69b <printf+0x6a>
      if(c == '%'){
     66f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     673:	75 0c                	jne    681 <printf+0x50>
        state = '%';
     675:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     67c:	e9 27 01 00 00       	jmp    7a8 <printf+0x177>
      } else {
        putc(fd, c);
     681:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     684:	0f be c0             	movsbl %al,%eax
     687:	83 ec 08             	sub    $0x8,%esp
     68a:	50                   	push   %eax
     68b:	ff 75 08             	pushl  0x8(%ebp)
     68e:	e8 c7 fe ff ff       	call   55a <putc>
     693:	83 c4 10             	add    $0x10,%esp
     696:	e9 0d 01 00 00       	jmp    7a8 <printf+0x177>
      }
    } else if(state == '%'){
     69b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     69f:	0f 85 03 01 00 00    	jne    7a8 <printf+0x177>
      if(c == 'd'){
     6a5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     6a9:	75 1e                	jne    6c9 <printf+0x98>
        printint(fd, *ap, 10, 1);
     6ab:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6ae:	8b 00                	mov    (%eax),%eax
     6b0:	6a 01                	push   $0x1
     6b2:	6a 0a                	push   $0xa
     6b4:	50                   	push   %eax
     6b5:	ff 75 08             	pushl  0x8(%ebp)
     6b8:	e8 c0 fe ff ff       	call   57d <printint>
     6bd:	83 c4 10             	add    $0x10,%esp
        ap++;
     6c0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     6c4:	e9 d8 00 00 00       	jmp    7a1 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     6c9:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     6cd:	74 06                	je     6d5 <printf+0xa4>
     6cf:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     6d3:	75 1e                	jne    6f3 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     6d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6d8:	8b 00                	mov    (%eax),%eax
     6da:	6a 00                	push   $0x0
     6dc:	6a 10                	push   $0x10
     6de:	50                   	push   %eax
     6df:	ff 75 08             	pushl  0x8(%ebp)
     6e2:	e8 96 fe ff ff       	call   57d <printint>
     6e7:	83 c4 10             	add    $0x10,%esp
        ap++;
     6ea:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     6ee:	e9 ae 00 00 00       	jmp    7a1 <printf+0x170>
      } else if(c == 's'){
     6f3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     6f7:	75 43                	jne    73c <printf+0x10b>
        s = (char*)*ap;
     6f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6fc:	8b 00                	mov    (%eax),%eax
     6fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     701:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     705:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     709:	75 25                	jne    730 <printf+0xff>
          s = "(null)";
     70b:	c7 45 f4 ed 22 00 00 	movl   $0x22ed,-0xc(%ebp)
        while(*s != 0){
     712:	eb 1c                	jmp    730 <printf+0xff>
          putc(fd, *s);
     714:	8b 45 f4             	mov    -0xc(%ebp),%eax
     717:	0f b6 00             	movzbl (%eax),%eax
     71a:	0f be c0             	movsbl %al,%eax
     71d:	83 ec 08             	sub    $0x8,%esp
     720:	50                   	push   %eax
     721:	ff 75 08             	pushl  0x8(%ebp)
     724:	e8 31 fe ff ff       	call   55a <putc>
     729:	83 c4 10             	add    $0x10,%esp
          s++;
     72c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     730:	8b 45 f4             	mov    -0xc(%ebp),%eax
     733:	0f b6 00             	movzbl (%eax),%eax
     736:	84 c0                	test   %al,%al
     738:	75 da                	jne    714 <printf+0xe3>
     73a:	eb 65                	jmp    7a1 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     73c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     740:	75 1d                	jne    75f <printf+0x12e>
        putc(fd, *ap);
     742:	8b 45 e8             	mov    -0x18(%ebp),%eax
     745:	8b 00                	mov    (%eax),%eax
     747:	0f be c0             	movsbl %al,%eax
     74a:	83 ec 08             	sub    $0x8,%esp
     74d:	50                   	push   %eax
     74e:	ff 75 08             	pushl  0x8(%ebp)
     751:	e8 04 fe ff ff       	call   55a <putc>
     756:	83 c4 10             	add    $0x10,%esp
        ap++;
     759:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     75d:	eb 42                	jmp    7a1 <printf+0x170>
      } else if(c == '%'){
     75f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     763:	75 17                	jne    77c <printf+0x14b>
        putc(fd, c);
     765:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     768:	0f be c0             	movsbl %al,%eax
     76b:	83 ec 08             	sub    $0x8,%esp
     76e:	50                   	push   %eax
     76f:	ff 75 08             	pushl  0x8(%ebp)
     772:	e8 e3 fd ff ff       	call   55a <putc>
     777:	83 c4 10             	add    $0x10,%esp
     77a:	eb 25                	jmp    7a1 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     77c:	83 ec 08             	sub    $0x8,%esp
     77f:	6a 25                	push   $0x25
     781:	ff 75 08             	pushl  0x8(%ebp)
     784:	e8 d1 fd ff ff       	call   55a <putc>
     789:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     78c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     78f:	0f be c0             	movsbl %al,%eax
     792:	83 ec 08             	sub    $0x8,%esp
     795:	50                   	push   %eax
     796:	ff 75 08             	pushl  0x8(%ebp)
     799:	e8 bc fd ff ff       	call   55a <putc>
     79e:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     7a1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     7a8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     7ac:	8b 55 0c             	mov    0xc(%ebp),%edx
     7af:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7b2:	01 d0                	add    %edx,%eax
     7b4:	0f b6 00             	movzbl (%eax),%eax
     7b7:	84 c0                	test   %al,%al
     7b9:	0f 85 94 fe ff ff    	jne    653 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     7bf:	90                   	nop
     7c0:	c9                   	leave  
     7c1:	c3                   	ret    

000007c2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     7c2:	55                   	push   %ebp
     7c3:	89 e5                	mov    %esp,%ebp
     7c5:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     7c8:	8b 45 08             	mov    0x8(%ebp),%eax
     7cb:	83 e8 08             	sub    $0x8,%eax
     7ce:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     7d1:	a1 d0 2c 00 00       	mov    0x2cd0,%eax
     7d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
     7d9:	eb 24                	jmp    7ff <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     7db:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7de:	8b 00                	mov    (%eax),%eax
     7e0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     7e3:	77 12                	ja     7f7 <free+0x35>
     7e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7e8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     7eb:	77 24                	ja     811 <free+0x4f>
     7ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7f0:	8b 00                	mov    (%eax),%eax
     7f2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     7f5:	77 1a                	ja     811 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     7f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7fa:	8b 00                	mov    (%eax),%eax
     7fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
     7ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
     802:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     805:	76 d4                	jbe    7db <free+0x19>
     807:	8b 45 fc             	mov    -0x4(%ebp),%eax
     80a:	8b 00                	mov    (%eax),%eax
     80c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     80f:	76 ca                	jbe    7db <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     811:	8b 45 f8             	mov    -0x8(%ebp),%eax
     814:	8b 40 04             	mov    0x4(%eax),%eax
     817:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     81e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     821:	01 c2                	add    %eax,%edx
     823:	8b 45 fc             	mov    -0x4(%ebp),%eax
     826:	8b 00                	mov    (%eax),%eax
     828:	39 c2                	cmp    %eax,%edx
     82a:	75 24                	jne    850 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     82c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     82f:	8b 50 04             	mov    0x4(%eax),%edx
     832:	8b 45 fc             	mov    -0x4(%ebp),%eax
     835:	8b 00                	mov    (%eax),%eax
     837:	8b 40 04             	mov    0x4(%eax),%eax
     83a:	01 c2                	add    %eax,%edx
     83c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     83f:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     842:	8b 45 fc             	mov    -0x4(%ebp),%eax
     845:	8b 00                	mov    (%eax),%eax
     847:	8b 10                	mov    (%eax),%edx
     849:	8b 45 f8             	mov    -0x8(%ebp),%eax
     84c:	89 10                	mov    %edx,(%eax)
     84e:	eb 0a                	jmp    85a <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     850:	8b 45 fc             	mov    -0x4(%ebp),%eax
     853:	8b 10                	mov    (%eax),%edx
     855:	8b 45 f8             	mov    -0x8(%ebp),%eax
     858:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     85a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     85d:	8b 40 04             	mov    0x4(%eax),%eax
     860:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     867:	8b 45 fc             	mov    -0x4(%ebp),%eax
     86a:	01 d0                	add    %edx,%eax
     86c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     86f:	75 20                	jne    891 <free+0xcf>
    p->s.size += bp->s.size;
     871:	8b 45 fc             	mov    -0x4(%ebp),%eax
     874:	8b 50 04             	mov    0x4(%eax),%edx
     877:	8b 45 f8             	mov    -0x8(%ebp),%eax
     87a:	8b 40 04             	mov    0x4(%eax),%eax
     87d:	01 c2                	add    %eax,%edx
     87f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     882:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     885:	8b 45 f8             	mov    -0x8(%ebp),%eax
     888:	8b 10                	mov    (%eax),%edx
     88a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     88d:	89 10                	mov    %edx,(%eax)
     88f:	eb 08                	jmp    899 <free+0xd7>
  } else
    p->s.ptr = bp;
     891:	8b 45 fc             	mov    -0x4(%ebp),%eax
     894:	8b 55 f8             	mov    -0x8(%ebp),%edx
     897:	89 10                	mov    %edx,(%eax)
  freep = p;
     899:	8b 45 fc             	mov    -0x4(%ebp),%eax
     89c:	a3 d0 2c 00 00       	mov    %eax,0x2cd0
}
     8a1:	90                   	nop
     8a2:	c9                   	leave  
     8a3:	c3                   	ret    

000008a4 <morecore>:

static Header*
morecore(uint nu)
{
     8a4:	55                   	push   %ebp
     8a5:	89 e5                	mov    %esp,%ebp
     8a7:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     8aa:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     8b1:	77 07                	ja     8ba <morecore+0x16>
    nu = 4096;
     8b3:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     8ba:	8b 45 08             	mov    0x8(%ebp),%eax
     8bd:	c1 e0 03             	shl    $0x3,%eax
     8c0:	83 ec 0c             	sub    $0xc,%esp
     8c3:	50                   	push   %eax
     8c4:	e8 51 fc ff ff       	call   51a <sbrk>
     8c9:	83 c4 10             	add    $0x10,%esp
     8cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     8cf:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     8d3:	75 07                	jne    8dc <morecore+0x38>
    return 0;
     8d5:	b8 00 00 00 00       	mov    $0x0,%eax
     8da:	eb 26                	jmp    902 <morecore+0x5e>
  hp = (Header*)p;
     8dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     8e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8e5:	8b 55 08             	mov    0x8(%ebp),%edx
     8e8:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     8eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8ee:	83 c0 08             	add    $0x8,%eax
     8f1:	83 ec 0c             	sub    $0xc,%esp
     8f4:	50                   	push   %eax
     8f5:	e8 c8 fe ff ff       	call   7c2 <free>
     8fa:	83 c4 10             	add    $0x10,%esp
  return freep;
     8fd:	a1 d0 2c 00 00       	mov    0x2cd0,%eax
}
     902:	c9                   	leave  
     903:	c3                   	ret    

00000904 <malloc>:

void*
malloc(uint nbytes)
{
     904:	55                   	push   %ebp
     905:	89 e5                	mov    %esp,%ebp
     907:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     90a:	8b 45 08             	mov    0x8(%ebp),%eax
     90d:	83 c0 07             	add    $0x7,%eax
     910:	c1 e8 03             	shr    $0x3,%eax
     913:	83 c0 01             	add    $0x1,%eax
     916:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     919:	a1 d0 2c 00 00       	mov    0x2cd0,%eax
     91e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     921:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     925:	75 23                	jne    94a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     927:	c7 45 f0 c8 2c 00 00 	movl   $0x2cc8,-0x10(%ebp)
     92e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     931:	a3 d0 2c 00 00       	mov    %eax,0x2cd0
     936:	a1 d0 2c 00 00       	mov    0x2cd0,%eax
     93b:	a3 c8 2c 00 00       	mov    %eax,0x2cc8
    base.s.size = 0;
     940:	c7 05 cc 2c 00 00 00 	movl   $0x0,0x2ccc
     947:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     94a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     94d:	8b 00                	mov    (%eax),%eax
     94f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     952:	8b 45 f4             	mov    -0xc(%ebp),%eax
     955:	8b 40 04             	mov    0x4(%eax),%eax
     958:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     95b:	72 4d                	jb     9aa <malloc+0xa6>
      if(p->s.size == nunits)
     95d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     960:	8b 40 04             	mov    0x4(%eax),%eax
     963:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     966:	75 0c                	jne    974 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     968:	8b 45 f4             	mov    -0xc(%ebp),%eax
     96b:	8b 10                	mov    (%eax),%edx
     96d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     970:	89 10                	mov    %edx,(%eax)
     972:	eb 26                	jmp    99a <malloc+0x96>
      else {
        p->s.size -= nunits;
     974:	8b 45 f4             	mov    -0xc(%ebp),%eax
     977:	8b 40 04             	mov    0x4(%eax),%eax
     97a:	2b 45 ec             	sub    -0x14(%ebp),%eax
     97d:	89 c2                	mov    %eax,%edx
     97f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     982:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     985:	8b 45 f4             	mov    -0xc(%ebp),%eax
     988:	8b 40 04             	mov    0x4(%eax),%eax
     98b:	c1 e0 03             	shl    $0x3,%eax
     98e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     991:	8b 45 f4             	mov    -0xc(%ebp),%eax
     994:	8b 55 ec             	mov    -0x14(%ebp),%edx
     997:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     99a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     99d:	a3 d0 2c 00 00       	mov    %eax,0x2cd0
      return (void*)(p + 1);
     9a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9a5:	83 c0 08             	add    $0x8,%eax
     9a8:	eb 3b                	jmp    9e5 <malloc+0xe1>
    }
    if(p == freep)
     9aa:	a1 d0 2c 00 00       	mov    0x2cd0,%eax
     9af:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     9b2:	75 1e                	jne    9d2 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     9b4:	83 ec 0c             	sub    $0xc,%esp
     9b7:	ff 75 ec             	pushl  -0x14(%ebp)
     9ba:	e8 e5 fe ff ff       	call   8a4 <morecore>
     9bf:	83 c4 10             	add    $0x10,%esp
     9c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
     9c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     9c9:	75 07                	jne    9d2 <malloc+0xce>
        return 0;
     9cb:	b8 00 00 00 00       	mov    $0x0,%eax
     9d0:	eb 13                	jmp    9e5 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     9d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     9d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9db:	8b 00                	mov    (%eax),%eax
     9dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     9e0:	e9 6d ff ff ff       	jmp    952 <malloc+0x4e>
}
     9e5:	c9                   	leave  
     9e6:	c3                   	ret    

000009e7 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     9e7:	55                   	push   %ebp
     9e8:	89 e5                	mov    %esp,%ebp
     9ea:	83 ec 1c             	sub    $0x1c,%esp
     9ed:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     9f0:	8b 55 10             	mov    0x10(%ebp),%edx
     9f3:	8b 45 14             	mov    0x14(%ebp),%eax
     9f6:	88 4d ec             	mov    %cl,-0x14(%ebp)
     9f9:	88 55 e8             	mov    %dl,-0x18(%ebp)
     9fc:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     9ff:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     a03:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     a06:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     a0a:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     a0d:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     a11:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     a14:	8b 45 08             	mov    0x8(%ebp),%eax
     a17:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     a1b:	66 89 10             	mov    %dx,(%eax)
     a1e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     a22:	88 50 02             	mov    %dl,0x2(%eax)
}
     a25:	8b 45 08             	mov    0x8(%ebp),%eax
     a28:	c9                   	leave  
     a29:	c2 04 00             	ret    $0x4

00000a2c <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     a2c:	55                   	push   %ebp
     a2d:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     a2f:	8b 45 08             	mov    0x8(%ebp),%eax
     a32:	2b 45 10             	sub    0x10(%ebp),%eax
     a35:	89 c2                	mov    %eax,%edx
     a37:	8b 45 08             	mov    0x8(%ebp),%eax
     a3a:	2b 45 10             	sub    0x10(%ebp),%eax
     a3d:	0f af d0             	imul   %eax,%edx
     a40:	8b 45 0c             	mov    0xc(%ebp),%eax
     a43:	2b 45 14             	sub    0x14(%ebp),%eax
     a46:	89 c1                	mov    %eax,%ecx
     a48:	8b 45 0c             	mov    0xc(%ebp),%eax
     a4b:	2b 45 14             	sub    0x14(%ebp),%eax
     a4e:	0f af c1             	imul   %ecx,%eax
     a51:	01 d0                	add    %edx,%eax
}
     a53:	5d                   	pop    %ebp
     a54:	c3                   	ret    

00000a55 <abs_int>:

static inline int abs_int(int x)
{
     a55:	55                   	push   %ebp
     a56:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     a58:	8b 45 08             	mov    0x8(%ebp),%eax
     a5b:	99                   	cltd   
     a5c:	89 d0                	mov    %edx,%eax
     a5e:	33 45 08             	xor    0x8(%ebp),%eax
     a61:	29 d0                	sub    %edx,%eax
}
     a63:	5d                   	pop    %ebp
     a64:	c3                   	ret    

00000a65 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     a65:	55                   	push   %ebp
     a66:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     a68:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     a6c:	79 07                	jns    a75 <APGetIndex+0x10>
        return X_SMALLER;
     a6e:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     a73:	eb 40                	jmp    ab5 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     a75:	8b 45 08             	mov    0x8(%ebp),%eax
     a78:	8b 00                	mov    (%eax),%eax
     a7a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     a7d:	7f 07                	jg     a86 <APGetIndex+0x21>
        return X_BIGGER;
     a7f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a84:	eb 2f                	jmp    ab5 <APGetIndex+0x50>
    if (y < 0)
     a86:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     a8a:	79 07                	jns    a93 <APGetIndex+0x2e>
        return Y_SMALLER;
     a8c:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     a91:	eb 22                	jmp    ab5 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     a93:	8b 45 08             	mov    0x8(%ebp),%eax
     a96:	8b 40 04             	mov    0x4(%eax),%eax
     a99:	3b 45 10             	cmp    0x10(%ebp),%eax
     a9c:	7f 07                	jg     aa5 <APGetIndex+0x40>
        return Y_BIGGER;
     a9e:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     aa3:	eb 10                	jmp    ab5 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     aa5:	8b 45 08             	mov    0x8(%ebp),%eax
     aa8:	8b 00                	mov    (%eax),%eax
     aaa:	0f af 45 10          	imul   0x10(%ebp),%eax
     aae:	89 c2                	mov    %eax,%edx
     ab0:	8b 45 0c             	mov    0xc(%ebp),%eax
     ab3:	01 d0                	add    %edx,%eax
}
     ab5:	5d                   	pop    %ebp
     ab6:	c3                   	ret    

00000ab7 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     ab7:	55                   	push   %ebp
     ab8:	89 e5                	mov    %esp,%ebp
     aba:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     abd:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     ac4:	8b 45 cc             	mov    -0x34(%ebp),%eax
     ac7:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     aca:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     ad1:	83 ec 08             	sub    $0x8,%esp
     ad4:	6a 00                	push   $0x0
     ad6:	ff 75 0c             	pushl  0xc(%ebp)
     ad9:	e8 f4 f9 ff ff       	call   4d2 <open>
     ade:	83 c4 10             	add    $0x10,%esp
     ae1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     ae4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ae8:	79 2e                	jns    b18 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     aea:	83 ec 04             	sub    $0x4,%esp
     aed:	ff 75 0c             	pushl  0xc(%ebp)
     af0:	68 f4 22 00 00       	push   $0x22f4
     af5:	6a 01                	push   $0x1
     af7:	e8 35 fb ff ff       	call   631 <printf>
     afc:	83 c4 10             	add    $0x10,%esp
        return bmp;
     aff:	8b 45 08             	mov    0x8(%ebp),%eax
     b02:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b05:	89 10                	mov    %edx,(%eax)
     b07:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b0a:	89 50 04             	mov    %edx,0x4(%eax)
     b0d:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b10:	89 50 08             	mov    %edx,0x8(%eax)
     b13:	e9 d2 01 00 00       	jmp    cea <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     b18:	83 ec 04             	sub    $0x4,%esp
     b1b:	6a 0e                	push   $0xe
     b1d:	8d 45 ba             	lea    -0x46(%ebp),%eax
     b20:	50                   	push   %eax
     b21:	ff 75 ec             	pushl  -0x14(%ebp)
     b24:	e8 81 f9 ff ff       	call   4aa <read>
     b29:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     b2c:	83 ec 04             	sub    $0x4,%esp
     b2f:	6a 28                	push   $0x28
     b31:	8d 45 92             	lea    -0x6e(%ebp),%eax
     b34:	50                   	push   %eax
     b35:	ff 75 ec             	pushl  -0x14(%ebp)
     b38:	e8 6d f9 ff ff       	call   4aa <read>
     b3d:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     b40:	8b 45 96             	mov    -0x6a(%ebp),%eax
     b43:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     b46:	8b 45 9a             	mov    -0x66(%ebp),%eax
     b49:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     b4c:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b4f:	8b 45 cc             	mov    -0x34(%ebp),%eax
     b52:	0f af d0             	imul   %eax,%edx
     b55:	89 d0                	mov    %edx,%eax
     b57:	01 c0                	add    %eax,%eax
     b59:	01 d0                	add    %edx,%eax
     b5b:	83 ec 0c             	sub    $0xc,%esp
     b5e:	50                   	push   %eax
     b5f:	e8 a0 fd ff ff       	call   904 <malloc>
     b64:	83 c4 10             	add    $0x10,%esp
     b67:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     b6a:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     b6e:	0f b7 c0             	movzwl %ax,%eax
     b71:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     b74:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b77:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b7a:	0f af c2             	imul   %edx,%eax
     b7d:	83 c0 1f             	add    $0x1f,%eax
     b80:	c1 e8 05             	shr    $0x5,%eax
     b83:	c1 e0 02             	shl    $0x2,%eax
     b86:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     b89:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b8c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b8f:	0f af c2             	imul   %edx,%eax
     b92:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     b95:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b98:	83 ec 0c             	sub    $0xc,%esp
     b9b:	50                   	push   %eax
     b9c:	e8 63 fd ff ff       	call   904 <malloc>
     ba1:	83 c4 10             	add    $0x10,%esp
     ba4:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     ba7:	83 ec 04             	sub    $0x4,%esp
     baa:	ff 75 e0             	pushl  -0x20(%ebp)
     bad:	ff 75 dc             	pushl  -0x24(%ebp)
     bb0:	ff 75 ec             	pushl  -0x14(%ebp)
     bb3:	e8 f2 f8 ff ff       	call   4aa <read>
     bb8:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     bbb:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     bbf:	66 c1 e8 03          	shr    $0x3,%ax
     bc3:	0f b7 c0             	movzwl %ax,%eax
     bc6:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     bc9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     bd0:	e9 e5 00 00 00       	jmp    cba <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     bd5:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bdb:	29 c2                	sub    %eax,%edx
     bdd:	89 d0                	mov    %edx,%eax
     bdf:	8d 50 ff             	lea    -0x1(%eax),%edx
     be2:	8b 45 c8             	mov    -0x38(%ebp),%eax
     be5:	0f af c2             	imul   %edx,%eax
     be8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     beb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     bf2:	e9 b1 00 00 00       	jmp    ca8 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     bf7:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bfa:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     bfd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c00:	01 c8                	add    %ecx,%eax
     c02:	89 c1                	mov    %eax,%ecx
     c04:	89 c8                	mov    %ecx,%eax
     c06:	01 c0                	add    %eax,%eax
     c08:	01 c8                	add    %ecx,%eax
     c0a:	01 c2                	add    %eax,%edx
     c0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c0f:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     c13:	89 c1                	mov    %eax,%ecx
     c15:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c18:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     c1c:	01 c1                	add    %eax,%ecx
     c1e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c21:	01 c8                	add    %ecx,%eax
     c23:	8d 48 ff             	lea    -0x1(%eax),%ecx
     c26:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c29:	01 c8                	add    %ecx,%eax
     c2b:	0f b6 00             	movzbl (%eax),%eax
     c2e:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     c31:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c34:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     c37:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c3a:	01 c8                	add    %ecx,%eax
     c3c:	89 c1                	mov    %eax,%ecx
     c3e:	89 c8                	mov    %ecx,%eax
     c40:	01 c0                	add    %eax,%eax
     c42:	01 c8                	add    %ecx,%eax
     c44:	01 c2                	add    %eax,%edx
     c46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c49:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     c4d:	89 c1                	mov    %eax,%ecx
     c4f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c52:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     c56:	01 c1                	add    %eax,%ecx
     c58:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c5b:	01 c8                	add    %ecx,%eax
     c5d:	8d 48 fe             	lea    -0x2(%eax),%ecx
     c60:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c63:	01 c8                	add    %ecx,%eax
     c65:	0f b6 00             	movzbl (%eax),%eax
     c68:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     c6b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c6e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     c71:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c74:	01 c8                	add    %ecx,%eax
     c76:	89 c1                	mov    %eax,%ecx
     c78:	89 c8                	mov    %ecx,%eax
     c7a:	01 c0                	add    %eax,%eax
     c7c:	01 c8                	add    %ecx,%eax
     c7e:	01 c2                	add    %eax,%edx
     c80:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c83:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     c87:	89 c1                	mov    %eax,%ecx
     c89:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c8c:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     c90:	01 c1                	add    %eax,%ecx
     c92:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c95:	01 c8                	add    %ecx,%eax
     c97:	8d 48 fd             	lea    -0x3(%eax),%ecx
     c9a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c9d:	01 c8                	add    %ecx,%eax
     c9f:	0f b6 00             	movzbl (%eax),%eax
     ca2:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     ca4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ca8:	8b 55 c8             	mov    -0x38(%ebp),%edx
     cab:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cae:	39 c2                	cmp    %eax,%edx
     cb0:	0f 87 41 ff ff ff    	ja     bf7 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     cb6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     cba:	8b 55 cc             	mov    -0x34(%ebp),%edx
     cbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc0:	39 c2                	cmp    %eax,%edx
     cc2:	0f 87 0d ff ff ff    	ja     bd5 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     cc8:	83 ec 0c             	sub    $0xc,%esp
     ccb:	ff 75 ec             	pushl  -0x14(%ebp)
     cce:	e8 e7 f7 ff ff       	call   4ba <close>
     cd3:	83 c4 10             	add    $0x10,%esp
    return bmp;
     cd6:	8b 45 08             	mov    0x8(%ebp),%eax
     cd9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     cdc:	89 10                	mov    %edx,(%eax)
     cde:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ce1:	89 50 04             	mov    %edx,0x4(%eax)
     ce4:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ce7:	89 50 08             	mov    %edx,0x8(%eax)
}
     cea:	8b 45 08             	mov    0x8(%ebp),%eax
     ced:	c9                   	leave  
     cee:	c2 04 00             	ret    $0x4

00000cf1 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     cf1:	55                   	push   %ebp
     cf2:	89 e5                	mov    %esp,%ebp
     cf4:	53                   	push   %ebx
     cf5:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     cf8:	83 ec 0c             	sub    $0xc,%esp
     cfb:	6a 1c                	push   $0x1c
     cfd:	e8 02 fc ff ff       	call   904 <malloc>
     d02:	83 c4 10             	add    $0x10,%esp
     d05:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     d08:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d0b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     d12:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     d15:	8d 45 d8             	lea    -0x28(%ebp),%eax
     d18:	6a 0c                	push   $0xc
     d1a:	6a 0c                	push   $0xc
     d1c:	6a 0c                	push   $0xc
     d1e:	50                   	push   %eax
     d1f:	e8 c3 fc ff ff       	call   9e7 <RGB>
     d24:	83 c4 0c             	add    $0xc,%esp
     d27:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     d2b:	66 89 43 13          	mov    %ax,0x13(%ebx)
     d2f:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     d33:	88 43 15             	mov    %al,0x15(%ebx)
     d36:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d39:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d3c:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     d40:	66 89 48 10          	mov    %cx,0x10(%eax)
     d44:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     d48:	88 50 12             	mov    %dl,0x12(%eax)
     d4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d51:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     d55:	66 89 48 08          	mov    %cx,0x8(%eax)
     d59:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     d5d:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     d60:	8b 45 08             	mov    0x8(%ebp),%eax
     d63:	89 c2                	mov    %eax,%edx
     d65:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d68:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     d6a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d6d:	89 c2                	mov    %eax,%edx
     d6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d72:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     d75:	8b 55 10             	mov    0x10(%ebp),%edx
     d78:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d7b:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     d7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     d81:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d84:	c9                   	leave  
     d85:	c3                   	ret    

00000d86 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     d86:	55                   	push   %ebp
     d87:	89 e5                	mov    %esp,%ebp
     d89:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     d8c:	8b 45 0c             	mov    0xc(%ebp),%eax
     d8f:	8b 50 08             	mov    0x8(%eax),%edx
     d92:	89 55 f8             	mov    %edx,-0x8(%ebp)
     d95:	8b 40 0c             	mov    0xc(%eax),%eax
     d98:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     d9b:	8b 45 0c             	mov    0xc(%ebp),%eax
     d9e:	8b 55 10             	mov    0x10(%ebp),%edx
     da1:	89 50 08             	mov    %edx,0x8(%eax)
     da4:	8b 55 14             	mov    0x14(%ebp),%edx
     da7:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     daa:	8b 45 08             	mov    0x8(%ebp),%eax
     dad:	8b 55 f8             	mov    -0x8(%ebp),%edx
     db0:	89 10                	mov    %edx,(%eax)
     db2:	8b 55 fc             	mov    -0x4(%ebp),%edx
     db5:	89 50 04             	mov    %edx,0x4(%eax)
}
     db8:	8b 45 08             	mov    0x8(%ebp),%eax
     dbb:	c9                   	leave  
     dbc:	c2 04 00             	ret    $0x4

00000dbf <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     dbf:	55                   	push   %ebp
     dc0:	89 e5                	mov    %esp,%ebp
     dc2:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     dc5:	8b 45 0c             	mov    0xc(%ebp),%eax
     dc8:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     dcc:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     dd0:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     dd4:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
     dda:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     dde:	66 89 50 10          	mov    %dx,0x10(%eax)
     de2:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     de6:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     de9:	8b 45 08             	mov    0x8(%ebp),%eax
     dec:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     df0:	66 89 10             	mov    %dx,(%eax)
     df3:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     df7:	88 50 02             	mov    %dl,0x2(%eax)
}
     dfa:	8b 45 08             	mov    0x8(%ebp),%eax
     dfd:	c9                   	leave  
     dfe:	c2 04 00             	ret    $0x4

00000e01 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     e01:	55                   	push   %ebp
     e02:	89 e5                	mov    %esp,%ebp
     e04:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     e07:	8b 45 08             	mov    0x8(%ebp),%eax
     e0a:	8b 40 0c             	mov    0xc(%eax),%eax
     e0d:	89 c2                	mov    %eax,%edx
     e0f:	c1 ea 1f             	shr    $0x1f,%edx
     e12:	01 d0                	add    %edx,%eax
     e14:	d1 f8                	sar    %eax
     e16:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     e19:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e1c:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     e20:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     e23:	8b 45 10             	mov    0x10(%ebp),%eax
     e26:	2b 45 f4             	sub    -0xc(%ebp),%eax
     e29:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     e2c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     e30:	0f 89 98 00 00 00    	jns    ece <APDrawPoint+0xcd>
        i = 0;
     e36:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     e3d:	e9 8c 00 00 00       	jmp    ece <APDrawPoint+0xcd>
    {
        j = x - off;
     e42:	8b 45 0c             	mov    0xc(%ebp),%eax
     e45:	2b 45 f4             	sub    -0xc(%ebp),%eax
     e48:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     e4b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     e4f:	79 69                	jns    eba <APDrawPoint+0xb9>
            j = 0;
     e51:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     e58:	eb 60                	jmp    eba <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     e5a:	ff 75 fc             	pushl  -0x4(%ebp)
     e5d:	ff 75 f8             	pushl  -0x8(%ebp)
     e60:	ff 75 08             	pushl  0x8(%ebp)
     e63:	e8 fd fb ff ff       	call   a65 <APGetIndex>
     e68:	83 c4 0c             	add    $0xc,%esp
     e6b:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     e6e:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     e72:	74 55                	je     ec9 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     e74:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     e78:	74 67                	je     ee1 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     e7a:	ff 75 10             	pushl  0x10(%ebp)
     e7d:	ff 75 0c             	pushl  0xc(%ebp)
     e80:	ff 75 fc             	pushl  -0x4(%ebp)
     e83:	ff 75 f8             	pushl  -0x8(%ebp)
     e86:	e8 a1 fb ff ff       	call   a2c <distance_2>
     e8b:	83 c4 10             	add    $0x10,%esp
     e8e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     e91:	7f 23                	jg     eb6 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     e93:	8b 45 08             	mov    0x8(%ebp),%eax
     e96:	8b 48 18             	mov    0x18(%eax),%ecx
     e99:	8b 55 ec             	mov    -0x14(%ebp),%edx
     e9c:	89 d0                	mov    %edx,%eax
     e9e:	01 c0                	add    %eax,%eax
     ea0:	01 d0                	add    %edx,%eax
     ea2:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     ea5:	8b 45 08             	mov    0x8(%ebp),%eax
     ea8:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     eac:	66 89 0a             	mov    %cx,(%edx)
     eaf:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     eb3:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     eb6:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     eba:	8b 55 0c             	mov    0xc(%ebp),%edx
     ebd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ec0:	01 d0                	add    %edx,%eax
     ec2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     ec5:	7d 93                	jge    e5a <APDrawPoint+0x59>
     ec7:	eb 01                	jmp    eca <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     ec9:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     eca:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     ece:	8b 55 10             	mov    0x10(%ebp),%edx
     ed1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ed4:	01 d0                	add    %edx,%eax
     ed6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     ed9:	0f 8d 63 ff ff ff    	jge    e42 <APDrawPoint+0x41>
     edf:	eb 01                	jmp    ee2 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     ee1:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     ee2:	c9                   	leave  
     ee3:	c3                   	ret    

00000ee4 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     ee4:	55                   	push   %ebp
     ee5:	89 e5                	mov    %esp,%ebp
     ee7:	53                   	push   %ebx
     ee8:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     eeb:	8b 45 0c             	mov    0xc(%ebp),%eax
     eee:	3b 45 14             	cmp    0x14(%ebp),%eax
     ef1:	0f 85 80 00 00 00    	jne    f77 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     ef7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     efb:	0f 88 9d 02 00 00    	js     119e <APDrawLine+0x2ba>
     f01:	8b 45 08             	mov    0x8(%ebp),%eax
     f04:	8b 00                	mov    (%eax),%eax
     f06:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f09:	0f 8e 8f 02 00 00    	jle    119e <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     f0f:	8b 45 10             	mov    0x10(%ebp),%eax
     f12:	3b 45 18             	cmp    0x18(%ebp),%eax
     f15:	7e 12                	jle    f29 <APDrawLine+0x45>
        {
            int tmp = y2;
     f17:	8b 45 18             	mov    0x18(%ebp),%eax
     f1a:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     f1d:	8b 45 10             	mov    0x10(%ebp),%eax
     f20:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     f23:	8b 45 dc             	mov    -0x24(%ebp),%eax
     f26:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     f29:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     f2d:	79 07                	jns    f36 <APDrawLine+0x52>
     f2f:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     f36:	8b 45 08             	mov    0x8(%ebp),%eax
     f39:	8b 40 04             	mov    0x4(%eax),%eax
     f3c:	3b 45 18             	cmp    0x18(%ebp),%eax
     f3f:	7d 0c                	jge    f4d <APDrawLine+0x69>
     f41:	8b 45 08             	mov    0x8(%ebp),%eax
     f44:	8b 40 04             	mov    0x4(%eax),%eax
     f47:	83 e8 01             	sub    $0x1,%eax
     f4a:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     f4d:	8b 45 10             	mov    0x10(%ebp),%eax
     f50:	89 45 f4             	mov    %eax,-0xc(%ebp)
     f53:	eb 15                	jmp    f6a <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     f55:	ff 75 f4             	pushl  -0xc(%ebp)
     f58:	ff 75 0c             	pushl  0xc(%ebp)
     f5b:	ff 75 08             	pushl  0x8(%ebp)
     f5e:	e8 9e fe ff ff       	call   e01 <APDrawPoint>
     f63:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     f66:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f6d:	3b 45 18             	cmp    0x18(%ebp),%eax
     f70:	7e e3                	jle    f55 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     f72:	e9 2b 02 00 00       	jmp    11a2 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     f77:	8b 45 10             	mov    0x10(%ebp),%eax
     f7a:	3b 45 18             	cmp    0x18(%ebp),%eax
     f7d:	75 7f                	jne    ffe <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     f7f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     f83:	0f 88 18 02 00 00    	js     11a1 <APDrawLine+0x2bd>
     f89:	8b 45 08             	mov    0x8(%ebp),%eax
     f8c:	8b 40 04             	mov    0x4(%eax),%eax
     f8f:	3b 45 10             	cmp    0x10(%ebp),%eax
     f92:	0f 8e 09 02 00 00    	jle    11a1 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     f98:	8b 45 0c             	mov    0xc(%ebp),%eax
     f9b:	3b 45 14             	cmp    0x14(%ebp),%eax
     f9e:	7e 12                	jle    fb2 <APDrawLine+0xce>
        {
            int tmp = x2;
     fa0:	8b 45 14             	mov    0x14(%ebp),%eax
     fa3:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     fa6:	8b 45 0c             	mov    0xc(%ebp),%eax
     fa9:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     fac:	8b 45 d8             	mov    -0x28(%ebp),%eax
     faf:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     fb2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     fb6:	79 07                	jns    fbf <APDrawLine+0xdb>
     fb8:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     fbf:	8b 45 08             	mov    0x8(%ebp),%eax
     fc2:	8b 00                	mov    (%eax),%eax
     fc4:	3b 45 14             	cmp    0x14(%ebp),%eax
     fc7:	7d 0b                	jge    fd4 <APDrawLine+0xf0>
     fc9:	8b 45 08             	mov    0x8(%ebp),%eax
     fcc:	8b 00                	mov    (%eax),%eax
     fce:	83 e8 01             	sub    $0x1,%eax
     fd1:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     fd4:	8b 45 0c             	mov    0xc(%ebp),%eax
     fd7:	89 45 f0             	mov    %eax,-0x10(%ebp)
     fda:	eb 15                	jmp    ff1 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     fdc:	ff 75 10             	pushl  0x10(%ebp)
     fdf:	ff 75 f0             	pushl  -0x10(%ebp)
     fe2:	ff 75 08             	pushl  0x8(%ebp)
     fe5:	e8 17 fe ff ff       	call   e01 <APDrawPoint>
     fea:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     fed:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ff1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ff4:	3b 45 14             	cmp    0x14(%ebp),%eax
     ff7:	7e e3                	jle    fdc <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     ff9:	e9 a4 01 00 00       	jmp    11a2 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     ffe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1005:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    100c:	8b 45 0c             	mov    0xc(%ebp),%eax
    100f:	2b 45 14             	sub    0x14(%ebp),%eax
    1012:	50                   	push   %eax
    1013:	e8 3d fa ff ff       	call   a55 <abs_int>
    1018:	83 c4 04             	add    $0x4,%esp
    101b:	89 c3                	mov    %eax,%ebx
    101d:	8b 45 10             	mov    0x10(%ebp),%eax
    1020:	2b 45 18             	sub    0x18(%ebp),%eax
    1023:	50                   	push   %eax
    1024:	e8 2c fa ff ff       	call   a55 <abs_int>
    1029:	83 c4 04             	add    $0x4,%esp
    102c:	39 c3                	cmp    %eax,%ebx
    102e:	0f 8e b5 00 00 00    	jle    10e9 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1034:	8b 45 10             	mov    0x10(%ebp),%eax
    1037:	2b 45 18             	sub    0x18(%ebp),%eax
    103a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    103d:	db 45 b0             	fildl  -0x50(%ebp)
    1040:	8b 45 0c             	mov    0xc(%ebp),%eax
    1043:	2b 45 14             	sub    0x14(%ebp),%eax
    1046:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1049:	db 45 b0             	fildl  -0x50(%ebp)
    104c:	de f9                	fdivrp %st,%st(1)
    104e:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1051:	8b 45 14             	mov    0x14(%ebp),%eax
    1054:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1057:	7e 0e                	jle    1067 <APDrawLine+0x183>
        {
            s = x1;
    1059:	8b 45 0c             	mov    0xc(%ebp),%eax
    105c:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    105f:	8b 45 14             	mov    0x14(%ebp),%eax
    1062:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1065:	eb 0c                	jmp    1073 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1067:	8b 45 14             	mov    0x14(%ebp),%eax
    106a:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    106d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1070:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1073:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1077:	79 07                	jns    1080 <APDrawLine+0x19c>
    1079:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1080:	8b 45 08             	mov    0x8(%ebp),%eax
    1083:	8b 00                	mov    (%eax),%eax
    1085:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1088:	7f 0b                	jg     1095 <APDrawLine+0x1b1>
    108a:	8b 45 08             	mov    0x8(%ebp),%eax
    108d:	8b 00                	mov    (%eax),%eax
    108f:	83 e8 01             	sub    $0x1,%eax
    1092:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1095:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1098:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    109b:	eb 3f                	jmp    10dc <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    109d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10a0:	2b 45 0c             	sub    0xc(%ebp),%eax
    10a3:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10a6:	db 45 b0             	fildl  -0x50(%ebp)
    10a9:	dc 4d d0             	fmull  -0x30(%ebp)
    10ac:	db 45 10             	fildl  0x10(%ebp)
    10af:	de c1                	faddp  %st,%st(1)
    10b1:	d9 7d b6             	fnstcw -0x4a(%ebp)
    10b4:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    10b8:	b4 0c                	mov    $0xc,%ah
    10ba:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    10be:	d9 6d b4             	fldcw  -0x4c(%ebp)
    10c1:	db 5d cc             	fistpl -0x34(%ebp)
    10c4:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    10c7:	ff 75 cc             	pushl  -0x34(%ebp)
    10ca:	ff 75 e4             	pushl  -0x1c(%ebp)
    10cd:	ff 75 08             	pushl  0x8(%ebp)
    10d0:	e8 2c fd ff ff       	call   e01 <APDrawPoint>
    10d5:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    10d8:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    10dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10df:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10e2:	7e b9                	jle    109d <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    10e4:	e9 b9 00 00 00       	jmp    11a2 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    10e9:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ec:	2b 45 14             	sub    0x14(%ebp),%eax
    10ef:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10f2:	db 45 b0             	fildl  -0x50(%ebp)
    10f5:	8b 45 10             	mov    0x10(%ebp),%eax
    10f8:	2b 45 18             	sub    0x18(%ebp),%eax
    10fb:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10fe:	db 45 b0             	fildl  -0x50(%ebp)
    1101:	de f9                	fdivrp %st,%st(1)
    1103:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1106:	8b 45 10             	mov    0x10(%ebp),%eax
    1109:	3b 45 18             	cmp    0x18(%ebp),%eax
    110c:	7e 0e                	jle    111c <APDrawLine+0x238>
    {
        s = y2;
    110e:	8b 45 18             	mov    0x18(%ebp),%eax
    1111:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1114:	8b 45 10             	mov    0x10(%ebp),%eax
    1117:	89 45 e8             	mov    %eax,-0x18(%ebp)
    111a:	eb 0c                	jmp    1128 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    111c:	8b 45 10             	mov    0x10(%ebp),%eax
    111f:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1122:	8b 45 18             	mov    0x18(%ebp),%eax
    1125:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1128:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    112c:	79 07                	jns    1135 <APDrawLine+0x251>
    112e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1135:	8b 45 08             	mov    0x8(%ebp),%eax
    1138:	8b 40 04             	mov    0x4(%eax),%eax
    113b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    113e:	7f 0c                	jg     114c <APDrawLine+0x268>
    1140:	8b 45 08             	mov    0x8(%ebp),%eax
    1143:	8b 40 04             	mov    0x4(%eax),%eax
    1146:	83 e8 01             	sub    $0x1,%eax
    1149:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    114c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    114f:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1152:	eb 3f                	jmp    1193 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1154:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1157:	2b 45 10             	sub    0x10(%ebp),%eax
    115a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    115d:	db 45 b0             	fildl  -0x50(%ebp)
    1160:	dc 4d c0             	fmull  -0x40(%ebp)
    1163:	db 45 0c             	fildl  0xc(%ebp)
    1166:	de c1                	faddp  %st,%st(1)
    1168:	d9 7d b6             	fnstcw -0x4a(%ebp)
    116b:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    116f:	b4 0c                	mov    $0xc,%ah
    1171:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1175:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1178:	db 5d bc             	fistpl -0x44(%ebp)
    117b:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    117e:	ff 75 e0             	pushl  -0x20(%ebp)
    1181:	ff 75 bc             	pushl  -0x44(%ebp)
    1184:	ff 75 08             	pushl  0x8(%ebp)
    1187:	e8 75 fc ff ff       	call   e01 <APDrawPoint>
    118c:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    118f:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1193:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1196:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1199:	7e b9                	jle    1154 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    119b:	90                   	nop
    119c:	eb 04                	jmp    11a2 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    119e:	90                   	nop
    119f:	eb 01                	jmp    11a2 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    11a1:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    11a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11a5:	c9                   	leave  
    11a6:	c3                   	ret    

000011a7 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    11a7:	55                   	push   %ebp
    11a8:	89 e5                	mov    %esp,%ebp
    11aa:	53                   	push   %ebx
    11ab:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    11ae:	8b 55 10             	mov    0x10(%ebp),%edx
    11b1:	8b 45 18             	mov    0x18(%ebp),%eax
    11b4:	01 d0                	add    %edx,%eax
    11b6:	83 e8 01             	sub    $0x1,%eax
    11b9:	83 ec 04             	sub    $0x4,%esp
    11bc:	50                   	push   %eax
    11bd:	ff 75 0c             	pushl  0xc(%ebp)
    11c0:	ff 75 10             	pushl  0x10(%ebp)
    11c3:	ff 75 0c             	pushl  0xc(%ebp)
    11c6:	ff 75 08             	pushl  0x8(%ebp)
    11c9:	e8 16 fd ff ff       	call   ee4 <APDrawLine>
    11ce:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    11d1:	8b 55 0c             	mov    0xc(%ebp),%edx
    11d4:	8b 45 14             	mov    0x14(%ebp),%eax
    11d7:	01 d0                	add    %edx,%eax
    11d9:	83 e8 01             	sub    $0x1,%eax
    11dc:	83 ec 04             	sub    $0x4,%esp
    11df:	ff 75 10             	pushl  0x10(%ebp)
    11e2:	50                   	push   %eax
    11e3:	ff 75 10             	pushl  0x10(%ebp)
    11e6:	ff 75 0c             	pushl  0xc(%ebp)
    11e9:	ff 75 08             	pushl  0x8(%ebp)
    11ec:	e8 f3 fc ff ff       	call   ee4 <APDrawLine>
    11f1:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    11f4:	8b 55 10             	mov    0x10(%ebp),%edx
    11f7:	8b 45 18             	mov    0x18(%ebp),%eax
    11fa:	01 d0                	add    %edx,%eax
    11fc:	8d 48 ff             	lea    -0x1(%eax),%ecx
    11ff:	8b 55 0c             	mov    0xc(%ebp),%edx
    1202:	8b 45 14             	mov    0x14(%ebp),%eax
    1205:	01 d0                	add    %edx,%eax
    1207:	8d 50 ff             	lea    -0x1(%eax),%edx
    120a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    120d:	8b 45 14             	mov    0x14(%ebp),%eax
    1210:	01 d8                	add    %ebx,%eax
    1212:	83 e8 01             	sub    $0x1,%eax
    1215:	83 ec 04             	sub    $0x4,%esp
    1218:	51                   	push   %ecx
    1219:	52                   	push   %edx
    121a:	ff 75 10             	pushl  0x10(%ebp)
    121d:	50                   	push   %eax
    121e:	ff 75 08             	pushl  0x8(%ebp)
    1221:	e8 be fc ff ff       	call   ee4 <APDrawLine>
    1226:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1229:	8b 55 10             	mov    0x10(%ebp),%edx
    122c:	8b 45 18             	mov    0x18(%ebp),%eax
    122f:	01 d0                	add    %edx,%eax
    1231:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1234:	8b 55 0c             	mov    0xc(%ebp),%edx
    1237:	8b 45 14             	mov    0x14(%ebp),%eax
    123a:	01 d0                	add    %edx,%eax
    123c:	8d 50 ff             	lea    -0x1(%eax),%edx
    123f:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1242:	8b 45 18             	mov    0x18(%ebp),%eax
    1245:	01 d8                	add    %ebx,%eax
    1247:	83 e8 01             	sub    $0x1,%eax
    124a:	83 ec 04             	sub    $0x4,%esp
    124d:	51                   	push   %ecx
    124e:	52                   	push   %edx
    124f:	50                   	push   %eax
    1250:	ff 75 0c             	pushl  0xc(%ebp)
    1253:	ff 75 08             	pushl  0x8(%ebp)
    1256:	e8 89 fc ff ff       	call   ee4 <APDrawLine>
    125b:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    125e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1261:	8b 45 14             	mov    0x14(%ebp),%eax
    1264:	01 d0                	add    %edx,%eax
    1266:	8d 50 ff             	lea    -0x1(%eax),%edx
    1269:	8b 45 08             	mov    0x8(%ebp),%eax
    126c:	8b 40 0c             	mov    0xc(%eax),%eax
    126f:	89 c1                	mov    %eax,%ecx
    1271:	c1 e9 1f             	shr    $0x1f,%ecx
    1274:	01 c8                	add    %ecx,%eax
    1276:	d1 f8                	sar    %eax
    1278:	29 c2                	sub    %eax,%edx
    127a:	89 d0                	mov    %edx,%eax
    127c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    127f:	8b 55 10             	mov    0x10(%ebp),%edx
    1282:	8b 45 18             	mov    0x18(%ebp),%eax
    1285:	01 d0                	add    %edx,%eax
    1287:	8d 50 ff             	lea    -0x1(%eax),%edx
    128a:	8b 45 08             	mov    0x8(%ebp),%eax
    128d:	8b 40 0c             	mov    0xc(%eax),%eax
    1290:	89 c1                	mov    %eax,%ecx
    1292:	c1 e9 1f             	shr    $0x1f,%ecx
    1295:	01 c8                	add    %ecx,%eax
    1297:	d1 f8                	sar    %eax
    1299:	29 c2                	sub    %eax,%edx
    129b:	89 d0                	mov    %edx,%eax
    129d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    12a0:	8b 45 08             	mov    0x8(%ebp),%eax
    12a3:	8b 40 0c             	mov    0xc(%eax),%eax
    12a6:	89 c2                	mov    %eax,%edx
    12a8:	c1 ea 1f             	shr    $0x1f,%edx
    12ab:	01 d0                	add    %edx,%eax
    12ad:	d1 f8                	sar    %eax
    12af:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    12b2:	8b 45 08             	mov    0x8(%ebp),%eax
    12b5:	8b 40 0c             	mov    0xc(%eax),%eax
    12b8:	89 c2                	mov    %eax,%edx
    12ba:	c1 ea 1f             	shr    $0x1f,%edx
    12bd:	01 d0                	add    %edx,%eax
    12bf:	d1 f8                	sar    %eax
    12c1:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    12c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12c8:	0f 88 d8 00 00 00    	js     13a6 <APDrawRect+0x1ff>
    12ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    12d2:	0f 88 ce 00 00 00    	js     13a6 <APDrawRect+0x1ff>
    12d8:	8b 45 08             	mov    0x8(%ebp),%eax
    12db:	8b 00                	mov    (%eax),%eax
    12dd:	3b 45 0c             	cmp    0xc(%ebp),%eax
    12e0:	0f 8e c0 00 00 00    	jle    13a6 <APDrawRect+0x1ff>
    12e6:	8b 45 08             	mov    0x8(%ebp),%eax
    12e9:	8b 40 04             	mov    0x4(%eax),%eax
    12ec:	3b 45 10             	cmp    0x10(%ebp),%eax
    12ef:	0f 8e b1 00 00 00    	jle    13a6 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    12f5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    12f9:	79 07                	jns    1302 <APDrawRect+0x15b>
    12fb:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1302:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1306:	79 07                	jns    130f <APDrawRect+0x168>
    1308:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    130f:	8b 45 08             	mov    0x8(%ebp),%eax
    1312:	8b 00                	mov    (%eax),%eax
    1314:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1317:	7f 0b                	jg     1324 <APDrawRect+0x17d>
    1319:	8b 45 08             	mov    0x8(%ebp),%eax
    131c:	8b 00                	mov    (%eax),%eax
    131e:	83 e8 01             	sub    $0x1,%eax
    1321:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1324:	8b 45 08             	mov    0x8(%ebp),%eax
    1327:	8b 40 04             	mov    0x4(%eax),%eax
    132a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    132d:	7f 0c                	jg     133b <APDrawRect+0x194>
    132f:	8b 45 08             	mov    0x8(%ebp),%eax
    1332:	8b 40 04             	mov    0x4(%eax),%eax
    1335:	83 e8 01             	sub    $0x1,%eax
    1338:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    133b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1342:	8b 45 0c             	mov    0xc(%ebp),%eax
    1345:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1348:	eb 52                	jmp    139c <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    134a:	8b 45 10             	mov    0x10(%ebp),%eax
    134d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1350:	eb 3e                	jmp    1390 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1352:	83 ec 04             	sub    $0x4,%esp
    1355:	ff 75 e8             	pushl  -0x18(%ebp)
    1358:	ff 75 ec             	pushl  -0x14(%ebp)
    135b:	ff 75 08             	pushl  0x8(%ebp)
    135e:	e8 02 f7 ff ff       	call   a65 <APGetIndex>
    1363:	83 c4 10             	add    $0x10,%esp
    1366:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1369:	8b 45 08             	mov    0x8(%ebp),%eax
    136c:	8b 48 18             	mov    0x18(%eax),%ecx
    136f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1372:	89 d0                	mov    %edx,%eax
    1374:	01 c0                	add    %eax,%eax
    1376:	01 d0                	add    %edx,%eax
    1378:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    137b:	8b 45 08             	mov    0x8(%ebp),%eax
    137e:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1382:	66 89 0a             	mov    %cx,(%edx)
    1385:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1389:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    138c:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1390:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1393:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1396:	7e ba                	jle    1352 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1398:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    139c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    139f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    13a2:	7e a6                	jle    134a <APDrawRect+0x1a3>
    13a4:	eb 01                	jmp    13a7 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    13a6:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    13a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13aa:	c9                   	leave  
    13ab:	c3                   	ret    

000013ac <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    13ac:	55                   	push   %ebp
    13ad:	89 e5                	mov    %esp,%ebp
    13af:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    13b2:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    13b6:	0f 88 8e 01 00 00    	js     154a <APDcCopy+0x19e>
    13bc:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    13c0:	0f 88 84 01 00 00    	js     154a <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    13c6:	8b 55 0c             	mov    0xc(%ebp),%edx
    13c9:	8b 45 20             	mov    0x20(%ebp),%eax
    13cc:	01 d0                	add    %edx,%eax
    13ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
    13d1:	8b 55 10             	mov    0x10(%ebp),%edx
    13d4:	8b 45 24             	mov    0x24(%ebp),%eax
    13d7:	01 d0                	add    %edx,%eax
    13d9:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    13dc:	8b 55 18             	mov    0x18(%ebp),%edx
    13df:	8b 45 20             	mov    0x20(%ebp),%eax
    13e2:	01 d0                	add    %edx,%eax
    13e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13e7:	8b 55 1c             	mov    0x1c(%ebp),%edx
    13ea:	8b 45 24             	mov    0x24(%ebp),%eax
    13ed:	01 d0                	add    %edx,%eax
    13ef:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    13f2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13f6:	0f 88 51 01 00 00    	js     154d <APDcCopy+0x1a1>
    13fc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1400:	0f 88 47 01 00 00    	js     154d <APDcCopy+0x1a1>
    1406:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    140a:	0f 88 3d 01 00 00    	js     154d <APDcCopy+0x1a1>
    1410:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1414:	0f 88 33 01 00 00    	js     154d <APDcCopy+0x1a1>
    141a:	8b 45 14             	mov    0x14(%ebp),%eax
    141d:	8b 00                	mov    (%eax),%eax
    141f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1422:	0f 8c 25 01 00 00    	jl     154d <APDcCopy+0x1a1>
    1428:	8b 45 14             	mov    0x14(%ebp),%eax
    142b:	8b 40 04             	mov    0x4(%eax),%eax
    142e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1431:	0f 8c 16 01 00 00    	jl     154d <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1437:	8b 45 08             	mov    0x8(%ebp),%eax
    143a:	8b 00                	mov    (%eax),%eax
    143c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    143f:	7f 0b                	jg     144c <APDcCopy+0xa0>
    1441:	8b 45 08             	mov    0x8(%ebp),%eax
    1444:	8b 00                	mov    (%eax),%eax
    1446:	83 e8 01             	sub    $0x1,%eax
    1449:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    144c:	8b 45 08             	mov    0x8(%ebp),%eax
    144f:	8b 40 04             	mov    0x4(%eax),%eax
    1452:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1455:	7f 0c                	jg     1463 <APDcCopy+0xb7>
    1457:	8b 45 08             	mov    0x8(%ebp),%eax
    145a:	8b 40 04             	mov    0x4(%eax),%eax
    145d:	83 e8 01             	sub    $0x1,%eax
    1460:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1463:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    146a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1471:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1478:	e9 bc 00 00 00       	jmp    1539 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    147d:	8b 45 08             	mov    0x8(%ebp),%eax
    1480:	8b 00                	mov    (%eax),%eax
    1482:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1485:	8b 55 10             	mov    0x10(%ebp),%edx
    1488:	01 ca                	add    %ecx,%edx
    148a:	0f af d0             	imul   %eax,%edx
    148d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1490:	01 d0                	add    %edx,%eax
    1492:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1495:	8b 45 14             	mov    0x14(%ebp),%eax
    1498:	8b 00                	mov    (%eax),%eax
    149a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    149d:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14a0:	01 ca                	add    %ecx,%edx
    14a2:	0f af d0             	imul   %eax,%edx
    14a5:	8b 45 18             	mov    0x18(%ebp),%eax
    14a8:	01 d0                	add    %edx,%eax
    14aa:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    14ad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14b4:	eb 74                	jmp    152a <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    14b6:	8b 45 14             	mov    0x14(%ebp),%eax
    14b9:	8b 50 18             	mov    0x18(%eax),%edx
    14bc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    14bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14c2:	01 c8                	add    %ecx,%eax
    14c4:	89 c1                	mov    %eax,%ecx
    14c6:	89 c8                	mov    %ecx,%eax
    14c8:	01 c0                	add    %eax,%eax
    14ca:	01 c8                	add    %ecx,%eax
    14cc:	01 d0                	add    %edx,%eax
    14ce:	0f b7 10             	movzwl (%eax),%edx
    14d1:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    14d5:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    14d9:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    14dc:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    14e0:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    14e4:	38 c2                	cmp    %al,%dl
    14e6:	75 18                	jne    1500 <APDcCopy+0x154>
    14e8:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    14ec:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    14f0:	38 c2                	cmp    %al,%dl
    14f2:	75 0c                	jne    1500 <APDcCopy+0x154>
    14f4:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    14f8:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    14fc:	38 c2                	cmp    %al,%dl
    14fe:	74 26                	je     1526 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1500:	8b 45 08             	mov    0x8(%ebp),%eax
    1503:	8b 50 18             	mov    0x18(%eax),%edx
    1506:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1509:	8b 45 f0             	mov    -0x10(%ebp),%eax
    150c:	01 c8                	add    %ecx,%eax
    150e:	89 c1                	mov    %eax,%ecx
    1510:	89 c8                	mov    %ecx,%eax
    1512:	01 c0                	add    %eax,%eax
    1514:	01 c8                	add    %ecx,%eax
    1516:	01 d0                	add    %edx,%eax
    1518:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    151c:	66 89 10             	mov    %dx,(%eax)
    151f:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1523:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1526:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    152a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    152d:	2b 45 0c             	sub    0xc(%ebp),%eax
    1530:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1533:	7d 81                	jge    14b6 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1535:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1539:	8b 45 f8             	mov    -0x8(%ebp),%eax
    153c:	2b 45 10             	sub    0x10(%ebp),%eax
    153f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1542:	0f 8d 35 ff ff ff    	jge    147d <APDcCopy+0xd1>
    1548:	eb 04                	jmp    154e <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    154a:	90                   	nop
    154b:	eb 01                	jmp    154e <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    154d:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    154e:	c9                   	leave  
    154f:	c3                   	ret    

00001550 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1550:	55                   	push   %ebp
    1551:	89 e5                	mov    %esp,%ebp
    1553:	83 ec 1c             	sub    $0x1c,%esp
    1556:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1559:	8b 55 10             	mov    0x10(%ebp),%edx
    155c:	8b 45 14             	mov    0x14(%ebp),%eax
    155f:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1562:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1565:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1568:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    156c:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    156f:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1573:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1576:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    157a:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    157d:	8b 45 08             	mov    0x8(%ebp),%eax
    1580:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1584:	66 89 10             	mov    %dx,(%eax)
    1587:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    158b:	88 50 02             	mov    %dl,0x2(%eax)
}
    158e:	8b 45 08             	mov    0x8(%ebp),%eax
    1591:	c9                   	leave  
    1592:	c2 04 00             	ret    $0x4

00001595 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1595:	55                   	push   %ebp
    1596:	89 e5                	mov    %esp,%ebp
    1598:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    159b:	8b 45 08             	mov    0x8(%ebp),%eax
    159e:	8b 00                	mov    (%eax),%eax
    15a0:	83 ec 08             	sub    $0x8,%esp
    15a3:	8d 55 0c             	lea    0xc(%ebp),%edx
    15a6:	52                   	push   %edx
    15a7:	50                   	push   %eax
    15a8:	e8 95 ef ff ff       	call   542 <sendMessage>
    15ad:	83 c4 10             	add    $0x10,%esp
}
    15b0:	90                   	nop
    15b1:	c9                   	leave  
    15b2:	c3                   	ret    

000015b3 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    15b3:	55                   	push   %ebp
    15b4:	89 e5                	mov    %esp,%ebp
    15b6:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    15b9:	83 ec 0c             	sub    $0xc,%esp
    15bc:	68 90 00 00 00       	push   $0x90
    15c1:	e8 3e f3 ff ff       	call   904 <malloc>
    15c6:	83 c4 10             	add    $0x10,%esp
    15c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    15cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15d0:	75 15                	jne    15e7 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    15d2:	83 ec 04             	sub    $0x4,%esp
    15d5:	ff 75 08             	pushl  0x8(%ebp)
    15d8:	68 04 23 00 00       	push   $0x2304
    15dd:	6a 01                	push   $0x1
    15df:	e8 4d f0 ff ff       	call   631 <printf>
    15e4:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    15e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ea:	83 c0 7c             	add    $0x7c,%eax
    15ed:	83 ec 08             	sub    $0x8,%esp
    15f0:	ff 75 08             	pushl  0x8(%ebp)
    15f3:	50                   	push   %eax
    15f4:	e8 68 ec ff ff       	call   261 <strcpy>
    15f9:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    15fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ff:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1606:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1609:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1610:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1613:	8b 40 34             	mov    0x34(%eax),%eax
    1616:	89 c2                	mov    %eax,%edx
    1618:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161b:	8b 40 38             	mov    0x38(%eax),%eax
    161e:	0f af d0             	imul   %eax,%edx
    1621:	89 d0                	mov    %edx,%eax
    1623:	01 c0                	add    %eax,%eax
    1625:	01 d0                	add    %edx,%eax
    1627:	83 ec 0c             	sub    $0xc,%esp
    162a:	50                   	push   %eax
    162b:	e8 d4 f2 ff ff       	call   904 <malloc>
    1630:	83 c4 10             	add    $0x10,%esp
    1633:	89 c2                	mov    %eax,%edx
    1635:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1638:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    163b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163e:	8b 40 4c             	mov    0x4c(%eax),%eax
    1641:	85 c0                	test   %eax,%eax
    1643:	75 15                	jne    165a <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1645:	83 ec 04             	sub    $0x4,%esp
    1648:	ff 75 08             	pushl  0x8(%ebp)
    164b:	68 24 23 00 00       	push   $0x2324
    1650:	6a 01                	push   $0x1
    1652:	e8 da ef ff ff       	call   631 <printf>
    1657:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    165a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165d:	8b 40 34             	mov    0x34(%eax),%eax
    1660:	89 c2                	mov    %eax,%edx
    1662:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1665:	8b 40 38             	mov    0x38(%eax),%eax
    1668:	0f af d0             	imul   %eax,%edx
    166b:	89 d0                	mov    %edx,%eax
    166d:	01 c0                	add    %eax,%eax
    166f:	01 c2                	add    %eax,%edx
    1671:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1674:	8b 40 4c             	mov    0x4c(%eax),%eax
    1677:	83 ec 04             	sub    $0x4,%esp
    167a:	52                   	push   %edx
    167b:	68 ff ff ff 00       	push   $0xffffff
    1680:	50                   	push   %eax
    1681:	e8 71 ec ff ff       	call   2f7 <memset>
    1686:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1689:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168c:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    1693:	e8 7a ee ff ff       	call   512 <getpid>
    1698:	89 c2                	mov    %eax,%edx
    169a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169d:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    16a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a3:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    16aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ad:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    16b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b7:	8b 40 50             	mov    0x50(%eax),%eax
    16ba:	89 c2                	mov    %eax,%edx
    16bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16bf:	8b 40 54             	mov    0x54(%eax),%eax
    16c2:	0f af d0             	imul   %eax,%edx
    16c5:	89 d0                	mov    %edx,%eax
    16c7:	01 c0                	add    %eax,%eax
    16c9:	01 d0                	add    %edx,%eax
    16cb:	83 ec 0c             	sub    $0xc,%esp
    16ce:	50                   	push   %eax
    16cf:	e8 30 f2 ff ff       	call   904 <malloc>
    16d4:	83 c4 10             	add    $0x10,%esp
    16d7:	89 c2                	mov    %eax,%edx
    16d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16dc:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    16df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e2:	8b 40 68             	mov    0x68(%eax),%eax
    16e5:	85 c0                	test   %eax,%eax
    16e7:	75 15                	jne    16fe <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    16e9:	83 ec 04             	sub    $0x4,%esp
    16ec:	ff 75 08             	pushl  0x8(%ebp)
    16ef:	68 48 23 00 00       	push   $0x2348
    16f4:	6a 01                	push   $0x1
    16f6:	e8 36 ef ff ff       	call   631 <printf>
    16fb:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    16fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1701:	8b 40 34             	mov    0x34(%eax),%eax
    1704:	89 c2                	mov    %eax,%edx
    1706:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1709:	8b 40 38             	mov    0x38(%eax),%eax
    170c:	0f af d0             	imul   %eax,%edx
    170f:	89 d0                	mov    %edx,%eax
    1711:	01 c0                	add    %eax,%eax
    1713:	01 c2                	add    %eax,%edx
    1715:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1718:	8b 40 4c             	mov    0x4c(%eax),%eax
    171b:	83 ec 04             	sub    $0x4,%esp
    171e:	52                   	push   %edx
    171f:	68 ff 00 00 00       	push   $0xff
    1724:	50                   	push   %eax
    1725:	e8 cd eb ff ff       	call   2f7 <memset>
    172a:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    172d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1730:	8b 55 0c             	mov    0xc(%ebp),%edx
    1733:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1736:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    173a:	74 35                	je     1771 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    173c:	8b 45 10             	mov    0x10(%ebp),%eax
    173f:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1745:	83 ec 0c             	sub    $0xc,%esp
    1748:	50                   	push   %eax
    1749:	e8 b6 f1 ff ff       	call   904 <malloc>
    174e:	83 c4 10             	add    $0x10,%esp
    1751:	89 c2                	mov    %eax,%edx
    1753:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1756:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1759:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175c:	8b 55 10             	mov    0x10(%ebp),%edx
    175f:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1762:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1765:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    176c:	e9 8d 00 00 00       	jmp    17fe <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1771:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1774:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    177b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177e:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1785:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1788:	8b 40 18             	mov    0x18(%eax),%eax
    178b:	89 c2                	mov    %eax,%edx
    178d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1790:	8b 40 1c             	mov    0x1c(%eax),%eax
    1793:	0f af d0             	imul   %eax,%edx
    1796:	89 d0                	mov    %edx,%eax
    1798:	01 c0                	add    %eax,%eax
    179a:	01 d0                	add    %edx,%eax
    179c:	83 ec 0c             	sub    $0xc,%esp
    179f:	50                   	push   %eax
    17a0:	e8 5f f1 ff ff       	call   904 <malloc>
    17a5:	83 c4 10             	add    $0x10,%esp
    17a8:	89 c2                	mov    %eax,%edx
    17aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ad:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    17b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b3:	8b 40 30             	mov    0x30(%eax),%eax
    17b6:	85 c0                	test   %eax,%eax
    17b8:	75 15                	jne    17cf <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    17ba:	83 ec 04             	sub    $0x4,%esp
    17bd:	ff 75 08             	pushl  0x8(%ebp)
    17c0:	68 70 23 00 00       	push   $0x2370
    17c5:	6a 01                	push   $0x1
    17c7:	e8 65 ee ff ff       	call   631 <printf>
    17cc:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    17cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d2:	8b 40 18             	mov    0x18(%eax),%eax
    17d5:	89 c2                	mov    %eax,%edx
    17d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17da:	8b 40 1c             	mov    0x1c(%eax),%eax
    17dd:	0f af d0             	imul   %eax,%edx
    17e0:	89 d0                	mov    %edx,%eax
    17e2:	01 c0                	add    %eax,%eax
    17e4:	01 c2                	add    %eax,%edx
    17e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e9:	8b 40 30             	mov    0x30(%eax),%eax
    17ec:	83 ec 04             	sub    $0x4,%esp
    17ef:	52                   	push   %edx
    17f0:	68 ff ff ff 00       	push   $0xffffff
    17f5:	50                   	push   %eax
    17f6:	e8 fc ea ff ff       	call   2f7 <memset>
    17fb:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    17fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1801:	c9                   	leave  
    1802:	c3                   	ret    

00001803 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1803:	55                   	push   %ebp
    1804:	89 e5                	mov    %esp,%ebp
    1806:	53                   	push   %ebx
    1807:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    180a:	8b 45 0c             	mov    0xc(%ebp),%eax
    180d:	83 f8 03             	cmp    $0x3,%eax
    1810:	74 02                	je     1814 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1812:	eb 33                	jmp    1847 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1814:	8b 45 08             	mov    0x8(%ebp),%eax
    1817:	8b 48 08             	mov    0x8(%eax),%ecx
    181a:	8b 45 08             	mov    0x8(%ebp),%eax
    181d:	8b 50 38             	mov    0x38(%eax),%edx
    1820:	8b 45 08             	mov    0x8(%ebp),%eax
    1823:	8b 40 34             	mov    0x34(%eax),%eax
    1826:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1829:	83 c3 34             	add    $0x34,%ebx
    182c:	83 ec 0c             	sub    $0xc,%esp
    182f:	51                   	push   %ecx
    1830:	52                   	push   %edx
    1831:	50                   	push   %eax
    1832:	6a 00                	push   $0x0
    1834:	6a 00                	push   $0x0
    1836:	53                   	push   %ebx
    1837:	6a 32                	push   $0x32
    1839:	6a 00                	push   $0x0
    183b:	ff 75 08             	pushl  0x8(%ebp)
    183e:	e8 ef ec ff ff       	call   532 <paintWindow>
    1843:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1846:	90                   	nop
        default: break;
            
            
    }
    return False;
    1847:	b8 00 00 00 00       	mov    $0x0,%eax
}
    184c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    184f:	c9                   	leave  
    1850:	c3                   	ret    

00001851 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1851:	55                   	push   %ebp
    1852:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1854:	8b 45 0c             	mov    0xc(%ebp),%eax
    1857:	8b 50 08             	mov    0x8(%eax),%edx
    185a:	8b 45 08             	mov    0x8(%ebp),%eax
    185d:	8b 00                	mov    (%eax),%eax
    185f:	39 c2                	cmp    %eax,%edx
    1861:	74 07                	je     186a <APPreJudge+0x19>
        return False;
    1863:	b8 00 00 00 00       	mov    $0x0,%eax
    1868:	eb 05                	jmp    186f <APPreJudge+0x1e>
    return True;
    186a:	b8 01 00 00 00       	mov    $0x1,%eax
}
    186f:	5d                   	pop    %ebp
    1870:	c3                   	ret    

00001871 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1871:	55                   	push   %ebp
    1872:	89 e5                	mov    %esp,%ebp
    1874:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1877:	8b 45 08             	mov    0x8(%ebp),%eax
    187a:	8b 55 0c             	mov    0xc(%ebp),%edx
    187d:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    1880:	83 ec 0c             	sub    $0xc,%esp
    1883:	ff 75 08             	pushl  0x8(%ebp)
    1886:	e8 c7 ec ff ff       	call   552 <registWindow>
    188b:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    188e:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1895:	8b 45 08             	mov    0x8(%ebp),%eax
    1898:	8b 00                	mov    (%eax),%eax
    189a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    189d:	ff 75 f4             	pushl  -0xc(%ebp)
    18a0:	ff 75 f0             	pushl  -0x10(%ebp)
    18a3:	ff 75 ec             	pushl  -0x14(%ebp)
    18a6:	ff 75 08             	pushl  0x8(%ebp)
    18a9:	e8 e7 fc ff ff       	call   1595 <APSendMessage>
    18ae:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    18b1:	83 ec 0c             	sub    $0xc,%esp
    18b4:	ff 75 08             	pushl  0x8(%ebp)
    18b7:	e8 8e ec ff ff       	call   54a <getMessage>
    18bc:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    18bf:	8b 45 08             	mov    0x8(%ebp),%eax
    18c2:	83 c0 6c             	add    $0x6c,%eax
    18c5:	83 ec 08             	sub    $0x8,%esp
    18c8:	50                   	push   %eax
    18c9:	ff 75 08             	pushl  0x8(%ebp)
    18cc:	e8 80 ff ff ff       	call   1851 <APPreJudge>
    18d1:	83 c4 10             	add    $0x10,%esp
    18d4:	84 c0                	test   %al,%al
    18d6:	74 1b                	je     18f3 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    18d8:	8b 45 08             	mov    0x8(%ebp),%eax
    18db:	ff 70 74             	pushl  0x74(%eax)
    18de:	ff 70 70             	pushl  0x70(%eax)
    18e1:	ff 70 6c             	pushl  0x6c(%eax)
    18e4:	ff 75 08             	pushl  0x8(%ebp)
    18e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    18ea:	ff d0                	call   *%eax
    18ec:	83 c4 10             	add    $0x10,%esp
    18ef:	84 c0                	test   %al,%al
    18f1:	75 0c                	jne    18ff <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    18f3:	8b 45 08             	mov    0x8(%ebp),%eax
    18f6:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    18fd:	eb b2                	jmp    18b1 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    18ff:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1900:	90                   	nop
    1901:	c9                   	leave  
    1902:	c3                   	ret    

00001903 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1903:	55                   	push   %ebp
    1904:	89 e5                	mov    %esp,%ebp
    1906:	57                   	push   %edi
    1907:	56                   	push   %esi
    1908:	53                   	push   %ebx
    1909:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    190c:	a1 d4 2c 00 00       	mov    0x2cd4,%eax
    1911:	85 c0                	test   %eax,%eax
    1913:	0f 85 2c 02 00 00    	jne    1b45 <APGridPaint+0x242>
    {
        iconReady = 1;
    1919:	c7 05 d4 2c 00 00 01 	movl   $0x1,0x2cd4
    1920:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1923:	8d 45 98             	lea    -0x68(%ebp),%eax
    1926:	83 ec 08             	sub    $0x8,%esp
    1929:	68 97 23 00 00       	push   $0x2397
    192e:	50                   	push   %eax
    192f:	e8 83 f1 ff ff       	call   ab7 <APLoadBitmap>
    1934:	83 c4 0c             	add    $0xc,%esp
    1937:	8b 45 98             	mov    -0x68(%ebp),%eax
    193a:	a3 f8 2c 00 00       	mov    %eax,0x2cf8
    193f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1942:	a3 fc 2c 00 00       	mov    %eax,0x2cfc
    1947:	8b 45 a0             	mov    -0x60(%ebp),%eax
    194a:	a3 00 2d 00 00       	mov    %eax,0x2d00
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    194f:	83 ec 04             	sub    $0x4,%esp
    1952:	ff 35 00 2d 00 00    	pushl  0x2d00
    1958:	ff 35 fc 2c 00 00    	pushl  0x2cfc
    195e:	ff 35 f8 2c 00 00    	pushl  0x2cf8
    1964:	e8 88 f3 ff ff       	call   cf1 <APCreateCompatibleDCFromBitmap>
    1969:	83 c4 10             	add    $0x10,%esp
    196c:	a3 04 2d 00 00       	mov    %eax,0x2d04
        grid_river = APLoadBitmap ("grid_river.bmp");
    1971:	8d 45 98             	lea    -0x68(%ebp),%eax
    1974:	83 ec 08             	sub    $0x8,%esp
    1977:	68 a5 23 00 00       	push   $0x23a5
    197c:	50                   	push   %eax
    197d:	e8 35 f1 ff ff       	call   ab7 <APLoadBitmap>
    1982:	83 c4 0c             	add    $0xc,%esp
    1985:	8b 45 98             	mov    -0x68(%ebp),%eax
    1988:	a3 34 2d 00 00       	mov    %eax,0x2d34
    198d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1990:	a3 38 2d 00 00       	mov    %eax,0x2d38
    1995:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1998:	a3 3c 2d 00 00       	mov    %eax,0x2d3c
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    199d:	83 ec 04             	sub    $0x4,%esp
    19a0:	ff 35 3c 2d 00 00    	pushl  0x2d3c
    19a6:	ff 35 38 2d 00 00    	pushl  0x2d38
    19ac:	ff 35 34 2d 00 00    	pushl  0x2d34
    19b2:	e8 3a f3 ff ff       	call   cf1 <APCreateCompatibleDCFromBitmap>
    19b7:	83 c4 10             	add    $0x10,%esp
    19ba:	a3 24 2d 00 00       	mov    %eax,0x2d24
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    19bf:	8d 45 98             	lea    -0x68(%ebp),%eax
    19c2:	83 ec 08             	sub    $0x8,%esp
    19c5:	68 b4 23 00 00       	push   $0x23b4
    19ca:	50                   	push   %eax
    19cb:	e8 e7 f0 ff ff       	call   ab7 <APLoadBitmap>
    19d0:	83 c4 0c             	add    $0xc,%esp
    19d3:	8b 45 98             	mov    -0x68(%ebp),%eax
    19d6:	a3 28 2d 00 00       	mov    %eax,0x2d28
    19db:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19de:	a3 2c 2d 00 00       	mov    %eax,0x2d2c
    19e3:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19e6:	a3 30 2d 00 00       	mov    %eax,0x2d30
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    19eb:	83 ec 04             	sub    $0x4,%esp
    19ee:	ff 35 30 2d 00 00    	pushl  0x2d30
    19f4:	ff 35 2c 2d 00 00    	pushl  0x2d2c
    19fa:	ff 35 28 2d 00 00    	pushl  0x2d28
    1a00:	e8 ec f2 ff ff       	call   cf1 <APCreateCompatibleDCFromBitmap>
    1a05:	83 c4 10             	add    $0x10,%esp
    1a08:	a3 d8 2c 00 00       	mov    %eax,0x2cd8
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1a0d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a10:	83 ec 08             	sub    $0x8,%esp
    1a13:	68 c3 23 00 00       	push   $0x23c3
    1a18:	50                   	push   %eax
    1a19:	e8 99 f0 ff ff       	call   ab7 <APLoadBitmap>
    1a1e:	83 c4 0c             	add    $0xc,%esp
    1a21:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a24:	a3 0c 2d 00 00       	mov    %eax,0x2d0c
    1a29:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a2c:	a3 10 2d 00 00       	mov    %eax,0x2d10
    1a31:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a34:	a3 14 2d 00 00       	mov    %eax,0x2d14
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1a39:	83 ec 04             	sub    $0x4,%esp
    1a3c:	ff 35 14 2d 00 00    	pushl  0x2d14
    1a42:	ff 35 10 2d 00 00    	pushl  0x2d10
    1a48:	ff 35 0c 2d 00 00    	pushl  0x2d0c
    1a4e:	e8 9e f2 ff ff       	call   cf1 <APCreateCompatibleDCFromBitmap>
    1a53:	83 c4 10             	add    $0x10,%esp
    1a56:	a3 40 2d 00 00       	mov    %eax,0x2d40
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1a5b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a5e:	83 ec 08             	sub    $0x8,%esp
    1a61:	68 d1 23 00 00       	push   $0x23d1
    1a66:	50                   	push   %eax
    1a67:	e8 4b f0 ff ff       	call   ab7 <APLoadBitmap>
    1a6c:	83 c4 0c             	add    $0xc,%esp
    1a6f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a72:	a3 e8 2c 00 00       	mov    %eax,0x2ce8
    1a77:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a7a:	a3 ec 2c 00 00       	mov    %eax,0x2cec
    1a7f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a82:	a3 f0 2c 00 00       	mov    %eax,0x2cf0
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1a87:	83 ec 04             	sub    $0x4,%esp
    1a8a:	ff 35 f0 2c 00 00    	pushl  0x2cf0
    1a90:	ff 35 ec 2c 00 00    	pushl  0x2cec
    1a96:	ff 35 e8 2c 00 00    	pushl  0x2ce8
    1a9c:	e8 50 f2 ff ff       	call   cf1 <APCreateCompatibleDCFromBitmap>
    1aa1:	83 c4 10             	add    $0x10,%esp
    1aa4:	a3 08 2d 00 00       	mov    %eax,0x2d08
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1aa9:	8d 45 98             	lea    -0x68(%ebp),%eax
    1aac:	83 ec 08             	sub    $0x8,%esp
    1aaf:	68 e1 23 00 00       	push   $0x23e1
    1ab4:	50                   	push   %eax
    1ab5:	e8 fd ef ff ff       	call   ab7 <APLoadBitmap>
    1aba:	83 c4 0c             	add    $0xc,%esp
    1abd:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ac0:	a3 dc 2c 00 00       	mov    %eax,0x2cdc
    1ac5:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1ac8:	a3 e0 2c 00 00       	mov    %eax,0x2ce0
    1acd:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ad0:	a3 e4 2c 00 00       	mov    %eax,0x2ce4
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1ad5:	83 ec 04             	sub    $0x4,%esp
    1ad8:	ff 35 e4 2c 00 00    	pushl  0x2ce4
    1ade:	ff 35 e0 2c 00 00    	pushl  0x2ce0
    1ae4:	ff 35 dc 2c 00 00    	pushl  0x2cdc
    1aea:	e8 02 f2 ff ff       	call   cf1 <APCreateCompatibleDCFromBitmap>
    1aef:	83 c4 10             	add    $0x10,%esp
    1af2:	a3 f4 2c 00 00       	mov    %eax,0x2cf4
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1af7:	8d 45 98             	lea    -0x68(%ebp),%eax
    1afa:	83 ec 08             	sub    $0x8,%esp
    1afd:	68 f3 23 00 00       	push   $0x23f3
    1b02:	50                   	push   %eax
    1b03:	e8 af ef ff ff       	call   ab7 <APLoadBitmap>
    1b08:	83 c4 0c             	add    $0xc,%esp
    1b0b:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b0e:	a3 18 2d 00 00       	mov    %eax,0x2d18
    1b13:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b16:	a3 1c 2d 00 00       	mov    %eax,0x2d1c
    1b1b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b1e:	a3 20 2d 00 00       	mov    %eax,0x2d20
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1b23:	83 ec 04             	sub    $0x4,%esp
    1b26:	ff 35 20 2d 00 00    	pushl  0x2d20
    1b2c:	ff 35 1c 2d 00 00    	pushl  0x2d1c
    1b32:	ff 35 18 2d 00 00    	pushl  0x2d18
    1b38:	e8 b4 f1 ff ff       	call   cf1 <APCreateCompatibleDCFromBitmap>
    1b3d:	83 c4 10             	add    $0x10,%esp
    1b40:	a3 44 2d 00 00       	mov    %eax,0x2d44
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1b45:	8b 45 08             	mov    0x8(%ebp),%eax
    1b48:	8b 40 08             	mov    0x8(%eax),%eax
    1b4b:	85 c0                	test   %eax,%eax
    1b4d:	75 17                	jne    1b66 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1b4f:	83 ec 08             	sub    $0x8,%esp
    1b52:	68 04 24 00 00       	push   $0x2404
    1b57:	6a 01                	push   $0x1
    1b59:	e8 d3 ea ff ff       	call   631 <printf>
    1b5e:	83 c4 10             	add    $0x10,%esp
        return;
    1b61:	e9 f2 03 00 00       	jmp    1f58 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1b66:	8b 45 08             	mov    0x8(%ebp),%eax
    1b69:	8b 40 10             	mov    0x10(%eax),%eax
    1b6c:	85 c0                	test   %eax,%eax
    1b6e:	7e 10                	jle    1b80 <APGridPaint+0x27d>
    1b70:	8b 45 08             	mov    0x8(%ebp),%eax
    1b73:	8b 50 14             	mov    0x14(%eax),%edx
    1b76:	8b 45 08             	mov    0x8(%ebp),%eax
    1b79:	8b 40 10             	mov    0x10(%eax),%eax
    1b7c:	39 c2                	cmp    %eax,%edx
    1b7e:	7c 17                	jl     1b97 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1b80:	83 ec 08             	sub    $0x8,%esp
    1b83:	68 2a 24 00 00       	push   $0x242a
    1b88:	6a 01                	push   $0x1
    1b8a:	e8 a2 ea ff ff       	call   631 <printf>
    1b8f:	83 c4 10             	add    $0x10,%esp
        return;
    1b92:	e9 c1 03 00 00       	jmp    1f58 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1b97:	8b 45 08             	mov    0x8(%ebp),%eax
    1b9a:	8b 40 14             	mov    0x14(%eax),%eax
    1b9d:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1ba3:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1ba6:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1ba9:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1bac:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1bb3:	e9 96 03 00 00       	jmp    1f4e <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1bb8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1bbf:	e9 7c 03 00 00       	jmp    1f40 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1bc4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bc7:	c1 e0 04             	shl    $0x4,%eax
    1bca:	89 c2                	mov    %eax,%edx
    1bcc:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1bcf:	01 c2                	add    %eax,%edx
    1bd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bd4:	01 d0                	add    %edx,%eax
    1bd6:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1bd9:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdc:	8b 40 0c             	mov    0xc(%eax),%eax
    1bdf:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1be2:	c1 e2 02             	shl    $0x2,%edx
    1be5:	01 d0                	add    %edx,%eax
    1be7:	8b 00                	mov    (%eax),%eax
    1be9:	83 f8 07             	cmp    $0x7,%eax
    1bec:	0f 87 49 03 00 00    	ja     1f3b <APGridPaint+0x638>
    1bf2:	8b 04 85 40 24 00 00 	mov    0x2440(,%eax,4),%eax
    1bf9:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bfb:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1bfe:	6a 0c                	push   $0xc
    1c00:	6a 0c                	push   $0xc
    1c02:	6a 0c                	push   $0xc
    1c04:	50                   	push   %eax
    1c05:	e8 46 f9 ff ff       	call   1550 <RGB>
    1c0a:	83 c4 0c             	add    $0xc,%esp
    1c0d:	8b 1d 04 2d 00 00    	mov    0x2d04,%ebx
    1c13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c16:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c19:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c1c:	6b c0 32             	imul   $0x32,%eax,%eax
    1c1f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c22:	8b 45 08             	mov    0x8(%ebp),%eax
    1c25:	8d 78 34             	lea    0x34(%eax),%edi
    1c28:	83 ec 0c             	sub    $0xc,%esp
    1c2b:	83 ec 04             	sub    $0x4,%esp
    1c2e:	89 e0                	mov    %esp,%eax
    1c30:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1c34:	66 89 30             	mov    %si,(%eax)
    1c37:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1c3b:	88 50 02             	mov    %dl,0x2(%eax)
    1c3e:	6a 32                	push   $0x32
    1c40:	6a 32                	push   $0x32
    1c42:	6a 00                	push   $0x0
    1c44:	6a 00                	push   $0x0
    1c46:	53                   	push   %ebx
    1c47:	51                   	push   %ecx
    1c48:	ff 75 94             	pushl  -0x6c(%ebp)
    1c4b:	57                   	push   %edi
    1c4c:	e8 5b f7 ff ff       	call   13ac <APDcCopy>
    1c51:	83 c4 30             	add    $0x30,%esp
                    break;
    1c54:	e9 e3 02 00 00       	jmp    1f3c <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1c59:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c5c:	6a 69                	push   $0x69
    1c5e:	6a 69                	push   $0x69
    1c60:	6a 69                	push   $0x69
    1c62:	50                   	push   %eax
    1c63:	e8 e8 f8 ff ff       	call   1550 <RGB>
    1c68:	83 c4 0c             	add    $0xc,%esp
    1c6b:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1c6f:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1c73:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1c77:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1c7a:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1c81:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c84:	6a 69                	push   $0x69
    1c86:	6a 69                	push   $0x69
    1c88:	6a 69                	push   $0x69
    1c8a:	50                   	push   %eax
    1c8b:	e8 c0 f8 ff ff       	call   1550 <RGB>
    1c90:	83 c4 0c             	add    $0xc,%esp
    1c93:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1c97:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1c9b:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1c9f:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1ca2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca5:	8d 50 34             	lea    0x34(%eax),%edx
    1ca8:	8d 45 98             	lea    -0x68(%ebp),%eax
    1cab:	ff 75 bc             	pushl  -0x44(%ebp)
    1cae:	ff 75 b8             	pushl  -0x48(%ebp)
    1cb1:	52                   	push   %edx
    1cb2:	50                   	push   %eax
    1cb3:	e8 ce f0 ff ff       	call   d86 <APSetPen>
    1cb8:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1cbb:	8b 45 08             	mov    0x8(%ebp),%eax
    1cbe:	8d 58 34             	lea    0x34(%eax),%ebx
    1cc1:	8d 55 98             	lea    -0x68(%ebp),%edx
    1cc4:	83 ec 04             	sub    $0x4,%esp
    1cc7:	83 ec 04             	sub    $0x4,%esp
    1cca:	89 e0                	mov    %esp,%eax
    1ccc:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1cd0:	66 89 08             	mov    %cx,(%eax)
    1cd3:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1cd7:	88 48 02             	mov    %cl,0x2(%eax)
    1cda:	53                   	push   %ebx
    1cdb:	52                   	push   %edx
    1cdc:	e8 de f0 ff ff       	call   dbf <APSetBrush>
    1ce1:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1ce4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ce7:	6b d0 32             	imul   $0x32,%eax,%edx
    1cea:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ced:	6b c0 32             	imul   $0x32,%eax,%eax
    1cf0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1cf3:	83 c1 34             	add    $0x34,%ecx
    1cf6:	83 ec 0c             	sub    $0xc,%esp
    1cf9:	6a 32                	push   $0x32
    1cfb:	6a 32                	push   $0x32
    1cfd:	52                   	push   %edx
    1cfe:	50                   	push   %eax
    1cff:	51                   	push   %ecx
    1d00:	e8 a2 f4 ff ff       	call   11a7 <APDrawRect>
    1d05:	83 c4 20             	add    $0x20,%esp
                    break;
    1d08:	e9 2f 02 00 00       	jmp    1f3c <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d0d:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1d10:	6a 0c                	push   $0xc
    1d12:	6a 0c                	push   $0xc
    1d14:	6a 0c                	push   $0xc
    1d16:	50                   	push   %eax
    1d17:	e8 34 f8 ff ff       	call   1550 <RGB>
    1d1c:	83 c4 0c             	add    $0xc,%esp
    1d1f:	8b 1d 44 2d 00 00    	mov    0x2d44,%ebx
    1d25:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d28:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d2b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d2e:	6b c0 32             	imul   $0x32,%eax,%eax
    1d31:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d34:	8b 45 08             	mov    0x8(%ebp),%eax
    1d37:	8d 78 34             	lea    0x34(%eax),%edi
    1d3a:	83 ec 0c             	sub    $0xc,%esp
    1d3d:	83 ec 04             	sub    $0x4,%esp
    1d40:	89 e0                	mov    %esp,%eax
    1d42:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1d46:	66 89 30             	mov    %si,(%eax)
    1d49:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1d4d:	88 50 02             	mov    %dl,0x2(%eax)
    1d50:	6a 32                	push   $0x32
    1d52:	6a 32                	push   $0x32
    1d54:	6a 00                	push   $0x0
    1d56:	6a 00                	push   $0x0
    1d58:	53                   	push   %ebx
    1d59:	51                   	push   %ecx
    1d5a:	ff 75 94             	pushl  -0x6c(%ebp)
    1d5d:	57                   	push   %edi
    1d5e:	e8 49 f6 ff ff       	call   13ac <APDcCopy>
    1d63:	83 c4 30             	add    $0x30,%esp
                    break;
    1d66:	e9 d1 01 00 00       	jmp    1f3c <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d6b:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1d6e:	6a 0c                	push   $0xc
    1d70:	6a 0c                	push   $0xc
    1d72:	6a 0c                	push   $0xc
    1d74:	50                   	push   %eax
    1d75:	e8 d6 f7 ff ff       	call   1550 <RGB>
    1d7a:	83 c4 0c             	add    $0xc,%esp
    1d7d:	8b 1d 24 2d 00 00    	mov    0x2d24,%ebx
    1d83:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d86:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d89:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d8c:	6b c0 32             	imul   $0x32,%eax,%eax
    1d8f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d92:	8b 45 08             	mov    0x8(%ebp),%eax
    1d95:	8d 78 34             	lea    0x34(%eax),%edi
    1d98:	83 ec 0c             	sub    $0xc,%esp
    1d9b:	83 ec 04             	sub    $0x4,%esp
    1d9e:	89 e0                	mov    %esp,%eax
    1da0:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1da4:	66 89 30             	mov    %si,(%eax)
    1da7:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1dab:	88 50 02             	mov    %dl,0x2(%eax)
    1dae:	6a 32                	push   $0x32
    1db0:	6a 32                	push   $0x32
    1db2:	6a 00                	push   $0x0
    1db4:	6a 00                	push   $0x0
    1db6:	53                   	push   %ebx
    1db7:	51                   	push   %ecx
    1db8:	ff 75 94             	pushl  -0x6c(%ebp)
    1dbb:	57                   	push   %edi
    1dbc:	e8 eb f5 ff ff       	call   13ac <APDcCopy>
    1dc1:	83 c4 30             	add    $0x30,%esp
                    break;
    1dc4:	e9 73 01 00 00       	jmp    1f3c <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dc9:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1dcc:	6a 0c                	push   $0xc
    1dce:	6a 0c                	push   $0xc
    1dd0:	6a 0c                	push   $0xc
    1dd2:	50                   	push   %eax
    1dd3:	e8 78 f7 ff ff       	call   1550 <RGB>
    1dd8:	83 c4 0c             	add    $0xc,%esp
    1ddb:	8b 1d 08 2d 00 00    	mov    0x2d08,%ebx
    1de1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1de4:	6b c8 32             	imul   $0x32,%eax,%ecx
    1de7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dea:	6b c0 32             	imul   $0x32,%eax,%eax
    1ded:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1df0:	8b 45 08             	mov    0x8(%ebp),%eax
    1df3:	8d 78 34             	lea    0x34(%eax),%edi
    1df6:	83 ec 0c             	sub    $0xc,%esp
    1df9:	83 ec 04             	sub    $0x4,%esp
    1dfc:	89 e0                	mov    %esp,%eax
    1dfe:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1e02:	66 89 30             	mov    %si,(%eax)
    1e05:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1e09:	88 50 02             	mov    %dl,0x2(%eax)
    1e0c:	6a 32                	push   $0x32
    1e0e:	6a 32                	push   $0x32
    1e10:	6a 00                	push   $0x0
    1e12:	6a 00                	push   $0x0
    1e14:	53                   	push   %ebx
    1e15:	51                   	push   %ecx
    1e16:	ff 75 94             	pushl  -0x6c(%ebp)
    1e19:	57                   	push   %edi
    1e1a:	e8 8d f5 ff ff       	call   13ac <APDcCopy>
    1e1f:	83 c4 30             	add    $0x30,%esp
                    break;
    1e22:	e9 15 01 00 00       	jmp    1f3c <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e27:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1e2a:	6a 0c                	push   $0xc
    1e2c:	6a 0c                	push   $0xc
    1e2e:	6a 0c                	push   $0xc
    1e30:	50                   	push   %eax
    1e31:	e8 1a f7 ff ff       	call   1550 <RGB>
    1e36:	83 c4 0c             	add    $0xc,%esp
    1e39:	8b 1d 40 2d 00 00    	mov    0x2d40,%ebx
    1e3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e42:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e45:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e48:	6b c0 32             	imul   $0x32,%eax,%eax
    1e4b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e51:	8d 78 34             	lea    0x34(%eax),%edi
    1e54:	83 ec 0c             	sub    $0xc,%esp
    1e57:	83 ec 04             	sub    $0x4,%esp
    1e5a:	89 e0                	mov    %esp,%eax
    1e5c:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1e60:	66 89 30             	mov    %si,(%eax)
    1e63:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1e67:	88 50 02             	mov    %dl,0x2(%eax)
    1e6a:	6a 32                	push   $0x32
    1e6c:	6a 32                	push   $0x32
    1e6e:	6a 00                	push   $0x0
    1e70:	6a 00                	push   $0x0
    1e72:	53                   	push   %ebx
    1e73:	51                   	push   %ecx
    1e74:	ff 75 94             	pushl  -0x6c(%ebp)
    1e77:	57                   	push   %edi
    1e78:	e8 2f f5 ff ff       	call   13ac <APDcCopy>
    1e7d:	83 c4 30             	add    $0x30,%esp
                    break;
    1e80:	e9 b7 00 00 00       	jmp    1f3c <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e85:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1e88:	6a 0c                	push   $0xc
    1e8a:	6a 0c                	push   $0xc
    1e8c:	6a 0c                	push   $0xc
    1e8e:	50                   	push   %eax
    1e8f:	e8 bc f6 ff ff       	call   1550 <RGB>
    1e94:	83 c4 0c             	add    $0xc,%esp
    1e97:	8b 1d d8 2c 00 00    	mov    0x2cd8,%ebx
    1e9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ea0:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ea3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ea6:	6b c0 32             	imul   $0x32,%eax,%eax
    1ea9:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1eac:	8b 45 08             	mov    0x8(%ebp),%eax
    1eaf:	8d 78 34             	lea    0x34(%eax),%edi
    1eb2:	83 ec 0c             	sub    $0xc,%esp
    1eb5:	83 ec 04             	sub    $0x4,%esp
    1eb8:	89 e0                	mov    %esp,%eax
    1eba:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1ebe:	66 89 30             	mov    %si,(%eax)
    1ec1:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1ec5:	88 50 02             	mov    %dl,0x2(%eax)
    1ec8:	6a 32                	push   $0x32
    1eca:	6a 32                	push   $0x32
    1ecc:	6a 00                	push   $0x0
    1ece:	6a 00                	push   $0x0
    1ed0:	53                   	push   %ebx
    1ed1:	51                   	push   %ecx
    1ed2:	ff 75 94             	pushl  -0x6c(%ebp)
    1ed5:	57                   	push   %edi
    1ed6:	e8 d1 f4 ff ff       	call   13ac <APDcCopy>
    1edb:	83 c4 30             	add    $0x30,%esp
                    break;
    1ede:	eb 5c                	jmp    1f3c <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ee0:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1ee3:	6a 0c                	push   $0xc
    1ee5:	6a 0c                	push   $0xc
    1ee7:	6a 0c                	push   $0xc
    1ee9:	50                   	push   %eax
    1eea:	e8 61 f6 ff ff       	call   1550 <RGB>
    1eef:	83 c4 0c             	add    $0xc,%esp
    1ef2:	8b 1d f4 2c 00 00    	mov    0x2cf4,%ebx
    1ef8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1efb:	6b c8 32             	imul   $0x32,%eax,%ecx
    1efe:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f01:	6b c0 32             	imul   $0x32,%eax,%eax
    1f04:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f07:	8b 45 08             	mov    0x8(%ebp),%eax
    1f0a:	8d 78 34             	lea    0x34(%eax),%edi
    1f0d:	83 ec 0c             	sub    $0xc,%esp
    1f10:	83 ec 04             	sub    $0x4,%esp
    1f13:	89 e0                	mov    %esp,%eax
    1f15:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1f19:	66 89 30             	mov    %si,(%eax)
    1f1c:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1f20:	88 50 02             	mov    %dl,0x2(%eax)
    1f23:	6a 32                	push   $0x32
    1f25:	6a 32                	push   $0x32
    1f27:	6a 00                	push   $0x0
    1f29:	6a 00                	push   $0x0
    1f2b:	53                   	push   %ebx
    1f2c:	51                   	push   %ecx
    1f2d:	ff 75 94             	pushl  -0x6c(%ebp)
    1f30:	57                   	push   %edi
    1f31:	e8 76 f4 ff ff       	call   13ac <APDcCopy>
    1f36:	83 c4 30             	add    $0x30,%esp
                    break;
    1f39:	eb 01                	jmp    1f3c <APGridPaint+0x639>
                default: break;
    1f3b:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1f3c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1f40:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1f44:	0f 8e 7a fc ff ff    	jle    1bc4 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1f4a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1f4e:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1f52:	0f 8e 60 fc ff ff    	jle    1bb8 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1f58:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1f5b:	5b                   	pop    %ebx
    1f5c:	5e                   	pop    %esi
    1f5d:	5f                   	pop    %edi
    1f5e:	5d                   	pop    %ebp
    1f5f:	c3                   	ret    

00001f60 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1f60:	55                   	push   %ebp
    1f61:	89 e5                	mov    %esp,%ebp
    1f63:	53                   	push   %ebx
    1f64:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1f67:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1f6e:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1f72:	74 17                	je     1f8b <sprintint+0x2b>
    1f74:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1f78:	79 11                	jns    1f8b <sprintint+0x2b>
        neg = 1;
    1f7a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1f81:	8b 45 10             	mov    0x10(%ebp),%eax
    1f84:	f7 d8                	neg    %eax
    1f86:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f89:	eb 06                	jmp    1f91 <sprintint+0x31>
    } else {
        x = xx;
    1f8b:	8b 45 10             	mov    0x10(%ebp),%eax
    1f8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1f91:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1f98:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1f9b:	8d 41 01             	lea    0x1(%ecx),%eax
    1f9e:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1fa1:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1fa4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1fa7:	ba 00 00 00 00       	mov    $0x0,%edx
    1fac:	f7 f3                	div    %ebx
    1fae:	89 d0                	mov    %edx,%eax
    1fb0:	0f b6 80 b4 2c 00 00 	movzbl 0x2cb4(%eax),%eax
    1fb7:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1fbb:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1fbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1fc1:	ba 00 00 00 00       	mov    $0x0,%edx
    1fc6:	f7 f3                	div    %ebx
    1fc8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1fcb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1fcf:	75 c7                	jne    1f98 <sprintint+0x38>
    if(neg)
    1fd1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fd5:	74 0e                	je     1fe5 <sprintint+0x85>
        buf[i++] = '-';
    1fd7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fda:	8d 50 01             	lea    0x1(%eax),%edx
    1fdd:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1fe0:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1fe5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fe8:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1feb:	eb 1b                	jmp    2008 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1fed:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ff0:	8b 00                	mov    (%eax),%eax
    1ff2:	8d 48 01             	lea    0x1(%eax),%ecx
    1ff5:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ff8:	89 0a                	mov    %ecx,(%edx)
    1ffa:	89 c2                	mov    %eax,%edx
    1ffc:	8b 45 08             	mov    0x8(%ebp),%eax
    1fff:	01 d0                	add    %edx,%eax
    2001:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2004:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2008:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    200c:	7f df                	jg     1fed <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    200e:	eb 21                	jmp    2031 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2010:	8b 45 0c             	mov    0xc(%ebp),%eax
    2013:	8b 00                	mov    (%eax),%eax
    2015:	8d 48 01             	lea    0x1(%eax),%ecx
    2018:	8b 55 0c             	mov    0xc(%ebp),%edx
    201b:	89 0a                	mov    %ecx,(%edx)
    201d:	89 c2                	mov    %eax,%edx
    201f:	8b 45 08             	mov    0x8(%ebp),%eax
    2022:	01 c2                	add    %eax,%edx
    2024:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2027:	8b 45 f8             	mov    -0x8(%ebp),%eax
    202a:	01 c8                	add    %ecx,%eax
    202c:	0f b6 00             	movzbl (%eax),%eax
    202f:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2031:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2035:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2039:	79 d5                	jns    2010 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    203b:	90                   	nop
    203c:	83 c4 20             	add    $0x20,%esp
    203f:	5b                   	pop    %ebx
    2040:	5d                   	pop    %ebp
    2041:	c3                   	ret    

00002042 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2042:	55                   	push   %ebp
    2043:	89 e5                	mov    %esp,%ebp
    2045:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2048:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    204f:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2056:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    205d:	8d 45 0c             	lea    0xc(%ebp),%eax
    2060:	83 c0 04             	add    $0x4,%eax
    2063:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2066:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    206d:	e9 d9 01 00 00       	jmp    224b <sprintf+0x209>
        c = fmt[i] & 0xff;
    2072:	8b 55 0c             	mov    0xc(%ebp),%edx
    2075:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2078:	01 d0                	add    %edx,%eax
    207a:	0f b6 00             	movzbl (%eax),%eax
    207d:	0f be c0             	movsbl %al,%eax
    2080:	25 ff 00 00 00       	and    $0xff,%eax
    2085:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2088:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    208c:	75 2c                	jne    20ba <sprintf+0x78>
            if(c == '%'){
    208e:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2092:	75 0c                	jne    20a0 <sprintf+0x5e>
                state = '%';
    2094:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    209b:	e9 a7 01 00 00       	jmp    2247 <sprintf+0x205>
            } else {
                dst[j++] = c;
    20a0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20a3:	8d 50 01             	lea    0x1(%eax),%edx
    20a6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20a9:	89 c2                	mov    %eax,%edx
    20ab:	8b 45 08             	mov    0x8(%ebp),%eax
    20ae:	01 d0                	add    %edx,%eax
    20b0:	8b 55 e0             	mov    -0x20(%ebp),%edx
    20b3:	88 10                	mov    %dl,(%eax)
    20b5:	e9 8d 01 00 00       	jmp    2247 <sprintf+0x205>
            }
        } else if(state == '%'){
    20ba:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    20be:	0f 85 83 01 00 00    	jne    2247 <sprintf+0x205>
            if(c == 'd'){
    20c4:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    20c8:	75 4c                	jne    2116 <sprintf+0xd4>
                buf[bi] = '\0';
    20ca:	8d 55 ce             	lea    -0x32(%ebp),%edx
    20cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20d0:	01 d0                	add    %edx,%eax
    20d2:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    20d5:	83 ec 0c             	sub    $0xc,%esp
    20d8:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20db:	50                   	push   %eax
    20dc:	e8 1f e3 ff ff       	call   400 <atoi>
    20e1:	83 c4 10             	add    $0x10,%esp
    20e4:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    20e7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    20ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20f1:	8b 00                	mov    (%eax),%eax
    20f3:	83 ec 08             	sub    $0x8,%esp
    20f6:	ff 75 d8             	pushl  -0x28(%ebp)
    20f9:	6a 01                	push   $0x1
    20fb:	6a 0a                	push   $0xa
    20fd:	50                   	push   %eax
    20fe:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2101:	50                   	push   %eax
    2102:	ff 75 08             	pushl  0x8(%ebp)
    2105:	e8 56 fe ff ff       	call   1f60 <sprintint>
    210a:	83 c4 20             	add    $0x20,%esp
                ap++;
    210d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2111:	e9 2a 01 00 00       	jmp    2240 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2116:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    211a:	74 06                	je     2122 <sprintf+0xe0>
    211c:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2120:	75 4c                	jne    216e <sprintf+0x12c>
                buf[bi] = '\0';
    2122:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2125:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2128:	01 d0                	add    %edx,%eax
    212a:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    212d:	83 ec 0c             	sub    $0xc,%esp
    2130:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2133:	50                   	push   %eax
    2134:	e8 c7 e2 ff ff       	call   400 <atoi>
    2139:	83 c4 10             	add    $0x10,%esp
    213c:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    213f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2146:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2149:	8b 00                	mov    (%eax),%eax
    214b:	83 ec 08             	sub    $0x8,%esp
    214e:	ff 75 dc             	pushl  -0x24(%ebp)
    2151:	6a 00                	push   $0x0
    2153:	6a 10                	push   $0x10
    2155:	50                   	push   %eax
    2156:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2159:	50                   	push   %eax
    215a:	ff 75 08             	pushl  0x8(%ebp)
    215d:	e8 fe fd ff ff       	call   1f60 <sprintint>
    2162:	83 c4 20             	add    $0x20,%esp
                ap++;
    2165:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2169:	e9 d2 00 00 00       	jmp    2240 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    216e:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2172:	75 46                	jne    21ba <sprintf+0x178>
                s = (char*)*ap;
    2174:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2177:	8b 00                	mov    (%eax),%eax
    2179:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    217c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2180:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2184:	75 25                	jne    21ab <sprintf+0x169>
                    s = "(null)";
    2186:	c7 45 f4 60 24 00 00 	movl   $0x2460,-0xc(%ebp)
                while(*s != 0){
    218d:	eb 1c                	jmp    21ab <sprintf+0x169>
                    dst[j++] = *s;
    218f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2192:	8d 50 01             	lea    0x1(%eax),%edx
    2195:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2198:	89 c2                	mov    %eax,%edx
    219a:	8b 45 08             	mov    0x8(%ebp),%eax
    219d:	01 c2                	add    %eax,%edx
    219f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21a2:	0f b6 00             	movzbl (%eax),%eax
    21a5:	88 02                	mov    %al,(%edx)
                    s++;
    21a7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    21ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21ae:	0f b6 00             	movzbl (%eax),%eax
    21b1:	84 c0                	test   %al,%al
    21b3:	75 da                	jne    218f <sprintf+0x14d>
    21b5:	e9 86 00 00 00       	jmp    2240 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    21ba:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    21be:	75 1d                	jne    21dd <sprintf+0x19b>
                dst[j++] = *ap;
    21c0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21c3:	8d 50 01             	lea    0x1(%eax),%edx
    21c6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21c9:	89 c2                	mov    %eax,%edx
    21cb:	8b 45 08             	mov    0x8(%ebp),%eax
    21ce:	01 c2                	add    %eax,%edx
    21d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21d3:	8b 00                	mov    (%eax),%eax
    21d5:	88 02                	mov    %al,(%edx)
                ap++;
    21d7:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    21db:	eb 63                	jmp    2240 <sprintf+0x1fe>
            } else if(c == '%'){
    21dd:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    21e1:	75 17                	jne    21fa <sprintf+0x1b8>
                dst[j++] = c;
    21e3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21e6:	8d 50 01             	lea    0x1(%eax),%edx
    21e9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21ec:	89 c2                	mov    %eax,%edx
    21ee:	8b 45 08             	mov    0x8(%ebp),%eax
    21f1:	01 d0                	add    %edx,%eax
    21f3:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21f6:	88 10                	mov    %dl,(%eax)
    21f8:	eb 46                	jmp    2240 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    21fa:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    21fe:	7e 18                	jle    2218 <sprintf+0x1d6>
    2200:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2204:	7f 12                	jg     2218 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2206:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2209:	8d 50 01             	lea    0x1(%eax),%edx
    220c:	89 55 f0             	mov    %edx,-0x10(%ebp)
    220f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2212:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2216:	eb 2f                	jmp    2247 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2218:	8b 45 c8             	mov    -0x38(%ebp),%eax
    221b:	8d 50 01             	lea    0x1(%eax),%edx
    221e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2221:	89 c2                	mov    %eax,%edx
    2223:	8b 45 08             	mov    0x8(%ebp),%eax
    2226:	01 d0                	add    %edx,%eax
    2228:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    222b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    222e:	8d 50 01             	lea    0x1(%eax),%edx
    2231:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2234:	89 c2                	mov    %eax,%edx
    2236:	8b 45 08             	mov    0x8(%ebp),%eax
    2239:	01 d0                	add    %edx,%eax
    223b:	8b 55 e0             	mov    -0x20(%ebp),%edx
    223e:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2240:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2247:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    224b:	8b 55 0c             	mov    0xc(%ebp),%edx
    224e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2251:	01 d0                	add    %edx,%eax
    2253:	0f b6 00             	movzbl (%eax),%eax
    2256:	84 c0                	test   %al,%al
    2258:	0f 85 14 fe ff ff    	jne    2072 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    225e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2261:	8d 50 01             	lea    0x1(%eax),%edx
    2264:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2267:	89 c2                	mov    %eax,%edx
    2269:	8b 45 08             	mov    0x8(%ebp),%eax
    226c:	01 d0                	add    %edx,%eax
    226e:	c6 00 00             	movb   $0x0,(%eax)
}
    2271:	90                   	nop
    2272:	c9                   	leave  
    2273:	c3                   	ret    
