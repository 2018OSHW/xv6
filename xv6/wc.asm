
_wc：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
       6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
       d:	8b 45 e8             	mov    -0x18(%ebp),%eax
      10:	89 45 ec             	mov    %eax,-0x14(%ebp)
      13:	8b 45 ec             	mov    -0x14(%ebp),%eax
      16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
      19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
      20:	eb 69                	jmp    8b <wc+0x8b>
    for(i=0; i<n; i++){
      22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      29:	eb 58                	jmp    83 <wc+0x83>
      c++;
      2b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      if(buf[i] == '\n')
      2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      32:	05 00 69 00 00       	add    $0x6900,%eax
      37:	0f b6 00             	movzbl (%eax),%eax
      3a:	3c 0a                	cmp    $0xa,%al
      3c:	75 04                	jne    42 <wc+0x42>
        l++;
      3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
      42:	8b 45 f4             	mov    -0xc(%ebp),%eax
      45:	05 00 69 00 00       	add    $0x6900,%eax
      4a:	0f b6 00             	movzbl (%eax),%eax
      4d:	0f be c0             	movsbl %al,%eax
      50:	83 ec 08             	sub    $0x8,%esp
      53:	50                   	push   %eax
      54:	68 30 25 00 00       	push   $0x2530
      59:	e8 35 02 00 00       	call   293 <strchr>
      5e:	83 c4 10             	add    $0x10,%esp
      61:	85 c0                	test   %eax,%eax
      63:	74 09                	je     6e <wc+0x6e>
        inword = 0;
      65:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      6c:	eb 11                	jmp    7f <wc+0x7f>
      else if(!inword){
      6e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
      72:	75 0b                	jne    7f <wc+0x7f>
        w++;
      74:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        inword = 1;
      78:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      7f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      83:	8b 45 f4             	mov    -0xc(%ebp),%eax
      86:	3b 45 e0             	cmp    -0x20(%ebp),%eax
      89:	7c a0                	jl     2b <wc+0x2b>
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
      8b:	83 ec 04             	sub    $0x4,%esp
      8e:	68 00 02 00 00       	push   $0x200
      93:	68 00 69 00 00       	push   $0x6900
      98:	ff 75 08             	pushl  0x8(%ebp)
      9b:	e8 8c 03 00 00       	call   42c <read>
      a0:	83 c4 10             	add    $0x10,%esp
      a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
      a6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
      aa:	0f 8f 72 ff ff ff    	jg     22 <wc+0x22>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
      b0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
      b4:	79 17                	jns    cd <wc+0xcd>
    printf(1, "wc: read error\n");
      b6:	83 ec 08             	sub    $0x8,%esp
      b9:	68 36 25 00 00       	push   $0x2536
      be:	6a 01                	push   $0x1
      c0:	e8 fe 04 00 00       	call   5c3 <printf>
      c5:	83 c4 10             	add    $0x10,%esp
    exit();
      c8:	e8 47 03 00 00       	call   414 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
      cd:	83 ec 08             	sub    $0x8,%esp
      d0:	ff 75 0c             	pushl  0xc(%ebp)
      d3:	ff 75 e8             	pushl  -0x18(%ebp)
      d6:	ff 75 ec             	pushl  -0x14(%ebp)
      d9:	ff 75 f0             	pushl  -0x10(%ebp)
      dc:	68 46 25 00 00       	push   $0x2546
      e1:	6a 01                	push   $0x1
      e3:	e8 db 04 00 00       	call   5c3 <printf>
      e8:	83 c4 20             	add    $0x20,%esp
}
      eb:	90                   	nop
      ec:	c9                   	leave  
      ed:	c3                   	ret    

000000ee <main>:

int
main(int argc, char *argv[])
{
      ee:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      f2:	83 e4 f0             	and    $0xfffffff0,%esp
      f5:	ff 71 fc             	pushl  -0x4(%ecx)
      f8:	55                   	push   %ebp
      f9:	89 e5                	mov    %esp,%ebp
      fb:	53                   	push   %ebx
      fc:	51                   	push   %ecx
      fd:	83 ec 10             	sub    $0x10,%esp
     100:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
     102:	83 3b 01             	cmpl   $0x1,(%ebx)
     105:	7f 17                	jg     11e <main+0x30>
    wc(0, "");
     107:	83 ec 08             	sub    $0x8,%esp
     10a:	68 53 25 00 00       	push   $0x2553
     10f:	6a 00                	push   $0x0
     111:	e8 ea fe ff ff       	call   0 <wc>
     116:	83 c4 10             	add    $0x10,%esp
    exit();
     119:	e8 f6 02 00 00       	call   414 <exit>
  }

  for(i = 1; i < argc; i++){
     11e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
     125:	e9 83 00 00 00       	jmp    1ad <main+0xbf>
    if((fd = open(argv[i], 0)) < 0){
     12a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     12d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     134:	8b 43 04             	mov    0x4(%ebx),%eax
     137:	01 d0                	add    %edx,%eax
     139:	8b 00                	mov    (%eax),%eax
     13b:	83 ec 08             	sub    $0x8,%esp
     13e:	6a 00                	push   $0x0
     140:	50                   	push   %eax
     141:	e8 0e 03 00 00       	call   454 <open>
     146:	83 c4 10             	add    $0x10,%esp
     149:	89 45 f0             	mov    %eax,-0x10(%ebp)
     14c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     150:	79 29                	jns    17b <main+0x8d>
      printf(1, "wc: cannot open %s\n", argv[i]);
     152:	8b 45 f4             	mov    -0xc(%ebp),%eax
     155:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     15c:	8b 43 04             	mov    0x4(%ebx),%eax
     15f:	01 d0                	add    %edx,%eax
     161:	8b 00                	mov    (%eax),%eax
     163:	83 ec 04             	sub    $0x4,%esp
     166:	50                   	push   %eax
     167:	68 54 25 00 00       	push   $0x2554
     16c:	6a 01                	push   $0x1
     16e:	e8 50 04 00 00       	call   5c3 <printf>
     173:	83 c4 10             	add    $0x10,%esp
      exit();
     176:	e8 99 02 00 00       	call   414 <exit>
    }
    wc(fd, argv[i]);
     17b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     17e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     185:	8b 43 04             	mov    0x4(%ebx),%eax
     188:	01 d0                	add    %edx,%eax
     18a:	8b 00                	mov    (%eax),%eax
     18c:	83 ec 08             	sub    $0x8,%esp
     18f:	50                   	push   %eax
     190:	ff 75 f0             	pushl  -0x10(%ebp)
     193:	e8 68 fe ff ff       	call   0 <wc>
     198:	83 c4 10             	add    $0x10,%esp
    close(fd);
     19b:	83 ec 0c             	sub    $0xc,%esp
     19e:	ff 75 f0             	pushl  -0x10(%ebp)
     1a1:	e8 96 02 00 00       	call   43c <close>
     1a6:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
     1a9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     1ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1b0:	3b 03                	cmp    (%ebx),%eax
     1b2:	0f 8c 72 ff ff ff    	jl     12a <main+0x3c>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
     1b8:	e8 57 02 00 00       	call   414 <exit>

000001bd <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     1bd:	55                   	push   %ebp
     1be:	89 e5                	mov    %esp,%ebp
     1c0:	57                   	push   %edi
     1c1:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     1c2:	8b 4d 08             	mov    0x8(%ebp),%ecx
     1c5:	8b 55 10             	mov    0x10(%ebp),%edx
     1c8:	8b 45 0c             	mov    0xc(%ebp),%eax
     1cb:	89 cb                	mov    %ecx,%ebx
     1cd:	89 df                	mov    %ebx,%edi
     1cf:	89 d1                	mov    %edx,%ecx
     1d1:	fc                   	cld    
     1d2:	f3 aa                	rep stos %al,%es:(%edi)
     1d4:	89 ca                	mov    %ecx,%edx
     1d6:	89 fb                	mov    %edi,%ebx
     1d8:	89 5d 08             	mov    %ebx,0x8(%ebp)
     1db:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     1de:	90                   	nop
     1df:	5b                   	pop    %ebx
     1e0:	5f                   	pop    %edi
     1e1:	5d                   	pop    %ebp
     1e2:	c3                   	ret    

000001e3 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     1e3:	55                   	push   %ebp
     1e4:	89 e5                	mov    %esp,%ebp
     1e6:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     1e9:	8b 45 08             	mov    0x8(%ebp),%eax
     1ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     1ef:	90                   	nop
     1f0:	8b 45 08             	mov    0x8(%ebp),%eax
     1f3:	8d 50 01             	lea    0x1(%eax),%edx
     1f6:	89 55 08             	mov    %edx,0x8(%ebp)
     1f9:	8b 55 0c             	mov    0xc(%ebp),%edx
     1fc:	8d 4a 01             	lea    0x1(%edx),%ecx
     1ff:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     202:	0f b6 12             	movzbl (%edx),%edx
     205:	88 10                	mov    %dl,(%eax)
     207:	0f b6 00             	movzbl (%eax),%eax
     20a:	84 c0                	test   %al,%al
     20c:	75 e2                	jne    1f0 <strcpy+0xd>
    ;
  return os;
     20e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     211:	c9                   	leave  
     212:	c3                   	ret    

00000213 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     213:	55                   	push   %ebp
     214:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     216:	eb 08                	jmp    220 <strcmp+0xd>
    p++, q++;
     218:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     21c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     220:	8b 45 08             	mov    0x8(%ebp),%eax
     223:	0f b6 00             	movzbl (%eax),%eax
     226:	84 c0                	test   %al,%al
     228:	74 10                	je     23a <strcmp+0x27>
     22a:	8b 45 08             	mov    0x8(%ebp),%eax
     22d:	0f b6 10             	movzbl (%eax),%edx
     230:	8b 45 0c             	mov    0xc(%ebp),%eax
     233:	0f b6 00             	movzbl (%eax),%eax
     236:	38 c2                	cmp    %al,%dl
     238:	74 de                	je     218 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     23a:	8b 45 08             	mov    0x8(%ebp),%eax
     23d:	0f b6 00             	movzbl (%eax),%eax
     240:	0f b6 d0             	movzbl %al,%edx
     243:	8b 45 0c             	mov    0xc(%ebp),%eax
     246:	0f b6 00             	movzbl (%eax),%eax
     249:	0f b6 c0             	movzbl %al,%eax
     24c:	29 c2                	sub    %eax,%edx
     24e:	89 d0                	mov    %edx,%eax
}
     250:	5d                   	pop    %ebp
     251:	c3                   	ret    

00000252 <strlen>:

uint
strlen(char *s)
{
     252:	55                   	push   %ebp
     253:	89 e5                	mov    %esp,%ebp
     255:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     258:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     25f:	eb 04                	jmp    265 <strlen+0x13>
     261:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     265:	8b 55 fc             	mov    -0x4(%ebp),%edx
     268:	8b 45 08             	mov    0x8(%ebp),%eax
     26b:	01 d0                	add    %edx,%eax
     26d:	0f b6 00             	movzbl (%eax),%eax
     270:	84 c0                	test   %al,%al
     272:	75 ed                	jne    261 <strlen+0xf>
    ;
  return n;
     274:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     277:	c9                   	leave  
     278:	c3                   	ret    

00000279 <memset>:

void*
memset(void *dst, int c, uint n)
{
     279:	55                   	push   %ebp
     27a:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     27c:	8b 45 10             	mov    0x10(%ebp),%eax
     27f:	50                   	push   %eax
     280:	ff 75 0c             	pushl  0xc(%ebp)
     283:	ff 75 08             	pushl  0x8(%ebp)
     286:	e8 32 ff ff ff       	call   1bd <stosb>
     28b:	83 c4 0c             	add    $0xc,%esp
  return dst;
     28e:	8b 45 08             	mov    0x8(%ebp),%eax
}
     291:	c9                   	leave  
     292:	c3                   	ret    

00000293 <strchr>:

char*
strchr(const char *s, char c)
{
     293:	55                   	push   %ebp
     294:	89 e5                	mov    %esp,%ebp
     296:	83 ec 04             	sub    $0x4,%esp
     299:	8b 45 0c             	mov    0xc(%ebp),%eax
     29c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     29f:	eb 14                	jmp    2b5 <strchr+0x22>
    if(*s == c)
     2a1:	8b 45 08             	mov    0x8(%ebp),%eax
     2a4:	0f b6 00             	movzbl (%eax),%eax
     2a7:	3a 45 fc             	cmp    -0x4(%ebp),%al
     2aa:	75 05                	jne    2b1 <strchr+0x1e>
      return (char*)s;
     2ac:	8b 45 08             	mov    0x8(%ebp),%eax
     2af:	eb 13                	jmp    2c4 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     2b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2b5:	8b 45 08             	mov    0x8(%ebp),%eax
     2b8:	0f b6 00             	movzbl (%eax),%eax
     2bb:	84 c0                	test   %al,%al
     2bd:	75 e2                	jne    2a1 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     2bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2c4:	c9                   	leave  
     2c5:	c3                   	ret    

000002c6 <gets>:

char*
gets(char *buf, int max)
{
     2c6:	55                   	push   %ebp
     2c7:	89 e5                	mov    %esp,%ebp
     2c9:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     2d3:	eb 42                	jmp    317 <gets+0x51>
    cc = read(0, &c, 1);
     2d5:	83 ec 04             	sub    $0x4,%esp
     2d8:	6a 01                	push   $0x1
     2da:	8d 45 ef             	lea    -0x11(%ebp),%eax
     2dd:	50                   	push   %eax
     2de:	6a 00                	push   $0x0
     2e0:	e8 47 01 00 00       	call   42c <read>
     2e5:	83 c4 10             	add    $0x10,%esp
     2e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     2eb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     2ef:	7e 33                	jle    324 <gets+0x5e>
      break;
    buf[i++] = c;
     2f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2f4:	8d 50 01             	lea    0x1(%eax),%edx
     2f7:	89 55 f4             	mov    %edx,-0xc(%ebp)
     2fa:	89 c2                	mov    %eax,%edx
     2fc:	8b 45 08             	mov    0x8(%ebp),%eax
     2ff:	01 c2                	add    %eax,%edx
     301:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     305:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     307:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     30b:	3c 0a                	cmp    $0xa,%al
     30d:	74 16                	je     325 <gets+0x5f>
     30f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     313:	3c 0d                	cmp    $0xd,%al
     315:	74 0e                	je     325 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     317:	8b 45 f4             	mov    -0xc(%ebp),%eax
     31a:	83 c0 01             	add    $0x1,%eax
     31d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     320:	7c b3                	jl     2d5 <gets+0xf>
     322:	eb 01                	jmp    325 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     324:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     325:	8b 55 f4             	mov    -0xc(%ebp),%edx
     328:	8b 45 08             	mov    0x8(%ebp),%eax
     32b:	01 d0                	add    %edx,%eax
     32d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     330:	8b 45 08             	mov    0x8(%ebp),%eax
}
     333:	c9                   	leave  
     334:	c3                   	ret    

00000335 <stat>:

int
stat(char *n, struct stat *st)
{
     335:	55                   	push   %ebp
     336:	89 e5                	mov    %esp,%ebp
     338:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     33b:	83 ec 08             	sub    $0x8,%esp
     33e:	6a 00                	push   $0x0
     340:	ff 75 08             	pushl  0x8(%ebp)
     343:	e8 0c 01 00 00       	call   454 <open>
     348:	83 c4 10             	add    $0x10,%esp
     34b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     34e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     352:	79 07                	jns    35b <stat+0x26>
    return -1;
     354:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     359:	eb 25                	jmp    380 <stat+0x4b>
  r = fstat(fd, st);
     35b:	83 ec 08             	sub    $0x8,%esp
     35e:	ff 75 0c             	pushl  0xc(%ebp)
     361:	ff 75 f4             	pushl  -0xc(%ebp)
     364:	e8 03 01 00 00       	call   46c <fstat>
     369:	83 c4 10             	add    $0x10,%esp
     36c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     36f:	83 ec 0c             	sub    $0xc,%esp
     372:	ff 75 f4             	pushl  -0xc(%ebp)
     375:	e8 c2 00 00 00       	call   43c <close>
     37a:	83 c4 10             	add    $0x10,%esp
  return r;
     37d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     380:	c9                   	leave  
     381:	c3                   	ret    

00000382 <atoi>:

int
atoi(const char *s)
{
     382:	55                   	push   %ebp
     383:	89 e5                	mov    %esp,%ebp
     385:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     388:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     38f:	eb 25                	jmp    3b6 <atoi+0x34>
    n = n*10 + *s++ - '0';
     391:	8b 55 fc             	mov    -0x4(%ebp),%edx
     394:	89 d0                	mov    %edx,%eax
     396:	c1 e0 02             	shl    $0x2,%eax
     399:	01 d0                	add    %edx,%eax
     39b:	01 c0                	add    %eax,%eax
     39d:	89 c1                	mov    %eax,%ecx
     39f:	8b 45 08             	mov    0x8(%ebp),%eax
     3a2:	8d 50 01             	lea    0x1(%eax),%edx
     3a5:	89 55 08             	mov    %edx,0x8(%ebp)
     3a8:	0f b6 00             	movzbl (%eax),%eax
     3ab:	0f be c0             	movsbl %al,%eax
     3ae:	01 c8                	add    %ecx,%eax
     3b0:	83 e8 30             	sub    $0x30,%eax
     3b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     3b6:	8b 45 08             	mov    0x8(%ebp),%eax
     3b9:	0f b6 00             	movzbl (%eax),%eax
     3bc:	3c 2f                	cmp    $0x2f,%al
     3be:	7e 0a                	jle    3ca <atoi+0x48>
     3c0:	8b 45 08             	mov    0x8(%ebp),%eax
     3c3:	0f b6 00             	movzbl (%eax),%eax
     3c6:	3c 39                	cmp    $0x39,%al
     3c8:	7e c7                	jle    391 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     3ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     3cd:	c9                   	leave  
     3ce:	c3                   	ret    

000003cf <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     3cf:	55                   	push   %ebp
     3d0:	89 e5                	mov    %esp,%ebp
     3d2:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     3d5:	8b 45 08             	mov    0x8(%ebp),%eax
     3d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     3db:	8b 45 0c             	mov    0xc(%ebp),%eax
     3de:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     3e1:	eb 17                	jmp    3fa <memmove+0x2b>
    *dst++ = *src++;
     3e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     3e6:	8d 50 01             	lea    0x1(%eax),%edx
     3e9:	89 55 fc             	mov    %edx,-0x4(%ebp)
     3ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
     3ef:	8d 4a 01             	lea    0x1(%edx),%ecx
     3f2:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     3f5:	0f b6 12             	movzbl (%edx),%edx
     3f8:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     3fa:	8b 45 10             	mov    0x10(%ebp),%eax
     3fd:	8d 50 ff             	lea    -0x1(%eax),%edx
     400:	89 55 10             	mov    %edx,0x10(%ebp)
     403:	85 c0                	test   %eax,%eax
     405:	7f dc                	jg     3e3 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     407:	8b 45 08             	mov    0x8(%ebp),%eax
}
     40a:	c9                   	leave  
     40b:	c3                   	ret    

0000040c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     40c:	b8 01 00 00 00       	mov    $0x1,%eax
     411:	cd 40                	int    $0x40
     413:	c3                   	ret    

00000414 <exit>:
SYSCALL(exit)
     414:	b8 02 00 00 00       	mov    $0x2,%eax
     419:	cd 40                	int    $0x40
     41b:	c3                   	ret    

0000041c <wait>:
SYSCALL(wait)
     41c:	b8 03 00 00 00       	mov    $0x3,%eax
     421:	cd 40                	int    $0x40
     423:	c3                   	ret    

00000424 <pipe>:
SYSCALL(pipe)
     424:	b8 04 00 00 00       	mov    $0x4,%eax
     429:	cd 40                	int    $0x40
     42b:	c3                   	ret    

0000042c <read>:
SYSCALL(read)
     42c:	b8 05 00 00 00       	mov    $0x5,%eax
     431:	cd 40                	int    $0x40
     433:	c3                   	ret    

00000434 <write>:
SYSCALL(write)
     434:	b8 10 00 00 00       	mov    $0x10,%eax
     439:	cd 40                	int    $0x40
     43b:	c3                   	ret    

0000043c <close>:
SYSCALL(close)
     43c:	b8 15 00 00 00       	mov    $0x15,%eax
     441:	cd 40                	int    $0x40
     443:	c3                   	ret    

00000444 <kill>:
SYSCALL(kill)
     444:	b8 06 00 00 00       	mov    $0x6,%eax
     449:	cd 40                	int    $0x40
     44b:	c3                   	ret    

0000044c <exec>:
SYSCALL(exec)
     44c:	b8 07 00 00 00       	mov    $0x7,%eax
     451:	cd 40                	int    $0x40
     453:	c3                   	ret    

00000454 <open>:
SYSCALL(open)
     454:	b8 0f 00 00 00       	mov    $0xf,%eax
     459:	cd 40                	int    $0x40
     45b:	c3                   	ret    

0000045c <mknod>:
SYSCALL(mknod)
     45c:	b8 11 00 00 00       	mov    $0x11,%eax
     461:	cd 40                	int    $0x40
     463:	c3                   	ret    

00000464 <unlink>:
SYSCALL(unlink)
     464:	b8 12 00 00 00       	mov    $0x12,%eax
     469:	cd 40                	int    $0x40
     46b:	c3                   	ret    

0000046c <fstat>:
SYSCALL(fstat)
     46c:	b8 08 00 00 00       	mov    $0x8,%eax
     471:	cd 40                	int    $0x40
     473:	c3                   	ret    

00000474 <link>:
SYSCALL(link)
     474:	b8 13 00 00 00       	mov    $0x13,%eax
     479:	cd 40                	int    $0x40
     47b:	c3                   	ret    

0000047c <mkdir>:
SYSCALL(mkdir)
     47c:	b8 14 00 00 00       	mov    $0x14,%eax
     481:	cd 40                	int    $0x40
     483:	c3                   	ret    

00000484 <chdir>:
SYSCALL(chdir)
     484:	b8 09 00 00 00       	mov    $0x9,%eax
     489:	cd 40                	int    $0x40
     48b:	c3                   	ret    

0000048c <dup>:
SYSCALL(dup)
     48c:	b8 0a 00 00 00       	mov    $0xa,%eax
     491:	cd 40                	int    $0x40
     493:	c3                   	ret    

00000494 <getpid>:
SYSCALL(getpid)
     494:	b8 0b 00 00 00       	mov    $0xb,%eax
     499:	cd 40                	int    $0x40
     49b:	c3                   	ret    

0000049c <sbrk>:
SYSCALL(sbrk)
     49c:	b8 0c 00 00 00       	mov    $0xc,%eax
     4a1:	cd 40                	int    $0x40
     4a3:	c3                   	ret    

000004a4 <sleep>:
SYSCALL(sleep)
     4a4:	b8 0d 00 00 00       	mov    $0xd,%eax
     4a9:	cd 40                	int    $0x40
     4ab:	c3                   	ret    

000004ac <uptime>:
SYSCALL(uptime)
     4ac:	b8 0e 00 00 00       	mov    $0xe,%eax
     4b1:	cd 40                	int    $0x40
     4b3:	c3                   	ret    

000004b4 <paintWindow>:

SYSCALL(paintWindow)
     4b4:	b8 16 00 00 00       	mov    $0x16,%eax
     4b9:	cd 40                	int    $0x40
     4bb:	c3                   	ret    

000004bc <sendMessage>:
SYSCALL(sendMessage)
     4bc:	b8 17 00 00 00       	mov    $0x17,%eax
     4c1:	cd 40                	int    $0x40
     4c3:	c3                   	ret    

000004c4 <getMessage>:
SYSCALL(getMessage)
     4c4:	b8 19 00 00 00       	mov    $0x19,%eax
     4c9:	cd 40                	int    $0x40
     4cb:	c3                   	ret    

000004cc <registWindow>:
SYSCALL(registWindow)
     4cc:	b8 18 00 00 00       	mov    $0x18,%eax
     4d1:	cd 40                	int    $0x40
     4d3:	c3                   	ret    

000004d4 <changePosition>:
SYSCALL(changePosition)
     4d4:	b8 1a 00 00 00       	mov    $0x1a,%eax
     4d9:	cd 40                	int    $0x40
     4db:	c3                   	ret    

000004dc <setupTimer>:
SYSCALL(setupTimer)
     4dc:	b8 1b 00 00 00       	mov    $0x1b,%eax
     4e1:	cd 40                	int    $0x40
     4e3:	c3                   	ret    

000004e4 <deleteTimer>:
SYSCALL(deleteTimer)
     4e4:	b8 1c 00 00 00       	mov    $0x1c,%eax
     4e9:	cd 40                	int    $0x40
     4eb:	c3                   	ret    

000004ec <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     4ec:	55                   	push   %ebp
     4ed:	89 e5                	mov    %esp,%ebp
     4ef:	83 ec 18             	sub    $0x18,%esp
     4f2:	8b 45 0c             	mov    0xc(%ebp),%eax
     4f5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     4f8:	83 ec 04             	sub    $0x4,%esp
     4fb:	6a 01                	push   $0x1
     4fd:	8d 45 f4             	lea    -0xc(%ebp),%eax
     500:	50                   	push   %eax
     501:	ff 75 08             	pushl  0x8(%ebp)
     504:	e8 2b ff ff ff       	call   434 <write>
     509:	83 c4 10             	add    $0x10,%esp
}
     50c:	90                   	nop
     50d:	c9                   	leave  
     50e:	c3                   	ret    

0000050f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     50f:	55                   	push   %ebp
     510:	89 e5                	mov    %esp,%ebp
     512:	53                   	push   %ebx
     513:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     516:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     51d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     521:	74 17                	je     53a <printint+0x2b>
     523:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     527:	79 11                	jns    53a <printint+0x2b>
    neg = 1;
     529:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     530:	8b 45 0c             	mov    0xc(%ebp),%eax
     533:	f7 d8                	neg    %eax
     535:	89 45 ec             	mov    %eax,-0x14(%ebp)
     538:	eb 06                	jmp    540 <printint+0x31>
  } else {
    x = xx;
     53a:	8b 45 0c             	mov    0xc(%ebp),%eax
     53d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     540:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     547:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     54a:	8d 41 01             	lea    0x1(%ecx),%eax
     54d:	89 45 f4             	mov    %eax,-0xc(%ebp)
     550:	8b 5d 10             	mov    0x10(%ebp),%ebx
     553:	8b 45 ec             	mov    -0x14(%ebp),%eax
     556:	ba 00 00 00 00       	mov    $0x0,%edx
     55b:	f7 f3                	div    %ebx
     55d:	89 d0                	mov    %edx,%eax
     55f:	0f b6 80 80 2c 00 00 	movzbl 0x2c80(%eax),%eax
     566:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     56a:	8b 5d 10             	mov    0x10(%ebp),%ebx
     56d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     570:	ba 00 00 00 00       	mov    $0x0,%edx
     575:	f7 f3                	div    %ebx
     577:	89 45 ec             	mov    %eax,-0x14(%ebp)
     57a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     57e:	75 c7                	jne    547 <printint+0x38>
  if(neg)
     580:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     584:	74 2d                	je     5b3 <printint+0xa4>
    buf[i++] = '-';
     586:	8b 45 f4             	mov    -0xc(%ebp),%eax
     589:	8d 50 01             	lea    0x1(%eax),%edx
     58c:	89 55 f4             	mov    %edx,-0xc(%ebp)
     58f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     594:	eb 1d                	jmp    5b3 <printint+0xa4>
    putc(fd, buf[i]);
     596:	8d 55 dc             	lea    -0x24(%ebp),%edx
     599:	8b 45 f4             	mov    -0xc(%ebp),%eax
     59c:	01 d0                	add    %edx,%eax
     59e:	0f b6 00             	movzbl (%eax),%eax
     5a1:	0f be c0             	movsbl %al,%eax
     5a4:	83 ec 08             	sub    $0x8,%esp
     5a7:	50                   	push   %eax
     5a8:	ff 75 08             	pushl  0x8(%ebp)
     5ab:	e8 3c ff ff ff       	call   4ec <putc>
     5b0:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     5b3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     5b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5bb:	79 d9                	jns    596 <printint+0x87>
    putc(fd, buf[i]);
}
     5bd:	90                   	nop
     5be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5c1:	c9                   	leave  
     5c2:	c3                   	ret    

000005c3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     5c3:	55                   	push   %ebp
     5c4:	89 e5                	mov    %esp,%ebp
     5c6:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     5c9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     5d0:	8d 45 0c             	lea    0xc(%ebp),%eax
     5d3:	83 c0 04             	add    $0x4,%eax
     5d6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     5d9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     5e0:	e9 59 01 00 00       	jmp    73e <printf+0x17b>
    c = fmt[i] & 0xff;
     5e5:	8b 55 0c             	mov    0xc(%ebp),%edx
     5e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5eb:	01 d0                	add    %edx,%eax
     5ed:	0f b6 00             	movzbl (%eax),%eax
     5f0:	0f be c0             	movsbl %al,%eax
     5f3:	25 ff 00 00 00       	and    $0xff,%eax
     5f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     5fb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     5ff:	75 2c                	jne    62d <printf+0x6a>
      if(c == '%'){
     601:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     605:	75 0c                	jne    613 <printf+0x50>
        state = '%';
     607:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     60e:	e9 27 01 00 00       	jmp    73a <printf+0x177>
      } else {
        putc(fd, c);
     613:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     616:	0f be c0             	movsbl %al,%eax
     619:	83 ec 08             	sub    $0x8,%esp
     61c:	50                   	push   %eax
     61d:	ff 75 08             	pushl  0x8(%ebp)
     620:	e8 c7 fe ff ff       	call   4ec <putc>
     625:	83 c4 10             	add    $0x10,%esp
     628:	e9 0d 01 00 00       	jmp    73a <printf+0x177>
      }
    } else if(state == '%'){
     62d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     631:	0f 85 03 01 00 00    	jne    73a <printf+0x177>
      if(c == 'd'){
     637:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     63b:	75 1e                	jne    65b <printf+0x98>
        printint(fd, *ap, 10, 1);
     63d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     640:	8b 00                	mov    (%eax),%eax
     642:	6a 01                	push   $0x1
     644:	6a 0a                	push   $0xa
     646:	50                   	push   %eax
     647:	ff 75 08             	pushl  0x8(%ebp)
     64a:	e8 c0 fe ff ff       	call   50f <printint>
     64f:	83 c4 10             	add    $0x10,%esp
        ap++;
     652:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     656:	e9 d8 00 00 00       	jmp    733 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     65b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     65f:	74 06                	je     667 <printf+0xa4>
     661:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     665:	75 1e                	jne    685 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     667:	8b 45 e8             	mov    -0x18(%ebp),%eax
     66a:	8b 00                	mov    (%eax),%eax
     66c:	6a 00                	push   $0x0
     66e:	6a 10                	push   $0x10
     670:	50                   	push   %eax
     671:	ff 75 08             	pushl  0x8(%ebp)
     674:	e8 96 fe ff ff       	call   50f <printint>
     679:	83 c4 10             	add    $0x10,%esp
        ap++;
     67c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     680:	e9 ae 00 00 00       	jmp    733 <printf+0x170>
      } else if(c == 's'){
     685:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     689:	75 43                	jne    6ce <printf+0x10b>
        s = (char*)*ap;
     68b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     68e:	8b 00                	mov    (%eax),%eax
     690:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     693:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     697:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     69b:	75 25                	jne    6c2 <printf+0xff>
          s = "(null)";
     69d:	c7 45 f4 68 25 00 00 	movl   $0x2568,-0xc(%ebp)
        while(*s != 0){
     6a4:	eb 1c                	jmp    6c2 <printf+0xff>
          putc(fd, *s);
     6a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6a9:	0f b6 00             	movzbl (%eax),%eax
     6ac:	0f be c0             	movsbl %al,%eax
     6af:	83 ec 08             	sub    $0x8,%esp
     6b2:	50                   	push   %eax
     6b3:	ff 75 08             	pushl  0x8(%ebp)
     6b6:	e8 31 fe ff ff       	call   4ec <putc>
     6bb:	83 c4 10             	add    $0x10,%esp
          s++;
     6be:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     6c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6c5:	0f b6 00             	movzbl (%eax),%eax
     6c8:	84 c0                	test   %al,%al
     6ca:	75 da                	jne    6a6 <printf+0xe3>
     6cc:	eb 65                	jmp    733 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     6ce:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     6d2:	75 1d                	jne    6f1 <printf+0x12e>
        putc(fd, *ap);
     6d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6d7:	8b 00                	mov    (%eax),%eax
     6d9:	0f be c0             	movsbl %al,%eax
     6dc:	83 ec 08             	sub    $0x8,%esp
     6df:	50                   	push   %eax
     6e0:	ff 75 08             	pushl  0x8(%ebp)
     6e3:	e8 04 fe ff ff       	call   4ec <putc>
     6e8:	83 c4 10             	add    $0x10,%esp
        ap++;
     6eb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     6ef:	eb 42                	jmp    733 <printf+0x170>
      } else if(c == '%'){
     6f1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     6f5:	75 17                	jne    70e <printf+0x14b>
        putc(fd, c);
     6f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6fa:	0f be c0             	movsbl %al,%eax
     6fd:	83 ec 08             	sub    $0x8,%esp
     700:	50                   	push   %eax
     701:	ff 75 08             	pushl  0x8(%ebp)
     704:	e8 e3 fd ff ff       	call   4ec <putc>
     709:	83 c4 10             	add    $0x10,%esp
     70c:	eb 25                	jmp    733 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     70e:	83 ec 08             	sub    $0x8,%esp
     711:	6a 25                	push   $0x25
     713:	ff 75 08             	pushl  0x8(%ebp)
     716:	e8 d1 fd ff ff       	call   4ec <putc>
     71b:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     71e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     721:	0f be c0             	movsbl %al,%eax
     724:	83 ec 08             	sub    $0x8,%esp
     727:	50                   	push   %eax
     728:	ff 75 08             	pushl  0x8(%ebp)
     72b:	e8 bc fd ff ff       	call   4ec <putc>
     730:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     733:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     73a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     73e:	8b 55 0c             	mov    0xc(%ebp),%edx
     741:	8b 45 f0             	mov    -0x10(%ebp),%eax
     744:	01 d0                	add    %edx,%eax
     746:	0f b6 00             	movzbl (%eax),%eax
     749:	84 c0                	test   %al,%al
     74b:	0f 85 94 fe ff ff    	jne    5e5 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     751:	90                   	nop
     752:	c9                   	leave  
     753:	c3                   	ret    

00000754 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     754:	55                   	push   %ebp
     755:	89 e5                	mov    %esp,%ebp
     757:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     75a:	8b 45 08             	mov    0x8(%ebp),%eax
     75d:	83 e8 08             	sub    $0x8,%eax
     760:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     763:	a1 e8 68 00 00       	mov    0x68e8,%eax
     768:	89 45 fc             	mov    %eax,-0x4(%ebp)
     76b:	eb 24                	jmp    791 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     76d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     770:	8b 00                	mov    (%eax),%eax
     772:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     775:	77 12                	ja     789 <free+0x35>
     777:	8b 45 f8             	mov    -0x8(%ebp),%eax
     77a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     77d:	77 24                	ja     7a3 <free+0x4f>
     77f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     782:	8b 00                	mov    (%eax),%eax
     784:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     787:	77 1a                	ja     7a3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     789:	8b 45 fc             	mov    -0x4(%ebp),%eax
     78c:	8b 00                	mov    (%eax),%eax
     78e:	89 45 fc             	mov    %eax,-0x4(%ebp)
     791:	8b 45 f8             	mov    -0x8(%ebp),%eax
     794:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     797:	76 d4                	jbe    76d <free+0x19>
     799:	8b 45 fc             	mov    -0x4(%ebp),%eax
     79c:	8b 00                	mov    (%eax),%eax
     79e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     7a1:	76 ca                	jbe    76d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     7a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7a6:	8b 40 04             	mov    0x4(%eax),%eax
     7a9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     7b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7b3:	01 c2                	add    %eax,%edx
     7b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7b8:	8b 00                	mov    (%eax),%eax
     7ba:	39 c2                	cmp    %eax,%edx
     7bc:	75 24                	jne    7e2 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     7be:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7c1:	8b 50 04             	mov    0x4(%eax),%edx
     7c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7c7:	8b 00                	mov    (%eax),%eax
     7c9:	8b 40 04             	mov    0x4(%eax),%eax
     7cc:	01 c2                	add    %eax,%edx
     7ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7d1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     7d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7d7:	8b 00                	mov    (%eax),%eax
     7d9:	8b 10                	mov    (%eax),%edx
     7db:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7de:	89 10                	mov    %edx,(%eax)
     7e0:	eb 0a                	jmp    7ec <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     7e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7e5:	8b 10                	mov    (%eax),%edx
     7e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7ea:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     7ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7ef:	8b 40 04             	mov    0x4(%eax),%eax
     7f2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     7f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7fc:	01 d0                	add    %edx,%eax
     7fe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     801:	75 20                	jne    823 <free+0xcf>
    p->s.size += bp->s.size;
     803:	8b 45 fc             	mov    -0x4(%ebp),%eax
     806:	8b 50 04             	mov    0x4(%eax),%edx
     809:	8b 45 f8             	mov    -0x8(%ebp),%eax
     80c:	8b 40 04             	mov    0x4(%eax),%eax
     80f:	01 c2                	add    %eax,%edx
     811:	8b 45 fc             	mov    -0x4(%ebp),%eax
     814:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     817:	8b 45 f8             	mov    -0x8(%ebp),%eax
     81a:	8b 10                	mov    (%eax),%edx
     81c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     81f:	89 10                	mov    %edx,(%eax)
     821:	eb 08                	jmp    82b <free+0xd7>
  } else
    p->s.ptr = bp;
     823:	8b 45 fc             	mov    -0x4(%ebp),%eax
     826:	8b 55 f8             	mov    -0x8(%ebp),%edx
     829:	89 10                	mov    %edx,(%eax)
  freep = p;
     82b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     82e:	a3 e8 68 00 00       	mov    %eax,0x68e8
}
     833:	90                   	nop
     834:	c9                   	leave  
     835:	c3                   	ret    

00000836 <morecore>:

static Header*
morecore(uint nu)
{
     836:	55                   	push   %ebp
     837:	89 e5                	mov    %esp,%ebp
     839:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     83c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     843:	77 07                	ja     84c <morecore+0x16>
    nu = 4096;
     845:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     84c:	8b 45 08             	mov    0x8(%ebp),%eax
     84f:	c1 e0 03             	shl    $0x3,%eax
     852:	83 ec 0c             	sub    $0xc,%esp
     855:	50                   	push   %eax
     856:	e8 41 fc ff ff       	call   49c <sbrk>
     85b:	83 c4 10             	add    $0x10,%esp
     85e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     861:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     865:	75 07                	jne    86e <morecore+0x38>
    return 0;
     867:	b8 00 00 00 00       	mov    $0x0,%eax
     86c:	eb 26                	jmp    894 <morecore+0x5e>
  hp = (Header*)p;
     86e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     871:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     874:	8b 45 f0             	mov    -0x10(%ebp),%eax
     877:	8b 55 08             	mov    0x8(%ebp),%edx
     87a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     87d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     880:	83 c0 08             	add    $0x8,%eax
     883:	83 ec 0c             	sub    $0xc,%esp
     886:	50                   	push   %eax
     887:	e8 c8 fe ff ff       	call   754 <free>
     88c:	83 c4 10             	add    $0x10,%esp
  return freep;
     88f:	a1 e8 68 00 00       	mov    0x68e8,%eax
}
     894:	c9                   	leave  
     895:	c3                   	ret    

00000896 <malloc>:

void*
malloc(uint nbytes)
{
     896:	55                   	push   %ebp
     897:	89 e5                	mov    %esp,%ebp
     899:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     89c:	8b 45 08             	mov    0x8(%ebp),%eax
     89f:	83 c0 07             	add    $0x7,%eax
     8a2:	c1 e8 03             	shr    $0x3,%eax
     8a5:	83 c0 01             	add    $0x1,%eax
     8a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     8ab:	a1 e8 68 00 00       	mov    0x68e8,%eax
     8b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8b7:	75 23                	jne    8dc <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     8b9:	c7 45 f0 e0 68 00 00 	movl   $0x68e0,-0x10(%ebp)
     8c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8c3:	a3 e8 68 00 00       	mov    %eax,0x68e8
     8c8:	a1 e8 68 00 00       	mov    0x68e8,%eax
     8cd:	a3 e0 68 00 00       	mov    %eax,0x68e0
    base.s.size = 0;
     8d2:	c7 05 e4 68 00 00 00 	movl   $0x0,0x68e4
     8d9:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8df:	8b 00                	mov    (%eax),%eax
     8e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     8e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8e7:	8b 40 04             	mov    0x4(%eax),%eax
     8ea:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     8ed:	72 4d                	jb     93c <malloc+0xa6>
      if(p->s.size == nunits)
     8ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f2:	8b 40 04             	mov    0x4(%eax),%eax
     8f5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     8f8:	75 0c                	jne    906 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     8fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8fd:	8b 10                	mov    (%eax),%edx
     8ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
     902:	89 10                	mov    %edx,(%eax)
     904:	eb 26                	jmp    92c <malloc+0x96>
      else {
        p->s.size -= nunits;
     906:	8b 45 f4             	mov    -0xc(%ebp),%eax
     909:	8b 40 04             	mov    0x4(%eax),%eax
     90c:	2b 45 ec             	sub    -0x14(%ebp),%eax
     90f:	89 c2                	mov    %eax,%edx
     911:	8b 45 f4             	mov    -0xc(%ebp),%eax
     914:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     917:	8b 45 f4             	mov    -0xc(%ebp),%eax
     91a:	8b 40 04             	mov    0x4(%eax),%eax
     91d:	c1 e0 03             	shl    $0x3,%eax
     920:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     923:	8b 45 f4             	mov    -0xc(%ebp),%eax
     926:	8b 55 ec             	mov    -0x14(%ebp),%edx
     929:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     92c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     92f:	a3 e8 68 00 00       	mov    %eax,0x68e8
      return (void*)(p + 1);
     934:	8b 45 f4             	mov    -0xc(%ebp),%eax
     937:	83 c0 08             	add    $0x8,%eax
     93a:	eb 3b                	jmp    977 <malloc+0xe1>
    }
    if(p == freep)
     93c:	a1 e8 68 00 00       	mov    0x68e8,%eax
     941:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     944:	75 1e                	jne    964 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     946:	83 ec 0c             	sub    $0xc,%esp
     949:	ff 75 ec             	pushl  -0x14(%ebp)
     94c:	e8 e5 fe ff ff       	call   836 <morecore>
     951:	83 c4 10             	add    $0x10,%esp
     954:	89 45 f4             	mov    %eax,-0xc(%ebp)
     957:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     95b:	75 07                	jne    964 <malloc+0xce>
        return 0;
     95d:	b8 00 00 00 00       	mov    $0x0,%eax
     962:	eb 13                	jmp    977 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     964:	8b 45 f4             	mov    -0xc(%ebp),%eax
     967:	89 45 f0             	mov    %eax,-0x10(%ebp)
     96a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     96d:	8b 00                	mov    (%eax),%eax
     96f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     972:	e9 6d ff ff ff       	jmp    8e4 <malloc+0x4e>
}
     977:	c9                   	leave  
     978:	c3                   	ret    

00000979 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     979:	55                   	push   %ebp
     97a:	89 e5                	mov    %esp,%ebp
     97c:	83 ec 1c             	sub    $0x1c,%esp
     97f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     982:	8b 55 10             	mov    0x10(%ebp),%edx
     985:	8b 45 14             	mov    0x14(%ebp),%eax
     988:	88 4d ec             	mov    %cl,-0x14(%ebp)
     98b:	88 55 e8             	mov    %dl,-0x18(%ebp)
     98e:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     991:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     995:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     998:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     99c:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     99f:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     9a3:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     9a6:	8b 45 08             	mov    0x8(%ebp),%eax
     9a9:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     9ad:	66 89 10             	mov    %dx,(%eax)
     9b0:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     9b4:	88 50 02             	mov    %dl,0x2(%eax)
}
     9b7:	8b 45 08             	mov    0x8(%ebp),%eax
     9ba:	c9                   	leave  
     9bb:	c2 04 00             	ret    $0x4

000009be <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     9be:	55                   	push   %ebp
     9bf:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     9c1:	8b 45 08             	mov    0x8(%ebp),%eax
     9c4:	2b 45 10             	sub    0x10(%ebp),%eax
     9c7:	89 c2                	mov    %eax,%edx
     9c9:	8b 45 08             	mov    0x8(%ebp),%eax
     9cc:	2b 45 10             	sub    0x10(%ebp),%eax
     9cf:	0f af d0             	imul   %eax,%edx
     9d2:	8b 45 0c             	mov    0xc(%ebp),%eax
     9d5:	2b 45 14             	sub    0x14(%ebp),%eax
     9d8:	89 c1                	mov    %eax,%ecx
     9da:	8b 45 0c             	mov    0xc(%ebp),%eax
     9dd:	2b 45 14             	sub    0x14(%ebp),%eax
     9e0:	0f af c1             	imul   %ecx,%eax
     9e3:	01 d0                	add    %edx,%eax
}
     9e5:	5d                   	pop    %ebp
     9e6:	c3                   	ret    

000009e7 <abs_int>:

static inline int abs_int(int x)
{
     9e7:	55                   	push   %ebp
     9e8:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     9ea:	8b 45 08             	mov    0x8(%ebp),%eax
     9ed:	99                   	cltd   
     9ee:	89 d0                	mov    %edx,%eax
     9f0:	33 45 08             	xor    0x8(%ebp),%eax
     9f3:	29 d0                	sub    %edx,%eax
}
     9f5:	5d                   	pop    %ebp
     9f6:	c3                   	ret    

000009f7 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     9f7:	55                   	push   %ebp
     9f8:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     9fa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     9fe:	79 07                	jns    a07 <APGetIndex+0x10>
        return X_SMALLER;
     a00:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     a05:	eb 40                	jmp    a47 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     a07:	8b 45 08             	mov    0x8(%ebp),%eax
     a0a:	8b 00                	mov    (%eax),%eax
     a0c:	3b 45 0c             	cmp    0xc(%ebp),%eax
     a0f:	7f 07                	jg     a18 <APGetIndex+0x21>
        return X_BIGGER;
     a11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a16:	eb 2f                	jmp    a47 <APGetIndex+0x50>
    if (y < 0)
     a18:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     a1c:	79 07                	jns    a25 <APGetIndex+0x2e>
        return Y_SMALLER;
     a1e:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     a23:	eb 22                	jmp    a47 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     a25:	8b 45 08             	mov    0x8(%ebp),%eax
     a28:	8b 40 04             	mov    0x4(%eax),%eax
     a2b:	3b 45 10             	cmp    0x10(%ebp),%eax
     a2e:	7f 07                	jg     a37 <APGetIndex+0x40>
        return Y_BIGGER;
     a30:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     a35:	eb 10                	jmp    a47 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     a37:	8b 45 08             	mov    0x8(%ebp),%eax
     a3a:	8b 00                	mov    (%eax),%eax
     a3c:	0f af 45 10          	imul   0x10(%ebp),%eax
     a40:	89 c2                	mov    %eax,%edx
     a42:	8b 45 0c             	mov    0xc(%ebp),%eax
     a45:	01 d0                	add    %edx,%eax
}
     a47:	5d                   	pop    %ebp
     a48:	c3                   	ret    

00000a49 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     a49:	55                   	push   %ebp
     a4a:	89 e5                	mov    %esp,%ebp
     a4c:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     a4f:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     a56:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a59:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     a5c:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     a63:	83 ec 08             	sub    $0x8,%esp
     a66:	6a 00                	push   $0x0
     a68:	ff 75 0c             	pushl  0xc(%ebp)
     a6b:	e8 e4 f9 ff ff       	call   454 <open>
     a70:	83 c4 10             	add    $0x10,%esp
     a73:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     a76:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     a7a:	79 2e                	jns    aaa <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     a7c:	83 ec 04             	sub    $0x4,%esp
     a7f:	ff 75 0c             	pushl  0xc(%ebp)
     a82:	68 6f 25 00 00       	push   $0x256f
     a87:	6a 01                	push   $0x1
     a89:	e8 35 fb ff ff       	call   5c3 <printf>
     a8e:	83 c4 10             	add    $0x10,%esp
        return bmp;
     a91:	8b 45 08             	mov    0x8(%ebp),%eax
     a94:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a97:	89 10                	mov    %edx,(%eax)
     a99:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a9c:	89 50 04             	mov    %edx,0x4(%eax)
     a9f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     aa2:	89 50 08             	mov    %edx,0x8(%eax)
     aa5:	e9 d2 01 00 00       	jmp    c7c <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     aaa:	83 ec 04             	sub    $0x4,%esp
     aad:	6a 0e                	push   $0xe
     aaf:	8d 45 ba             	lea    -0x46(%ebp),%eax
     ab2:	50                   	push   %eax
     ab3:	ff 75 ec             	pushl  -0x14(%ebp)
     ab6:	e8 71 f9 ff ff       	call   42c <read>
     abb:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     abe:	83 ec 04             	sub    $0x4,%esp
     ac1:	6a 28                	push   $0x28
     ac3:	8d 45 92             	lea    -0x6e(%ebp),%eax
     ac6:	50                   	push   %eax
     ac7:	ff 75 ec             	pushl  -0x14(%ebp)
     aca:	e8 5d f9 ff ff       	call   42c <read>
     acf:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     ad2:	8b 45 96             	mov    -0x6a(%ebp),%eax
     ad5:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     ad8:	8b 45 9a             	mov    -0x66(%ebp),%eax
     adb:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     ade:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ae1:	8b 45 cc             	mov    -0x34(%ebp),%eax
     ae4:	0f af d0             	imul   %eax,%edx
     ae7:	89 d0                	mov    %edx,%eax
     ae9:	01 c0                	add    %eax,%eax
     aeb:	01 d0                	add    %edx,%eax
     aed:	83 ec 0c             	sub    $0xc,%esp
     af0:	50                   	push   %eax
     af1:	e8 a0 fd ff ff       	call   896 <malloc>
     af6:	83 c4 10             	add    $0x10,%esp
     af9:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     afc:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     b00:	0f b7 c0             	movzwl %ax,%eax
     b03:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     b06:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b09:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b0c:	0f af c2             	imul   %edx,%eax
     b0f:	83 c0 1f             	add    $0x1f,%eax
     b12:	c1 e8 05             	shr    $0x5,%eax
     b15:	c1 e0 02             	shl    $0x2,%eax
     b18:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     b1b:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b1e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b21:	0f af c2             	imul   %edx,%eax
     b24:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     b27:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b2a:	83 ec 0c             	sub    $0xc,%esp
     b2d:	50                   	push   %eax
     b2e:	e8 63 fd ff ff       	call   896 <malloc>
     b33:	83 c4 10             	add    $0x10,%esp
     b36:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     b39:	83 ec 04             	sub    $0x4,%esp
     b3c:	ff 75 e0             	pushl  -0x20(%ebp)
     b3f:	ff 75 dc             	pushl  -0x24(%ebp)
     b42:	ff 75 ec             	pushl  -0x14(%ebp)
     b45:	e8 e2 f8 ff ff       	call   42c <read>
     b4a:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     b4d:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     b51:	66 c1 e8 03          	shr    $0x3,%ax
     b55:	0f b7 c0             	movzwl %ax,%eax
     b58:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     b5b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     b62:	e9 e5 00 00 00       	jmp    c4c <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     b67:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b6d:	29 c2                	sub    %eax,%edx
     b6f:	89 d0                	mov    %edx,%eax
     b71:	8d 50 ff             	lea    -0x1(%eax),%edx
     b74:	8b 45 c8             	mov    -0x38(%ebp),%eax
     b77:	0f af c2             	imul   %edx,%eax
     b7a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     b7d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b84:	e9 b1 00 00 00       	jmp    c3a <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     b89:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b8c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b92:	01 c8                	add    %ecx,%eax
     b94:	89 c1                	mov    %eax,%ecx
     b96:	89 c8                	mov    %ecx,%eax
     b98:	01 c0                	add    %eax,%eax
     b9a:	01 c8                	add    %ecx,%eax
     b9c:	01 c2                	add    %eax,%edx
     b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba1:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ba5:	89 c1                	mov    %eax,%ecx
     ba7:	8b 45 d8             	mov    -0x28(%ebp),%eax
     baa:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     bae:	01 c1                	add    %eax,%ecx
     bb0:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bb3:	01 c8                	add    %ecx,%eax
     bb5:	8d 48 ff             	lea    -0x1(%eax),%ecx
     bb8:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bbb:	01 c8                	add    %ecx,%eax
     bbd:	0f b6 00             	movzbl (%eax),%eax
     bc0:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     bc3:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bc6:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     bc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bcc:	01 c8                	add    %ecx,%eax
     bce:	89 c1                	mov    %eax,%ecx
     bd0:	89 c8                	mov    %ecx,%eax
     bd2:	01 c0                	add    %eax,%eax
     bd4:	01 c8                	add    %ecx,%eax
     bd6:	01 c2                	add    %eax,%edx
     bd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bdb:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     bdf:	89 c1                	mov    %eax,%ecx
     be1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     be4:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     be8:	01 c1                	add    %eax,%ecx
     bea:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bed:	01 c8                	add    %ecx,%eax
     bef:	8d 48 fe             	lea    -0x2(%eax),%ecx
     bf2:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bf5:	01 c8                	add    %ecx,%eax
     bf7:	0f b6 00             	movzbl (%eax),%eax
     bfa:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     bfd:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c00:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     c03:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c06:	01 c8                	add    %ecx,%eax
     c08:	89 c1                	mov    %eax,%ecx
     c0a:	89 c8                	mov    %ecx,%eax
     c0c:	01 c0                	add    %eax,%eax
     c0e:	01 c8                	add    %ecx,%eax
     c10:	01 c2                	add    %eax,%edx
     c12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c15:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     c19:	89 c1                	mov    %eax,%ecx
     c1b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c1e:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     c22:	01 c1                	add    %eax,%ecx
     c24:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c27:	01 c8                	add    %ecx,%eax
     c29:	8d 48 fd             	lea    -0x3(%eax),%ecx
     c2c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c2f:	01 c8                	add    %ecx,%eax
     c31:	0f b6 00             	movzbl (%eax),%eax
     c34:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     c36:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     c3a:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c40:	39 c2                	cmp    %eax,%edx
     c42:	0f 87 41 ff ff ff    	ja     b89 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     c48:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c4c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c52:	39 c2                	cmp    %eax,%edx
     c54:	0f 87 0d ff ff ff    	ja     b67 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     c5a:	83 ec 0c             	sub    $0xc,%esp
     c5d:	ff 75 ec             	pushl  -0x14(%ebp)
     c60:	e8 d7 f7 ff ff       	call   43c <close>
     c65:	83 c4 10             	add    $0x10,%esp
    return bmp;
     c68:	8b 45 08             	mov    0x8(%ebp),%eax
     c6b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c6e:	89 10                	mov    %edx,(%eax)
     c70:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c73:	89 50 04             	mov    %edx,0x4(%eax)
     c76:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c79:	89 50 08             	mov    %edx,0x8(%eax)
}
     c7c:	8b 45 08             	mov    0x8(%ebp),%eax
     c7f:	c9                   	leave  
     c80:	c2 04 00             	ret    $0x4

00000c83 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     c83:	55                   	push   %ebp
     c84:	89 e5                	mov    %esp,%ebp
     c86:	53                   	push   %ebx
     c87:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     c8a:	83 ec 0c             	sub    $0xc,%esp
     c8d:	6a 1c                	push   $0x1c
     c8f:	e8 02 fc ff ff       	call   896 <malloc>
     c94:	83 c4 10             	add    $0x10,%esp
     c97:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     c9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c9d:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     ca4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     ca7:	8d 45 d8             	lea    -0x28(%ebp),%eax
     caa:	6a 0c                	push   $0xc
     cac:	6a 0c                	push   $0xc
     cae:	6a 0c                	push   $0xc
     cb0:	50                   	push   %eax
     cb1:	e8 c3 fc ff ff       	call   979 <RGB>
     cb6:	83 c4 0c             	add    $0xc,%esp
     cb9:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     cbd:	66 89 43 13          	mov    %ax,0x13(%ebx)
     cc1:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     cc5:	88 43 15             	mov    %al,0x15(%ebx)
     cc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ccb:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cce:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     cd2:	66 89 48 10          	mov    %cx,0x10(%eax)
     cd6:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     cda:	88 50 12             	mov    %dl,0x12(%eax)
     cdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ce0:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ce3:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     ce7:	66 89 48 08          	mov    %cx,0x8(%eax)
     ceb:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     cef:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     cf2:	8b 45 08             	mov    0x8(%ebp),%eax
     cf5:	89 c2                	mov    %eax,%edx
     cf7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cfa:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     cfc:	8b 45 0c             	mov    0xc(%ebp),%eax
     cff:	89 c2                	mov    %eax,%edx
     d01:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d04:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     d07:	8b 55 10             	mov    0x10(%ebp),%edx
     d0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d0d:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     d10:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     d13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d16:	c9                   	leave  
     d17:	c3                   	ret    

00000d18 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     d18:	55                   	push   %ebp
     d19:	89 e5                	mov    %esp,%ebp
     d1b:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     d1e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d21:	8b 50 08             	mov    0x8(%eax),%edx
     d24:	89 55 f8             	mov    %edx,-0x8(%ebp)
     d27:	8b 40 0c             	mov    0xc(%eax),%eax
     d2a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     d2d:	8b 45 0c             	mov    0xc(%ebp),%eax
     d30:	8b 55 10             	mov    0x10(%ebp),%edx
     d33:	89 50 08             	mov    %edx,0x8(%eax)
     d36:	8b 55 14             	mov    0x14(%ebp),%edx
     d39:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     d3c:	8b 45 08             	mov    0x8(%ebp),%eax
     d3f:	8b 55 f8             	mov    -0x8(%ebp),%edx
     d42:	89 10                	mov    %edx,(%eax)
     d44:	8b 55 fc             	mov    -0x4(%ebp),%edx
     d47:	89 50 04             	mov    %edx,0x4(%eax)
}
     d4a:	8b 45 08             	mov    0x8(%ebp),%eax
     d4d:	c9                   	leave  
     d4e:	c2 04 00             	ret    $0x4

00000d51 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     d51:	55                   	push   %ebp
     d52:	89 e5                	mov    %esp,%ebp
     d54:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     d57:	8b 45 0c             	mov    0xc(%ebp),%eax
     d5a:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     d5e:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     d62:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     d66:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     d69:	8b 45 0c             	mov    0xc(%ebp),%eax
     d6c:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     d70:	66 89 50 10          	mov    %dx,0x10(%eax)
     d74:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     d78:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     d7b:	8b 45 08             	mov    0x8(%ebp),%eax
     d7e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d82:	66 89 10             	mov    %dx,(%eax)
     d85:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d89:	88 50 02             	mov    %dl,0x2(%eax)
}
     d8c:	8b 45 08             	mov    0x8(%ebp),%eax
     d8f:	c9                   	leave  
     d90:	c2 04 00             	ret    $0x4

00000d93 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     d93:	55                   	push   %ebp
     d94:	89 e5                	mov    %esp,%ebp
     d96:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     d99:	8b 45 0c             	mov    0xc(%ebp),%eax
     d9c:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     da0:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     da4:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     da8:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     dab:	8b 45 0c             	mov    0xc(%ebp),%eax
     dae:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     db2:	66 89 50 13          	mov    %dx,0x13(%eax)
     db6:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     dba:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     dbd:	8b 45 08             	mov    0x8(%ebp),%eax
     dc0:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     dc4:	66 89 10             	mov    %dx,(%eax)
     dc7:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     dcb:	88 50 02             	mov    %dl,0x2(%eax)
}
     dce:	8b 45 08             	mov    0x8(%ebp),%eax
     dd1:	c9                   	leave  
     dd2:	c2 04 00             	ret    $0x4

00000dd5 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     dd5:	55                   	push   %ebp
     dd6:	89 e5                	mov    %esp,%ebp
     dd8:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     ddb:	8b 45 08             	mov    0x8(%ebp),%eax
     dde:	8b 40 0c             	mov    0xc(%eax),%eax
     de1:	89 c2                	mov    %eax,%edx
     de3:	c1 ea 1f             	shr    $0x1f,%edx
     de6:	01 d0                	add    %edx,%eax
     de8:	d1 f8                	sar    %eax
     dea:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     ded:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df0:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     df4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     df7:	8b 45 10             	mov    0x10(%ebp),%eax
     dfa:	2b 45 f4             	sub    -0xc(%ebp),%eax
     dfd:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     e00:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     e04:	0f 89 98 00 00 00    	jns    ea2 <APDrawPoint+0xcd>
        i = 0;
     e0a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     e11:	e9 8c 00 00 00       	jmp    ea2 <APDrawPoint+0xcd>
    {
        j = x - off;
     e16:	8b 45 0c             	mov    0xc(%ebp),%eax
     e19:	2b 45 f4             	sub    -0xc(%ebp),%eax
     e1c:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     e1f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     e23:	79 69                	jns    e8e <APDrawPoint+0xb9>
            j = 0;
     e25:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     e2c:	eb 60                	jmp    e8e <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     e2e:	ff 75 fc             	pushl  -0x4(%ebp)
     e31:	ff 75 f8             	pushl  -0x8(%ebp)
     e34:	ff 75 08             	pushl  0x8(%ebp)
     e37:	e8 bb fb ff ff       	call   9f7 <APGetIndex>
     e3c:	83 c4 0c             	add    $0xc,%esp
     e3f:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     e42:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     e46:	74 55                	je     e9d <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     e48:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     e4c:	74 67                	je     eb5 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     e4e:	ff 75 10             	pushl  0x10(%ebp)
     e51:	ff 75 0c             	pushl  0xc(%ebp)
     e54:	ff 75 fc             	pushl  -0x4(%ebp)
     e57:	ff 75 f8             	pushl  -0x8(%ebp)
     e5a:	e8 5f fb ff ff       	call   9be <distance_2>
     e5f:	83 c4 10             	add    $0x10,%esp
     e62:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     e65:	7f 23                	jg     e8a <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     e67:	8b 45 08             	mov    0x8(%ebp),%eax
     e6a:	8b 48 18             	mov    0x18(%eax),%ecx
     e6d:	8b 55 ec             	mov    -0x14(%ebp),%edx
     e70:	89 d0                	mov    %edx,%eax
     e72:	01 c0                	add    %eax,%eax
     e74:	01 d0                	add    %edx,%eax
     e76:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     e79:	8b 45 08             	mov    0x8(%ebp),%eax
     e7c:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     e80:	66 89 0a             	mov    %cx,(%edx)
     e83:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     e87:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     e8a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     e8e:	8b 55 0c             	mov    0xc(%ebp),%edx
     e91:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e94:	01 d0                	add    %edx,%eax
     e96:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     e99:	7d 93                	jge    e2e <APDrawPoint+0x59>
     e9b:	eb 01                	jmp    e9e <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     e9d:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     e9e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     ea2:	8b 55 10             	mov    0x10(%ebp),%edx
     ea5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ea8:	01 d0                	add    %edx,%eax
     eaa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     ead:	0f 8d 63 ff ff ff    	jge    e16 <APDrawPoint+0x41>
     eb3:	eb 01                	jmp    eb6 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     eb5:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     eb6:	c9                   	leave  
     eb7:	c3                   	ret    

00000eb8 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     eb8:	55                   	push   %ebp
     eb9:	89 e5                	mov    %esp,%ebp
     ebb:	53                   	push   %ebx
     ebc:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     ebf:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec2:	3b 45 14             	cmp    0x14(%ebp),%eax
     ec5:	0f 85 80 00 00 00    	jne    f4b <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     ecb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ecf:	0f 88 9d 02 00 00    	js     1172 <APDrawLine+0x2ba>
     ed5:	8b 45 08             	mov    0x8(%ebp),%eax
     ed8:	8b 00                	mov    (%eax),%eax
     eda:	3b 45 0c             	cmp    0xc(%ebp),%eax
     edd:	0f 8e 8f 02 00 00    	jle    1172 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     ee3:	8b 45 10             	mov    0x10(%ebp),%eax
     ee6:	3b 45 18             	cmp    0x18(%ebp),%eax
     ee9:	7e 12                	jle    efd <APDrawLine+0x45>
        {
            int tmp = y2;
     eeb:	8b 45 18             	mov    0x18(%ebp),%eax
     eee:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     ef1:	8b 45 10             	mov    0x10(%ebp),%eax
     ef4:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     ef7:	8b 45 dc             	mov    -0x24(%ebp),%eax
     efa:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     efd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     f01:	79 07                	jns    f0a <APDrawLine+0x52>
     f03:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     f0a:	8b 45 08             	mov    0x8(%ebp),%eax
     f0d:	8b 40 04             	mov    0x4(%eax),%eax
     f10:	3b 45 18             	cmp    0x18(%ebp),%eax
     f13:	7d 0c                	jge    f21 <APDrawLine+0x69>
     f15:	8b 45 08             	mov    0x8(%ebp),%eax
     f18:	8b 40 04             	mov    0x4(%eax),%eax
     f1b:	83 e8 01             	sub    $0x1,%eax
     f1e:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     f21:	8b 45 10             	mov    0x10(%ebp),%eax
     f24:	89 45 f4             	mov    %eax,-0xc(%ebp)
     f27:	eb 15                	jmp    f3e <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     f29:	ff 75 f4             	pushl  -0xc(%ebp)
     f2c:	ff 75 0c             	pushl  0xc(%ebp)
     f2f:	ff 75 08             	pushl  0x8(%ebp)
     f32:	e8 9e fe ff ff       	call   dd5 <APDrawPoint>
     f37:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     f3a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f41:	3b 45 18             	cmp    0x18(%ebp),%eax
     f44:	7e e3                	jle    f29 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     f46:	e9 2b 02 00 00       	jmp    1176 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     f4b:	8b 45 10             	mov    0x10(%ebp),%eax
     f4e:	3b 45 18             	cmp    0x18(%ebp),%eax
     f51:	75 7f                	jne    fd2 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     f53:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     f57:	0f 88 18 02 00 00    	js     1175 <APDrawLine+0x2bd>
     f5d:	8b 45 08             	mov    0x8(%ebp),%eax
     f60:	8b 40 04             	mov    0x4(%eax),%eax
     f63:	3b 45 10             	cmp    0x10(%ebp),%eax
     f66:	0f 8e 09 02 00 00    	jle    1175 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     f6c:	8b 45 0c             	mov    0xc(%ebp),%eax
     f6f:	3b 45 14             	cmp    0x14(%ebp),%eax
     f72:	7e 12                	jle    f86 <APDrawLine+0xce>
        {
            int tmp = x2;
     f74:	8b 45 14             	mov    0x14(%ebp),%eax
     f77:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     f7a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f7d:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     f80:	8b 45 d8             	mov    -0x28(%ebp),%eax
     f83:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     f86:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f8a:	79 07                	jns    f93 <APDrawLine+0xdb>
     f8c:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     f93:	8b 45 08             	mov    0x8(%ebp),%eax
     f96:	8b 00                	mov    (%eax),%eax
     f98:	3b 45 14             	cmp    0x14(%ebp),%eax
     f9b:	7d 0b                	jge    fa8 <APDrawLine+0xf0>
     f9d:	8b 45 08             	mov    0x8(%ebp),%eax
     fa0:	8b 00                	mov    (%eax),%eax
     fa2:	83 e8 01             	sub    $0x1,%eax
     fa5:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     fa8:	8b 45 0c             	mov    0xc(%ebp),%eax
     fab:	89 45 f0             	mov    %eax,-0x10(%ebp)
     fae:	eb 15                	jmp    fc5 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     fb0:	ff 75 10             	pushl  0x10(%ebp)
     fb3:	ff 75 f0             	pushl  -0x10(%ebp)
     fb6:	ff 75 08             	pushl  0x8(%ebp)
     fb9:	e8 17 fe ff ff       	call   dd5 <APDrawPoint>
     fbe:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     fc1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     fc5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fc8:	3b 45 14             	cmp    0x14(%ebp),%eax
     fcb:	7e e3                	jle    fb0 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     fcd:	e9 a4 01 00 00       	jmp    1176 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     fd2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     fd9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     fe0:	8b 45 0c             	mov    0xc(%ebp),%eax
     fe3:	2b 45 14             	sub    0x14(%ebp),%eax
     fe6:	50                   	push   %eax
     fe7:	e8 fb f9 ff ff       	call   9e7 <abs_int>
     fec:	83 c4 04             	add    $0x4,%esp
     fef:	89 c3                	mov    %eax,%ebx
     ff1:	8b 45 10             	mov    0x10(%ebp),%eax
     ff4:	2b 45 18             	sub    0x18(%ebp),%eax
     ff7:	50                   	push   %eax
     ff8:	e8 ea f9 ff ff       	call   9e7 <abs_int>
     ffd:	83 c4 04             	add    $0x4,%esp
    1000:	39 c3                	cmp    %eax,%ebx
    1002:	0f 8e b5 00 00 00    	jle    10bd <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1008:	8b 45 10             	mov    0x10(%ebp),%eax
    100b:	2b 45 18             	sub    0x18(%ebp),%eax
    100e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1011:	db 45 b0             	fildl  -0x50(%ebp)
    1014:	8b 45 0c             	mov    0xc(%ebp),%eax
    1017:	2b 45 14             	sub    0x14(%ebp),%eax
    101a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    101d:	db 45 b0             	fildl  -0x50(%ebp)
    1020:	de f9                	fdivrp %st,%st(1)
    1022:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1025:	8b 45 14             	mov    0x14(%ebp),%eax
    1028:	3b 45 0c             	cmp    0xc(%ebp),%eax
    102b:	7e 0e                	jle    103b <APDrawLine+0x183>
        {
            s = x1;
    102d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1030:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    1033:	8b 45 14             	mov    0x14(%ebp),%eax
    1036:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1039:	eb 0c                	jmp    1047 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    103b:	8b 45 14             	mov    0x14(%ebp),%eax
    103e:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1041:	8b 45 0c             	mov    0xc(%ebp),%eax
    1044:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1047:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    104b:	79 07                	jns    1054 <APDrawLine+0x19c>
    104d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1054:	8b 45 08             	mov    0x8(%ebp),%eax
    1057:	8b 00                	mov    (%eax),%eax
    1059:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    105c:	7f 0b                	jg     1069 <APDrawLine+0x1b1>
    105e:	8b 45 08             	mov    0x8(%ebp),%eax
    1061:	8b 00                	mov    (%eax),%eax
    1063:	83 e8 01             	sub    $0x1,%eax
    1066:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1069:	8b 45 ec             	mov    -0x14(%ebp),%eax
    106c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    106f:	eb 3f                	jmp    10b0 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1071:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1074:	2b 45 0c             	sub    0xc(%ebp),%eax
    1077:	89 45 b0             	mov    %eax,-0x50(%ebp)
    107a:	db 45 b0             	fildl  -0x50(%ebp)
    107d:	dc 4d d0             	fmull  -0x30(%ebp)
    1080:	db 45 10             	fildl  0x10(%ebp)
    1083:	de c1                	faddp  %st,%st(1)
    1085:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1088:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    108c:	b4 0c                	mov    $0xc,%ah
    108e:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1092:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1095:	db 5d cc             	fistpl -0x34(%ebp)
    1098:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    109b:	ff 75 cc             	pushl  -0x34(%ebp)
    109e:	ff 75 e4             	pushl  -0x1c(%ebp)
    10a1:	ff 75 08             	pushl  0x8(%ebp)
    10a4:	e8 2c fd ff ff       	call   dd5 <APDrawPoint>
    10a9:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    10ac:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    10b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10b3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10b6:	7e b9                	jle    1071 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    10b8:	e9 b9 00 00 00       	jmp    1176 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    10bd:	8b 45 0c             	mov    0xc(%ebp),%eax
    10c0:	2b 45 14             	sub    0x14(%ebp),%eax
    10c3:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10c6:	db 45 b0             	fildl  -0x50(%ebp)
    10c9:	8b 45 10             	mov    0x10(%ebp),%eax
    10cc:	2b 45 18             	sub    0x18(%ebp),%eax
    10cf:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10d2:	db 45 b0             	fildl  -0x50(%ebp)
    10d5:	de f9                	fdivrp %st,%st(1)
    10d7:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    10da:	8b 45 10             	mov    0x10(%ebp),%eax
    10dd:	3b 45 18             	cmp    0x18(%ebp),%eax
    10e0:	7e 0e                	jle    10f0 <APDrawLine+0x238>
    {
        s = y2;
    10e2:	8b 45 18             	mov    0x18(%ebp),%eax
    10e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    10e8:	8b 45 10             	mov    0x10(%ebp),%eax
    10eb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    10ee:	eb 0c                	jmp    10fc <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    10f0:	8b 45 10             	mov    0x10(%ebp),%eax
    10f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    10f6:	8b 45 18             	mov    0x18(%ebp),%eax
    10f9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    10fc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1100:	79 07                	jns    1109 <APDrawLine+0x251>
    1102:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1109:	8b 45 08             	mov    0x8(%ebp),%eax
    110c:	8b 40 04             	mov    0x4(%eax),%eax
    110f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1112:	7f 0c                	jg     1120 <APDrawLine+0x268>
    1114:	8b 45 08             	mov    0x8(%ebp),%eax
    1117:	8b 40 04             	mov    0x4(%eax),%eax
    111a:	83 e8 01             	sub    $0x1,%eax
    111d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1120:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1123:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1126:	eb 3f                	jmp    1167 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1128:	8b 45 e0             	mov    -0x20(%ebp),%eax
    112b:	2b 45 10             	sub    0x10(%ebp),%eax
    112e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1131:	db 45 b0             	fildl  -0x50(%ebp)
    1134:	dc 4d c0             	fmull  -0x40(%ebp)
    1137:	db 45 0c             	fildl  0xc(%ebp)
    113a:	de c1                	faddp  %st,%st(1)
    113c:	d9 7d b6             	fnstcw -0x4a(%ebp)
    113f:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1143:	b4 0c                	mov    $0xc,%ah
    1145:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1149:	d9 6d b4             	fldcw  -0x4c(%ebp)
    114c:	db 5d bc             	fistpl -0x44(%ebp)
    114f:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1152:	ff 75 e0             	pushl  -0x20(%ebp)
    1155:	ff 75 bc             	pushl  -0x44(%ebp)
    1158:	ff 75 08             	pushl  0x8(%ebp)
    115b:	e8 75 fc ff ff       	call   dd5 <APDrawPoint>
    1160:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1163:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1167:	8b 45 e0             	mov    -0x20(%ebp),%eax
    116a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    116d:	7e b9                	jle    1128 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    116f:	90                   	nop
    1170:	eb 04                	jmp    1176 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1172:	90                   	nop
    1173:	eb 01                	jmp    1176 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1175:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1176:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1179:	c9                   	leave  
    117a:	c3                   	ret    

0000117b <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    117b:	55                   	push   %ebp
    117c:	89 e5                	mov    %esp,%ebp
    117e:	53                   	push   %ebx
    117f:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1182:	8b 55 10             	mov    0x10(%ebp),%edx
    1185:	8b 45 18             	mov    0x18(%ebp),%eax
    1188:	01 d0                	add    %edx,%eax
    118a:	83 e8 01             	sub    $0x1,%eax
    118d:	83 ec 04             	sub    $0x4,%esp
    1190:	50                   	push   %eax
    1191:	ff 75 0c             	pushl  0xc(%ebp)
    1194:	ff 75 10             	pushl  0x10(%ebp)
    1197:	ff 75 0c             	pushl  0xc(%ebp)
    119a:	ff 75 08             	pushl  0x8(%ebp)
    119d:	e8 16 fd ff ff       	call   eb8 <APDrawLine>
    11a2:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    11a5:	8b 55 0c             	mov    0xc(%ebp),%edx
    11a8:	8b 45 14             	mov    0x14(%ebp),%eax
    11ab:	01 d0                	add    %edx,%eax
    11ad:	83 e8 01             	sub    $0x1,%eax
    11b0:	83 ec 04             	sub    $0x4,%esp
    11b3:	ff 75 10             	pushl  0x10(%ebp)
    11b6:	50                   	push   %eax
    11b7:	ff 75 10             	pushl  0x10(%ebp)
    11ba:	ff 75 0c             	pushl  0xc(%ebp)
    11bd:	ff 75 08             	pushl  0x8(%ebp)
    11c0:	e8 f3 fc ff ff       	call   eb8 <APDrawLine>
    11c5:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    11c8:	8b 55 10             	mov    0x10(%ebp),%edx
    11cb:	8b 45 18             	mov    0x18(%ebp),%eax
    11ce:	01 d0                	add    %edx,%eax
    11d0:	8d 48 ff             	lea    -0x1(%eax),%ecx
    11d3:	8b 55 0c             	mov    0xc(%ebp),%edx
    11d6:	8b 45 14             	mov    0x14(%ebp),%eax
    11d9:	01 d0                	add    %edx,%eax
    11db:	8d 50 ff             	lea    -0x1(%eax),%edx
    11de:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    11e1:	8b 45 14             	mov    0x14(%ebp),%eax
    11e4:	01 d8                	add    %ebx,%eax
    11e6:	83 e8 01             	sub    $0x1,%eax
    11e9:	83 ec 04             	sub    $0x4,%esp
    11ec:	51                   	push   %ecx
    11ed:	52                   	push   %edx
    11ee:	ff 75 10             	pushl  0x10(%ebp)
    11f1:	50                   	push   %eax
    11f2:	ff 75 08             	pushl  0x8(%ebp)
    11f5:	e8 be fc ff ff       	call   eb8 <APDrawLine>
    11fa:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    11fd:	8b 55 10             	mov    0x10(%ebp),%edx
    1200:	8b 45 18             	mov    0x18(%ebp),%eax
    1203:	01 d0                	add    %edx,%eax
    1205:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1208:	8b 55 0c             	mov    0xc(%ebp),%edx
    120b:	8b 45 14             	mov    0x14(%ebp),%eax
    120e:	01 d0                	add    %edx,%eax
    1210:	8d 50 ff             	lea    -0x1(%eax),%edx
    1213:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1216:	8b 45 18             	mov    0x18(%ebp),%eax
    1219:	01 d8                	add    %ebx,%eax
    121b:	83 e8 01             	sub    $0x1,%eax
    121e:	83 ec 04             	sub    $0x4,%esp
    1221:	51                   	push   %ecx
    1222:	52                   	push   %edx
    1223:	50                   	push   %eax
    1224:	ff 75 0c             	pushl  0xc(%ebp)
    1227:	ff 75 08             	pushl  0x8(%ebp)
    122a:	e8 89 fc ff ff       	call   eb8 <APDrawLine>
    122f:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1232:	8b 55 0c             	mov    0xc(%ebp),%edx
    1235:	8b 45 14             	mov    0x14(%ebp),%eax
    1238:	01 d0                	add    %edx,%eax
    123a:	8d 50 ff             	lea    -0x1(%eax),%edx
    123d:	8b 45 08             	mov    0x8(%ebp),%eax
    1240:	8b 40 0c             	mov    0xc(%eax),%eax
    1243:	89 c1                	mov    %eax,%ecx
    1245:	c1 e9 1f             	shr    $0x1f,%ecx
    1248:	01 c8                	add    %ecx,%eax
    124a:	d1 f8                	sar    %eax
    124c:	29 c2                	sub    %eax,%edx
    124e:	89 d0                	mov    %edx,%eax
    1250:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1253:	8b 55 10             	mov    0x10(%ebp),%edx
    1256:	8b 45 18             	mov    0x18(%ebp),%eax
    1259:	01 d0                	add    %edx,%eax
    125b:	8d 50 ff             	lea    -0x1(%eax),%edx
    125e:	8b 45 08             	mov    0x8(%ebp),%eax
    1261:	8b 40 0c             	mov    0xc(%eax),%eax
    1264:	89 c1                	mov    %eax,%ecx
    1266:	c1 e9 1f             	shr    $0x1f,%ecx
    1269:	01 c8                	add    %ecx,%eax
    126b:	d1 f8                	sar    %eax
    126d:	29 c2                	sub    %eax,%edx
    126f:	89 d0                	mov    %edx,%eax
    1271:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1274:	8b 45 08             	mov    0x8(%ebp),%eax
    1277:	8b 40 0c             	mov    0xc(%eax),%eax
    127a:	89 c2                	mov    %eax,%edx
    127c:	c1 ea 1f             	shr    $0x1f,%edx
    127f:	01 d0                	add    %edx,%eax
    1281:	d1 f8                	sar    %eax
    1283:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1286:	8b 45 08             	mov    0x8(%ebp),%eax
    1289:	8b 40 0c             	mov    0xc(%eax),%eax
    128c:	89 c2                	mov    %eax,%edx
    128e:	c1 ea 1f             	shr    $0x1f,%edx
    1291:	01 d0                	add    %edx,%eax
    1293:	d1 f8                	sar    %eax
    1295:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1298:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    129c:	0f 88 d8 00 00 00    	js     137a <APDrawRect+0x1ff>
    12a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    12a6:	0f 88 ce 00 00 00    	js     137a <APDrawRect+0x1ff>
    12ac:	8b 45 08             	mov    0x8(%ebp),%eax
    12af:	8b 00                	mov    (%eax),%eax
    12b1:	3b 45 0c             	cmp    0xc(%ebp),%eax
    12b4:	0f 8e c0 00 00 00    	jle    137a <APDrawRect+0x1ff>
    12ba:	8b 45 08             	mov    0x8(%ebp),%eax
    12bd:	8b 40 04             	mov    0x4(%eax),%eax
    12c0:	3b 45 10             	cmp    0x10(%ebp),%eax
    12c3:	0f 8e b1 00 00 00    	jle    137a <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    12c9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    12cd:	79 07                	jns    12d6 <APDrawRect+0x15b>
    12cf:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    12d6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12da:	79 07                	jns    12e3 <APDrawRect+0x168>
    12dc:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    12e3:	8b 45 08             	mov    0x8(%ebp),%eax
    12e6:	8b 00                	mov    (%eax),%eax
    12e8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    12eb:	7f 0b                	jg     12f8 <APDrawRect+0x17d>
    12ed:	8b 45 08             	mov    0x8(%ebp),%eax
    12f0:	8b 00                	mov    (%eax),%eax
    12f2:	83 e8 01             	sub    $0x1,%eax
    12f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    12f8:	8b 45 08             	mov    0x8(%ebp),%eax
    12fb:	8b 40 04             	mov    0x4(%eax),%eax
    12fe:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1301:	7f 0c                	jg     130f <APDrawRect+0x194>
    1303:	8b 45 08             	mov    0x8(%ebp),%eax
    1306:	8b 40 04             	mov    0x4(%eax),%eax
    1309:	83 e8 01             	sub    $0x1,%eax
    130c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    130f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1316:	8b 45 0c             	mov    0xc(%ebp),%eax
    1319:	89 45 ec             	mov    %eax,-0x14(%ebp)
    131c:	eb 52                	jmp    1370 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    131e:	8b 45 10             	mov    0x10(%ebp),%eax
    1321:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1324:	eb 3e                	jmp    1364 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1326:	83 ec 04             	sub    $0x4,%esp
    1329:	ff 75 e8             	pushl  -0x18(%ebp)
    132c:	ff 75 ec             	pushl  -0x14(%ebp)
    132f:	ff 75 08             	pushl  0x8(%ebp)
    1332:	e8 c0 f6 ff ff       	call   9f7 <APGetIndex>
    1337:	83 c4 10             	add    $0x10,%esp
    133a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    133d:	8b 45 08             	mov    0x8(%ebp),%eax
    1340:	8b 48 18             	mov    0x18(%eax),%ecx
    1343:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1346:	89 d0                	mov    %edx,%eax
    1348:	01 c0                	add    %eax,%eax
    134a:	01 d0                	add    %edx,%eax
    134c:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    134f:	8b 45 08             	mov    0x8(%ebp),%eax
    1352:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1356:	66 89 0a             	mov    %cx,(%edx)
    1359:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    135d:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1360:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1364:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1367:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    136a:	7e ba                	jle    1326 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    136c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1370:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1373:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1376:	7e a6                	jle    131e <APDrawRect+0x1a3>
    1378:	eb 01                	jmp    137b <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    137a:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    137b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    137e:	c9                   	leave  
    137f:	c3                   	ret    

00001380 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1380:	55                   	push   %ebp
    1381:	89 e5                	mov    %esp,%ebp
    1383:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    1386:	83 ec 0c             	sub    $0xc,%esp
    1389:	ff 75 0c             	pushl  0xc(%ebp)
    138c:	e8 c1 ee ff ff       	call   252 <strlen>
    1391:	83 c4 10             	add    $0x10,%esp
    1394:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1397:	8b 45 08             	mov    0x8(%ebp),%eax
    139a:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    139e:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    13a2:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    13a6:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    13a9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    13b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13b7:	e9 bc 00 00 00       	jmp    1478 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    13bc:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    13c2:	01 d0                	add    %edx,%eax
    13c4:	0f b6 00             	movzbl (%eax),%eax
    13c7:	0f be c0             	movsbl %al,%eax
    13ca:	83 e8 20             	sub    $0x20,%eax
    13cd:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    13d0:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    13d4:	0f 87 9a 00 00 00    	ja     1474 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    13da:	8b 45 08             	mov    0x8(%ebp),%eax
    13dd:	8b 00                	mov    (%eax),%eax
    13df:	0f af 45 14          	imul   0x14(%ebp),%eax
    13e3:	89 c2                	mov    %eax,%edx
    13e5:	8b 45 10             	mov    0x10(%ebp),%eax
    13e8:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    13eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13ee:	89 d0                	mov    %edx,%eax
    13f0:	c1 e0 03             	shl    $0x3,%eax
    13f3:	01 d0                	add    %edx,%eax
    13f5:	01 c8                	add    %ecx,%eax
    13f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    13fa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1401:	eb 6b                	jmp    146e <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1403:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    140a:	eb 50                	jmp    145c <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    140c:	8b 55 ec             	mov    -0x14(%ebp),%edx
    140f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1412:	89 d0                	mov    %edx,%eax
    1414:	c1 e0 03             	shl    $0x3,%eax
    1417:	01 d0                	add    %edx,%eax
    1419:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    141f:	01 c2                	add    %eax,%edx
    1421:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1424:	01 d0                	add    %edx,%eax
    1426:	05 a0 2c 00 00       	add    $0x2ca0,%eax
    142b:	0f b6 00             	movzbl (%eax),%eax
    142e:	84 c0                	test   %al,%al
    1430:	74 26                	je     1458 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    1432:	8b 45 08             	mov    0x8(%ebp),%eax
    1435:	8b 50 18             	mov    0x18(%eax),%edx
    1438:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    143b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    143e:	01 c8                	add    %ecx,%eax
    1440:	89 c1                	mov    %eax,%ecx
    1442:	89 c8                	mov    %ecx,%eax
    1444:	01 c0                	add    %eax,%eax
    1446:	01 c8                	add    %ecx,%eax
    1448:	01 d0                	add    %edx,%eax
    144a:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    144e:	66 89 10             	mov    %dx,(%eax)
    1451:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1455:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1458:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    145c:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1460:	7e aa                	jle    140c <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1462:	8b 45 08             	mov    0x8(%ebp),%eax
    1465:	8b 00                	mov    (%eax),%eax
    1467:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    146a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    146e:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1472:	7e 8f                	jle    1403 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    1474:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1478:	8b 45 f4             	mov    -0xc(%ebp),%eax
    147b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    147e:	0f 82 38 ff ff ff    	jb     13bc <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1484:	90                   	nop
    1485:	c9                   	leave  
    1486:	c3                   	ret    

00001487 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1487:	55                   	push   %ebp
    1488:	89 e5                	mov    %esp,%ebp
    148a:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    148d:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1491:	0f 88 8e 01 00 00    	js     1625 <APDcCopy+0x19e>
    1497:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    149b:	0f 88 84 01 00 00    	js     1625 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    14a1:	8b 55 0c             	mov    0xc(%ebp),%edx
    14a4:	8b 45 20             	mov    0x20(%ebp),%eax
    14a7:	01 d0                	add    %edx,%eax
    14a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    14ac:	8b 55 10             	mov    0x10(%ebp),%edx
    14af:	8b 45 24             	mov    0x24(%ebp),%eax
    14b2:	01 d0                	add    %edx,%eax
    14b4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    14b7:	8b 55 18             	mov    0x18(%ebp),%edx
    14ba:	8b 45 20             	mov    0x20(%ebp),%eax
    14bd:	01 d0                	add    %edx,%eax
    14bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14c2:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14c5:	8b 45 24             	mov    0x24(%ebp),%eax
    14c8:	01 d0                	add    %edx,%eax
    14ca:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    14cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14d1:	0f 88 51 01 00 00    	js     1628 <APDcCopy+0x1a1>
    14d7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    14db:	0f 88 47 01 00 00    	js     1628 <APDcCopy+0x1a1>
    14e1:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    14e5:	0f 88 3d 01 00 00    	js     1628 <APDcCopy+0x1a1>
    14eb:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    14ef:	0f 88 33 01 00 00    	js     1628 <APDcCopy+0x1a1>
    14f5:	8b 45 14             	mov    0x14(%ebp),%eax
    14f8:	8b 00                	mov    (%eax),%eax
    14fa:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    14fd:	0f 8c 25 01 00 00    	jl     1628 <APDcCopy+0x1a1>
    1503:	8b 45 14             	mov    0x14(%ebp),%eax
    1506:	8b 40 04             	mov    0x4(%eax),%eax
    1509:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    150c:	0f 8c 16 01 00 00    	jl     1628 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1512:	8b 45 08             	mov    0x8(%ebp),%eax
    1515:	8b 00                	mov    (%eax),%eax
    1517:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    151a:	7f 0b                	jg     1527 <APDcCopy+0xa0>
    151c:	8b 45 08             	mov    0x8(%ebp),%eax
    151f:	8b 00                	mov    (%eax),%eax
    1521:	83 e8 01             	sub    $0x1,%eax
    1524:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1527:	8b 45 08             	mov    0x8(%ebp),%eax
    152a:	8b 40 04             	mov    0x4(%eax),%eax
    152d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1530:	7f 0c                	jg     153e <APDcCopy+0xb7>
    1532:	8b 45 08             	mov    0x8(%ebp),%eax
    1535:	8b 40 04             	mov    0x4(%eax),%eax
    1538:	83 e8 01             	sub    $0x1,%eax
    153b:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    153e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1545:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    154c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1553:	e9 bc 00 00 00       	jmp    1614 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1558:	8b 45 08             	mov    0x8(%ebp),%eax
    155b:	8b 00                	mov    (%eax),%eax
    155d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1560:	8b 55 10             	mov    0x10(%ebp),%edx
    1563:	01 ca                	add    %ecx,%edx
    1565:	0f af d0             	imul   %eax,%edx
    1568:	8b 45 0c             	mov    0xc(%ebp),%eax
    156b:	01 d0                	add    %edx,%eax
    156d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1570:	8b 45 14             	mov    0x14(%ebp),%eax
    1573:	8b 00                	mov    (%eax),%eax
    1575:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1578:	8b 55 1c             	mov    0x1c(%ebp),%edx
    157b:	01 ca                	add    %ecx,%edx
    157d:	0f af d0             	imul   %eax,%edx
    1580:	8b 45 18             	mov    0x18(%ebp),%eax
    1583:	01 d0                	add    %edx,%eax
    1585:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1588:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    158f:	eb 74                	jmp    1605 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1591:	8b 45 14             	mov    0x14(%ebp),%eax
    1594:	8b 50 18             	mov    0x18(%eax),%edx
    1597:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    159a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    159d:	01 c8                	add    %ecx,%eax
    159f:	89 c1                	mov    %eax,%ecx
    15a1:	89 c8                	mov    %ecx,%eax
    15a3:	01 c0                	add    %eax,%eax
    15a5:	01 c8                	add    %ecx,%eax
    15a7:	01 d0                	add    %edx,%eax
    15a9:	0f b7 10             	movzwl (%eax),%edx
    15ac:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    15b0:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    15b4:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    15b7:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    15bb:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    15bf:	38 c2                	cmp    %al,%dl
    15c1:	75 18                	jne    15db <APDcCopy+0x154>
    15c3:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    15c7:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    15cb:	38 c2                	cmp    %al,%dl
    15cd:	75 0c                	jne    15db <APDcCopy+0x154>
    15cf:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    15d3:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    15d7:	38 c2                	cmp    %al,%dl
    15d9:	74 26                	je     1601 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    15db:	8b 45 08             	mov    0x8(%ebp),%eax
    15de:	8b 50 18             	mov    0x18(%eax),%edx
    15e1:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    15e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15e7:	01 c8                	add    %ecx,%eax
    15e9:	89 c1                	mov    %eax,%ecx
    15eb:	89 c8                	mov    %ecx,%eax
    15ed:	01 c0                	add    %eax,%eax
    15ef:	01 c8                	add    %ecx,%eax
    15f1:	01 d0                	add    %edx,%eax
    15f3:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    15f7:	66 89 10             	mov    %dx,(%eax)
    15fa:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    15fe:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1601:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1605:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1608:	2b 45 0c             	sub    0xc(%ebp),%eax
    160b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    160e:	7d 81                	jge    1591 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1610:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1614:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1617:	2b 45 10             	sub    0x10(%ebp),%eax
    161a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    161d:	0f 8d 35 ff ff ff    	jge    1558 <APDcCopy+0xd1>
    1623:	eb 04                	jmp    1629 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1625:	90                   	nop
    1626:	eb 01                	jmp    1629 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1628:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1629:	c9                   	leave  
    162a:	c3                   	ret    

0000162b <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    162b:	55                   	push   %ebp
    162c:	89 e5                	mov    %esp,%ebp
    162e:	83 ec 1c             	sub    $0x1c,%esp
    1631:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1634:	8b 55 10             	mov    0x10(%ebp),%edx
    1637:	8b 45 14             	mov    0x14(%ebp),%eax
    163a:	88 4d ec             	mov    %cl,-0x14(%ebp)
    163d:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1640:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1643:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1647:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    164a:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    164e:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1651:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1655:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1658:	8b 45 08             	mov    0x8(%ebp),%eax
    165b:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    165f:	66 89 10             	mov    %dx,(%eax)
    1662:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1666:	88 50 02             	mov    %dl,0x2(%eax)
}
    1669:	8b 45 08             	mov    0x8(%ebp),%eax
    166c:	c9                   	leave  
    166d:	c2 04 00             	ret    $0x4

00001670 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1670:	55                   	push   %ebp
    1671:	89 e5                	mov    %esp,%ebp
    1673:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1676:	8b 45 08             	mov    0x8(%ebp),%eax
    1679:	8b 00                	mov    (%eax),%eax
    167b:	83 ec 08             	sub    $0x8,%esp
    167e:	8d 55 0c             	lea    0xc(%ebp),%edx
    1681:	52                   	push   %edx
    1682:	50                   	push   %eax
    1683:	e8 34 ee ff ff       	call   4bc <sendMessage>
    1688:	83 c4 10             	add    $0x10,%esp
}
    168b:	90                   	nop
    168c:	c9                   	leave  
    168d:	c3                   	ret    

0000168e <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    168e:	55                   	push   %ebp
    168f:	89 e5                	mov    %esp,%ebp
    1691:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1694:	83 ec 0c             	sub    $0xc,%esp
    1697:	68 98 00 00 00       	push   $0x98
    169c:	e8 f5 f1 ff ff       	call   896 <malloc>
    16a1:	83 c4 10             	add    $0x10,%esp
    16a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    16a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16ab:	75 15                	jne    16c2 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    16ad:	83 ec 04             	sub    $0x4,%esp
    16b0:	ff 75 08             	pushl  0x8(%ebp)
    16b3:	68 80 25 00 00       	push   $0x2580
    16b8:	6a 01                	push   $0x1
    16ba:	e8 04 ef ff ff       	call   5c3 <printf>
    16bf:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    16c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c5:	05 84 00 00 00       	add    $0x84,%eax
    16ca:	83 ec 08             	sub    $0x8,%esp
    16cd:	ff 75 08             	pushl  0x8(%ebp)
    16d0:	50                   	push   %eax
    16d1:	e8 0d eb ff ff       	call   1e3 <strcpy>
    16d6:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    16d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16dc:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    16e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e6:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    16ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f0:	8b 40 3c             	mov    0x3c(%eax),%eax
    16f3:	89 c2                	mov    %eax,%edx
    16f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f8:	8b 40 40             	mov    0x40(%eax),%eax
    16fb:	0f af d0             	imul   %eax,%edx
    16fe:	89 d0                	mov    %edx,%eax
    1700:	01 c0                	add    %eax,%eax
    1702:	01 d0                	add    %edx,%eax
    1704:	83 ec 0c             	sub    $0xc,%esp
    1707:	50                   	push   %eax
    1708:	e8 89 f1 ff ff       	call   896 <malloc>
    170d:	83 c4 10             	add    $0x10,%esp
    1710:	89 c2                	mov    %eax,%edx
    1712:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1715:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1718:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171b:	8b 40 54             	mov    0x54(%eax),%eax
    171e:	85 c0                	test   %eax,%eax
    1720:	75 15                	jne    1737 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1722:	83 ec 04             	sub    $0x4,%esp
    1725:	ff 75 08             	pushl  0x8(%ebp)
    1728:	68 a0 25 00 00       	push   $0x25a0
    172d:	6a 01                	push   $0x1
    172f:	e8 8f ee ff ff       	call   5c3 <printf>
    1734:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1737:	8b 45 f4             	mov    -0xc(%ebp),%eax
    173a:	8b 40 3c             	mov    0x3c(%eax),%eax
    173d:	89 c2                	mov    %eax,%edx
    173f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1742:	8b 40 40             	mov    0x40(%eax),%eax
    1745:	0f af d0             	imul   %eax,%edx
    1748:	89 d0                	mov    %edx,%eax
    174a:	01 c0                	add    %eax,%eax
    174c:	01 c2                	add    %eax,%edx
    174e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1751:	8b 40 54             	mov    0x54(%eax),%eax
    1754:	83 ec 04             	sub    $0x4,%esp
    1757:	52                   	push   %edx
    1758:	68 ff ff ff 00       	push   $0xffffff
    175d:	50                   	push   %eax
    175e:	e8 16 eb ff ff       	call   279 <memset>
    1763:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1766:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1769:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1770:	e8 1f ed ff ff       	call   494 <getpid>
    1775:	89 c2                	mov    %eax,%edx
    1777:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177a:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    177d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1780:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1787:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178a:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1791:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1794:	8b 40 58             	mov    0x58(%eax),%eax
    1797:	89 c2                	mov    %eax,%edx
    1799:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179c:	8b 40 5c             	mov    0x5c(%eax),%eax
    179f:	0f af d0             	imul   %eax,%edx
    17a2:	89 d0                	mov    %edx,%eax
    17a4:	01 c0                	add    %eax,%eax
    17a6:	01 d0                	add    %edx,%eax
    17a8:	83 ec 0c             	sub    $0xc,%esp
    17ab:	50                   	push   %eax
    17ac:	e8 e5 f0 ff ff       	call   896 <malloc>
    17b1:	83 c4 10             	add    $0x10,%esp
    17b4:	89 c2                	mov    %eax,%edx
    17b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b9:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    17bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bf:	8b 40 70             	mov    0x70(%eax),%eax
    17c2:	85 c0                	test   %eax,%eax
    17c4:	75 15                	jne    17db <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    17c6:	83 ec 04             	sub    $0x4,%esp
    17c9:	ff 75 08             	pushl  0x8(%ebp)
    17cc:	68 c4 25 00 00       	push   $0x25c4
    17d1:	6a 01                	push   $0x1
    17d3:	e8 eb ed ff ff       	call   5c3 <printf>
    17d8:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    17db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17de:	8b 40 3c             	mov    0x3c(%eax),%eax
    17e1:	89 c2                	mov    %eax,%edx
    17e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e6:	8b 40 40             	mov    0x40(%eax),%eax
    17e9:	0f af d0             	imul   %eax,%edx
    17ec:	89 d0                	mov    %edx,%eax
    17ee:	01 c0                	add    %eax,%eax
    17f0:	01 c2                	add    %eax,%edx
    17f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f5:	8b 40 54             	mov    0x54(%eax),%eax
    17f8:	83 ec 04             	sub    $0x4,%esp
    17fb:	52                   	push   %edx
    17fc:	68 ff 00 00 00       	push   $0xff
    1801:	50                   	push   %eax
    1802:	e8 72 ea ff ff       	call   279 <memset>
    1807:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    180a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1810:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1813:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1817:	74 49                	je     1862 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1819:	8b 45 10             	mov    0x10(%ebp),%eax
    181c:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1822:	83 ec 0c             	sub    $0xc,%esp
    1825:	50                   	push   %eax
    1826:	e8 6b f0 ff ff       	call   896 <malloc>
    182b:	83 c4 10             	add    $0x10,%esp
    182e:	89 c2                	mov    %eax,%edx
    1830:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1833:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1836:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1839:	8b 55 10             	mov    0x10(%ebp),%edx
    183c:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    183f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1842:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1849:	8b 45 f4             	mov    -0xc(%ebp),%eax
    184c:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1853:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1856:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    185d:	e9 8d 00 00 00       	jmp    18ef <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1862:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1865:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    186c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186f:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1876:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1879:	8b 40 20             	mov    0x20(%eax),%eax
    187c:	89 c2                	mov    %eax,%edx
    187e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1881:	8b 40 24             	mov    0x24(%eax),%eax
    1884:	0f af d0             	imul   %eax,%edx
    1887:	89 d0                	mov    %edx,%eax
    1889:	01 c0                	add    %eax,%eax
    188b:	01 d0                	add    %edx,%eax
    188d:	83 ec 0c             	sub    $0xc,%esp
    1890:	50                   	push   %eax
    1891:	e8 00 f0 ff ff       	call   896 <malloc>
    1896:	83 c4 10             	add    $0x10,%esp
    1899:	89 c2                	mov    %eax,%edx
    189b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189e:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    18a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a4:	8b 40 38             	mov    0x38(%eax),%eax
    18a7:	85 c0                	test   %eax,%eax
    18a9:	75 15                	jne    18c0 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    18ab:	83 ec 04             	sub    $0x4,%esp
    18ae:	ff 75 08             	pushl  0x8(%ebp)
    18b1:	68 ec 25 00 00       	push   $0x25ec
    18b6:	6a 01                	push   $0x1
    18b8:	e8 06 ed ff ff       	call   5c3 <printf>
    18bd:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    18c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c3:	8b 40 20             	mov    0x20(%eax),%eax
    18c6:	89 c2                	mov    %eax,%edx
    18c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18cb:	8b 40 24             	mov    0x24(%eax),%eax
    18ce:	0f af d0             	imul   %eax,%edx
    18d1:	89 d0                	mov    %edx,%eax
    18d3:	01 c0                	add    %eax,%eax
    18d5:	01 c2                	add    %eax,%edx
    18d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18da:	8b 40 38             	mov    0x38(%eax),%eax
    18dd:	83 ec 04             	sub    $0x4,%esp
    18e0:	52                   	push   %edx
    18e1:	68 ff ff ff 00       	push   $0xffffff
    18e6:	50                   	push   %eax
    18e7:	e8 8d e9 ff ff       	call   279 <memset>
    18ec:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    18ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    18f2:	c9                   	leave  
    18f3:	c3                   	ret    

000018f4 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    18f4:	55                   	push   %ebp
    18f5:	89 e5                	mov    %esp,%ebp
    18f7:	57                   	push   %edi
    18f8:	56                   	push   %esi
    18f9:	53                   	push   %ebx
    18fa:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    18fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    1900:	83 f8 03             	cmp    $0x3,%eax
    1903:	74 02                	je     1907 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1905:	eb 7c                	jmp    1983 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1907:	8b 45 08             	mov    0x8(%ebp),%eax
    190a:	8b 58 1c             	mov    0x1c(%eax),%ebx
    190d:	8b 45 08             	mov    0x8(%ebp),%eax
    1910:	8b 48 18             	mov    0x18(%eax),%ecx
    1913:	8b 45 08             	mov    0x8(%ebp),%eax
    1916:	8b 50 5c             	mov    0x5c(%eax),%edx
    1919:	8b 45 08             	mov    0x8(%ebp),%eax
    191c:	8b 40 58             	mov    0x58(%eax),%eax
    191f:	8b 75 08             	mov    0x8(%ebp),%esi
    1922:	83 c6 58             	add    $0x58,%esi
    1925:	83 ec 04             	sub    $0x4,%esp
    1928:	53                   	push   %ebx
    1929:	51                   	push   %ecx
    192a:	6a 00                	push   $0x0
    192c:	52                   	push   %edx
    192d:	50                   	push   %eax
    192e:	6a 00                	push   $0x0
    1930:	6a 00                	push   $0x0
    1932:	56                   	push   %esi
    1933:	6a 00                	push   $0x0
    1935:	6a 00                	push   $0x0
    1937:	ff 75 08             	pushl  0x8(%ebp)
    193a:	e8 75 eb ff ff       	call   4b4 <paintWindow>
    193f:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1942:	8b 45 08             	mov    0x8(%ebp),%eax
    1945:	8b 70 1c             	mov    0x1c(%eax),%esi
    1948:	8b 45 08             	mov    0x8(%ebp),%eax
    194b:	8b 58 18             	mov    0x18(%eax),%ebx
    194e:	8b 45 08             	mov    0x8(%ebp),%eax
    1951:	8b 48 08             	mov    0x8(%eax),%ecx
    1954:	8b 45 08             	mov    0x8(%ebp),%eax
    1957:	8b 50 40             	mov    0x40(%eax),%edx
    195a:	8b 45 08             	mov    0x8(%ebp),%eax
    195d:	8b 40 3c             	mov    0x3c(%eax),%eax
    1960:	8b 7d 08             	mov    0x8(%ebp),%edi
    1963:	83 c7 3c             	add    $0x3c,%edi
    1966:	83 ec 04             	sub    $0x4,%esp
    1969:	56                   	push   %esi
    196a:	53                   	push   %ebx
    196b:	51                   	push   %ecx
    196c:	52                   	push   %edx
    196d:	50                   	push   %eax
    196e:	6a 00                	push   $0x0
    1970:	6a 00                	push   $0x0
    1972:	57                   	push   %edi
    1973:	6a 32                	push   $0x32
    1975:	6a 00                	push   $0x0
    1977:	ff 75 08             	pushl  0x8(%ebp)
    197a:	e8 35 eb ff ff       	call   4b4 <paintWindow>
    197f:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1982:	90                   	nop
        default: break;
            
            
    }
    return False;
    1983:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1988:	8d 65 f4             	lea    -0xc(%ebp),%esp
    198b:	5b                   	pop    %ebx
    198c:	5e                   	pop    %esi
    198d:	5f                   	pop    %edi
    198e:	5d                   	pop    %ebp
    198f:	c3                   	ret    

00001990 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1990:	55                   	push   %ebp
    1991:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1993:	8b 45 0c             	mov    0xc(%ebp),%eax
    1996:	8b 50 08             	mov    0x8(%eax),%edx
    1999:	8b 45 08             	mov    0x8(%ebp),%eax
    199c:	8b 00                	mov    (%eax),%eax
    199e:	39 c2                	cmp    %eax,%edx
    19a0:	74 07                	je     19a9 <APPreJudge+0x19>
        return False;
    19a2:	b8 00 00 00 00       	mov    $0x0,%eax
    19a7:	eb 05                	jmp    19ae <APPreJudge+0x1e>
    return True;
    19a9:	b8 01 00 00 00       	mov    $0x1,%eax
}
    19ae:	5d                   	pop    %ebp
    19af:	c3                   	ret    

000019b0 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    19b0:	55                   	push   %ebp
    19b1:	89 e5                	mov    %esp,%ebp
    19b3:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    19b6:	8b 45 08             	mov    0x8(%ebp),%eax
    19b9:	8b 55 0c             	mov    0xc(%ebp),%edx
    19bc:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    19c2:	83 ec 0c             	sub    $0xc,%esp
    19c5:	ff 75 08             	pushl  0x8(%ebp)
    19c8:	e8 ff ea ff ff       	call   4cc <registWindow>
    19cd:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    19d0:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    19d7:	8b 45 08             	mov    0x8(%ebp),%eax
    19da:	8b 00                	mov    (%eax),%eax
    19dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    19df:	ff 75 f4             	pushl  -0xc(%ebp)
    19e2:	ff 75 f0             	pushl  -0x10(%ebp)
    19e5:	ff 75 ec             	pushl  -0x14(%ebp)
    19e8:	ff 75 08             	pushl  0x8(%ebp)
    19eb:	e8 80 fc ff ff       	call   1670 <APSendMessage>
    19f0:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    19f3:	83 ec 0c             	sub    $0xc,%esp
    19f6:	ff 75 08             	pushl  0x8(%ebp)
    19f9:	e8 c6 ea ff ff       	call   4c4 <getMessage>
    19fe:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1a01:	8b 45 08             	mov    0x8(%ebp),%eax
    1a04:	83 c0 74             	add    $0x74,%eax
    1a07:	83 ec 08             	sub    $0x8,%esp
    1a0a:	50                   	push   %eax
    1a0b:	ff 75 08             	pushl  0x8(%ebp)
    1a0e:	e8 7d ff ff ff       	call   1990 <APPreJudge>
    1a13:	83 c4 10             	add    $0x10,%esp
    1a16:	84 c0                	test   %al,%al
    1a18:	74 1b                	je     1a35 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1a1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1d:	ff 70 7c             	pushl  0x7c(%eax)
    1a20:	ff 70 78             	pushl  0x78(%eax)
    1a23:	ff 70 74             	pushl  0x74(%eax)
    1a26:	ff 75 08             	pushl  0x8(%ebp)
    1a29:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a2c:	ff d0                	call   *%eax
    1a2e:	83 c4 10             	add    $0x10,%esp
    1a31:	84 c0                	test   %al,%al
    1a33:	75 0c                	jne    1a41 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1a35:	8b 45 08             	mov    0x8(%ebp),%eax
    1a38:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1a3f:	eb b2                	jmp    19f3 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1a41:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1a42:	90                   	nop
    1a43:	c9                   	leave  
    1a44:	c3                   	ret    

00001a45 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1a45:	55                   	push   %ebp
    1a46:	89 e5                	mov    %esp,%ebp
    1a48:	57                   	push   %edi
    1a49:	56                   	push   %esi
    1a4a:	53                   	push   %ebx
    1a4b:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    1a4e:	a1 ec 68 00 00       	mov    0x68ec,%eax
    1a53:	85 c0                	test   %eax,%eax
    1a55:	0f 85 2c 02 00 00    	jne    1c87 <APGridPaint+0x242>
    {
        iconReady = 1;
    1a5b:	c7 05 ec 68 00 00 01 	movl   $0x1,0x68ec
    1a62:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1a65:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a68:	83 ec 08             	sub    $0x8,%esp
    1a6b:	68 13 26 00 00       	push   $0x2613
    1a70:	50                   	push   %eax
    1a71:	e8 d3 ef ff ff       	call   a49 <APLoadBitmap>
    1a76:	83 c4 0c             	add    $0xc,%esp
    1a79:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a7c:	a3 20 6b 00 00       	mov    %eax,0x6b20
    1a81:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a84:	a3 24 6b 00 00       	mov    %eax,0x6b24
    1a89:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a8c:	a3 28 6b 00 00       	mov    %eax,0x6b28
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1a91:	83 ec 04             	sub    $0x4,%esp
    1a94:	ff 35 28 6b 00 00    	pushl  0x6b28
    1a9a:	ff 35 24 6b 00 00    	pushl  0x6b24
    1aa0:	ff 35 20 6b 00 00    	pushl  0x6b20
    1aa6:	e8 d8 f1 ff ff       	call   c83 <APCreateCompatibleDCFromBitmap>
    1aab:	83 c4 10             	add    $0x10,%esp
    1aae:	a3 2c 6b 00 00       	mov    %eax,0x6b2c
        grid_river = APLoadBitmap ("grid_river.bmp");
    1ab3:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ab6:	83 ec 08             	sub    $0x8,%esp
    1ab9:	68 21 26 00 00       	push   $0x2621
    1abe:	50                   	push   %eax
    1abf:	e8 85 ef ff ff       	call   a49 <APLoadBitmap>
    1ac4:	83 c4 0c             	add    $0xc,%esp
    1ac7:	8b 45 88             	mov    -0x78(%ebp),%eax
    1aca:	a3 5c 6b 00 00       	mov    %eax,0x6b5c
    1acf:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1ad2:	a3 60 6b 00 00       	mov    %eax,0x6b60
    1ad7:	8b 45 90             	mov    -0x70(%ebp),%eax
    1ada:	a3 64 6b 00 00       	mov    %eax,0x6b64
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1adf:	83 ec 04             	sub    $0x4,%esp
    1ae2:	ff 35 64 6b 00 00    	pushl  0x6b64
    1ae8:	ff 35 60 6b 00 00    	pushl  0x6b60
    1aee:	ff 35 5c 6b 00 00    	pushl  0x6b5c
    1af4:	e8 8a f1 ff ff       	call   c83 <APCreateCompatibleDCFromBitmap>
    1af9:	83 c4 10             	add    $0x10,%esp
    1afc:	a3 4c 6b 00 00       	mov    %eax,0x6b4c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1b01:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b04:	83 ec 08             	sub    $0x8,%esp
    1b07:	68 30 26 00 00       	push   $0x2630
    1b0c:	50                   	push   %eax
    1b0d:	e8 37 ef ff ff       	call   a49 <APLoadBitmap>
    1b12:	83 c4 0c             	add    $0xc,%esp
    1b15:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b18:	a3 50 6b 00 00       	mov    %eax,0x6b50
    1b1d:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b20:	a3 54 6b 00 00       	mov    %eax,0x6b54
    1b25:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b28:	a3 58 6b 00 00       	mov    %eax,0x6b58
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1b2d:	83 ec 04             	sub    $0x4,%esp
    1b30:	ff 35 58 6b 00 00    	pushl  0x6b58
    1b36:	ff 35 54 6b 00 00    	pushl  0x6b54
    1b3c:	ff 35 50 6b 00 00    	pushl  0x6b50
    1b42:	e8 3c f1 ff ff       	call   c83 <APCreateCompatibleDCFromBitmap>
    1b47:	83 c4 10             	add    $0x10,%esp
    1b4a:	a3 00 6b 00 00       	mov    %eax,0x6b00
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1b4f:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b52:	83 ec 08             	sub    $0x8,%esp
    1b55:	68 3f 26 00 00       	push   $0x263f
    1b5a:	50                   	push   %eax
    1b5b:	e8 e9 ee ff ff       	call   a49 <APLoadBitmap>
    1b60:	83 c4 0c             	add    $0xc,%esp
    1b63:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b66:	a3 34 6b 00 00       	mov    %eax,0x6b34
    1b6b:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b6e:	a3 38 6b 00 00       	mov    %eax,0x6b38
    1b73:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b76:	a3 3c 6b 00 00       	mov    %eax,0x6b3c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1b7b:	83 ec 04             	sub    $0x4,%esp
    1b7e:	ff 35 3c 6b 00 00    	pushl  0x6b3c
    1b84:	ff 35 38 6b 00 00    	pushl  0x6b38
    1b8a:	ff 35 34 6b 00 00    	pushl  0x6b34
    1b90:	e8 ee f0 ff ff       	call   c83 <APCreateCompatibleDCFromBitmap>
    1b95:	83 c4 10             	add    $0x10,%esp
    1b98:	a3 68 6b 00 00       	mov    %eax,0x6b68
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1b9d:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ba0:	83 ec 08             	sub    $0x8,%esp
    1ba3:	68 4d 26 00 00       	push   $0x264d
    1ba8:	50                   	push   %eax
    1ba9:	e8 9b ee ff ff       	call   a49 <APLoadBitmap>
    1bae:	83 c4 0c             	add    $0xc,%esp
    1bb1:	8b 45 88             	mov    -0x78(%ebp),%eax
    1bb4:	a3 10 6b 00 00       	mov    %eax,0x6b10
    1bb9:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1bbc:	a3 14 6b 00 00       	mov    %eax,0x6b14
    1bc1:	8b 45 90             	mov    -0x70(%ebp),%eax
    1bc4:	a3 18 6b 00 00       	mov    %eax,0x6b18
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1bc9:	83 ec 04             	sub    $0x4,%esp
    1bcc:	ff 35 18 6b 00 00    	pushl  0x6b18
    1bd2:	ff 35 14 6b 00 00    	pushl  0x6b14
    1bd8:	ff 35 10 6b 00 00    	pushl  0x6b10
    1bde:	e8 a0 f0 ff ff       	call   c83 <APCreateCompatibleDCFromBitmap>
    1be3:	83 c4 10             	add    $0x10,%esp
    1be6:	a3 30 6b 00 00       	mov    %eax,0x6b30
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1beb:	8d 45 88             	lea    -0x78(%ebp),%eax
    1bee:	83 ec 08             	sub    $0x8,%esp
    1bf1:	68 5d 26 00 00       	push   $0x265d
    1bf6:	50                   	push   %eax
    1bf7:	e8 4d ee ff ff       	call   a49 <APLoadBitmap>
    1bfc:	83 c4 0c             	add    $0xc,%esp
    1bff:	8b 45 88             	mov    -0x78(%ebp),%eax
    1c02:	a3 04 6b 00 00       	mov    %eax,0x6b04
    1c07:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1c0a:	a3 08 6b 00 00       	mov    %eax,0x6b08
    1c0f:	8b 45 90             	mov    -0x70(%ebp),%eax
    1c12:	a3 0c 6b 00 00       	mov    %eax,0x6b0c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1c17:	83 ec 04             	sub    $0x4,%esp
    1c1a:	ff 35 0c 6b 00 00    	pushl  0x6b0c
    1c20:	ff 35 08 6b 00 00    	pushl  0x6b08
    1c26:	ff 35 04 6b 00 00    	pushl  0x6b04
    1c2c:	e8 52 f0 ff ff       	call   c83 <APCreateCompatibleDCFromBitmap>
    1c31:	83 c4 10             	add    $0x10,%esp
    1c34:	a3 1c 6b 00 00       	mov    %eax,0x6b1c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1c39:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c3c:	83 ec 08             	sub    $0x8,%esp
    1c3f:	68 6f 26 00 00       	push   $0x266f
    1c44:	50                   	push   %eax
    1c45:	e8 ff ed ff ff       	call   a49 <APLoadBitmap>
    1c4a:	83 c4 0c             	add    $0xc,%esp
    1c4d:	8b 45 88             	mov    -0x78(%ebp),%eax
    1c50:	a3 40 6b 00 00       	mov    %eax,0x6b40
    1c55:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1c58:	a3 44 6b 00 00       	mov    %eax,0x6b44
    1c5d:	8b 45 90             	mov    -0x70(%ebp),%eax
    1c60:	a3 48 6b 00 00       	mov    %eax,0x6b48
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1c65:	83 ec 04             	sub    $0x4,%esp
    1c68:	ff 35 48 6b 00 00    	pushl  0x6b48
    1c6e:	ff 35 44 6b 00 00    	pushl  0x6b44
    1c74:	ff 35 40 6b 00 00    	pushl  0x6b40
    1c7a:	e8 04 f0 ff ff       	call   c83 <APCreateCompatibleDCFromBitmap>
    1c7f:	83 c4 10             	add    $0x10,%esp
    1c82:	a3 6c 6b 00 00       	mov    %eax,0x6b6c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1c87:	8b 45 08             	mov    0x8(%ebp),%eax
    1c8a:	8b 40 08             	mov    0x8(%eax),%eax
    1c8d:	85 c0                	test   %eax,%eax
    1c8f:	75 17                	jne    1ca8 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1c91:	83 ec 08             	sub    $0x8,%esp
    1c94:	68 80 26 00 00       	push   $0x2680
    1c99:	6a 01                	push   $0x1
    1c9b:	e8 23 e9 ff ff       	call   5c3 <printf>
    1ca0:	83 c4 10             	add    $0x10,%esp
        return;
    1ca3:	e9 07 05 00 00       	jmp    21af <APGridPaint+0x76a>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1ca8:	8b 45 08             	mov    0x8(%ebp),%eax
    1cab:	8b 40 10             	mov    0x10(%eax),%eax
    1cae:	85 c0                	test   %eax,%eax
    1cb0:	7e 10                	jle    1cc2 <APGridPaint+0x27d>
    1cb2:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb5:	8b 50 14             	mov    0x14(%eax),%edx
    1cb8:	8b 45 08             	mov    0x8(%ebp),%eax
    1cbb:	8b 40 10             	mov    0x10(%eax),%eax
    1cbe:	39 c2                	cmp    %eax,%edx
    1cc0:	7c 17                	jl     1cd9 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1cc2:	83 ec 08             	sub    $0x8,%esp
    1cc5:	68 a6 26 00 00       	push   $0x26a6
    1cca:	6a 01                	push   $0x1
    1ccc:	e8 f2 e8 ff ff       	call   5c3 <printf>
    1cd1:	83 c4 10             	add    $0x10,%esp
        return;
    1cd4:	e9 d6 04 00 00       	jmp    21af <APGridPaint+0x76a>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1cd9:	8b 45 08             	mov    0x8(%ebp),%eax
    1cdc:	8b 40 14             	mov    0x14(%eax),%eax
    1cdf:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1ce5:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1ce8:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1ceb:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1cee:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1cf5:	e9 96 03 00 00       	jmp    2090 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1cfa:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1d01:	e9 7c 03 00 00       	jmp    2082 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1d06:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d09:	c1 e0 04             	shl    $0x4,%eax
    1d0c:	89 c2                	mov    %eax,%edx
    1d0e:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1d11:	01 c2                	add    %eax,%edx
    1d13:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d16:	01 d0                	add    %edx,%eax
    1d18:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1d1b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d1e:	8b 40 0c             	mov    0xc(%eax),%eax
    1d21:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1d24:	c1 e2 02             	shl    $0x2,%edx
    1d27:	01 d0                	add    %edx,%eax
    1d29:	8b 00                	mov    (%eax),%eax
    1d2b:	83 f8 07             	cmp    $0x7,%eax
    1d2e:	0f 87 49 03 00 00    	ja     207d <APGridPaint+0x638>
    1d34:	8b 04 85 bc 26 00 00 	mov    0x26bc(,%eax,4),%eax
    1d3b:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d3d:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1d40:	6a 0c                	push   $0xc
    1d42:	6a 0c                	push   $0xc
    1d44:	6a 0c                	push   $0xc
    1d46:	50                   	push   %eax
    1d47:	e8 df f8 ff ff       	call   162b <RGB>
    1d4c:	83 c4 0c             	add    $0xc,%esp
    1d4f:	8b 1d 2c 6b 00 00    	mov    0x6b2c,%ebx
    1d55:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d58:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d5b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d5e:	6b c0 32             	imul   $0x32,%eax,%eax
    1d61:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1d64:	8b 45 08             	mov    0x8(%ebp),%eax
    1d67:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d6a:	83 ec 0c             	sub    $0xc,%esp
    1d6d:	83 ec 04             	sub    $0x4,%esp
    1d70:	89 e0                	mov    %esp,%eax
    1d72:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1d76:	66 89 30             	mov    %si,(%eax)
    1d79:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1d7d:	88 50 02             	mov    %dl,0x2(%eax)
    1d80:	6a 32                	push   $0x32
    1d82:	6a 32                	push   $0x32
    1d84:	6a 00                	push   $0x0
    1d86:	6a 00                	push   $0x0
    1d88:	53                   	push   %ebx
    1d89:	51                   	push   %ecx
    1d8a:	ff 75 84             	pushl  -0x7c(%ebp)
    1d8d:	57                   	push   %edi
    1d8e:	e8 f4 f6 ff ff       	call   1487 <APDcCopy>
    1d93:	83 c4 30             	add    $0x30,%esp
                    break;
    1d96:	e9 e3 02 00 00       	jmp    207e <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1d9b:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d9e:	6a 69                	push   $0x69
    1da0:	6a 69                	push   $0x69
    1da2:	6a 69                	push   $0x69
    1da4:	50                   	push   %eax
    1da5:	e8 81 f8 ff ff       	call   162b <RGB>
    1daa:	83 c4 0c             	add    $0xc,%esp
    1dad:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1db1:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1db5:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1db9:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1dbc:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1dc3:	8d 45 88             	lea    -0x78(%ebp),%eax
    1dc6:	6a 69                	push   $0x69
    1dc8:	6a 69                	push   $0x69
    1dca:	6a 69                	push   $0x69
    1dcc:	50                   	push   %eax
    1dcd:	e8 59 f8 ff ff       	call   162b <RGB>
    1dd2:	83 c4 0c             	add    $0xc,%esp
    1dd5:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1dd9:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1ddd:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1de1:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1de4:	8b 45 08             	mov    0x8(%ebp),%eax
    1de7:	8d 50 3c             	lea    0x3c(%eax),%edx
    1dea:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ded:	ff 75 ac             	pushl  -0x54(%ebp)
    1df0:	ff 75 a8             	pushl  -0x58(%ebp)
    1df3:	52                   	push   %edx
    1df4:	50                   	push   %eax
    1df5:	e8 1e ef ff ff       	call   d18 <APSetPen>
    1dfa:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1dfd:	8b 45 08             	mov    0x8(%ebp),%eax
    1e00:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1e03:	8d 55 88             	lea    -0x78(%ebp),%edx
    1e06:	83 ec 04             	sub    $0x4,%esp
    1e09:	83 ec 04             	sub    $0x4,%esp
    1e0c:	89 e0                	mov    %esp,%eax
    1e0e:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1e12:	66 89 08             	mov    %cx,(%eax)
    1e15:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    1e19:	88 48 02             	mov    %cl,0x2(%eax)
    1e1c:	53                   	push   %ebx
    1e1d:	52                   	push   %edx
    1e1e:	e8 2e ef ff ff       	call   d51 <APSetBrush>
    1e23:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1e26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e29:	6b d0 32             	imul   $0x32,%eax,%edx
    1e2c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e2f:	6b c0 32             	imul   $0x32,%eax,%eax
    1e32:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1e35:	83 c1 3c             	add    $0x3c,%ecx
    1e38:	83 ec 0c             	sub    $0xc,%esp
    1e3b:	6a 32                	push   $0x32
    1e3d:	6a 32                	push   $0x32
    1e3f:	52                   	push   %edx
    1e40:	50                   	push   %eax
    1e41:	51                   	push   %ecx
    1e42:	e8 34 f3 ff ff       	call   117b <APDrawRect>
    1e47:	83 c4 20             	add    $0x20,%esp
                    break;
    1e4a:	e9 2f 02 00 00       	jmp    207e <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e4f:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1e52:	6a 0c                	push   $0xc
    1e54:	6a 0c                	push   $0xc
    1e56:	6a 0c                	push   $0xc
    1e58:	50                   	push   %eax
    1e59:	e8 cd f7 ff ff       	call   162b <RGB>
    1e5e:	83 c4 0c             	add    $0xc,%esp
    1e61:	8b 1d 6c 6b 00 00    	mov    0x6b6c,%ebx
    1e67:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e6a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e6d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e70:	6b c0 32             	imul   $0x32,%eax,%eax
    1e73:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e76:	8b 45 08             	mov    0x8(%ebp),%eax
    1e79:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e7c:	83 ec 0c             	sub    $0xc,%esp
    1e7f:	83 ec 04             	sub    $0x4,%esp
    1e82:	89 e0                	mov    %esp,%eax
    1e84:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1e88:	66 89 30             	mov    %si,(%eax)
    1e8b:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1e8f:	88 50 02             	mov    %dl,0x2(%eax)
    1e92:	6a 32                	push   $0x32
    1e94:	6a 32                	push   $0x32
    1e96:	6a 00                	push   $0x0
    1e98:	6a 00                	push   $0x0
    1e9a:	53                   	push   %ebx
    1e9b:	51                   	push   %ecx
    1e9c:	ff 75 84             	pushl  -0x7c(%ebp)
    1e9f:	57                   	push   %edi
    1ea0:	e8 e2 f5 ff ff       	call   1487 <APDcCopy>
    1ea5:	83 c4 30             	add    $0x30,%esp
                    break;
    1ea8:	e9 d1 01 00 00       	jmp    207e <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ead:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1eb0:	6a 0c                	push   $0xc
    1eb2:	6a 0c                	push   $0xc
    1eb4:	6a 0c                	push   $0xc
    1eb6:	50                   	push   %eax
    1eb7:	e8 6f f7 ff ff       	call   162b <RGB>
    1ebc:	83 c4 0c             	add    $0xc,%esp
    1ebf:	8b 1d 4c 6b 00 00    	mov    0x6b4c,%ebx
    1ec5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ec8:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ecb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ece:	6b c0 32             	imul   $0x32,%eax,%eax
    1ed1:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1ed4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ed7:	8d 78 3c             	lea    0x3c(%eax),%edi
    1eda:	83 ec 0c             	sub    $0xc,%esp
    1edd:	83 ec 04             	sub    $0x4,%esp
    1ee0:	89 e0                	mov    %esp,%eax
    1ee2:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1ee6:	66 89 30             	mov    %si,(%eax)
    1ee9:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1eed:	88 50 02             	mov    %dl,0x2(%eax)
    1ef0:	6a 32                	push   $0x32
    1ef2:	6a 32                	push   $0x32
    1ef4:	6a 00                	push   $0x0
    1ef6:	6a 00                	push   $0x0
    1ef8:	53                   	push   %ebx
    1ef9:	51                   	push   %ecx
    1efa:	ff 75 84             	pushl  -0x7c(%ebp)
    1efd:	57                   	push   %edi
    1efe:	e8 84 f5 ff ff       	call   1487 <APDcCopy>
    1f03:	83 c4 30             	add    $0x30,%esp
                    break;
    1f06:	e9 73 01 00 00       	jmp    207e <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f0b:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1f0e:	6a 0c                	push   $0xc
    1f10:	6a 0c                	push   $0xc
    1f12:	6a 0c                	push   $0xc
    1f14:	50                   	push   %eax
    1f15:	e8 11 f7 ff ff       	call   162b <RGB>
    1f1a:	83 c4 0c             	add    $0xc,%esp
    1f1d:	8b 1d 30 6b 00 00    	mov    0x6b30,%ebx
    1f23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f26:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f29:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f2c:	6b c0 32             	imul   $0x32,%eax,%eax
    1f2f:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f32:	8b 45 08             	mov    0x8(%ebp),%eax
    1f35:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f38:	83 ec 0c             	sub    $0xc,%esp
    1f3b:	83 ec 04             	sub    $0x4,%esp
    1f3e:	89 e0                	mov    %esp,%eax
    1f40:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1f44:	66 89 30             	mov    %si,(%eax)
    1f47:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1f4b:	88 50 02             	mov    %dl,0x2(%eax)
    1f4e:	6a 32                	push   $0x32
    1f50:	6a 32                	push   $0x32
    1f52:	6a 00                	push   $0x0
    1f54:	6a 00                	push   $0x0
    1f56:	53                   	push   %ebx
    1f57:	51                   	push   %ecx
    1f58:	ff 75 84             	pushl  -0x7c(%ebp)
    1f5b:	57                   	push   %edi
    1f5c:	e8 26 f5 ff ff       	call   1487 <APDcCopy>
    1f61:	83 c4 30             	add    $0x30,%esp
                    break;
    1f64:	e9 15 01 00 00       	jmp    207e <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f69:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1f6c:	6a 0c                	push   $0xc
    1f6e:	6a 0c                	push   $0xc
    1f70:	6a 0c                	push   $0xc
    1f72:	50                   	push   %eax
    1f73:	e8 b3 f6 ff ff       	call   162b <RGB>
    1f78:	83 c4 0c             	add    $0xc,%esp
    1f7b:	8b 1d 68 6b 00 00    	mov    0x6b68,%ebx
    1f81:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f84:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f87:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f8a:	6b c0 32             	imul   $0x32,%eax,%eax
    1f8d:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f90:	8b 45 08             	mov    0x8(%ebp),%eax
    1f93:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f96:	83 ec 0c             	sub    $0xc,%esp
    1f99:	83 ec 04             	sub    $0x4,%esp
    1f9c:	89 e0                	mov    %esp,%eax
    1f9e:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1fa2:	66 89 30             	mov    %si,(%eax)
    1fa5:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1fa9:	88 50 02             	mov    %dl,0x2(%eax)
    1fac:	6a 32                	push   $0x32
    1fae:	6a 32                	push   $0x32
    1fb0:	6a 00                	push   $0x0
    1fb2:	6a 00                	push   $0x0
    1fb4:	53                   	push   %ebx
    1fb5:	51                   	push   %ecx
    1fb6:	ff 75 84             	pushl  -0x7c(%ebp)
    1fb9:	57                   	push   %edi
    1fba:	e8 c8 f4 ff ff       	call   1487 <APDcCopy>
    1fbf:	83 c4 30             	add    $0x30,%esp
                    break;
    1fc2:	e9 b7 00 00 00       	jmp    207e <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fc7:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1fca:	6a 0c                	push   $0xc
    1fcc:	6a 0c                	push   $0xc
    1fce:	6a 0c                	push   $0xc
    1fd0:	50                   	push   %eax
    1fd1:	e8 55 f6 ff ff       	call   162b <RGB>
    1fd6:	83 c4 0c             	add    $0xc,%esp
    1fd9:	8b 1d 00 6b 00 00    	mov    0x6b00,%ebx
    1fdf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fe2:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fe5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fe8:	6b c0 32             	imul   $0x32,%eax,%eax
    1feb:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1fee:	8b 45 08             	mov    0x8(%ebp),%eax
    1ff1:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ff4:	83 ec 0c             	sub    $0xc,%esp
    1ff7:	83 ec 04             	sub    $0x4,%esp
    1ffa:	89 e0                	mov    %esp,%eax
    1ffc:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2000:	66 89 30             	mov    %si,(%eax)
    2003:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2007:	88 50 02             	mov    %dl,0x2(%eax)
    200a:	6a 32                	push   $0x32
    200c:	6a 32                	push   $0x32
    200e:	6a 00                	push   $0x0
    2010:	6a 00                	push   $0x0
    2012:	53                   	push   %ebx
    2013:	51                   	push   %ecx
    2014:	ff 75 84             	pushl  -0x7c(%ebp)
    2017:	57                   	push   %edi
    2018:	e8 6a f4 ff ff       	call   1487 <APDcCopy>
    201d:	83 c4 30             	add    $0x30,%esp
                    break;
    2020:	eb 5c                	jmp    207e <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2022:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    2025:	6a 0c                	push   $0xc
    2027:	6a 0c                	push   $0xc
    2029:	6a 0c                	push   $0xc
    202b:	50                   	push   %eax
    202c:	e8 fa f5 ff ff       	call   162b <RGB>
    2031:	83 c4 0c             	add    $0xc,%esp
    2034:	8b 1d 1c 6b 00 00    	mov    0x6b1c,%ebx
    203a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    203d:	6b c8 32             	imul   $0x32,%eax,%ecx
    2040:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2043:	6b c0 32             	imul   $0x32,%eax,%eax
    2046:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2049:	8b 45 08             	mov    0x8(%ebp),%eax
    204c:	8d 78 3c             	lea    0x3c(%eax),%edi
    204f:	83 ec 0c             	sub    $0xc,%esp
    2052:	83 ec 04             	sub    $0x4,%esp
    2055:	89 e0                	mov    %esp,%eax
    2057:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    205b:	66 89 30             	mov    %si,(%eax)
    205e:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2062:	88 50 02             	mov    %dl,0x2(%eax)
    2065:	6a 32                	push   $0x32
    2067:	6a 32                	push   $0x32
    2069:	6a 00                	push   $0x0
    206b:	6a 00                	push   $0x0
    206d:	53                   	push   %ebx
    206e:	51                   	push   %ecx
    206f:	ff 75 84             	pushl  -0x7c(%ebp)
    2072:	57                   	push   %edi
    2073:	e8 0f f4 ff ff       	call   1487 <APDcCopy>
    2078:	83 c4 30             	add    $0x30,%esp
                    break;
    207b:	eb 01                	jmp    207e <APGridPaint+0x639>
                default: break;
    207d:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    207e:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2082:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2086:	0f 8e 7a fc ff ff    	jle    1d06 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    208c:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2090:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2094:	0f 8e 60 fc ff ff    	jle    1cfa <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    209a:	8d 45 88             	lea    -0x78(%ebp),%eax
    209d:	68 cd 00 00 00       	push   $0xcd
    20a2:	6a 74                	push   $0x74
    20a4:	6a 18                	push   $0x18
    20a6:	50                   	push   %eax
    20a7:	e8 7f f5 ff ff       	call   162b <RGB>
    20ac:	83 c4 0c             	add    $0xc,%esp
    20af:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    20b3:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    20b7:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    20bb:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    20be:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    20c5:	8d 45 88             	lea    -0x78(%ebp),%eax
    20c8:	68 cd 00 00 00       	push   $0xcd
    20cd:	6a 74                	push   $0x74
    20cf:	6a 18                	push   $0x18
    20d1:	50                   	push   %eax
    20d2:	e8 54 f5 ff ff       	call   162b <RGB>
    20d7:	83 c4 0c             	add    $0xc,%esp
    20da:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    20de:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    20e2:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    20e6:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    20e9:	8b 45 08             	mov    0x8(%ebp),%eax
    20ec:	8d 50 58             	lea    0x58(%eax),%edx
    20ef:	8d 45 88             	lea    -0x78(%ebp),%eax
    20f2:	ff 75 bc             	pushl  -0x44(%ebp)
    20f5:	ff 75 b8             	pushl  -0x48(%ebp)
    20f8:	52                   	push   %edx
    20f9:	50                   	push   %eax
    20fa:	e8 19 ec ff ff       	call   d18 <APSetPen>
    20ff:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2102:	8b 45 08             	mov    0x8(%ebp),%eax
    2105:	8d 58 58             	lea    0x58(%eax),%ebx
    2108:	8d 55 88             	lea    -0x78(%ebp),%edx
    210b:	83 ec 04             	sub    $0x4,%esp
    210e:	83 ec 04             	sub    $0x4,%esp
    2111:	89 e0                	mov    %esp,%eax
    2113:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    2117:	66 89 08             	mov    %cx,(%eax)
    211a:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    211e:	88 48 02             	mov    %cl,0x2(%eax)
    2121:	53                   	push   %ebx
    2122:	52                   	push   %edx
    2123:	e8 29 ec ff ff       	call   d51 <APSetBrush>
    2128:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    212b:	8b 45 08             	mov    0x8(%ebp),%eax
    212e:	83 c0 58             	add    $0x58,%eax
    2131:	83 ec 0c             	sub    $0xc,%esp
    2134:	6a 32                	push   $0x32
    2136:	68 20 03 00 00       	push   $0x320
    213b:	6a 00                	push   $0x0
    213d:	6a 00                	push   $0x0
    213f:	50                   	push   %eax
    2140:	e8 36 f0 ff ff       	call   117b <APDrawRect>
    2145:	83 c4 20             	add    $0x20,%esp
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    2148:	8d 45 88             	lea    -0x78(%ebp),%eax
    214b:	6a 08                	push   $0x8
    214d:	6a 08                	push   $0x8
    214f:	6a 08                	push   $0x8
    2151:	50                   	push   %eax
    2152:	e8 d4 f4 ff ff       	call   162b <RGB>
    2157:	83 c4 0c             	add    $0xc,%esp
    215a:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    215e:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    2162:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2166:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    2169:	8b 45 08             	mov    0x8(%ebp),%eax
    216c:	8d 58 58             	lea    0x58(%eax),%ebx
    216f:	8d 55 88             	lea    -0x78(%ebp),%edx
    2172:	83 ec 04             	sub    $0x4,%esp
    2175:	83 ec 04             	sub    $0x4,%esp
    2178:	89 e0                	mov    %esp,%eax
    217a:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    217e:	66 89 08             	mov    %cx,(%eax)
    2181:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    2185:	88 48 02             	mov    %cl,0x2(%eax)
    2188:	53                   	push   %ebx
    2189:	52                   	push   %edx
    218a:	e8 04 ec ff ff       	call   d93 <APSetFont>
    218f:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    2192:	8b 45 08             	mov    0x8(%ebp),%eax
    2195:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    219b:	8b 45 08             	mov    0x8(%ebp),%eax
    219e:	83 c0 58             	add    $0x58,%eax
    21a1:	6a 14                	push   $0x14
    21a3:	6a 14                	push   $0x14
    21a5:	52                   	push   %edx
    21a6:	50                   	push   %eax
    21a7:	e8 d4 f1 ff ff       	call   1380 <APDrawText>
    21ac:	83 c4 10             	add    $0x10,%esp
}
    21af:	8d 65 f4             	lea    -0xc(%ebp),%esp
    21b2:	5b                   	pop    %ebx
    21b3:	5e                   	pop    %esi
    21b4:	5f                   	pop    %edi
    21b5:	5d                   	pop    %ebp
    21b6:	c3                   	ret    

000021b7 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    21b7:	55                   	push   %ebp
    21b8:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    21ba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    21be:	7e 08                	jle    21c8 <random+0x11>
{
rand_num = seed;
    21c0:	8b 45 08             	mov    0x8(%ebp),%eax
    21c3:	a3 c0 68 00 00       	mov    %eax,0x68c0
}
rand_num *= 3;
    21c8:	8b 15 c0 68 00 00    	mov    0x68c0,%edx
    21ce:	89 d0                	mov    %edx,%eax
    21d0:	01 c0                	add    %eax,%eax
    21d2:	01 d0                	add    %edx,%eax
    21d4:	a3 c0 68 00 00       	mov    %eax,0x68c0
if (rand_num < 0)
    21d9:	a1 c0 68 00 00       	mov    0x68c0,%eax
    21de:	85 c0                	test   %eax,%eax
    21e0:	79 0c                	jns    21ee <random+0x37>
{
rand_num *= (-1);
    21e2:	a1 c0 68 00 00       	mov    0x68c0,%eax
    21e7:	f7 d8                	neg    %eax
    21e9:	a3 c0 68 00 00       	mov    %eax,0x68c0
}
return rand_num % 997;
    21ee:	8b 0d c0 68 00 00    	mov    0x68c0,%ecx
    21f4:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    21f9:	89 c8                	mov    %ecx,%eax
    21fb:	f7 ea                	imul   %edx
    21fd:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2200:	c1 f8 09             	sar    $0x9,%eax
    2203:	89 c2                	mov    %eax,%edx
    2205:	89 c8                	mov    %ecx,%eax
    2207:	c1 f8 1f             	sar    $0x1f,%eax
    220a:	29 c2                	sub    %eax,%edx
    220c:	89 d0                	mov    %edx,%eax
    220e:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2214:	29 c1                	sub    %eax,%ecx
    2216:	89 c8                	mov    %ecx,%eax
}
    2218:	5d                   	pop    %ebp
    2219:	c3                   	ret    

0000221a <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    221a:	55                   	push   %ebp
    221b:	89 e5                	mov    %esp,%ebp
    221d:	53                   	push   %ebx
    221e:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2221:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2228:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    222c:	74 17                	je     2245 <sprintint+0x2b>
    222e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2232:	79 11                	jns    2245 <sprintint+0x2b>
        neg = 1;
    2234:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    223b:	8b 45 10             	mov    0x10(%ebp),%eax
    223e:	f7 d8                	neg    %eax
    2240:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2243:	eb 06                	jmp    224b <sprintint+0x31>
    } else {
        x = xx;
    2245:	8b 45 10             	mov    0x10(%ebp),%eax
    2248:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    224b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2252:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2255:	8d 41 01             	lea    0x1(%ecx),%eax
    2258:	89 45 f8             	mov    %eax,-0x8(%ebp)
    225b:	8b 5d 14             	mov    0x14(%ebp),%ebx
    225e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2261:	ba 00 00 00 00       	mov    $0x0,%edx
    2266:	f7 f3                	div    %ebx
    2268:	89 d0                	mov    %edx,%eax
    226a:	0f b6 80 c4 68 00 00 	movzbl 0x68c4(%eax),%eax
    2271:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2275:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2278:	8b 45 f0             	mov    -0x10(%ebp),%eax
    227b:	ba 00 00 00 00       	mov    $0x0,%edx
    2280:	f7 f3                	div    %ebx
    2282:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2285:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2289:	75 c7                	jne    2252 <sprintint+0x38>
    if(neg)
    228b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    228f:	74 0e                	je     229f <sprintint+0x85>
        buf[i++] = '-';
    2291:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2294:	8d 50 01             	lea    0x1(%eax),%edx
    2297:	89 55 f8             	mov    %edx,-0x8(%ebp)
    229a:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    229f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22a2:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    22a5:	eb 1b                	jmp    22c2 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    22a7:	8b 45 0c             	mov    0xc(%ebp),%eax
    22aa:	8b 00                	mov    (%eax),%eax
    22ac:	8d 48 01             	lea    0x1(%eax),%ecx
    22af:	8b 55 0c             	mov    0xc(%ebp),%edx
    22b2:	89 0a                	mov    %ecx,(%edx)
    22b4:	89 c2                	mov    %eax,%edx
    22b6:	8b 45 08             	mov    0x8(%ebp),%eax
    22b9:	01 d0                	add    %edx,%eax
    22bb:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    22be:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    22c2:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    22c6:	7f df                	jg     22a7 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    22c8:	eb 21                	jmp    22eb <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    22ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    22cd:	8b 00                	mov    (%eax),%eax
    22cf:	8d 48 01             	lea    0x1(%eax),%ecx
    22d2:	8b 55 0c             	mov    0xc(%ebp),%edx
    22d5:	89 0a                	mov    %ecx,(%edx)
    22d7:	89 c2                	mov    %eax,%edx
    22d9:	8b 45 08             	mov    0x8(%ebp),%eax
    22dc:	01 c2                	add    %eax,%edx
    22de:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    22e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22e4:	01 c8                	add    %ecx,%eax
    22e6:	0f b6 00             	movzbl (%eax),%eax
    22e9:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    22eb:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    22ef:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    22f3:	79 d5                	jns    22ca <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    22f5:	90                   	nop
    22f6:	83 c4 20             	add    $0x20,%esp
    22f9:	5b                   	pop    %ebx
    22fa:	5d                   	pop    %ebp
    22fb:	c3                   	ret    

000022fc <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    22fc:	55                   	push   %ebp
    22fd:	89 e5                	mov    %esp,%ebp
    22ff:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2302:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2309:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2310:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2317:	8d 45 0c             	lea    0xc(%ebp),%eax
    231a:	83 c0 04             	add    $0x4,%eax
    231d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2320:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2327:	e9 d9 01 00 00       	jmp    2505 <sprintf+0x209>
        c = fmt[i] & 0xff;
    232c:	8b 55 0c             	mov    0xc(%ebp),%edx
    232f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2332:	01 d0                	add    %edx,%eax
    2334:	0f b6 00             	movzbl (%eax),%eax
    2337:	0f be c0             	movsbl %al,%eax
    233a:	25 ff 00 00 00       	and    $0xff,%eax
    233f:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2342:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2346:	75 2c                	jne    2374 <sprintf+0x78>
            if(c == '%'){
    2348:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    234c:	75 0c                	jne    235a <sprintf+0x5e>
                state = '%';
    234e:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2355:	e9 a7 01 00 00       	jmp    2501 <sprintf+0x205>
            } else {
                dst[j++] = c;
    235a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    235d:	8d 50 01             	lea    0x1(%eax),%edx
    2360:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2363:	89 c2                	mov    %eax,%edx
    2365:	8b 45 08             	mov    0x8(%ebp),%eax
    2368:	01 d0                	add    %edx,%eax
    236a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    236d:	88 10                	mov    %dl,(%eax)
    236f:	e9 8d 01 00 00       	jmp    2501 <sprintf+0x205>
            }
        } else if(state == '%'){
    2374:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2378:	0f 85 83 01 00 00    	jne    2501 <sprintf+0x205>
            if(c == 'd'){
    237e:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2382:	75 4c                	jne    23d0 <sprintf+0xd4>
                buf[bi] = '\0';
    2384:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2387:	8b 45 f0             	mov    -0x10(%ebp),%eax
    238a:	01 d0                	add    %edx,%eax
    238c:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    238f:	83 ec 0c             	sub    $0xc,%esp
    2392:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2395:	50                   	push   %eax
    2396:	e8 e7 df ff ff       	call   382 <atoi>
    239b:	83 c4 10             	add    $0x10,%esp
    239e:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    23a1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    23a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23ab:	8b 00                	mov    (%eax),%eax
    23ad:	83 ec 08             	sub    $0x8,%esp
    23b0:	ff 75 d8             	pushl  -0x28(%ebp)
    23b3:	6a 01                	push   $0x1
    23b5:	6a 0a                	push   $0xa
    23b7:	50                   	push   %eax
    23b8:	8d 45 c8             	lea    -0x38(%ebp),%eax
    23bb:	50                   	push   %eax
    23bc:	ff 75 08             	pushl  0x8(%ebp)
    23bf:	e8 56 fe ff ff       	call   221a <sprintint>
    23c4:	83 c4 20             	add    $0x20,%esp
                ap++;
    23c7:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    23cb:	e9 2a 01 00 00       	jmp    24fa <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    23d0:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    23d4:	74 06                	je     23dc <sprintf+0xe0>
    23d6:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    23da:	75 4c                	jne    2428 <sprintf+0x12c>
                buf[bi] = '\0';
    23dc:	8d 55 ce             	lea    -0x32(%ebp),%edx
    23df:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23e2:	01 d0                	add    %edx,%eax
    23e4:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    23e7:	83 ec 0c             	sub    $0xc,%esp
    23ea:	8d 45 ce             	lea    -0x32(%ebp),%eax
    23ed:	50                   	push   %eax
    23ee:	e8 8f df ff ff       	call   382 <atoi>
    23f3:	83 c4 10             	add    $0x10,%esp
    23f6:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    23f9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2400:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2403:	8b 00                	mov    (%eax),%eax
    2405:	83 ec 08             	sub    $0x8,%esp
    2408:	ff 75 dc             	pushl  -0x24(%ebp)
    240b:	6a 00                	push   $0x0
    240d:	6a 10                	push   $0x10
    240f:	50                   	push   %eax
    2410:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2413:	50                   	push   %eax
    2414:	ff 75 08             	pushl  0x8(%ebp)
    2417:	e8 fe fd ff ff       	call   221a <sprintint>
    241c:	83 c4 20             	add    $0x20,%esp
                ap++;
    241f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2423:	e9 d2 00 00 00       	jmp    24fa <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2428:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    242c:	75 46                	jne    2474 <sprintf+0x178>
                s = (char*)*ap;
    242e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2431:	8b 00                	mov    (%eax),%eax
    2433:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2436:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    243a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    243e:	75 25                	jne    2465 <sprintf+0x169>
                    s = "(null)";
    2440:	c7 45 f4 dc 26 00 00 	movl   $0x26dc,-0xc(%ebp)
                while(*s != 0){
    2447:	eb 1c                	jmp    2465 <sprintf+0x169>
                    dst[j++] = *s;
    2449:	8b 45 c8             	mov    -0x38(%ebp),%eax
    244c:	8d 50 01             	lea    0x1(%eax),%edx
    244f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2452:	89 c2                	mov    %eax,%edx
    2454:	8b 45 08             	mov    0x8(%ebp),%eax
    2457:	01 c2                	add    %eax,%edx
    2459:	8b 45 f4             	mov    -0xc(%ebp),%eax
    245c:	0f b6 00             	movzbl (%eax),%eax
    245f:	88 02                	mov    %al,(%edx)
                    s++;
    2461:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2465:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2468:	0f b6 00             	movzbl (%eax),%eax
    246b:	84 c0                	test   %al,%al
    246d:	75 da                	jne    2449 <sprintf+0x14d>
    246f:	e9 86 00 00 00       	jmp    24fa <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2474:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2478:	75 1d                	jne    2497 <sprintf+0x19b>
                dst[j++] = *ap;
    247a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    247d:	8d 50 01             	lea    0x1(%eax),%edx
    2480:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2483:	89 c2                	mov    %eax,%edx
    2485:	8b 45 08             	mov    0x8(%ebp),%eax
    2488:	01 c2                	add    %eax,%edx
    248a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    248d:	8b 00                	mov    (%eax),%eax
    248f:	88 02                	mov    %al,(%edx)
                ap++;
    2491:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2495:	eb 63                	jmp    24fa <sprintf+0x1fe>
            } else if(c == '%'){
    2497:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    249b:	75 17                	jne    24b4 <sprintf+0x1b8>
                dst[j++] = c;
    249d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24a0:	8d 50 01             	lea    0x1(%eax),%edx
    24a3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24a6:	89 c2                	mov    %eax,%edx
    24a8:	8b 45 08             	mov    0x8(%ebp),%eax
    24ab:	01 d0                	add    %edx,%eax
    24ad:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24b0:	88 10                	mov    %dl,(%eax)
    24b2:	eb 46                	jmp    24fa <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    24b4:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    24b8:	7e 18                	jle    24d2 <sprintf+0x1d6>
    24ba:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    24be:	7f 12                	jg     24d2 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    24c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24c3:	8d 50 01             	lea    0x1(%eax),%edx
    24c6:	89 55 f0             	mov    %edx,-0x10(%ebp)
    24c9:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24cc:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    24d0:	eb 2f                	jmp    2501 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    24d2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24d5:	8d 50 01             	lea    0x1(%eax),%edx
    24d8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24db:	89 c2                	mov    %eax,%edx
    24dd:	8b 45 08             	mov    0x8(%ebp),%eax
    24e0:	01 d0                	add    %edx,%eax
    24e2:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    24e5:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24e8:	8d 50 01             	lea    0x1(%eax),%edx
    24eb:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24ee:	89 c2                	mov    %eax,%edx
    24f0:	8b 45 08             	mov    0x8(%ebp),%eax
    24f3:	01 d0                	add    %edx,%eax
    24f5:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24f8:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    24fa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2501:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2505:	8b 55 0c             	mov    0xc(%ebp),%edx
    2508:	8b 45 ec             	mov    -0x14(%ebp),%eax
    250b:	01 d0                	add    %edx,%eax
    250d:	0f b6 00             	movzbl (%eax),%eax
    2510:	84 c0                	test   %al,%al
    2512:	0f 85 14 fe ff ff    	jne    232c <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2518:	8b 45 c8             	mov    -0x38(%ebp),%eax
    251b:	8d 50 01             	lea    0x1(%eax),%edx
    251e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2521:	89 c2                	mov    %eax,%edx
    2523:	8b 45 08             	mov    0x8(%ebp),%eax
    2526:	01 d0                	add    %edx,%eax
    2528:	c6 00 00             	movb   $0x0,(%eax)
}
    252b:	90                   	nop
    252c:	c9                   	leave  
    252d:	c3                   	ret    
