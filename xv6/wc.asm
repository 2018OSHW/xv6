
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
      32:	05 80 6a 00 00       	add    $0x6a80,%eax
      37:	0f b6 00             	movzbl (%eax),%eax
      3a:	3c 0a                	cmp    $0xa,%al
      3c:	75 04                	jne    42 <wc+0x42>
        l++;
      3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
      42:	8b 45 f4             	mov    -0xc(%ebp),%eax
      45:	05 80 6a 00 00       	add    $0x6a80,%eax
      4a:	0f b6 00             	movzbl (%eax),%eax
      4d:	0f be c0             	movsbl %al,%eax
      50:	83 ec 08             	sub    $0x8,%esp
      53:	50                   	push   %eax
      54:	68 5c 26 00 00       	push   $0x265c
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
      93:	68 80 6a 00 00       	push   $0x6a80
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
      b9:	68 62 26 00 00       	push   $0x2662
      be:	6a 01                	push   $0x1
      c0:	e8 0e 05 00 00       	call   5d3 <printf>
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
      dc:	68 72 26 00 00       	push   $0x2672
      e1:	6a 01                	push   $0x1
      e3:	e8 eb 04 00 00       	call   5d3 <printf>
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
     10a:	68 7f 26 00 00       	push   $0x267f
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
     167:	68 80 26 00 00       	push   $0x2680
     16c:	6a 01                	push   $0x1
     16e:	e8 60 04 00 00       	call   5d3 <printf>
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

000004ec <getCurrentTime>:
SYSCALL(getCurrentTime)
     4ec:	b8 1d 00 00 00       	mov    $0x1d,%eax
     4f1:	cd 40                	int    $0x40
     4f3:	c3                   	ret    

000004f4 <removeWindow>:
SYSCALL(removeWindow)
     4f4:	b8 1e 00 00 00       	mov    $0x1e,%eax
     4f9:	cd 40                	int    $0x40
     4fb:	c3                   	ret    

000004fc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     4fc:	55                   	push   %ebp
     4fd:	89 e5                	mov    %esp,%ebp
     4ff:	83 ec 18             	sub    $0x18,%esp
     502:	8b 45 0c             	mov    0xc(%ebp),%eax
     505:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     508:	83 ec 04             	sub    $0x4,%esp
     50b:	6a 01                	push   $0x1
     50d:	8d 45 f4             	lea    -0xc(%ebp),%eax
     510:	50                   	push   %eax
     511:	ff 75 08             	pushl  0x8(%ebp)
     514:	e8 1b ff ff ff       	call   434 <write>
     519:	83 c4 10             	add    $0x10,%esp
}
     51c:	90                   	nop
     51d:	c9                   	leave  
     51e:	c3                   	ret    

0000051f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     51f:	55                   	push   %ebp
     520:	89 e5                	mov    %esp,%ebp
     522:	53                   	push   %ebx
     523:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     526:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     52d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     531:	74 17                	je     54a <printint+0x2b>
     533:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     537:	79 11                	jns    54a <printint+0x2b>
    neg = 1;
     539:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     540:	8b 45 0c             	mov    0xc(%ebp),%eax
     543:	f7 d8                	neg    %eax
     545:	89 45 ec             	mov    %eax,-0x14(%ebp)
     548:	eb 06                	jmp    550 <printint+0x31>
  } else {
    x = xx;
     54a:	8b 45 0c             	mov    0xc(%ebp),%eax
     54d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     550:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     557:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     55a:	8d 41 01             	lea    0x1(%ecx),%eax
     55d:	89 45 f4             	mov    %eax,-0xc(%ebp)
     560:	8b 5d 10             	mov    0x10(%ebp),%ebx
     563:	8b 45 ec             	mov    -0x14(%ebp),%eax
     566:	ba 00 00 00 00       	mov    $0x0,%edx
     56b:	f7 f3                	div    %ebx
     56d:	89 d0                	mov    %edx,%eax
     56f:	0f b6 80 00 2e 00 00 	movzbl 0x2e00(%eax),%eax
     576:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     57a:	8b 5d 10             	mov    0x10(%ebp),%ebx
     57d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     580:	ba 00 00 00 00       	mov    $0x0,%edx
     585:	f7 f3                	div    %ebx
     587:	89 45 ec             	mov    %eax,-0x14(%ebp)
     58a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     58e:	75 c7                	jne    557 <printint+0x38>
  if(neg)
     590:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     594:	74 2d                	je     5c3 <printint+0xa4>
    buf[i++] = '-';
     596:	8b 45 f4             	mov    -0xc(%ebp),%eax
     599:	8d 50 01             	lea    0x1(%eax),%edx
     59c:	89 55 f4             	mov    %edx,-0xc(%ebp)
     59f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     5a4:	eb 1d                	jmp    5c3 <printint+0xa4>
    putc(fd, buf[i]);
     5a6:	8d 55 dc             	lea    -0x24(%ebp),%edx
     5a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5ac:	01 d0                	add    %edx,%eax
     5ae:	0f b6 00             	movzbl (%eax),%eax
     5b1:	0f be c0             	movsbl %al,%eax
     5b4:	83 ec 08             	sub    $0x8,%esp
     5b7:	50                   	push   %eax
     5b8:	ff 75 08             	pushl  0x8(%ebp)
     5bb:	e8 3c ff ff ff       	call   4fc <putc>
     5c0:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     5c3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     5c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5cb:	79 d9                	jns    5a6 <printint+0x87>
    putc(fd, buf[i]);
}
     5cd:	90                   	nop
     5ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5d1:	c9                   	leave  
     5d2:	c3                   	ret    

000005d3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     5d3:	55                   	push   %ebp
     5d4:	89 e5                	mov    %esp,%ebp
     5d6:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     5d9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     5e0:	8d 45 0c             	lea    0xc(%ebp),%eax
     5e3:	83 c0 04             	add    $0x4,%eax
     5e6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     5e9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     5f0:	e9 59 01 00 00       	jmp    74e <printf+0x17b>
    c = fmt[i] & 0xff;
     5f5:	8b 55 0c             	mov    0xc(%ebp),%edx
     5f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5fb:	01 d0                	add    %edx,%eax
     5fd:	0f b6 00             	movzbl (%eax),%eax
     600:	0f be c0             	movsbl %al,%eax
     603:	25 ff 00 00 00       	and    $0xff,%eax
     608:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     60b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     60f:	75 2c                	jne    63d <printf+0x6a>
      if(c == '%'){
     611:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     615:	75 0c                	jne    623 <printf+0x50>
        state = '%';
     617:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     61e:	e9 27 01 00 00       	jmp    74a <printf+0x177>
      } else {
        putc(fd, c);
     623:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     626:	0f be c0             	movsbl %al,%eax
     629:	83 ec 08             	sub    $0x8,%esp
     62c:	50                   	push   %eax
     62d:	ff 75 08             	pushl  0x8(%ebp)
     630:	e8 c7 fe ff ff       	call   4fc <putc>
     635:	83 c4 10             	add    $0x10,%esp
     638:	e9 0d 01 00 00       	jmp    74a <printf+0x177>
      }
    } else if(state == '%'){
     63d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     641:	0f 85 03 01 00 00    	jne    74a <printf+0x177>
      if(c == 'd'){
     647:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     64b:	75 1e                	jne    66b <printf+0x98>
        printint(fd, *ap, 10, 1);
     64d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     650:	8b 00                	mov    (%eax),%eax
     652:	6a 01                	push   $0x1
     654:	6a 0a                	push   $0xa
     656:	50                   	push   %eax
     657:	ff 75 08             	pushl  0x8(%ebp)
     65a:	e8 c0 fe ff ff       	call   51f <printint>
     65f:	83 c4 10             	add    $0x10,%esp
        ap++;
     662:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     666:	e9 d8 00 00 00       	jmp    743 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     66b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     66f:	74 06                	je     677 <printf+0xa4>
     671:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     675:	75 1e                	jne    695 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     677:	8b 45 e8             	mov    -0x18(%ebp),%eax
     67a:	8b 00                	mov    (%eax),%eax
     67c:	6a 00                	push   $0x0
     67e:	6a 10                	push   $0x10
     680:	50                   	push   %eax
     681:	ff 75 08             	pushl  0x8(%ebp)
     684:	e8 96 fe ff ff       	call   51f <printint>
     689:	83 c4 10             	add    $0x10,%esp
        ap++;
     68c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     690:	e9 ae 00 00 00       	jmp    743 <printf+0x170>
      } else if(c == 's'){
     695:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     699:	75 43                	jne    6de <printf+0x10b>
        s = (char*)*ap;
     69b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     69e:	8b 00                	mov    (%eax),%eax
     6a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     6a3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     6a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     6ab:	75 25                	jne    6d2 <printf+0xff>
          s = "(null)";
     6ad:	c7 45 f4 94 26 00 00 	movl   $0x2694,-0xc(%ebp)
        while(*s != 0){
     6b4:	eb 1c                	jmp    6d2 <printf+0xff>
          putc(fd, *s);
     6b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6b9:	0f b6 00             	movzbl (%eax),%eax
     6bc:	0f be c0             	movsbl %al,%eax
     6bf:	83 ec 08             	sub    $0x8,%esp
     6c2:	50                   	push   %eax
     6c3:	ff 75 08             	pushl  0x8(%ebp)
     6c6:	e8 31 fe ff ff       	call   4fc <putc>
     6cb:	83 c4 10             	add    $0x10,%esp
          s++;
     6ce:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     6d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6d5:	0f b6 00             	movzbl (%eax),%eax
     6d8:	84 c0                	test   %al,%al
     6da:	75 da                	jne    6b6 <printf+0xe3>
     6dc:	eb 65                	jmp    743 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     6de:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     6e2:	75 1d                	jne    701 <printf+0x12e>
        putc(fd, *ap);
     6e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6e7:	8b 00                	mov    (%eax),%eax
     6e9:	0f be c0             	movsbl %al,%eax
     6ec:	83 ec 08             	sub    $0x8,%esp
     6ef:	50                   	push   %eax
     6f0:	ff 75 08             	pushl  0x8(%ebp)
     6f3:	e8 04 fe ff ff       	call   4fc <putc>
     6f8:	83 c4 10             	add    $0x10,%esp
        ap++;
     6fb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     6ff:	eb 42                	jmp    743 <printf+0x170>
      } else if(c == '%'){
     701:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     705:	75 17                	jne    71e <printf+0x14b>
        putc(fd, c);
     707:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     70a:	0f be c0             	movsbl %al,%eax
     70d:	83 ec 08             	sub    $0x8,%esp
     710:	50                   	push   %eax
     711:	ff 75 08             	pushl  0x8(%ebp)
     714:	e8 e3 fd ff ff       	call   4fc <putc>
     719:	83 c4 10             	add    $0x10,%esp
     71c:	eb 25                	jmp    743 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     71e:	83 ec 08             	sub    $0x8,%esp
     721:	6a 25                	push   $0x25
     723:	ff 75 08             	pushl  0x8(%ebp)
     726:	e8 d1 fd ff ff       	call   4fc <putc>
     72b:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     72e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     731:	0f be c0             	movsbl %al,%eax
     734:	83 ec 08             	sub    $0x8,%esp
     737:	50                   	push   %eax
     738:	ff 75 08             	pushl  0x8(%ebp)
     73b:	e8 bc fd ff ff       	call   4fc <putc>
     740:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     743:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     74a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     74e:	8b 55 0c             	mov    0xc(%ebp),%edx
     751:	8b 45 f0             	mov    -0x10(%ebp),%eax
     754:	01 d0                	add    %edx,%eax
     756:	0f b6 00             	movzbl (%eax),%eax
     759:	84 c0                	test   %al,%al
     75b:	0f 85 94 fe ff ff    	jne    5f5 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     761:	90                   	nop
     762:	c9                   	leave  
     763:	c3                   	ret    

00000764 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     764:	55                   	push   %ebp
     765:	89 e5                	mov    %esp,%ebp
     767:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     76a:	8b 45 08             	mov    0x8(%ebp),%eax
     76d:	83 e8 08             	sub    $0x8,%eax
     770:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     773:	a1 68 6a 00 00       	mov    0x6a68,%eax
     778:	89 45 fc             	mov    %eax,-0x4(%ebp)
     77b:	eb 24                	jmp    7a1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     77d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     780:	8b 00                	mov    (%eax),%eax
     782:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     785:	77 12                	ja     799 <free+0x35>
     787:	8b 45 f8             	mov    -0x8(%ebp),%eax
     78a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     78d:	77 24                	ja     7b3 <free+0x4f>
     78f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     792:	8b 00                	mov    (%eax),%eax
     794:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     797:	77 1a                	ja     7b3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     799:	8b 45 fc             	mov    -0x4(%ebp),%eax
     79c:	8b 00                	mov    (%eax),%eax
     79e:	89 45 fc             	mov    %eax,-0x4(%ebp)
     7a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7a4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     7a7:	76 d4                	jbe    77d <free+0x19>
     7a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7ac:	8b 00                	mov    (%eax),%eax
     7ae:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     7b1:	76 ca                	jbe    77d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     7b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7b6:	8b 40 04             	mov    0x4(%eax),%eax
     7b9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     7c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7c3:	01 c2                	add    %eax,%edx
     7c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7c8:	8b 00                	mov    (%eax),%eax
     7ca:	39 c2                	cmp    %eax,%edx
     7cc:	75 24                	jne    7f2 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     7ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7d1:	8b 50 04             	mov    0x4(%eax),%edx
     7d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7d7:	8b 00                	mov    (%eax),%eax
     7d9:	8b 40 04             	mov    0x4(%eax),%eax
     7dc:	01 c2                	add    %eax,%edx
     7de:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7e1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     7e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7e7:	8b 00                	mov    (%eax),%eax
     7e9:	8b 10                	mov    (%eax),%edx
     7eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7ee:	89 10                	mov    %edx,(%eax)
     7f0:	eb 0a                	jmp    7fc <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     7f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7f5:	8b 10                	mov    (%eax),%edx
     7f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7fa:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     7fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7ff:	8b 40 04             	mov    0x4(%eax),%eax
     802:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     809:	8b 45 fc             	mov    -0x4(%ebp),%eax
     80c:	01 d0                	add    %edx,%eax
     80e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     811:	75 20                	jne    833 <free+0xcf>
    p->s.size += bp->s.size;
     813:	8b 45 fc             	mov    -0x4(%ebp),%eax
     816:	8b 50 04             	mov    0x4(%eax),%edx
     819:	8b 45 f8             	mov    -0x8(%ebp),%eax
     81c:	8b 40 04             	mov    0x4(%eax),%eax
     81f:	01 c2                	add    %eax,%edx
     821:	8b 45 fc             	mov    -0x4(%ebp),%eax
     824:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     827:	8b 45 f8             	mov    -0x8(%ebp),%eax
     82a:	8b 10                	mov    (%eax),%edx
     82c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     82f:	89 10                	mov    %edx,(%eax)
     831:	eb 08                	jmp    83b <free+0xd7>
  } else
    p->s.ptr = bp;
     833:	8b 45 fc             	mov    -0x4(%ebp),%eax
     836:	8b 55 f8             	mov    -0x8(%ebp),%edx
     839:	89 10                	mov    %edx,(%eax)
  freep = p;
     83b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     83e:	a3 68 6a 00 00       	mov    %eax,0x6a68
}
     843:	90                   	nop
     844:	c9                   	leave  
     845:	c3                   	ret    

00000846 <morecore>:

static Header*
morecore(uint nu)
{
     846:	55                   	push   %ebp
     847:	89 e5                	mov    %esp,%ebp
     849:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     84c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     853:	77 07                	ja     85c <morecore+0x16>
    nu = 4096;
     855:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     85c:	8b 45 08             	mov    0x8(%ebp),%eax
     85f:	c1 e0 03             	shl    $0x3,%eax
     862:	83 ec 0c             	sub    $0xc,%esp
     865:	50                   	push   %eax
     866:	e8 31 fc ff ff       	call   49c <sbrk>
     86b:	83 c4 10             	add    $0x10,%esp
     86e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     871:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     875:	75 07                	jne    87e <morecore+0x38>
    return 0;
     877:	b8 00 00 00 00       	mov    $0x0,%eax
     87c:	eb 26                	jmp    8a4 <morecore+0x5e>
  hp = (Header*)p;
     87e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     881:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     884:	8b 45 f0             	mov    -0x10(%ebp),%eax
     887:	8b 55 08             	mov    0x8(%ebp),%edx
     88a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     88d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     890:	83 c0 08             	add    $0x8,%eax
     893:	83 ec 0c             	sub    $0xc,%esp
     896:	50                   	push   %eax
     897:	e8 c8 fe ff ff       	call   764 <free>
     89c:	83 c4 10             	add    $0x10,%esp
  return freep;
     89f:	a1 68 6a 00 00       	mov    0x6a68,%eax
}
     8a4:	c9                   	leave  
     8a5:	c3                   	ret    

000008a6 <malloc>:

void*
malloc(uint nbytes)
{
     8a6:	55                   	push   %ebp
     8a7:	89 e5                	mov    %esp,%ebp
     8a9:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     8ac:	8b 45 08             	mov    0x8(%ebp),%eax
     8af:	83 c0 07             	add    $0x7,%eax
     8b2:	c1 e8 03             	shr    $0x3,%eax
     8b5:	83 c0 01             	add    $0x1,%eax
     8b8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     8bb:	a1 68 6a 00 00       	mov    0x6a68,%eax
     8c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8c7:	75 23                	jne    8ec <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     8c9:	c7 45 f0 60 6a 00 00 	movl   $0x6a60,-0x10(%ebp)
     8d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8d3:	a3 68 6a 00 00       	mov    %eax,0x6a68
     8d8:	a1 68 6a 00 00       	mov    0x6a68,%eax
     8dd:	a3 60 6a 00 00       	mov    %eax,0x6a60
    base.s.size = 0;
     8e2:	c7 05 64 6a 00 00 00 	movl   $0x0,0x6a64
     8e9:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8ef:	8b 00                	mov    (%eax),%eax
     8f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     8f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f7:	8b 40 04             	mov    0x4(%eax),%eax
     8fa:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     8fd:	72 4d                	jb     94c <malloc+0xa6>
      if(p->s.size == nunits)
     8ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     902:	8b 40 04             	mov    0x4(%eax),%eax
     905:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     908:	75 0c                	jne    916 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     90a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     90d:	8b 10                	mov    (%eax),%edx
     90f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     912:	89 10                	mov    %edx,(%eax)
     914:	eb 26                	jmp    93c <malloc+0x96>
      else {
        p->s.size -= nunits;
     916:	8b 45 f4             	mov    -0xc(%ebp),%eax
     919:	8b 40 04             	mov    0x4(%eax),%eax
     91c:	2b 45 ec             	sub    -0x14(%ebp),%eax
     91f:	89 c2                	mov    %eax,%edx
     921:	8b 45 f4             	mov    -0xc(%ebp),%eax
     924:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     927:	8b 45 f4             	mov    -0xc(%ebp),%eax
     92a:	8b 40 04             	mov    0x4(%eax),%eax
     92d:	c1 e0 03             	shl    $0x3,%eax
     930:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     933:	8b 45 f4             	mov    -0xc(%ebp),%eax
     936:	8b 55 ec             	mov    -0x14(%ebp),%edx
     939:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     93c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     93f:	a3 68 6a 00 00       	mov    %eax,0x6a68
      return (void*)(p + 1);
     944:	8b 45 f4             	mov    -0xc(%ebp),%eax
     947:	83 c0 08             	add    $0x8,%eax
     94a:	eb 3b                	jmp    987 <malloc+0xe1>
    }
    if(p == freep)
     94c:	a1 68 6a 00 00       	mov    0x6a68,%eax
     951:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     954:	75 1e                	jne    974 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     956:	83 ec 0c             	sub    $0xc,%esp
     959:	ff 75 ec             	pushl  -0x14(%ebp)
     95c:	e8 e5 fe ff ff       	call   846 <morecore>
     961:	83 c4 10             	add    $0x10,%esp
     964:	89 45 f4             	mov    %eax,-0xc(%ebp)
     967:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     96b:	75 07                	jne    974 <malloc+0xce>
        return 0;
     96d:	b8 00 00 00 00       	mov    $0x0,%eax
     972:	eb 13                	jmp    987 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     974:	8b 45 f4             	mov    -0xc(%ebp),%eax
     977:	89 45 f0             	mov    %eax,-0x10(%ebp)
     97a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     97d:	8b 00                	mov    (%eax),%eax
     97f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     982:	e9 6d ff ff ff       	jmp    8f4 <malloc+0x4e>
}
     987:	c9                   	leave  
     988:	c3                   	ret    

00000989 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     989:	55                   	push   %ebp
     98a:	89 e5                	mov    %esp,%ebp
     98c:	83 ec 1c             	sub    $0x1c,%esp
     98f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     992:	8b 55 10             	mov    0x10(%ebp),%edx
     995:	8b 45 14             	mov    0x14(%ebp),%eax
     998:	88 4d ec             	mov    %cl,-0x14(%ebp)
     99b:	88 55 e8             	mov    %dl,-0x18(%ebp)
     99e:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     9a1:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     9a5:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     9a8:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     9ac:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     9af:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     9b3:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     9b6:	8b 45 08             	mov    0x8(%ebp),%eax
     9b9:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     9bd:	66 89 10             	mov    %dx,(%eax)
     9c0:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     9c4:	88 50 02             	mov    %dl,0x2(%eax)
}
     9c7:	8b 45 08             	mov    0x8(%ebp),%eax
     9ca:	c9                   	leave  
     9cb:	c2 04 00             	ret    $0x4

000009ce <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     9ce:	55                   	push   %ebp
     9cf:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     9d1:	8b 45 08             	mov    0x8(%ebp),%eax
     9d4:	2b 45 10             	sub    0x10(%ebp),%eax
     9d7:	89 c2                	mov    %eax,%edx
     9d9:	8b 45 08             	mov    0x8(%ebp),%eax
     9dc:	2b 45 10             	sub    0x10(%ebp),%eax
     9df:	0f af d0             	imul   %eax,%edx
     9e2:	8b 45 0c             	mov    0xc(%ebp),%eax
     9e5:	2b 45 14             	sub    0x14(%ebp),%eax
     9e8:	89 c1                	mov    %eax,%ecx
     9ea:	8b 45 0c             	mov    0xc(%ebp),%eax
     9ed:	2b 45 14             	sub    0x14(%ebp),%eax
     9f0:	0f af c1             	imul   %ecx,%eax
     9f3:	01 d0                	add    %edx,%eax
}
     9f5:	5d                   	pop    %ebp
     9f6:	c3                   	ret    

000009f7 <abs_int>:

static inline int abs_int(int x)
{
     9f7:	55                   	push   %ebp
     9f8:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     9fa:	8b 45 08             	mov    0x8(%ebp),%eax
     9fd:	99                   	cltd   
     9fe:	89 d0                	mov    %edx,%eax
     a00:	33 45 08             	xor    0x8(%ebp),%eax
     a03:	29 d0                	sub    %edx,%eax
}
     a05:	5d                   	pop    %ebp
     a06:	c3                   	ret    

00000a07 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     a07:	55                   	push   %ebp
     a08:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     a0a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     a0e:	79 07                	jns    a17 <APGetIndex+0x10>
        return X_SMALLER;
     a10:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     a15:	eb 40                	jmp    a57 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     a17:	8b 45 08             	mov    0x8(%ebp),%eax
     a1a:	8b 00                	mov    (%eax),%eax
     a1c:	3b 45 0c             	cmp    0xc(%ebp),%eax
     a1f:	7f 07                	jg     a28 <APGetIndex+0x21>
        return X_BIGGER;
     a21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a26:	eb 2f                	jmp    a57 <APGetIndex+0x50>
    if (y < 0)
     a28:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     a2c:	79 07                	jns    a35 <APGetIndex+0x2e>
        return Y_SMALLER;
     a2e:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     a33:	eb 22                	jmp    a57 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     a35:	8b 45 08             	mov    0x8(%ebp),%eax
     a38:	8b 40 04             	mov    0x4(%eax),%eax
     a3b:	3b 45 10             	cmp    0x10(%ebp),%eax
     a3e:	7f 07                	jg     a47 <APGetIndex+0x40>
        return Y_BIGGER;
     a40:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     a45:	eb 10                	jmp    a57 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     a47:	8b 45 08             	mov    0x8(%ebp),%eax
     a4a:	8b 00                	mov    (%eax),%eax
     a4c:	0f af 45 10          	imul   0x10(%ebp),%eax
     a50:	89 c2                	mov    %eax,%edx
     a52:	8b 45 0c             	mov    0xc(%ebp),%eax
     a55:	01 d0                	add    %edx,%eax
}
     a57:	5d                   	pop    %ebp
     a58:	c3                   	ret    

00000a59 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     a59:	55                   	push   %ebp
     a5a:	89 e5                	mov    %esp,%ebp
     a5c:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     a5f:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     a66:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a69:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     a6c:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     a73:	83 ec 08             	sub    $0x8,%esp
     a76:	6a 00                	push   $0x0
     a78:	ff 75 0c             	pushl  0xc(%ebp)
     a7b:	e8 d4 f9 ff ff       	call   454 <open>
     a80:	83 c4 10             	add    $0x10,%esp
     a83:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     a86:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     a8a:	79 2e                	jns    aba <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     a8c:	83 ec 04             	sub    $0x4,%esp
     a8f:	ff 75 0c             	pushl  0xc(%ebp)
     a92:	68 9b 26 00 00       	push   $0x269b
     a97:	6a 01                	push   $0x1
     a99:	e8 35 fb ff ff       	call   5d3 <printf>
     a9e:	83 c4 10             	add    $0x10,%esp
        return bmp;
     aa1:	8b 45 08             	mov    0x8(%ebp),%eax
     aa4:	8b 55 c8             	mov    -0x38(%ebp),%edx
     aa7:	89 10                	mov    %edx,(%eax)
     aa9:	8b 55 cc             	mov    -0x34(%ebp),%edx
     aac:	89 50 04             	mov    %edx,0x4(%eax)
     aaf:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ab2:	89 50 08             	mov    %edx,0x8(%eax)
     ab5:	e9 d2 01 00 00       	jmp    c8c <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     aba:	83 ec 04             	sub    $0x4,%esp
     abd:	6a 0e                	push   $0xe
     abf:	8d 45 ba             	lea    -0x46(%ebp),%eax
     ac2:	50                   	push   %eax
     ac3:	ff 75 ec             	pushl  -0x14(%ebp)
     ac6:	e8 61 f9 ff ff       	call   42c <read>
     acb:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     ace:	83 ec 04             	sub    $0x4,%esp
     ad1:	6a 28                	push   $0x28
     ad3:	8d 45 92             	lea    -0x6e(%ebp),%eax
     ad6:	50                   	push   %eax
     ad7:	ff 75 ec             	pushl  -0x14(%ebp)
     ada:	e8 4d f9 ff ff       	call   42c <read>
     adf:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     ae2:	8b 45 96             	mov    -0x6a(%ebp),%eax
     ae5:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     ae8:	8b 45 9a             	mov    -0x66(%ebp),%eax
     aeb:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     aee:	8b 55 c8             	mov    -0x38(%ebp),%edx
     af1:	8b 45 cc             	mov    -0x34(%ebp),%eax
     af4:	0f af d0             	imul   %eax,%edx
     af7:	89 d0                	mov    %edx,%eax
     af9:	01 c0                	add    %eax,%eax
     afb:	01 d0                	add    %edx,%eax
     afd:	83 ec 0c             	sub    $0xc,%esp
     b00:	50                   	push   %eax
     b01:	e8 a0 fd ff ff       	call   8a6 <malloc>
     b06:	83 c4 10             	add    $0x10,%esp
     b09:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     b0c:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     b10:	0f b7 c0             	movzwl %ax,%eax
     b13:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     b16:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b19:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b1c:	0f af c2             	imul   %edx,%eax
     b1f:	83 c0 1f             	add    $0x1f,%eax
     b22:	c1 e8 05             	shr    $0x5,%eax
     b25:	c1 e0 02             	shl    $0x2,%eax
     b28:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     b2b:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b2e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b31:	0f af c2             	imul   %edx,%eax
     b34:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     b37:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b3a:	83 ec 0c             	sub    $0xc,%esp
     b3d:	50                   	push   %eax
     b3e:	e8 63 fd ff ff       	call   8a6 <malloc>
     b43:	83 c4 10             	add    $0x10,%esp
     b46:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     b49:	83 ec 04             	sub    $0x4,%esp
     b4c:	ff 75 e0             	pushl  -0x20(%ebp)
     b4f:	ff 75 dc             	pushl  -0x24(%ebp)
     b52:	ff 75 ec             	pushl  -0x14(%ebp)
     b55:	e8 d2 f8 ff ff       	call   42c <read>
     b5a:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     b5d:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     b61:	66 c1 e8 03          	shr    $0x3,%ax
     b65:	0f b7 c0             	movzwl %ax,%eax
     b68:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     b6b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     b72:	e9 e5 00 00 00       	jmp    c5c <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     b77:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b7d:	29 c2                	sub    %eax,%edx
     b7f:	89 d0                	mov    %edx,%eax
     b81:	8d 50 ff             	lea    -0x1(%eax),%edx
     b84:	8b 45 c8             	mov    -0x38(%ebp),%eax
     b87:	0f af c2             	imul   %edx,%eax
     b8a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     b8d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b94:	e9 b1 00 00 00       	jmp    c4a <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     b99:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b9c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ba2:	01 c8                	add    %ecx,%eax
     ba4:	89 c1                	mov    %eax,%ecx
     ba6:	89 c8                	mov    %ecx,%eax
     ba8:	01 c0                	add    %eax,%eax
     baa:	01 c8                	add    %ecx,%eax
     bac:	01 c2                	add    %eax,%edx
     bae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb1:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     bb5:	89 c1                	mov    %eax,%ecx
     bb7:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bba:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     bbe:	01 c1                	add    %eax,%ecx
     bc0:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bc3:	01 c8                	add    %ecx,%eax
     bc5:	8d 48 ff             	lea    -0x1(%eax),%ecx
     bc8:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bcb:	01 c8                	add    %ecx,%eax
     bcd:	0f b6 00             	movzbl (%eax),%eax
     bd0:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     bd3:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bd6:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     bd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bdc:	01 c8                	add    %ecx,%eax
     bde:	89 c1                	mov    %eax,%ecx
     be0:	89 c8                	mov    %ecx,%eax
     be2:	01 c0                	add    %eax,%eax
     be4:	01 c8                	add    %ecx,%eax
     be6:	01 c2                	add    %eax,%edx
     be8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     beb:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     bef:	89 c1                	mov    %eax,%ecx
     bf1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bf4:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     bf8:	01 c1                	add    %eax,%ecx
     bfa:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bfd:	01 c8                	add    %ecx,%eax
     bff:	8d 48 fe             	lea    -0x2(%eax),%ecx
     c02:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c05:	01 c8                	add    %ecx,%eax
     c07:	0f b6 00             	movzbl (%eax),%eax
     c0a:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     c0d:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c10:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     c13:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c16:	01 c8                	add    %ecx,%eax
     c18:	89 c1                	mov    %eax,%ecx
     c1a:	89 c8                	mov    %ecx,%eax
     c1c:	01 c0                	add    %eax,%eax
     c1e:	01 c8                	add    %ecx,%eax
     c20:	01 c2                	add    %eax,%edx
     c22:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c25:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     c29:	89 c1                	mov    %eax,%ecx
     c2b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c2e:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     c32:	01 c1                	add    %eax,%ecx
     c34:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c37:	01 c8                	add    %ecx,%eax
     c39:	8d 48 fd             	lea    -0x3(%eax),%ecx
     c3c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c3f:	01 c8                	add    %ecx,%eax
     c41:	0f b6 00             	movzbl (%eax),%eax
     c44:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     c46:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     c4a:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c50:	39 c2                	cmp    %eax,%edx
     c52:	0f 87 41 ff ff ff    	ja     b99 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     c58:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c5c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c62:	39 c2                	cmp    %eax,%edx
     c64:	0f 87 0d ff ff ff    	ja     b77 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     c6a:	83 ec 0c             	sub    $0xc,%esp
     c6d:	ff 75 ec             	pushl  -0x14(%ebp)
     c70:	e8 c7 f7 ff ff       	call   43c <close>
     c75:	83 c4 10             	add    $0x10,%esp
    return bmp;
     c78:	8b 45 08             	mov    0x8(%ebp),%eax
     c7b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c7e:	89 10                	mov    %edx,(%eax)
     c80:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c83:	89 50 04             	mov    %edx,0x4(%eax)
     c86:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c89:	89 50 08             	mov    %edx,0x8(%eax)
}
     c8c:	8b 45 08             	mov    0x8(%ebp),%eax
     c8f:	c9                   	leave  
     c90:	c2 04 00             	ret    $0x4

00000c93 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     c93:	55                   	push   %ebp
     c94:	89 e5                	mov    %esp,%ebp
     c96:	53                   	push   %ebx
     c97:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     c9a:	83 ec 0c             	sub    $0xc,%esp
     c9d:	6a 1c                	push   $0x1c
     c9f:	e8 02 fc ff ff       	call   8a6 <malloc>
     ca4:	83 c4 10             	add    $0x10,%esp
     ca7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     caa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cad:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     cb4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     cb7:	8d 45 d8             	lea    -0x28(%ebp),%eax
     cba:	6a 0c                	push   $0xc
     cbc:	6a 0c                	push   $0xc
     cbe:	6a 0c                	push   $0xc
     cc0:	50                   	push   %eax
     cc1:	e8 c3 fc ff ff       	call   989 <RGB>
     cc6:	83 c4 0c             	add    $0xc,%esp
     cc9:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     ccd:	66 89 43 13          	mov    %ax,0x13(%ebx)
     cd1:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     cd5:	88 43 15             	mov    %al,0x15(%ebx)
     cd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cdb:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cde:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     ce2:	66 89 48 10          	mov    %cx,0x10(%eax)
     ce6:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     cea:	88 50 12             	mov    %dl,0x12(%eax)
     ced:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf0:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cf3:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     cf7:	66 89 48 08          	mov    %cx,0x8(%eax)
     cfb:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     cff:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     d02:	8b 45 08             	mov    0x8(%ebp),%eax
     d05:	89 c2                	mov    %eax,%edx
     d07:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d0a:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     d0c:	8b 45 0c             	mov    0xc(%ebp),%eax
     d0f:	89 c2                	mov    %eax,%edx
     d11:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d14:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     d17:	8b 55 10             	mov    0x10(%ebp),%edx
     d1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d1d:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     d20:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     d23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d26:	c9                   	leave  
     d27:	c3                   	ret    

00000d28 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     d28:	55                   	push   %ebp
     d29:	89 e5                	mov    %esp,%ebp
     d2b:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     d2e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d31:	8b 50 08             	mov    0x8(%eax),%edx
     d34:	89 55 f8             	mov    %edx,-0x8(%ebp)
     d37:	8b 40 0c             	mov    0xc(%eax),%eax
     d3a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     d3d:	8b 45 0c             	mov    0xc(%ebp),%eax
     d40:	8b 55 10             	mov    0x10(%ebp),%edx
     d43:	89 50 08             	mov    %edx,0x8(%eax)
     d46:	8b 55 14             	mov    0x14(%ebp),%edx
     d49:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     d4c:	8b 45 08             	mov    0x8(%ebp),%eax
     d4f:	8b 55 f8             	mov    -0x8(%ebp),%edx
     d52:	89 10                	mov    %edx,(%eax)
     d54:	8b 55 fc             	mov    -0x4(%ebp),%edx
     d57:	89 50 04             	mov    %edx,0x4(%eax)
}
     d5a:	8b 45 08             	mov    0x8(%ebp),%eax
     d5d:	c9                   	leave  
     d5e:	c2 04 00             	ret    $0x4

00000d61 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     d61:	55                   	push   %ebp
     d62:	89 e5                	mov    %esp,%ebp
     d64:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     d67:	8b 45 0c             	mov    0xc(%ebp),%eax
     d6a:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     d6e:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     d72:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     d76:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     d79:	8b 45 0c             	mov    0xc(%ebp),%eax
     d7c:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     d80:	66 89 50 10          	mov    %dx,0x10(%eax)
     d84:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     d88:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     d8b:	8b 45 08             	mov    0x8(%ebp),%eax
     d8e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d92:	66 89 10             	mov    %dx,(%eax)
     d95:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d99:	88 50 02             	mov    %dl,0x2(%eax)
}
     d9c:	8b 45 08             	mov    0x8(%ebp),%eax
     d9f:	c9                   	leave  
     da0:	c2 04 00             	ret    $0x4

00000da3 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     da3:	55                   	push   %ebp
     da4:	89 e5                	mov    %esp,%ebp
     da6:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     da9:	8b 45 0c             	mov    0xc(%ebp),%eax
     dac:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     db0:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     db4:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     db8:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     dbb:	8b 45 0c             	mov    0xc(%ebp),%eax
     dbe:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     dc2:	66 89 50 13          	mov    %dx,0x13(%eax)
     dc6:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     dca:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     dcd:	8b 45 08             	mov    0x8(%ebp),%eax
     dd0:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     dd4:	66 89 10             	mov    %dx,(%eax)
     dd7:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     ddb:	88 50 02             	mov    %dl,0x2(%eax)
}
     dde:	8b 45 08             	mov    0x8(%ebp),%eax
     de1:	c9                   	leave  
     de2:	c2 04 00             	ret    $0x4

00000de5 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     de5:	55                   	push   %ebp
     de6:	89 e5                	mov    %esp,%ebp
     de8:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     deb:	8b 45 08             	mov    0x8(%ebp),%eax
     dee:	8b 40 0c             	mov    0xc(%eax),%eax
     df1:	89 c2                	mov    %eax,%edx
     df3:	c1 ea 1f             	shr    $0x1f,%edx
     df6:	01 d0                	add    %edx,%eax
     df8:	d1 f8                	sar    %eax
     dfa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     dfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e00:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     e04:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     e07:	8b 45 10             	mov    0x10(%ebp),%eax
     e0a:	2b 45 f4             	sub    -0xc(%ebp),%eax
     e0d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     e10:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     e14:	0f 89 98 00 00 00    	jns    eb2 <APDrawPoint+0xcd>
        i = 0;
     e1a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     e21:	e9 8c 00 00 00       	jmp    eb2 <APDrawPoint+0xcd>
    {
        j = x - off;
     e26:	8b 45 0c             	mov    0xc(%ebp),%eax
     e29:	2b 45 f4             	sub    -0xc(%ebp),%eax
     e2c:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     e2f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     e33:	79 69                	jns    e9e <APDrawPoint+0xb9>
            j = 0;
     e35:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     e3c:	eb 60                	jmp    e9e <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     e3e:	ff 75 fc             	pushl  -0x4(%ebp)
     e41:	ff 75 f8             	pushl  -0x8(%ebp)
     e44:	ff 75 08             	pushl  0x8(%ebp)
     e47:	e8 bb fb ff ff       	call   a07 <APGetIndex>
     e4c:	83 c4 0c             	add    $0xc,%esp
     e4f:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     e52:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     e56:	74 55                	je     ead <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     e58:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     e5c:	74 67                	je     ec5 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     e5e:	ff 75 10             	pushl  0x10(%ebp)
     e61:	ff 75 0c             	pushl  0xc(%ebp)
     e64:	ff 75 fc             	pushl  -0x4(%ebp)
     e67:	ff 75 f8             	pushl  -0x8(%ebp)
     e6a:	e8 5f fb ff ff       	call   9ce <distance_2>
     e6f:	83 c4 10             	add    $0x10,%esp
     e72:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     e75:	7f 23                	jg     e9a <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     e77:	8b 45 08             	mov    0x8(%ebp),%eax
     e7a:	8b 48 18             	mov    0x18(%eax),%ecx
     e7d:	8b 55 ec             	mov    -0x14(%ebp),%edx
     e80:	89 d0                	mov    %edx,%eax
     e82:	01 c0                	add    %eax,%eax
     e84:	01 d0                	add    %edx,%eax
     e86:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     e89:	8b 45 08             	mov    0x8(%ebp),%eax
     e8c:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     e90:	66 89 0a             	mov    %cx,(%edx)
     e93:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     e97:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     e9a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     e9e:	8b 55 0c             	mov    0xc(%ebp),%edx
     ea1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ea4:	01 d0                	add    %edx,%eax
     ea6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     ea9:	7d 93                	jge    e3e <APDrawPoint+0x59>
     eab:	eb 01                	jmp    eae <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     ead:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     eae:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     eb2:	8b 55 10             	mov    0x10(%ebp),%edx
     eb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eb8:	01 d0                	add    %edx,%eax
     eba:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     ebd:	0f 8d 63 ff ff ff    	jge    e26 <APDrawPoint+0x41>
     ec3:	eb 01                	jmp    ec6 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     ec5:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     ec6:	c9                   	leave  
     ec7:	c3                   	ret    

00000ec8 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     ec8:	55                   	push   %ebp
     ec9:	89 e5                	mov    %esp,%ebp
     ecb:	53                   	push   %ebx
     ecc:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     ecf:	8b 45 0c             	mov    0xc(%ebp),%eax
     ed2:	3b 45 14             	cmp    0x14(%ebp),%eax
     ed5:	0f 85 80 00 00 00    	jne    f5b <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     edb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     edf:	0f 88 9d 02 00 00    	js     1182 <APDrawLine+0x2ba>
     ee5:	8b 45 08             	mov    0x8(%ebp),%eax
     ee8:	8b 00                	mov    (%eax),%eax
     eea:	3b 45 0c             	cmp    0xc(%ebp),%eax
     eed:	0f 8e 8f 02 00 00    	jle    1182 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     ef3:	8b 45 10             	mov    0x10(%ebp),%eax
     ef6:	3b 45 18             	cmp    0x18(%ebp),%eax
     ef9:	7e 12                	jle    f0d <APDrawLine+0x45>
        {
            int tmp = y2;
     efb:	8b 45 18             	mov    0x18(%ebp),%eax
     efe:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     f01:	8b 45 10             	mov    0x10(%ebp),%eax
     f04:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     f07:	8b 45 dc             	mov    -0x24(%ebp),%eax
     f0a:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     f0d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     f11:	79 07                	jns    f1a <APDrawLine+0x52>
     f13:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     f1a:	8b 45 08             	mov    0x8(%ebp),%eax
     f1d:	8b 40 04             	mov    0x4(%eax),%eax
     f20:	3b 45 18             	cmp    0x18(%ebp),%eax
     f23:	7d 0c                	jge    f31 <APDrawLine+0x69>
     f25:	8b 45 08             	mov    0x8(%ebp),%eax
     f28:	8b 40 04             	mov    0x4(%eax),%eax
     f2b:	83 e8 01             	sub    $0x1,%eax
     f2e:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     f31:	8b 45 10             	mov    0x10(%ebp),%eax
     f34:	89 45 f4             	mov    %eax,-0xc(%ebp)
     f37:	eb 15                	jmp    f4e <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     f39:	ff 75 f4             	pushl  -0xc(%ebp)
     f3c:	ff 75 0c             	pushl  0xc(%ebp)
     f3f:	ff 75 08             	pushl  0x8(%ebp)
     f42:	e8 9e fe ff ff       	call   de5 <APDrawPoint>
     f47:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     f4a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f51:	3b 45 18             	cmp    0x18(%ebp),%eax
     f54:	7e e3                	jle    f39 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     f56:	e9 2b 02 00 00       	jmp    1186 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     f5b:	8b 45 10             	mov    0x10(%ebp),%eax
     f5e:	3b 45 18             	cmp    0x18(%ebp),%eax
     f61:	75 7f                	jne    fe2 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     f63:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     f67:	0f 88 18 02 00 00    	js     1185 <APDrawLine+0x2bd>
     f6d:	8b 45 08             	mov    0x8(%ebp),%eax
     f70:	8b 40 04             	mov    0x4(%eax),%eax
     f73:	3b 45 10             	cmp    0x10(%ebp),%eax
     f76:	0f 8e 09 02 00 00    	jle    1185 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     f7c:	8b 45 0c             	mov    0xc(%ebp),%eax
     f7f:	3b 45 14             	cmp    0x14(%ebp),%eax
     f82:	7e 12                	jle    f96 <APDrawLine+0xce>
        {
            int tmp = x2;
     f84:	8b 45 14             	mov    0x14(%ebp),%eax
     f87:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     f8a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f8d:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     f90:	8b 45 d8             	mov    -0x28(%ebp),%eax
     f93:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     f96:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f9a:	79 07                	jns    fa3 <APDrawLine+0xdb>
     f9c:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     fa3:	8b 45 08             	mov    0x8(%ebp),%eax
     fa6:	8b 00                	mov    (%eax),%eax
     fa8:	3b 45 14             	cmp    0x14(%ebp),%eax
     fab:	7d 0b                	jge    fb8 <APDrawLine+0xf0>
     fad:	8b 45 08             	mov    0x8(%ebp),%eax
     fb0:	8b 00                	mov    (%eax),%eax
     fb2:	83 e8 01             	sub    $0x1,%eax
     fb5:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     fb8:	8b 45 0c             	mov    0xc(%ebp),%eax
     fbb:	89 45 f0             	mov    %eax,-0x10(%ebp)
     fbe:	eb 15                	jmp    fd5 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     fc0:	ff 75 10             	pushl  0x10(%ebp)
     fc3:	ff 75 f0             	pushl  -0x10(%ebp)
     fc6:	ff 75 08             	pushl  0x8(%ebp)
     fc9:	e8 17 fe ff ff       	call   de5 <APDrawPoint>
     fce:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     fd1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     fd5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fd8:	3b 45 14             	cmp    0x14(%ebp),%eax
     fdb:	7e e3                	jle    fc0 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     fdd:	e9 a4 01 00 00       	jmp    1186 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     fe2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     fe9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
     ff3:	2b 45 14             	sub    0x14(%ebp),%eax
     ff6:	50                   	push   %eax
     ff7:	e8 fb f9 ff ff       	call   9f7 <abs_int>
     ffc:	83 c4 04             	add    $0x4,%esp
     fff:	89 c3                	mov    %eax,%ebx
    1001:	8b 45 10             	mov    0x10(%ebp),%eax
    1004:	2b 45 18             	sub    0x18(%ebp),%eax
    1007:	50                   	push   %eax
    1008:	e8 ea f9 ff ff       	call   9f7 <abs_int>
    100d:	83 c4 04             	add    $0x4,%esp
    1010:	39 c3                	cmp    %eax,%ebx
    1012:	0f 8e b5 00 00 00    	jle    10cd <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1018:	8b 45 10             	mov    0x10(%ebp),%eax
    101b:	2b 45 18             	sub    0x18(%ebp),%eax
    101e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1021:	db 45 b0             	fildl  -0x50(%ebp)
    1024:	8b 45 0c             	mov    0xc(%ebp),%eax
    1027:	2b 45 14             	sub    0x14(%ebp),%eax
    102a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    102d:	db 45 b0             	fildl  -0x50(%ebp)
    1030:	de f9                	fdivrp %st,%st(1)
    1032:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1035:	8b 45 14             	mov    0x14(%ebp),%eax
    1038:	3b 45 0c             	cmp    0xc(%ebp),%eax
    103b:	7e 0e                	jle    104b <APDrawLine+0x183>
        {
            s = x1;
    103d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1040:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    1043:	8b 45 14             	mov    0x14(%ebp),%eax
    1046:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1049:	eb 0c                	jmp    1057 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    104b:	8b 45 14             	mov    0x14(%ebp),%eax
    104e:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1051:	8b 45 0c             	mov    0xc(%ebp),%eax
    1054:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1057:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    105b:	79 07                	jns    1064 <APDrawLine+0x19c>
    105d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1064:	8b 45 08             	mov    0x8(%ebp),%eax
    1067:	8b 00                	mov    (%eax),%eax
    1069:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    106c:	7f 0b                	jg     1079 <APDrawLine+0x1b1>
    106e:	8b 45 08             	mov    0x8(%ebp),%eax
    1071:	8b 00                	mov    (%eax),%eax
    1073:	83 e8 01             	sub    $0x1,%eax
    1076:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1079:	8b 45 ec             	mov    -0x14(%ebp),%eax
    107c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    107f:	eb 3f                	jmp    10c0 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1081:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1084:	2b 45 0c             	sub    0xc(%ebp),%eax
    1087:	89 45 b0             	mov    %eax,-0x50(%ebp)
    108a:	db 45 b0             	fildl  -0x50(%ebp)
    108d:	dc 4d d0             	fmull  -0x30(%ebp)
    1090:	db 45 10             	fildl  0x10(%ebp)
    1093:	de c1                	faddp  %st,%st(1)
    1095:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1098:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    109c:	b4 0c                	mov    $0xc,%ah
    109e:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    10a2:	d9 6d b4             	fldcw  -0x4c(%ebp)
    10a5:	db 5d cc             	fistpl -0x34(%ebp)
    10a8:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    10ab:	ff 75 cc             	pushl  -0x34(%ebp)
    10ae:	ff 75 e4             	pushl  -0x1c(%ebp)
    10b1:	ff 75 08             	pushl  0x8(%ebp)
    10b4:	e8 2c fd ff ff       	call   de5 <APDrawPoint>
    10b9:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    10bc:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    10c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10c3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10c6:	7e b9                	jle    1081 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    10c8:	e9 b9 00 00 00       	jmp    1186 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    10cd:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d0:	2b 45 14             	sub    0x14(%ebp),%eax
    10d3:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10d6:	db 45 b0             	fildl  -0x50(%ebp)
    10d9:	8b 45 10             	mov    0x10(%ebp),%eax
    10dc:	2b 45 18             	sub    0x18(%ebp),%eax
    10df:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10e2:	db 45 b0             	fildl  -0x50(%ebp)
    10e5:	de f9                	fdivrp %st,%st(1)
    10e7:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    10ea:	8b 45 10             	mov    0x10(%ebp),%eax
    10ed:	3b 45 18             	cmp    0x18(%ebp),%eax
    10f0:	7e 0e                	jle    1100 <APDrawLine+0x238>
    {
        s = y2;
    10f2:	8b 45 18             	mov    0x18(%ebp),%eax
    10f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    10f8:	8b 45 10             	mov    0x10(%ebp),%eax
    10fb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    10fe:	eb 0c                	jmp    110c <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1100:	8b 45 10             	mov    0x10(%ebp),%eax
    1103:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1106:	8b 45 18             	mov    0x18(%ebp),%eax
    1109:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    110c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1110:	79 07                	jns    1119 <APDrawLine+0x251>
    1112:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1119:	8b 45 08             	mov    0x8(%ebp),%eax
    111c:	8b 40 04             	mov    0x4(%eax),%eax
    111f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1122:	7f 0c                	jg     1130 <APDrawLine+0x268>
    1124:	8b 45 08             	mov    0x8(%ebp),%eax
    1127:	8b 40 04             	mov    0x4(%eax),%eax
    112a:	83 e8 01             	sub    $0x1,%eax
    112d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1130:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1133:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1136:	eb 3f                	jmp    1177 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1138:	8b 45 e0             	mov    -0x20(%ebp),%eax
    113b:	2b 45 10             	sub    0x10(%ebp),%eax
    113e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1141:	db 45 b0             	fildl  -0x50(%ebp)
    1144:	dc 4d c0             	fmull  -0x40(%ebp)
    1147:	db 45 0c             	fildl  0xc(%ebp)
    114a:	de c1                	faddp  %st,%st(1)
    114c:	d9 7d b6             	fnstcw -0x4a(%ebp)
    114f:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1153:	b4 0c                	mov    $0xc,%ah
    1155:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1159:	d9 6d b4             	fldcw  -0x4c(%ebp)
    115c:	db 5d bc             	fistpl -0x44(%ebp)
    115f:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1162:	ff 75 e0             	pushl  -0x20(%ebp)
    1165:	ff 75 bc             	pushl  -0x44(%ebp)
    1168:	ff 75 08             	pushl  0x8(%ebp)
    116b:	e8 75 fc ff ff       	call   de5 <APDrawPoint>
    1170:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1173:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1177:	8b 45 e0             	mov    -0x20(%ebp),%eax
    117a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    117d:	7e b9                	jle    1138 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    117f:	90                   	nop
    1180:	eb 04                	jmp    1186 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1182:	90                   	nop
    1183:	eb 01                	jmp    1186 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1185:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1186:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1189:	c9                   	leave  
    118a:	c3                   	ret    

0000118b <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    118b:	55                   	push   %ebp
    118c:	89 e5                	mov    %esp,%ebp
    118e:	53                   	push   %ebx
    118f:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1192:	8b 55 10             	mov    0x10(%ebp),%edx
    1195:	8b 45 18             	mov    0x18(%ebp),%eax
    1198:	01 d0                	add    %edx,%eax
    119a:	83 e8 01             	sub    $0x1,%eax
    119d:	83 ec 04             	sub    $0x4,%esp
    11a0:	50                   	push   %eax
    11a1:	ff 75 0c             	pushl  0xc(%ebp)
    11a4:	ff 75 10             	pushl  0x10(%ebp)
    11a7:	ff 75 0c             	pushl  0xc(%ebp)
    11aa:	ff 75 08             	pushl  0x8(%ebp)
    11ad:	e8 16 fd ff ff       	call   ec8 <APDrawLine>
    11b2:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    11b5:	8b 55 0c             	mov    0xc(%ebp),%edx
    11b8:	8b 45 14             	mov    0x14(%ebp),%eax
    11bb:	01 d0                	add    %edx,%eax
    11bd:	83 e8 01             	sub    $0x1,%eax
    11c0:	83 ec 04             	sub    $0x4,%esp
    11c3:	ff 75 10             	pushl  0x10(%ebp)
    11c6:	50                   	push   %eax
    11c7:	ff 75 10             	pushl  0x10(%ebp)
    11ca:	ff 75 0c             	pushl  0xc(%ebp)
    11cd:	ff 75 08             	pushl  0x8(%ebp)
    11d0:	e8 f3 fc ff ff       	call   ec8 <APDrawLine>
    11d5:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    11d8:	8b 55 10             	mov    0x10(%ebp),%edx
    11db:	8b 45 18             	mov    0x18(%ebp),%eax
    11de:	01 d0                	add    %edx,%eax
    11e0:	8d 48 ff             	lea    -0x1(%eax),%ecx
    11e3:	8b 55 0c             	mov    0xc(%ebp),%edx
    11e6:	8b 45 14             	mov    0x14(%ebp),%eax
    11e9:	01 d0                	add    %edx,%eax
    11eb:	8d 50 ff             	lea    -0x1(%eax),%edx
    11ee:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    11f1:	8b 45 14             	mov    0x14(%ebp),%eax
    11f4:	01 d8                	add    %ebx,%eax
    11f6:	83 e8 01             	sub    $0x1,%eax
    11f9:	83 ec 04             	sub    $0x4,%esp
    11fc:	51                   	push   %ecx
    11fd:	52                   	push   %edx
    11fe:	ff 75 10             	pushl  0x10(%ebp)
    1201:	50                   	push   %eax
    1202:	ff 75 08             	pushl  0x8(%ebp)
    1205:	e8 be fc ff ff       	call   ec8 <APDrawLine>
    120a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    120d:	8b 55 10             	mov    0x10(%ebp),%edx
    1210:	8b 45 18             	mov    0x18(%ebp),%eax
    1213:	01 d0                	add    %edx,%eax
    1215:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1218:	8b 55 0c             	mov    0xc(%ebp),%edx
    121b:	8b 45 14             	mov    0x14(%ebp),%eax
    121e:	01 d0                	add    %edx,%eax
    1220:	8d 50 ff             	lea    -0x1(%eax),%edx
    1223:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1226:	8b 45 18             	mov    0x18(%ebp),%eax
    1229:	01 d8                	add    %ebx,%eax
    122b:	83 e8 01             	sub    $0x1,%eax
    122e:	83 ec 04             	sub    $0x4,%esp
    1231:	51                   	push   %ecx
    1232:	52                   	push   %edx
    1233:	50                   	push   %eax
    1234:	ff 75 0c             	pushl  0xc(%ebp)
    1237:	ff 75 08             	pushl  0x8(%ebp)
    123a:	e8 89 fc ff ff       	call   ec8 <APDrawLine>
    123f:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1242:	8b 55 0c             	mov    0xc(%ebp),%edx
    1245:	8b 45 14             	mov    0x14(%ebp),%eax
    1248:	01 d0                	add    %edx,%eax
    124a:	8d 50 ff             	lea    -0x1(%eax),%edx
    124d:	8b 45 08             	mov    0x8(%ebp),%eax
    1250:	8b 40 0c             	mov    0xc(%eax),%eax
    1253:	89 c1                	mov    %eax,%ecx
    1255:	c1 e9 1f             	shr    $0x1f,%ecx
    1258:	01 c8                	add    %ecx,%eax
    125a:	d1 f8                	sar    %eax
    125c:	29 c2                	sub    %eax,%edx
    125e:	89 d0                	mov    %edx,%eax
    1260:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1263:	8b 55 10             	mov    0x10(%ebp),%edx
    1266:	8b 45 18             	mov    0x18(%ebp),%eax
    1269:	01 d0                	add    %edx,%eax
    126b:	8d 50 ff             	lea    -0x1(%eax),%edx
    126e:	8b 45 08             	mov    0x8(%ebp),%eax
    1271:	8b 40 0c             	mov    0xc(%eax),%eax
    1274:	89 c1                	mov    %eax,%ecx
    1276:	c1 e9 1f             	shr    $0x1f,%ecx
    1279:	01 c8                	add    %ecx,%eax
    127b:	d1 f8                	sar    %eax
    127d:	29 c2                	sub    %eax,%edx
    127f:	89 d0                	mov    %edx,%eax
    1281:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1284:	8b 45 08             	mov    0x8(%ebp),%eax
    1287:	8b 40 0c             	mov    0xc(%eax),%eax
    128a:	89 c2                	mov    %eax,%edx
    128c:	c1 ea 1f             	shr    $0x1f,%edx
    128f:	01 d0                	add    %edx,%eax
    1291:	d1 f8                	sar    %eax
    1293:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1296:	8b 45 08             	mov    0x8(%ebp),%eax
    1299:	8b 40 0c             	mov    0xc(%eax),%eax
    129c:	89 c2                	mov    %eax,%edx
    129e:	c1 ea 1f             	shr    $0x1f,%edx
    12a1:	01 d0                	add    %edx,%eax
    12a3:	d1 f8                	sar    %eax
    12a5:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    12a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12ac:	0f 88 d8 00 00 00    	js     138a <APDrawRect+0x1ff>
    12b2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    12b6:	0f 88 ce 00 00 00    	js     138a <APDrawRect+0x1ff>
    12bc:	8b 45 08             	mov    0x8(%ebp),%eax
    12bf:	8b 00                	mov    (%eax),%eax
    12c1:	3b 45 0c             	cmp    0xc(%ebp),%eax
    12c4:	0f 8e c0 00 00 00    	jle    138a <APDrawRect+0x1ff>
    12ca:	8b 45 08             	mov    0x8(%ebp),%eax
    12cd:	8b 40 04             	mov    0x4(%eax),%eax
    12d0:	3b 45 10             	cmp    0x10(%ebp),%eax
    12d3:	0f 8e b1 00 00 00    	jle    138a <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    12d9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    12dd:	79 07                	jns    12e6 <APDrawRect+0x15b>
    12df:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    12e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12ea:	79 07                	jns    12f3 <APDrawRect+0x168>
    12ec:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    12f3:	8b 45 08             	mov    0x8(%ebp),%eax
    12f6:	8b 00                	mov    (%eax),%eax
    12f8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    12fb:	7f 0b                	jg     1308 <APDrawRect+0x17d>
    12fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1300:	8b 00                	mov    (%eax),%eax
    1302:	83 e8 01             	sub    $0x1,%eax
    1305:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1308:	8b 45 08             	mov    0x8(%ebp),%eax
    130b:	8b 40 04             	mov    0x4(%eax),%eax
    130e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1311:	7f 0c                	jg     131f <APDrawRect+0x194>
    1313:	8b 45 08             	mov    0x8(%ebp),%eax
    1316:	8b 40 04             	mov    0x4(%eax),%eax
    1319:	83 e8 01             	sub    $0x1,%eax
    131c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    131f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1326:	8b 45 0c             	mov    0xc(%ebp),%eax
    1329:	89 45 ec             	mov    %eax,-0x14(%ebp)
    132c:	eb 52                	jmp    1380 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    132e:	8b 45 10             	mov    0x10(%ebp),%eax
    1331:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1334:	eb 3e                	jmp    1374 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1336:	83 ec 04             	sub    $0x4,%esp
    1339:	ff 75 e8             	pushl  -0x18(%ebp)
    133c:	ff 75 ec             	pushl  -0x14(%ebp)
    133f:	ff 75 08             	pushl  0x8(%ebp)
    1342:	e8 c0 f6 ff ff       	call   a07 <APGetIndex>
    1347:	83 c4 10             	add    $0x10,%esp
    134a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    134d:	8b 45 08             	mov    0x8(%ebp),%eax
    1350:	8b 48 18             	mov    0x18(%eax),%ecx
    1353:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1356:	89 d0                	mov    %edx,%eax
    1358:	01 c0                	add    %eax,%eax
    135a:	01 d0                	add    %edx,%eax
    135c:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    135f:	8b 45 08             	mov    0x8(%ebp),%eax
    1362:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1366:	66 89 0a             	mov    %cx,(%edx)
    1369:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    136d:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1370:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1374:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1377:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    137a:	7e ba                	jle    1336 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    137c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1380:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1383:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1386:	7e a6                	jle    132e <APDrawRect+0x1a3>
    1388:	eb 01                	jmp    138b <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    138a:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    138b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    138e:	c9                   	leave  
    138f:	c3                   	ret    

00001390 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1390:	55                   	push   %ebp
    1391:	89 e5                	mov    %esp,%ebp
    1393:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    1396:	83 ec 0c             	sub    $0xc,%esp
    1399:	ff 75 0c             	pushl  0xc(%ebp)
    139c:	e8 b1 ee ff ff       	call   252 <strlen>
    13a1:	83 c4 10             	add    $0x10,%esp
    13a4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    13a7:	8b 45 08             	mov    0x8(%ebp),%eax
    13aa:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    13ae:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    13b2:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    13b6:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    13b9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    13c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13c7:	e9 bc 00 00 00       	jmp    1488 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    13cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13cf:	8b 45 0c             	mov    0xc(%ebp),%eax
    13d2:	01 d0                	add    %edx,%eax
    13d4:	0f b6 00             	movzbl (%eax),%eax
    13d7:	0f be c0             	movsbl %al,%eax
    13da:	83 e8 20             	sub    $0x20,%eax
    13dd:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    13e0:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    13e4:	0f 87 9a 00 00 00    	ja     1484 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    13ea:	8b 45 08             	mov    0x8(%ebp),%eax
    13ed:	8b 00                	mov    (%eax),%eax
    13ef:	0f af 45 14          	imul   0x14(%ebp),%eax
    13f3:	89 c2                	mov    %eax,%edx
    13f5:	8b 45 10             	mov    0x10(%ebp),%eax
    13f8:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    13fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13fe:	89 d0                	mov    %edx,%eax
    1400:	c1 e0 03             	shl    $0x3,%eax
    1403:	01 d0                	add    %edx,%eax
    1405:	01 c8                	add    %ecx,%eax
    1407:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    140a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1411:	eb 6b                	jmp    147e <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1413:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    141a:	eb 50                	jmp    146c <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    141c:	8b 55 ec             	mov    -0x14(%ebp),%edx
    141f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1422:	89 d0                	mov    %edx,%eax
    1424:	c1 e0 03             	shl    $0x3,%eax
    1427:	01 d0                	add    %edx,%eax
    1429:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    142f:	01 c2                	add    %eax,%edx
    1431:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1434:	01 d0                	add    %edx,%eax
    1436:	05 20 2e 00 00       	add    $0x2e20,%eax
    143b:	0f b6 00             	movzbl (%eax),%eax
    143e:	84 c0                	test   %al,%al
    1440:	74 26                	je     1468 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    1442:	8b 45 08             	mov    0x8(%ebp),%eax
    1445:	8b 50 18             	mov    0x18(%eax),%edx
    1448:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    144b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    144e:	01 c8                	add    %ecx,%eax
    1450:	89 c1                	mov    %eax,%ecx
    1452:	89 c8                	mov    %ecx,%eax
    1454:	01 c0                	add    %eax,%eax
    1456:	01 c8                	add    %ecx,%eax
    1458:	01 d0                	add    %edx,%eax
    145a:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    145e:	66 89 10             	mov    %dx,(%eax)
    1461:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1465:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1468:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    146c:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1470:	7e aa                	jle    141c <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1472:	8b 45 08             	mov    0x8(%ebp),%eax
    1475:	8b 00                	mov    (%eax),%eax
    1477:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    147a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    147e:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1482:	7e 8f                	jle    1413 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    1484:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1488:	8b 45 f4             	mov    -0xc(%ebp),%eax
    148b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    148e:	0f 82 38 ff ff ff    	jb     13cc <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1494:	90                   	nop
    1495:	c9                   	leave  
    1496:	c3                   	ret    

00001497 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1497:	55                   	push   %ebp
    1498:	89 e5                	mov    %esp,%ebp
    149a:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    149d:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    14a1:	0f 88 8e 01 00 00    	js     1635 <APDcCopy+0x19e>
    14a7:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    14ab:	0f 88 84 01 00 00    	js     1635 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    14b1:	8b 55 0c             	mov    0xc(%ebp),%edx
    14b4:	8b 45 20             	mov    0x20(%ebp),%eax
    14b7:	01 d0                	add    %edx,%eax
    14b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    14bc:	8b 55 10             	mov    0x10(%ebp),%edx
    14bf:	8b 45 24             	mov    0x24(%ebp),%eax
    14c2:	01 d0                	add    %edx,%eax
    14c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    14c7:	8b 55 18             	mov    0x18(%ebp),%edx
    14ca:	8b 45 20             	mov    0x20(%ebp),%eax
    14cd:	01 d0                	add    %edx,%eax
    14cf:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14d2:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14d5:	8b 45 24             	mov    0x24(%ebp),%eax
    14d8:	01 d0                	add    %edx,%eax
    14da:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    14dd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14e1:	0f 88 51 01 00 00    	js     1638 <APDcCopy+0x1a1>
    14e7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    14eb:	0f 88 47 01 00 00    	js     1638 <APDcCopy+0x1a1>
    14f1:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    14f5:	0f 88 3d 01 00 00    	js     1638 <APDcCopy+0x1a1>
    14fb:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    14ff:	0f 88 33 01 00 00    	js     1638 <APDcCopy+0x1a1>
    1505:	8b 45 14             	mov    0x14(%ebp),%eax
    1508:	8b 00                	mov    (%eax),%eax
    150a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    150d:	0f 8c 25 01 00 00    	jl     1638 <APDcCopy+0x1a1>
    1513:	8b 45 14             	mov    0x14(%ebp),%eax
    1516:	8b 40 04             	mov    0x4(%eax),%eax
    1519:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    151c:	0f 8c 16 01 00 00    	jl     1638 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1522:	8b 45 08             	mov    0x8(%ebp),%eax
    1525:	8b 00                	mov    (%eax),%eax
    1527:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    152a:	7f 0b                	jg     1537 <APDcCopy+0xa0>
    152c:	8b 45 08             	mov    0x8(%ebp),%eax
    152f:	8b 00                	mov    (%eax),%eax
    1531:	83 e8 01             	sub    $0x1,%eax
    1534:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1537:	8b 45 08             	mov    0x8(%ebp),%eax
    153a:	8b 40 04             	mov    0x4(%eax),%eax
    153d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1540:	7f 0c                	jg     154e <APDcCopy+0xb7>
    1542:	8b 45 08             	mov    0x8(%ebp),%eax
    1545:	8b 40 04             	mov    0x4(%eax),%eax
    1548:	83 e8 01             	sub    $0x1,%eax
    154b:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    154e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1555:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    155c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1563:	e9 bc 00 00 00       	jmp    1624 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1568:	8b 45 08             	mov    0x8(%ebp),%eax
    156b:	8b 00                	mov    (%eax),%eax
    156d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1570:	8b 55 10             	mov    0x10(%ebp),%edx
    1573:	01 ca                	add    %ecx,%edx
    1575:	0f af d0             	imul   %eax,%edx
    1578:	8b 45 0c             	mov    0xc(%ebp),%eax
    157b:	01 d0                	add    %edx,%eax
    157d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1580:	8b 45 14             	mov    0x14(%ebp),%eax
    1583:	8b 00                	mov    (%eax),%eax
    1585:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1588:	8b 55 1c             	mov    0x1c(%ebp),%edx
    158b:	01 ca                	add    %ecx,%edx
    158d:	0f af d0             	imul   %eax,%edx
    1590:	8b 45 18             	mov    0x18(%ebp),%eax
    1593:	01 d0                	add    %edx,%eax
    1595:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1598:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    159f:	eb 74                	jmp    1615 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    15a1:	8b 45 14             	mov    0x14(%ebp),%eax
    15a4:	8b 50 18             	mov    0x18(%eax),%edx
    15a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    15aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15ad:	01 c8                	add    %ecx,%eax
    15af:	89 c1                	mov    %eax,%ecx
    15b1:	89 c8                	mov    %ecx,%eax
    15b3:	01 c0                	add    %eax,%eax
    15b5:	01 c8                	add    %ecx,%eax
    15b7:	01 d0                	add    %edx,%eax
    15b9:	0f b7 10             	movzwl (%eax),%edx
    15bc:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    15c0:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    15c4:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    15c7:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    15cb:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    15cf:	38 c2                	cmp    %al,%dl
    15d1:	75 18                	jne    15eb <APDcCopy+0x154>
    15d3:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    15d7:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    15db:	38 c2                	cmp    %al,%dl
    15dd:	75 0c                	jne    15eb <APDcCopy+0x154>
    15df:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    15e3:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    15e7:	38 c2                	cmp    %al,%dl
    15e9:	74 26                	je     1611 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    15eb:	8b 45 08             	mov    0x8(%ebp),%eax
    15ee:	8b 50 18             	mov    0x18(%eax),%edx
    15f1:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    15f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15f7:	01 c8                	add    %ecx,%eax
    15f9:	89 c1                	mov    %eax,%ecx
    15fb:	89 c8                	mov    %ecx,%eax
    15fd:	01 c0                	add    %eax,%eax
    15ff:	01 c8                	add    %ecx,%eax
    1601:	01 d0                	add    %edx,%eax
    1603:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1607:	66 89 10             	mov    %dx,(%eax)
    160a:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    160e:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1611:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1615:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1618:	2b 45 0c             	sub    0xc(%ebp),%eax
    161b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    161e:	7d 81                	jge    15a1 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1620:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1624:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1627:	2b 45 10             	sub    0x10(%ebp),%eax
    162a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    162d:	0f 8d 35 ff ff ff    	jge    1568 <APDcCopy+0xd1>
    1633:	eb 04                	jmp    1639 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1635:	90                   	nop
    1636:	eb 01                	jmp    1639 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1638:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1639:	c9                   	leave  
    163a:	c3                   	ret    

0000163b <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    163b:	55                   	push   %ebp
    163c:	89 e5                	mov    %esp,%ebp
    163e:	83 ec 1c             	sub    $0x1c,%esp
    1641:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1644:	8b 55 10             	mov    0x10(%ebp),%edx
    1647:	8b 45 14             	mov    0x14(%ebp),%eax
    164a:	88 4d ec             	mov    %cl,-0x14(%ebp)
    164d:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1650:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1653:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1657:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    165a:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    165e:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1661:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1665:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1668:	8b 45 08             	mov    0x8(%ebp),%eax
    166b:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    166f:	66 89 10             	mov    %dx,(%eax)
    1672:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1676:	88 50 02             	mov    %dl,0x2(%eax)
}
    1679:	8b 45 08             	mov    0x8(%ebp),%eax
    167c:	c9                   	leave  
    167d:	c2 04 00             	ret    $0x4

00001680 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1680:	55                   	push   %ebp
    1681:	89 e5                	mov    %esp,%ebp
    1683:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1686:	8b 45 08             	mov    0x8(%ebp),%eax
    1689:	8b 00                	mov    (%eax),%eax
    168b:	83 ec 08             	sub    $0x8,%esp
    168e:	8d 55 0c             	lea    0xc(%ebp),%edx
    1691:	52                   	push   %edx
    1692:	50                   	push   %eax
    1693:	e8 24 ee ff ff       	call   4bc <sendMessage>
    1698:	83 c4 10             	add    $0x10,%esp
}
    169b:	90                   	nop
    169c:	c9                   	leave  
    169d:	c3                   	ret    

0000169e <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    169e:	55                   	push   %ebp
    169f:	89 e5                	mov    %esp,%ebp
    16a1:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    16a4:	83 ec 0c             	sub    $0xc,%esp
    16a7:	68 9c 00 00 00       	push   $0x9c
    16ac:	e8 f5 f1 ff ff       	call   8a6 <malloc>
    16b1:	83 c4 10             	add    $0x10,%esp
    16b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    16b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16bb:	75 15                	jne    16d2 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    16bd:	83 ec 04             	sub    $0x4,%esp
    16c0:	ff 75 08             	pushl  0x8(%ebp)
    16c3:	68 ac 26 00 00       	push   $0x26ac
    16c8:	6a 01                	push   $0x1
    16ca:	e8 04 ef ff ff       	call   5d3 <printf>
    16cf:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    16d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d5:	05 88 00 00 00       	add    $0x88,%eax
    16da:	83 ec 08             	sub    $0x8,%esp
    16dd:	ff 75 08             	pushl  0x8(%ebp)
    16e0:	50                   	push   %eax
    16e1:	e8 fd ea ff ff       	call   1e3 <strcpy>
    16e6:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    16e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ec:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    16f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f6:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    16fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1700:	8b 40 3c             	mov    0x3c(%eax),%eax
    1703:	89 c2                	mov    %eax,%edx
    1705:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1708:	8b 40 40             	mov    0x40(%eax),%eax
    170b:	0f af d0             	imul   %eax,%edx
    170e:	89 d0                	mov    %edx,%eax
    1710:	01 c0                	add    %eax,%eax
    1712:	01 d0                	add    %edx,%eax
    1714:	83 ec 0c             	sub    $0xc,%esp
    1717:	50                   	push   %eax
    1718:	e8 89 f1 ff ff       	call   8a6 <malloc>
    171d:	83 c4 10             	add    $0x10,%esp
    1720:	89 c2                	mov    %eax,%edx
    1722:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1725:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1728:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172b:	8b 40 54             	mov    0x54(%eax),%eax
    172e:	85 c0                	test   %eax,%eax
    1730:	75 15                	jne    1747 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1732:	83 ec 04             	sub    $0x4,%esp
    1735:	ff 75 08             	pushl  0x8(%ebp)
    1738:	68 cc 26 00 00       	push   $0x26cc
    173d:	6a 01                	push   $0x1
    173f:	e8 8f ee ff ff       	call   5d3 <printf>
    1744:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1747:	8b 45 f4             	mov    -0xc(%ebp),%eax
    174a:	8b 40 3c             	mov    0x3c(%eax),%eax
    174d:	89 c2                	mov    %eax,%edx
    174f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1752:	8b 40 40             	mov    0x40(%eax),%eax
    1755:	0f af d0             	imul   %eax,%edx
    1758:	89 d0                	mov    %edx,%eax
    175a:	01 c0                	add    %eax,%eax
    175c:	01 c2                	add    %eax,%edx
    175e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1761:	8b 40 54             	mov    0x54(%eax),%eax
    1764:	83 ec 04             	sub    $0x4,%esp
    1767:	52                   	push   %edx
    1768:	68 ff ff ff 00       	push   $0xffffff
    176d:	50                   	push   %eax
    176e:	e8 06 eb ff ff       	call   279 <memset>
    1773:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1776:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1779:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1780:	e8 0f ed ff ff       	call   494 <getpid>
    1785:	89 c2                	mov    %eax,%edx
    1787:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178a:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    178d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1790:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1797:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179a:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    17a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a4:	8b 40 58             	mov    0x58(%eax),%eax
    17a7:	89 c2                	mov    %eax,%edx
    17a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ac:	8b 40 5c             	mov    0x5c(%eax),%eax
    17af:	0f af d0             	imul   %eax,%edx
    17b2:	89 d0                	mov    %edx,%eax
    17b4:	01 c0                	add    %eax,%eax
    17b6:	01 d0                	add    %edx,%eax
    17b8:	83 ec 0c             	sub    $0xc,%esp
    17bb:	50                   	push   %eax
    17bc:	e8 e5 f0 ff ff       	call   8a6 <malloc>
    17c1:	83 c4 10             	add    $0x10,%esp
    17c4:	89 c2                	mov    %eax,%edx
    17c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c9:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    17cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17cf:	8b 40 70             	mov    0x70(%eax),%eax
    17d2:	85 c0                	test   %eax,%eax
    17d4:	75 15                	jne    17eb <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    17d6:	83 ec 04             	sub    $0x4,%esp
    17d9:	ff 75 08             	pushl  0x8(%ebp)
    17dc:	68 f0 26 00 00       	push   $0x26f0
    17e1:	6a 01                	push   $0x1
    17e3:	e8 eb ed ff ff       	call   5d3 <printf>
    17e8:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    17eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ee:	8b 40 3c             	mov    0x3c(%eax),%eax
    17f1:	89 c2                	mov    %eax,%edx
    17f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f6:	8b 40 40             	mov    0x40(%eax),%eax
    17f9:	0f af d0             	imul   %eax,%edx
    17fc:	89 d0                	mov    %edx,%eax
    17fe:	01 c0                	add    %eax,%eax
    1800:	01 c2                	add    %eax,%edx
    1802:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1805:	8b 40 54             	mov    0x54(%eax),%eax
    1808:	83 ec 04             	sub    $0x4,%esp
    180b:	52                   	push   %edx
    180c:	68 ff 00 00 00       	push   $0xff
    1811:	50                   	push   %eax
    1812:	e8 62 ea ff ff       	call   279 <memset>
    1817:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    181a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1820:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1823:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1827:	74 49                	je     1872 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1829:	8b 45 10             	mov    0x10(%ebp),%eax
    182c:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1832:	83 ec 0c             	sub    $0xc,%esp
    1835:	50                   	push   %eax
    1836:	e8 6b f0 ff ff       	call   8a6 <malloc>
    183b:	83 c4 10             	add    $0x10,%esp
    183e:	89 c2                	mov    %eax,%edx
    1840:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1843:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1846:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1849:	8b 55 10             	mov    0x10(%ebp),%edx
    184c:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    184f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1852:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1859:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185c:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1863:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1866:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    186d:	e9 8d 00 00 00       	jmp    18ff <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1872:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1875:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    187c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    187f:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1886:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1889:	8b 40 20             	mov    0x20(%eax),%eax
    188c:	89 c2                	mov    %eax,%edx
    188e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1891:	8b 40 24             	mov    0x24(%eax),%eax
    1894:	0f af d0             	imul   %eax,%edx
    1897:	89 d0                	mov    %edx,%eax
    1899:	01 c0                	add    %eax,%eax
    189b:	01 d0                	add    %edx,%eax
    189d:	83 ec 0c             	sub    $0xc,%esp
    18a0:	50                   	push   %eax
    18a1:	e8 00 f0 ff ff       	call   8a6 <malloc>
    18a6:	83 c4 10             	add    $0x10,%esp
    18a9:	89 c2                	mov    %eax,%edx
    18ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ae:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    18b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b4:	8b 40 38             	mov    0x38(%eax),%eax
    18b7:	85 c0                	test   %eax,%eax
    18b9:	75 15                	jne    18d0 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    18bb:	83 ec 04             	sub    $0x4,%esp
    18be:	ff 75 08             	pushl  0x8(%ebp)
    18c1:	68 18 27 00 00       	push   $0x2718
    18c6:	6a 01                	push   $0x1
    18c8:	e8 06 ed ff ff       	call   5d3 <printf>
    18cd:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    18d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d3:	8b 40 20             	mov    0x20(%eax),%eax
    18d6:	89 c2                	mov    %eax,%edx
    18d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18db:	8b 40 24             	mov    0x24(%eax),%eax
    18de:	0f af d0             	imul   %eax,%edx
    18e1:	89 d0                	mov    %edx,%eax
    18e3:	01 c0                	add    %eax,%eax
    18e5:	01 c2                	add    %eax,%edx
    18e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ea:	8b 40 38             	mov    0x38(%eax),%eax
    18ed:	83 ec 04             	sub    $0x4,%esp
    18f0:	52                   	push   %edx
    18f1:	68 ff ff ff 00       	push   $0xffffff
    18f6:	50                   	push   %eax
    18f7:	e8 7d e9 ff ff       	call   279 <memset>
    18fc:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    18ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1902:	c9                   	leave  
    1903:	c3                   	ret    

00001904 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1904:	55                   	push   %ebp
    1905:	89 e5                	mov    %esp,%ebp
    1907:	57                   	push   %edi
    1908:	56                   	push   %esi
    1909:	53                   	push   %ebx
    190a:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    190d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1910:	83 f8 03             	cmp    $0x3,%eax
    1913:	74 0e                	je     1923 <APWndProc+0x1f>
    1915:	83 f8 0a             	cmp    $0xa,%eax
    1918:	0f 84 82 00 00 00    	je     19a0 <APWndProc+0x9c>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            break;
        default: break;
    191e:	e9 cb 00 00 00       	jmp    19ee <APWndProc+0xea>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1923:	8b 45 08             	mov    0x8(%ebp),%eax
    1926:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1929:	8b 45 08             	mov    0x8(%ebp),%eax
    192c:	8b 48 18             	mov    0x18(%eax),%ecx
    192f:	8b 45 08             	mov    0x8(%ebp),%eax
    1932:	8b 50 5c             	mov    0x5c(%eax),%edx
    1935:	8b 45 08             	mov    0x8(%ebp),%eax
    1938:	8b 40 58             	mov    0x58(%eax),%eax
    193b:	8b 75 08             	mov    0x8(%ebp),%esi
    193e:	83 c6 58             	add    $0x58,%esi
    1941:	83 ec 04             	sub    $0x4,%esp
    1944:	53                   	push   %ebx
    1945:	51                   	push   %ecx
    1946:	6a 00                	push   $0x0
    1948:	52                   	push   %edx
    1949:	50                   	push   %eax
    194a:	6a 00                	push   $0x0
    194c:	6a 00                	push   $0x0
    194e:	56                   	push   %esi
    194f:	6a 00                	push   $0x0
    1951:	6a 00                	push   $0x0
    1953:	ff 75 08             	pushl  0x8(%ebp)
    1956:	e8 59 eb ff ff       	call   4b4 <paintWindow>
    195b:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    195e:	8b 45 08             	mov    0x8(%ebp),%eax
    1961:	8b 70 1c             	mov    0x1c(%eax),%esi
    1964:	8b 45 08             	mov    0x8(%ebp),%eax
    1967:	8b 58 18             	mov    0x18(%eax),%ebx
    196a:	8b 45 08             	mov    0x8(%ebp),%eax
    196d:	8b 48 08             	mov    0x8(%eax),%ecx
    1970:	8b 45 08             	mov    0x8(%ebp),%eax
    1973:	8b 50 40             	mov    0x40(%eax),%edx
    1976:	8b 45 08             	mov    0x8(%ebp),%eax
    1979:	8b 40 3c             	mov    0x3c(%eax),%eax
    197c:	8b 7d 08             	mov    0x8(%ebp),%edi
    197f:	83 c7 3c             	add    $0x3c,%edi
    1982:	83 ec 04             	sub    $0x4,%esp
    1985:	56                   	push   %esi
    1986:	53                   	push   %ebx
    1987:	51                   	push   %ecx
    1988:	52                   	push   %edx
    1989:	50                   	push   %eax
    198a:	6a 00                	push   $0x0
    198c:	6a 00                	push   $0x0
    198e:	57                   	push   %edi
    198f:	6a 32                	push   $0x32
    1991:	6a 00                	push   $0x0
    1993:	ff 75 08             	pushl  0x8(%ebp)
    1996:	e8 19 eb ff ff       	call   4b4 <paintWindow>
    199b:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    199e:	eb 4e                	jmp    19ee <APWndProc+0xea>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
    19a0:	8b 45 18             	mov    0x18(%ebp),%eax
    19a3:	83 ec 08             	sub    $0x8,%esp
    19a6:	50                   	push   %eax
    19a7:	ff 75 08             	pushl  0x8(%ebp)
    19aa:	e8 19 08 00 00       	call   21c8 <updateword>
    19af:	83 c4 10             	add    $0x10,%esp
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    19b2:	8b 45 08             	mov    0x8(%ebp),%eax
    19b5:	8b 58 1c             	mov    0x1c(%eax),%ebx
    19b8:	8b 45 08             	mov    0x8(%ebp),%eax
    19bb:	8b 48 18             	mov    0x18(%eax),%ecx
    19be:	8b 45 08             	mov    0x8(%ebp),%eax
    19c1:	8b 50 5c             	mov    0x5c(%eax),%edx
    19c4:	8b 45 08             	mov    0x8(%ebp),%eax
    19c7:	8b 40 58             	mov    0x58(%eax),%eax
    19ca:	8b 75 08             	mov    0x8(%ebp),%esi
    19cd:	83 c6 58             	add    $0x58,%esi
    19d0:	83 ec 04             	sub    $0x4,%esp
    19d3:	53                   	push   %ebx
    19d4:	51                   	push   %ecx
    19d5:	6a 00                	push   $0x0
    19d7:	52                   	push   %edx
    19d8:	50                   	push   %eax
    19d9:	6a 00                	push   $0x0
    19db:	6a 00                	push   $0x0
    19dd:	56                   	push   %esi
    19de:	6a 00                	push   $0x0
    19e0:	6a 00                	push   $0x0
    19e2:	ff 75 08             	pushl  0x8(%ebp)
    19e5:	e8 ca ea ff ff       	call   4b4 <paintWindow>
    19ea:	83 c4 30             	add    $0x30,%esp
            break;
    19ed:	90                   	nop
        default: break;
            
            
    }
    return False;
    19ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
    19f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19f6:	5b                   	pop    %ebx
    19f7:	5e                   	pop    %esi
    19f8:	5f                   	pop    %edi
    19f9:	5d                   	pop    %ebp
    19fa:	c3                   	ret    

000019fb <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    19fb:	55                   	push   %ebp
    19fc:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    19fe:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a01:	8b 50 08             	mov    0x8(%eax),%edx
    1a04:	8b 45 08             	mov    0x8(%ebp),%eax
    1a07:	8b 00                	mov    (%eax),%eax
    1a09:	39 c2                	cmp    %eax,%edx
    1a0b:	74 07                	je     1a14 <APPreJudge+0x19>
        return False;
    1a0d:	b8 00 00 00 00       	mov    $0x0,%eax
    1a12:	eb 05                	jmp    1a19 <APPreJudge+0x1e>
    return True;
    1a14:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1a19:	5d                   	pop    %ebp
    1a1a:	c3                   	ret    

00001a1b <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1a1b:	55                   	push   %ebp
    1a1c:	89 e5                	mov    %esp,%ebp
    1a1e:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1a21:	8b 45 08             	mov    0x8(%ebp),%eax
    1a24:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a27:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
    //--------add window to list
    registWindow(hwnd);
    1a2d:	83 ec 0c             	sub    $0xc,%esp
    1a30:	ff 75 08             	pushl  0x8(%ebp)
    1a33:	e8 94 ea ff ff       	call   4cc <registWindow>
    1a38:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1a3b:	c7 45 e8 02 00 00 00 	movl   $0x2,-0x18(%ebp)
    msg.wndID = hwnd->id;
    1a42:	8b 45 08             	mov    0x8(%ebp),%eax
    1a45:	8b 00                	mov    (%eax),%eax
    1a47:	89 45 f0             	mov    %eax,-0x10(%ebp)
    APSendMessage(hwnd,msg);
    1a4a:	83 ec 0c             	sub    $0xc,%esp
    1a4d:	ff 75 f4             	pushl  -0xc(%ebp)
    1a50:	ff 75 f0             	pushl  -0x10(%ebp)
    1a53:	ff 75 ec             	pushl  -0x14(%ebp)
    1a56:	ff 75 e8             	pushl  -0x18(%ebp)
    1a59:	ff 75 08             	pushl  0x8(%ebp)
    1a5c:	e8 1f fc ff ff       	call   1680 <APSendMessage>
    1a61:	83 c4 20             	add    $0x20,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1a64:	83 ec 0c             	sub    $0xc,%esp
    1a67:	ff 75 08             	pushl  0x8(%ebp)
    1a6a:	e8 55 ea ff ff       	call   4c4 <getMessage>
    1a6f:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1a72:	8b 45 08             	mov    0x8(%ebp),%eax
    1a75:	83 c0 74             	add    $0x74,%eax
    1a78:	83 ec 08             	sub    $0x8,%esp
    1a7b:	50                   	push   %eax
    1a7c:	ff 75 08             	pushl  0x8(%ebp)
    1a7f:	e8 77 ff ff ff       	call   19fb <APPreJudge>
    1a84:	83 c4 10             	add    $0x10,%esp
    1a87:	84 c0                	test   %al,%al
    1a89:	74 24                	je     1aaf <APWndExec+0x94>
            if (wndProc(hwnd, hwnd->msg))
    1a8b:	83 ec 0c             	sub    $0xc,%esp
    1a8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a91:	ff b0 80 00 00 00    	pushl  0x80(%eax)
    1a97:	ff 70 7c             	pushl  0x7c(%eax)
    1a9a:	ff 70 78             	pushl  0x78(%eax)
    1a9d:	ff 70 74             	pushl  0x74(%eax)
    1aa0:	ff 75 08             	pushl  0x8(%ebp)
    1aa3:	8b 45 0c             	mov    0xc(%ebp),%eax
    1aa6:	ff d0                	call   *%eax
    1aa8:	83 c4 20             	add    $0x20,%esp
    1aab:	84 c0                	test   %al,%al
    1aad:	75 0c                	jne    1abb <APWndExec+0xa0>
                break;
        hwnd->msg.type = MSG_NULL;
    1aaf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab2:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1ab9:	eb a9                	jmp    1a64 <APWndExec+0x49>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1abb:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1abc:	90                   	nop
    1abd:	c9                   	leave  
    1abe:	c3                   	ret    

00001abf <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1abf:	55                   	push   %ebp
    1ac0:	89 e5                	mov    %esp,%ebp
    1ac2:	57                   	push   %edi
    1ac3:	56                   	push   %esi
    1ac4:	53                   	push   %ebx
    1ac5:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1ac8:	a1 6c 6a 00 00       	mov    0x6a6c,%eax
    1acd:	85 c0                	test   %eax,%eax
    1acf:	0f 85 7a 02 00 00    	jne    1d4f <APGridPaint+0x290>
    {
        iconReady = 1;
    1ad5:	c7 05 6c 6a 00 00 01 	movl   $0x1,0x6a6c
    1adc:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1adf:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ae2:	83 ec 08             	sub    $0x8,%esp
    1ae5:	68 3f 27 00 00       	push   $0x273f
    1aea:	50                   	push   %eax
    1aeb:	e8 69 ef ff ff       	call   a59 <APLoadBitmap>
    1af0:	83 c4 0c             	add    $0xc,%esp
    1af3:	8b 45 98             	mov    -0x68(%ebp),%eax
    1af6:	a3 a0 6c 00 00       	mov    %eax,0x6ca0
    1afb:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1afe:	a3 a4 6c 00 00       	mov    %eax,0x6ca4
    1b03:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b06:	a3 a8 6c 00 00       	mov    %eax,0x6ca8
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1b0b:	83 ec 04             	sub    $0x4,%esp
    1b0e:	ff 35 a8 6c 00 00    	pushl  0x6ca8
    1b14:	ff 35 a4 6c 00 00    	pushl  0x6ca4
    1b1a:	ff 35 a0 6c 00 00    	pushl  0x6ca0
    1b20:	e8 6e f1 ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1b25:	83 c4 10             	add    $0x10,%esp
    1b28:	a3 ac 6c 00 00       	mov    %eax,0x6cac
        grid_river = APLoadBitmap ("grid_river.bmp");
    1b2d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b30:	83 ec 08             	sub    $0x8,%esp
    1b33:	68 4d 27 00 00       	push   $0x274d
    1b38:	50                   	push   %eax
    1b39:	e8 1b ef ff ff       	call   a59 <APLoadBitmap>
    1b3e:	83 c4 0c             	add    $0xc,%esp
    1b41:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b44:	a3 e8 6c 00 00       	mov    %eax,0x6ce8
    1b49:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b4c:	a3 ec 6c 00 00       	mov    %eax,0x6cec
    1b51:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b54:	a3 f0 6c 00 00       	mov    %eax,0x6cf0
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1b59:	83 ec 04             	sub    $0x4,%esp
    1b5c:	ff 35 f0 6c 00 00    	pushl  0x6cf0
    1b62:	ff 35 ec 6c 00 00    	pushl  0x6cec
    1b68:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1b6e:	e8 20 f1 ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1b73:	83 c4 10             	add    $0x10,%esp
    1b76:	a3 d8 6c 00 00       	mov    %eax,0x6cd8
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1b7b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b7e:	83 ec 08             	sub    $0x8,%esp
    1b81:	68 5c 27 00 00       	push   $0x275c
    1b86:	50                   	push   %eax
    1b87:	e8 cd ee ff ff       	call   a59 <APLoadBitmap>
    1b8c:	83 c4 0c             	add    $0xc,%esp
    1b8f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b92:	a3 dc 6c 00 00       	mov    %eax,0x6cdc
    1b97:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b9a:	a3 e0 6c 00 00       	mov    %eax,0x6ce0
    1b9f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ba2:	a3 e4 6c 00 00       	mov    %eax,0x6ce4
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1ba7:	83 ec 04             	sub    $0x4,%esp
    1baa:	ff 35 e4 6c 00 00    	pushl  0x6ce4
    1bb0:	ff 35 e0 6c 00 00    	pushl  0x6ce0
    1bb6:	ff 35 dc 6c 00 00    	pushl  0x6cdc
    1bbc:	e8 d2 f0 ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1bc1:	83 c4 10             	add    $0x10,%esp
    1bc4:	a3 80 6c 00 00       	mov    %eax,0x6c80
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1bc9:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bcc:	83 ec 08             	sub    $0x8,%esp
    1bcf:	68 6b 27 00 00       	push   $0x276b
    1bd4:	50                   	push   %eax
    1bd5:	e8 7f ee ff ff       	call   a59 <APLoadBitmap>
    1bda:	83 c4 0c             	add    $0xc,%esp
    1bdd:	8b 45 98             	mov    -0x68(%ebp),%eax
    1be0:	a3 b4 6c 00 00       	mov    %eax,0x6cb4
    1be5:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1be8:	a3 b8 6c 00 00       	mov    %eax,0x6cb8
    1bed:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bf0:	a3 bc 6c 00 00       	mov    %eax,0x6cbc
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1bf5:	83 ec 04             	sub    $0x4,%esp
    1bf8:	ff 35 bc 6c 00 00    	pushl  0x6cbc
    1bfe:	ff 35 b8 6c 00 00    	pushl  0x6cb8
    1c04:	ff 35 b4 6c 00 00    	pushl  0x6cb4
    1c0a:	e8 84 f0 ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1c0f:	83 c4 10             	add    $0x10,%esp
    1c12:	a3 f8 6c 00 00       	mov    %eax,0x6cf8
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1c17:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c1a:	83 ec 08             	sub    $0x8,%esp
    1c1d:	68 79 27 00 00       	push   $0x2779
    1c22:	50                   	push   %eax
    1c23:	e8 31 ee ff ff       	call   a59 <APLoadBitmap>
    1c28:	83 c4 0c             	add    $0xc,%esp
    1c2b:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c2e:	a3 90 6c 00 00       	mov    %eax,0x6c90
    1c33:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c36:	a3 94 6c 00 00       	mov    %eax,0x6c94
    1c3b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c3e:	a3 98 6c 00 00       	mov    %eax,0x6c98
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1c43:	83 ec 04             	sub    $0x4,%esp
    1c46:	ff 35 98 6c 00 00    	pushl  0x6c98
    1c4c:	ff 35 94 6c 00 00    	pushl  0x6c94
    1c52:	ff 35 90 6c 00 00    	pushl  0x6c90
    1c58:	e8 36 f0 ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1c5d:	83 c4 10             	add    $0x10,%esp
    1c60:	a3 b0 6c 00 00       	mov    %eax,0x6cb0
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1c65:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c68:	83 ec 08             	sub    $0x8,%esp
    1c6b:	68 89 27 00 00       	push   $0x2789
    1c70:	50                   	push   %eax
    1c71:	e8 e3 ed ff ff       	call   a59 <APLoadBitmap>
    1c76:	83 c4 0c             	add    $0xc,%esp
    1c79:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c7c:	a3 84 6c 00 00       	mov    %eax,0x6c84
    1c81:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c84:	a3 88 6c 00 00       	mov    %eax,0x6c88
    1c89:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c8c:	a3 8c 6c 00 00       	mov    %eax,0x6c8c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1c91:	83 ec 04             	sub    $0x4,%esp
    1c94:	ff 35 8c 6c 00 00    	pushl  0x6c8c
    1c9a:	ff 35 88 6c 00 00    	pushl  0x6c88
    1ca0:	ff 35 84 6c 00 00    	pushl  0x6c84
    1ca6:	e8 e8 ef ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1cab:	83 c4 10             	add    $0x10,%esp
    1cae:	a3 9c 6c 00 00       	mov    %eax,0x6c9c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1cb3:	8d 45 98             	lea    -0x68(%ebp),%eax
    1cb6:	83 ec 08             	sub    $0x8,%esp
    1cb9:	68 9b 27 00 00       	push   $0x279b
    1cbe:	50                   	push   %eax
    1cbf:	e8 95 ed ff ff       	call   a59 <APLoadBitmap>
    1cc4:	83 c4 0c             	add    $0xc,%esp
    1cc7:	8b 45 98             	mov    -0x68(%ebp),%eax
    1cca:	a3 cc 6c 00 00       	mov    %eax,0x6ccc
    1ccf:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1cd2:	a3 d0 6c 00 00       	mov    %eax,0x6cd0
    1cd7:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1cda:	a3 d4 6c 00 00       	mov    %eax,0x6cd4
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1cdf:	83 ec 04             	sub    $0x4,%esp
    1ce2:	ff 35 d4 6c 00 00    	pushl  0x6cd4
    1ce8:	ff 35 d0 6c 00 00    	pushl  0x6cd0
    1cee:	ff 35 cc 6c 00 00    	pushl  0x6ccc
    1cf4:	e8 9a ef ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1cf9:	83 c4 10             	add    $0x10,%esp
    1cfc:	a3 fc 6c 00 00       	mov    %eax,0x6cfc
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    1d01:	8d 45 98             	lea    -0x68(%ebp),%eax
    1d04:	83 ec 08             	sub    $0x8,%esp
    1d07:	68 aa 27 00 00       	push   $0x27aa
    1d0c:	50                   	push   %eax
    1d0d:	e8 47 ed ff ff       	call   a59 <APLoadBitmap>
    1d12:	83 c4 0c             	add    $0xc,%esp
    1d15:	8b 45 98             	mov    -0x68(%ebp),%eax
    1d18:	a3 c0 6c 00 00       	mov    %eax,0x6cc0
    1d1d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1d20:	a3 c4 6c 00 00       	mov    %eax,0x6cc4
    1d25:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1d28:	a3 c8 6c 00 00       	mov    %eax,0x6cc8
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    1d2d:	83 ec 04             	sub    $0x4,%esp
    1d30:	ff 35 c8 6c 00 00    	pushl  0x6cc8
    1d36:	ff 35 c4 6c 00 00    	pushl  0x6cc4
    1d3c:	ff 35 c0 6c 00 00    	pushl  0x6cc0
    1d42:	e8 4c ef ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1d47:	83 c4 10             	add    $0x10,%esp
    1d4a:	a3 f4 6c 00 00       	mov    %eax,0x6cf4
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1d4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d52:	8b 40 08             	mov    0x8(%eax),%eax
    1d55:	85 c0                	test   %eax,%eax
    1d57:	75 17                	jne    1d70 <APGridPaint+0x2b1>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1d59:	83 ec 08             	sub    $0x8,%esp
    1d5c:	68 bc 27 00 00       	push   $0x27bc
    1d61:	6a 01                	push   $0x1
    1d63:	e8 6b e8 ff ff       	call   5d3 <printf>
    1d68:	83 c4 10             	add    $0x10,%esp
        return;
    1d6b:	e9 50 04 00 00       	jmp    21c0 <APGridPaint+0x701>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1d70:	8b 45 08             	mov    0x8(%ebp),%eax
    1d73:	8b 40 10             	mov    0x10(%eax),%eax
    1d76:	85 c0                	test   %eax,%eax
    1d78:	7e 10                	jle    1d8a <APGridPaint+0x2cb>
    1d7a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7d:	8b 50 14             	mov    0x14(%eax),%edx
    1d80:	8b 45 08             	mov    0x8(%ebp),%eax
    1d83:	8b 40 10             	mov    0x10(%eax),%eax
    1d86:	39 c2                	cmp    %eax,%edx
    1d88:	7c 17                	jl     1da1 <APGridPaint+0x2e2>
    {
        printf(1,"Grid mode page error!");
    1d8a:	83 ec 08             	sub    $0x8,%esp
    1d8d:	68 e2 27 00 00       	push   $0x27e2
    1d92:	6a 01                	push   $0x1
    1d94:	e8 3a e8 ff ff       	call   5d3 <printf>
    1d99:	83 c4 10             	add    $0x10,%esp
        return;
    1d9c:	e9 1f 04 00 00       	jmp    21c0 <APGridPaint+0x701>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1da1:	8b 45 08             	mov    0x8(%ebp),%eax
    1da4:	8b 40 14             	mov    0x14(%eax),%eax
    1da7:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1dad:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1db0:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1db3:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1db6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1dbd:	e9 f4 03 00 00       	jmp    21b6 <APGridPaint+0x6f7>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1dc2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1dc9:	e9 da 03 00 00       	jmp    21a8 <APGridPaint+0x6e9>
        {
            index = start + GRID_W_NUMBER * j + i;
    1dce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dd1:	c1 e0 04             	shl    $0x4,%eax
    1dd4:	89 c2                	mov    %eax,%edx
    1dd6:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1dd9:	01 c2                	add    %eax,%edx
    1ddb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dde:	01 d0                	add    %edx,%eax
    1de0:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1de3:	8b 45 08             	mov    0x8(%ebp),%eax
    1de6:	8b 40 0c             	mov    0xc(%eax),%eax
    1de9:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1dec:	c1 e2 02             	shl    $0x2,%edx
    1def:	01 d0                	add    %edx,%eax
    1df1:	8b 00                	mov    (%eax),%eax
    1df3:	83 f8 0a             	cmp    $0xa,%eax
    1df6:	0f 87 a7 03 00 00    	ja     21a3 <APGridPaint+0x6e4>
    1dfc:	8b 04 85 f8 27 00 00 	mov    0x27f8(,%eax,4),%eax
    1e03:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e05:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1e08:	6a 0c                	push   $0xc
    1e0a:	6a 0c                	push   $0xc
    1e0c:	6a 0c                	push   $0xc
    1e0e:	50                   	push   %eax
    1e0f:	e8 27 f8 ff ff       	call   163b <RGB>
    1e14:	83 c4 0c             	add    $0xc,%esp
    1e17:	8b 1d ac 6c 00 00    	mov    0x6cac,%ebx
    1e1d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e20:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e23:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e26:	6b c0 32             	imul   $0x32,%eax,%eax
    1e29:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e2f:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e32:	83 ec 0c             	sub    $0xc,%esp
    1e35:	83 ec 04             	sub    $0x4,%esp
    1e38:	89 e0                	mov    %esp,%eax
    1e3a:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    1e3e:	66 89 30             	mov    %si,(%eax)
    1e41:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    1e45:	88 50 02             	mov    %dl,0x2(%eax)
    1e48:	6a 32                	push   $0x32
    1e4a:	6a 32                	push   $0x32
    1e4c:	6a 00                	push   $0x0
    1e4e:	6a 00                	push   $0x0
    1e50:	53                   	push   %ebx
    1e51:	51                   	push   %ecx
    1e52:	ff 75 94             	pushl  -0x6c(%ebp)
    1e55:	57                   	push   %edi
    1e56:	e8 3c f6 ff ff       	call   1497 <APDcCopy>
    1e5b:	83 c4 30             	add    $0x30,%esp
                    break;
    1e5e:	e9 41 03 00 00       	jmp    21a4 <APGridPaint+0x6e5>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1e63:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e66:	6a 69                	push   $0x69
    1e68:	6a 69                	push   $0x69
    1e6a:	6a 69                	push   $0x69
    1e6c:	50                   	push   %eax
    1e6d:	e8 c9 f7 ff ff       	call   163b <RGB>
    1e72:	83 c4 0c             	add    $0xc,%esp
    1e75:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e79:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1e7d:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e81:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1e84:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1e8b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e8e:	6a 69                	push   $0x69
    1e90:	6a 69                	push   $0x69
    1e92:	6a 69                	push   $0x69
    1e94:	50                   	push   %eax
    1e95:	e8 a1 f7 ff ff       	call   163b <RGB>
    1e9a:	83 c4 0c             	add    $0xc,%esp
    1e9d:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ea1:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1ea5:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ea9:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1eac:	8b 45 08             	mov    0x8(%ebp),%eax
    1eaf:	8d 50 3c             	lea    0x3c(%eax),%edx
    1eb2:	8d 45 98             	lea    -0x68(%ebp),%eax
    1eb5:	ff 75 bc             	pushl  -0x44(%ebp)
    1eb8:	ff 75 b8             	pushl  -0x48(%ebp)
    1ebb:	52                   	push   %edx
    1ebc:	50                   	push   %eax
    1ebd:	e8 66 ee ff ff       	call   d28 <APSetPen>
    1ec2:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1ec5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec8:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1ecb:	8d 55 98             	lea    -0x68(%ebp),%edx
    1ece:	83 ec 04             	sub    $0x4,%esp
    1ed1:	83 ec 04             	sub    $0x4,%esp
    1ed4:	89 e0                	mov    %esp,%eax
    1ed6:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1eda:	66 89 08             	mov    %cx,(%eax)
    1edd:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1ee1:	88 48 02             	mov    %cl,0x2(%eax)
    1ee4:	53                   	push   %ebx
    1ee5:	52                   	push   %edx
    1ee6:	e8 76 ee ff ff       	call   d61 <APSetBrush>
    1eeb:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1eee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ef1:	6b d0 32             	imul   $0x32,%eax,%edx
    1ef4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ef7:	6b c0 32             	imul   $0x32,%eax,%eax
    1efa:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1efd:	83 c1 3c             	add    $0x3c,%ecx
    1f00:	83 ec 0c             	sub    $0xc,%esp
    1f03:	6a 32                	push   $0x32
    1f05:	6a 32                	push   $0x32
    1f07:	52                   	push   %edx
    1f08:	50                   	push   %eax
    1f09:	51                   	push   %ecx
    1f0a:	e8 7c f2 ff ff       	call   118b <APDrawRect>
    1f0f:	83 c4 20             	add    $0x20,%esp
                    break;
    1f12:	e9 8d 02 00 00       	jmp    21a4 <APGridPaint+0x6e5>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f17:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1f1a:	6a 0c                	push   $0xc
    1f1c:	6a 0c                	push   $0xc
    1f1e:	6a 0c                	push   $0xc
    1f20:	50                   	push   %eax
    1f21:	e8 15 f7 ff ff       	call   163b <RGB>
    1f26:	83 c4 0c             	add    $0xc,%esp
    1f29:	8b 1d fc 6c 00 00    	mov    0x6cfc,%ebx
    1f2f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f32:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f35:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f38:	6b c0 32             	imul   $0x32,%eax,%eax
    1f3b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f41:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f44:	83 ec 0c             	sub    $0xc,%esp
    1f47:	83 ec 04             	sub    $0x4,%esp
    1f4a:	89 e0                	mov    %esp,%eax
    1f4c:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1f50:	66 89 30             	mov    %si,(%eax)
    1f53:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1f57:	88 50 02             	mov    %dl,0x2(%eax)
    1f5a:	6a 32                	push   $0x32
    1f5c:	6a 32                	push   $0x32
    1f5e:	6a 00                	push   $0x0
    1f60:	6a 00                	push   $0x0
    1f62:	53                   	push   %ebx
    1f63:	51                   	push   %ecx
    1f64:	ff 75 94             	pushl  -0x6c(%ebp)
    1f67:	57                   	push   %edi
    1f68:	e8 2a f5 ff ff       	call   1497 <APDcCopy>
    1f6d:	83 c4 30             	add    $0x30,%esp
                    break;
    1f70:	e9 2f 02 00 00       	jmp    21a4 <APGridPaint+0x6e5>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f75:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1f78:	6a 0c                	push   $0xc
    1f7a:	6a 0c                	push   $0xc
    1f7c:	6a 0c                	push   $0xc
    1f7e:	50                   	push   %eax
    1f7f:	e8 b7 f6 ff ff       	call   163b <RGB>
    1f84:	83 c4 0c             	add    $0xc,%esp
    1f87:	8b 1d d8 6c 00 00    	mov    0x6cd8,%ebx
    1f8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f90:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f93:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f96:	6b c0 32             	imul   $0x32,%eax,%eax
    1f99:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f9c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f9f:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fa2:	83 ec 0c             	sub    $0xc,%esp
    1fa5:	83 ec 04             	sub    $0x4,%esp
    1fa8:	89 e0                	mov    %esp,%eax
    1faa:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1fae:	66 89 30             	mov    %si,(%eax)
    1fb1:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1fb5:	88 50 02             	mov    %dl,0x2(%eax)
    1fb8:	6a 32                	push   $0x32
    1fba:	6a 32                	push   $0x32
    1fbc:	6a 00                	push   $0x0
    1fbe:	6a 00                	push   $0x0
    1fc0:	53                   	push   %ebx
    1fc1:	51                   	push   %ecx
    1fc2:	ff 75 94             	pushl  -0x6c(%ebp)
    1fc5:	57                   	push   %edi
    1fc6:	e8 cc f4 ff ff       	call   1497 <APDcCopy>
    1fcb:	83 c4 30             	add    $0x30,%esp
                    break;
    1fce:	e9 d1 01 00 00       	jmp    21a4 <APGridPaint+0x6e5>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fd3:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1fd6:	6a 0c                	push   $0xc
    1fd8:	6a 0c                	push   $0xc
    1fda:	6a 0c                	push   $0xc
    1fdc:	50                   	push   %eax
    1fdd:	e8 59 f6 ff ff       	call   163b <RGB>
    1fe2:	83 c4 0c             	add    $0xc,%esp
    1fe5:	8b 1d b0 6c 00 00    	mov    0x6cb0,%ebx
    1feb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fee:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ff1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ff4:	6b c0 32             	imul   $0x32,%eax,%eax
    1ff7:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ffa:	8b 45 08             	mov    0x8(%ebp),%eax
    1ffd:	8d 78 3c             	lea    0x3c(%eax),%edi
    2000:	83 ec 0c             	sub    $0xc,%esp
    2003:	83 ec 04             	sub    $0x4,%esp
    2006:	89 e0                	mov    %esp,%eax
    2008:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    200c:	66 89 30             	mov    %si,(%eax)
    200f:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    2013:	88 50 02             	mov    %dl,0x2(%eax)
    2016:	6a 32                	push   $0x32
    2018:	6a 32                	push   $0x32
    201a:	6a 00                	push   $0x0
    201c:	6a 00                	push   $0x0
    201e:	53                   	push   %ebx
    201f:	51                   	push   %ecx
    2020:	ff 75 94             	pushl  -0x6c(%ebp)
    2023:	57                   	push   %edi
    2024:	e8 6e f4 ff ff       	call   1497 <APDcCopy>
    2029:	83 c4 30             	add    $0x30,%esp
                    break;
    202c:	e9 73 01 00 00       	jmp    21a4 <APGridPaint+0x6e5>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2031:	8d 45 cc             	lea    -0x34(%ebp),%eax
    2034:	6a 0c                	push   $0xc
    2036:	6a 0c                	push   $0xc
    2038:	6a 0c                	push   $0xc
    203a:	50                   	push   %eax
    203b:	e8 fb f5 ff ff       	call   163b <RGB>
    2040:	83 c4 0c             	add    $0xc,%esp
    2043:	8b 1d f8 6c 00 00    	mov    0x6cf8,%ebx
    2049:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    204c:	6b c8 32             	imul   $0x32,%eax,%ecx
    204f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2052:	6b c0 32             	imul   $0x32,%eax,%eax
    2055:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2058:	8b 45 08             	mov    0x8(%ebp),%eax
    205b:	8d 78 3c             	lea    0x3c(%eax),%edi
    205e:	83 ec 0c             	sub    $0xc,%esp
    2061:	83 ec 04             	sub    $0x4,%esp
    2064:	89 e0                	mov    %esp,%eax
    2066:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    206a:	66 89 30             	mov    %si,(%eax)
    206d:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    2071:	88 50 02             	mov    %dl,0x2(%eax)
    2074:	6a 32                	push   $0x32
    2076:	6a 32                	push   $0x32
    2078:	6a 00                	push   $0x0
    207a:	6a 00                	push   $0x0
    207c:	53                   	push   %ebx
    207d:	51                   	push   %ecx
    207e:	ff 75 94             	pushl  -0x6c(%ebp)
    2081:	57                   	push   %edi
    2082:	e8 10 f4 ff ff       	call   1497 <APDcCopy>
    2087:	83 c4 30             	add    $0x30,%esp
                    break;
    208a:	e9 15 01 00 00       	jmp    21a4 <APGridPaint+0x6e5>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    208f:	8d 45 cf             	lea    -0x31(%ebp),%eax
    2092:	6a 0c                	push   $0xc
    2094:	6a 0c                	push   $0xc
    2096:	6a 0c                	push   $0xc
    2098:	50                   	push   %eax
    2099:	e8 9d f5 ff ff       	call   163b <RGB>
    209e:	83 c4 0c             	add    $0xc,%esp
    20a1:	8b 1d 80 6c 00 00    	mov    0x6c80,%ebx
    20a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20aa:	6b c8 32             	imul   $0x32,%eax,%ecx
    20ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
    20b0:	6b c0 32             	imul   $0x32,%eax,%eax
    20b3:	89 45 94             	mov    %eax,-0x6c(%ebp)
    20b6:	8b 45 08             	mov    0x8(%ebp),%eax
    20b9:	8d 78 3c             	lea    0x3c(%eax),%edi
    20bc:	83 ec 0c             	sub    $0xc,%esp
    20bf:	83 ec 04             	sub    $0x4,%esp
    20c2:	89 e0                	mov    %esp,%eax
    20c4:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    20c8:	66 89 30             	mov    %si,(%eax)
    20cb:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    20cf:	88 50 02             	mov    %dl,0x2(%eax)
    20d2:	6a 32                	push   $0x32
    20d4:	6a 32                	push   $0x32
    20d6:	6a 00                	push   $0x0
    20d8:	6a 00                	push   $0x0
    20da:	53                   	push   %ebx
    20db:	51                   	push   %ecx
    20dc:	ff 75 94             	pushl  -0x6c(%ebp)
    20df:	57                   	push   %edi
    20e0:	e8 b2 f3 ff ff       	call   1497 <APDcCopy>
    20e5:	83 c4 30             	add    $0x30,%esp
                    break;
    20e8:	e9 b7 00 00 00       	jmp    21a4 <APGridPaint+0x6e5>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    20ed:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    20f0:	6a 0c                	push   $0xc
    20f2:	6a 0c                	push   $0xc
    20f4:	6a 0c                	push   $0xc
    20f6:	50                   	push   %eax
    20f7:	e8 3f f5 ff ff       	call   163b <RGB>
    20fc:	83 c4 0c             	add    $0xc,%esp
    20ff:	8b 1d 9c 6c 00 00    	mov    0x6c9c,%ebx
    2105:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2108:	6b c8 32             	imul   $0x32,%eax,%ecx
    210b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    210e:	6b c0 32             	imul   $0x32,%eax,%eax
    2111:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2114:	8b 45 08             	mov    0x8(%ebp),%eax
    2117:	8d 78 3c             	lea    0x3c(%eax),%edi
    211a:	83 ec 0c             	sub    $0xc,%esp
    211d:	83 ec 04             	sub    $0x4,%esp
    2120:	89 e0                	mov    %esp,%eax
    2122:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2126:	66 89 30             	mov    %si,(%eax)
    2129:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    212d:	88 50 02             	mov    %dl,0x2(%eax)
    2130:	6a 32                	push   $0x32
    2132:	6a 32                	push   $0x32
    2134:	6a 00                	push   $0x0
    2136:	6a 00                	push   $0x0
    2138:	53                   	push   %ebx
    2139:	51                   	push   %ecx
    213a:	ff 75 94             	pushl  -0x6c(%ebp)
    213d:	57                   	push   %edi
    213e:	e8 54 f3 ff ff       	call   1497 <APDcCopy>
    2143:	83 c4 30             	add    $0x30,%esp
                    break;
    2146:	eb 5c                	jmp    21a4 <APGridPaint+0x6e5>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2148:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    214b:	6a 0c                	push   $0xc
    214d:	6a 0c                	push   $0xc
    214f:	6a 0c                	push   $0xc
    2151:	50                   	push   %eax
    2152:	e8 e4 f4 ff ff       	call   163b <RGB>
    2157:	83 c4 0c             	add    $0xc,%esp
    215a:	8b 1d f4 6c 00 00    	mov    0x6cf4,%ebx
    2160:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2163:	6b c8 32             	imul   $0x32,%eax,%ecx
    2166:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2169:	6b c0 32             	imul   $0x32,%eax,%eax
    216c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    216f:	8b 45 08             	mov    0x8(%ebp),%eax
    2172:	8d 78 3c             	lea    0x3c(%eax),%edi
    2175:	83 ec 0c             	sub    $0xc,%esp
    2178:	83 ec 04             	sub    $0x4,%esp
    217b:	89 e0                	mov    %esp,%eax
    217d:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2181:	66 89 30             	mov    %si,(%eax)
    2184:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2188:	88 50 02             	mov    %dl,0x2(%eax)
    218b:	6a 32                	push   $0x32
    218d:	6a 32                	push   $0x32
    218f:	6a 00                	push   $0x0
    2191:	6a 00                	push   $0x0
    2193:	53                   	push   %ebx
    2194:	51                   	push   %ecx
    2195:	ff 75 94             	pushl  -0x6c(%ebp)
    2198:	57                   	push   %edi
    2199:	e8 f9 f2 ff ff       	call   1497 <APDcCopy>
    219e:	83 c4 30             	add    $0x30,%esp
                    break;
    21a1:	eb 01                	jmp    21a4 <APGridPaint+0x6e5>
                default: break;
    21a3:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    21a4:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    21a8:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    21ac:	0f 8e 1c fc ff ff    	jle    1dce <APGridPaint+0x30f>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    21b2:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    21b6:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    21ba:	0f 8e 02 fc ff ff    	jle    1dc2 <APGridPaint+0x303>
                default: break;
            }
        }
    }
    
}
    21c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    21c3:	5b                   	pop    %ebx
    21c4:	5e                   	pop    %esi
    21c5:	5f                   	pop    %edi
    21c6:	5d                   	pop    %ebp
    21c7:	c3                   	ret    

000021c8 <updateword>:


void updateword(AHwnd hwnd,char* str)
{
    21c8:	55                   	push   %ebp
    21c9:	89 e5                	mov    %esp,%ebp
    21cb:	53                   	push   %ebx
    21cc:	83 ec 24             	sub    $0x24,%esp
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    21cf:	8d 45 d8             	lea    -0x28(%ebp),%eax
    21d2:	68 cd 00 00 00       	push   $0xcd
    21d7:	6a 74                	push   $0x74
    21d9:	6a 18                	push   $0x18
    21db:	50                   	push   %eax
    21dc:	e8 5a f4 ff ff       	call   163b <RGB>
    21e1:	83 c4 0c             	add    $0xc,%esp
    21e4:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    21e8:	66 89 45 f0          	mov    %ax,-0x10(%ebp)
    21ec:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    21f0:	88 45 f2             	mov    %al,-0xe(%ebp)
    pen.size = 1;
    21f3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    21fa:	8d 45 d8             	lea    -0x28(%ebp),%eax
    21fd:	68 cd 00 00 00       	push   $0xcd
    2202:	6a 74                	push   $0x74
    2204:	6a 18                	push   $0x18
    2206:	50                   	push   %eax
    2207:	e8 2f f4 ff ff       	call   163b <RGB>
    220c:	83 c4 0c             	add    $0xc,%esp
    220f:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2213:	66 89 45 ed          	mov    %ax,-0x13(%ebp)
    2217:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    221b:	88 45 ef             	mov    %al,-0x11(%ebp)
    APSetPen(&hwnd->TitleDc,pen);
    221e:	8b 45 08             	mov    0x8(%ebp),%eax
    2221:	8d 50 58             	lea    0x58(%eax),%edx
    2224:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2227:	ff 75 f4             	pushl  -0xc(%ebp)
    222a:	ff 75 f0             	pushl  -0x10(%ebp)
    222d:	52                   	push   %edx
    222e:	50                   	push   %eax
    222f:	e8 f4 ea ff ff       	call   d28 <APSetPen>
    2234:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&hwnd->TitleDc,brush);
    2237:	8b 45 08             	mov    0x8(%ebp),%eax
    223a:	8d 58 58             	lea    0x58(%eax),%ebx
    223d:	8d 55 d8             	lea    -0x28(%ebp),%edx
    2240:	83 ec 04             	sub    $0x4,%esp
    2243:	83 ec 04             	sub    $0x4,%esp
    2246:	89 e0                	mov    %esp,%eax
    2248:	0f b7 4d ed          	movzwl -0x13(%ebp),%ecx
    224c:	66 89 08             	mov    %cx,(%eax)
    224f:	0f b6 4d ef          	movzbl -0x11(%ebp),%ecx
    2253:	88 48 02             	mov    %cl,0x2(%eax)
    2256:	53                   	push   %ebx
    2257:	52                   	push   %edx
    2258:	e8 04 eb ff ff       	call   d61 <APSetBrush>
    225d:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&hwnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2260:	8b 45 08             	mov    0x8(%ebp),%eax
    2263:	83 c0 58             	add    $0x58,%eax
    2266:	83 ec 0c             	sub    $0xc,%esp
    2269:	6a 32                	push   $0x32
    226b:	68 20 03 00 00       	push   $0x320
    2270:	6a 00                	push   $0x0
    2272:	6a 00                	push   $0x0
    2274:	50                   	push   %eax
    2275:	e8 11 ef ff ff       	call   118b <APDrawRect>
    227a:	83 c4 20             	add    $0x20,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    227d:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2280:	6a 08                	push   $0x8
    2282:	6a 08                	push   $0x8
    2284:	6a 08                	push   $0x8
    2286:	50                   	push   %eax
    2287:	e8 af f3 ff ff       	call   163b <RGB>
    228c:	83 c4 0c             	add    $0xc,%esp
    228f:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2293:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    2297:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    229b:	88 45 ec             	mov    %al,-0x14(%ebp)
    APSetFont(&hwnd->TitleDc,font);
    229e:	8b 45 08             	mov    0x8(%ebp),%eax
    22a1:	8d 58 58             	lea    0x58(%eax),%ebx
    22a4:	8d 55 d8             	lea    -0x28(%ebp),%edx
    22a7:	83 ec 04             	sub    $0x4,%esp
    22aa:	83 ec 04             	sub    $0x4,%esp
    22ad:	89 e0                	mov    %esp,%eax
    22af:	0f b7 4d ea          	movzwl -0x16(%ebp),%ecx
    22b3:	66 89 08             	mov    %cx,(%eax)
    22b6:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
    22ba:	88 48 02             	mov    %cl,0x2(%eax)
    22bd:	53                   	push   %ebx
    22be:	52                   	push   %edx
    22bf:	e8 df ea ff ff       	call   da3 <APSetFont>
    22c4:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&hwnd->TitleDc,str,10,20);
    22c7:	8b 45 08             	mov    0x8(%ebp),%eax
    22ca:	83 c0 58             	add    $0x58,%eax
    22cd:	6a 14                	push   $0x14
    22cf:	6a 0a                	push   $0xa
    22d1:	ff 75 0c             	pushl  0xc(%ebp)
    22d4:	50                   	push   %eax
    22d5:	e8 b6 f0 ff ff       	call   1390 <APDrawText>
    22da:	83 c4 10             	add    $0x10,%esp
}
    22dd:	90                   	nop
    22de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    22e1:	c9                   	leave  
    22e2:	c3                   	ret    

000022e3 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    22e3:	55                   	push   %ebp
    22e4:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    22e6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    22ea:	7e 08                	jle    22f4 <random+0x11>
{
rand_num = seed;
    22ec:	8b 45 08             	mov    0x8(%ebp),%eax
    22ef:	a3 40 6a 00 00       	mov    %eax,0x6a40
}
rand_num *= 3;
    22f4:	8b 15 40 6a 00 00    	mov    0x6a40,%edx
    22fa:	89 d0                	mov    %edx,%eax
    22fc:	01 c0                	add    %eax,%eax
    22fe:	01 d0                	add    %edx,%eax
    2300:	a3 40 6a 00 00       	mov    %eax,0x6a40
if (rand_num < 0)
    2305:	a1 40 6a 00 00       	mov    0x6a40,%eax
    230a:	85 c0                	test   %eax,%eax
    230c:	79 0c                	jns    231a <random+0x37>
{
rand_num *= (-1);
    230e:	a1 40 6a 00 00       	mov    0x6a40,%eax
    2313:	f7 d8                	neg    %eax
    2315:	a3 40 6a 00 00       	mov    %eax,0x6a40
}
return rand_num % 997;
    231a:	8b 0d 40 6a 00 00    	mov    0x6a40,%ecx
    2320:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2325:	89 c8                	mov    %ecx,%eax
    2327:	f7 ea                	imul   %edx
    2329:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    232c:	c1 f8 09             	sar    $0x9,%eax
    232f:	89 c2                	mov    %eax,%edx
    2331:	89 c8                	mov    %ecx,%eax
    2333:	c1 f8 1f             	sar    $0x1f,%eax
    2336:	29 c2                	sub    %eax,%edx
    2338:	89 d0                	mov    %edx,%eax
    233a:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2340:	29 c1                	sub    %eax,%ecx
    2342:	89 c8                	mov    %ecx,%eax
}
    2344:	5d                   	pop    %ebp
    2345:	c3                   	ret    

00002346 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2346:	55                   	push   %ebp
    2347:	89 e5                	mov    %esp,%ebp
    2349:	53                   	push   %ebx
    234a:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    234d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2354:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2358:	74 17                	je     2371 <sprintint+0x2b>
    235a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    235e:	79 11                	jns    2371 <sprintint+0x2b>
        neg = 1;
    2360:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2367:	8b 45 10             	mov    0x10(%ebp),%eax
    236a:	f7 d8                	neg    %eax
    236c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    236f:	eb 06                	jmp    2377 <sprintint+0x31>
    } else {
        x = xx;
    2371:	8b 45 10             	mov    0x10(%ebp),%eax
    2374:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2377:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    237e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2381:	8d 41 01             	lea    0x1(%ecx),%eax
    2384:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2387:	8b 5d 14             	mov    0x14(%ebp),%ebx
    238a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    238d:	ba 00 00 00 00       	mov    $0x0,%edx
    2392:	f7 f3                	div    %ebx
    2394:	89 d0                	mov    %edx,%eax
    2396:	0f b6 80 44 6a 00 00 	movzbl 0x6a44(%eax),%eax
    239d:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    23a1:	8b 5d 14             	mov    0x14(%ebp),%ebx
    23a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23a7:	ba 00 00 00 00       	mov    $0x0,%edx
    23ac:	f7 f3                	div    %ebx
    23ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
    23b1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    23b5:	75 c7                	jne    237e <sprintint+0x38>
    if(neg)
    23b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    23bb:	74 0e                	je     23cb <sprintint+0x85>
        buf[i++] = '-';
    23bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    23c0:	8d 50 01             	lea    0x1(%eax),%edx
    23c3:	89 55 f8             	mov    %edx,-0x8(%ebp)
    23c6:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    23cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    23ce:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    23d1:	eb 1b                	jmp    23ee <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    23d3:	8b 45 0c             	mov    0xc(%ebp),%eax
    23d6:	8b 00                	mov    (%eax),%eax
    23d8:	8d 48 01             	lea    0x1(%eax),%ecx
    23db:	8b 55 0c             	mov    0xc(%ebp),%edx
    23de:	89 0a                	mov    %ecx,(%edx)
    23e0:	89 c2                	mov    %eax,%edx
    23e2:	8b 45 08             	mov    0x8(%ebp),%eax
    23e5:	01 d0                	add    %edx,%eax
    23e7:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    23ea:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    23ee:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    23f2:	7f df                	jg     23d3 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    23f4:	eb 21                	jmp    2417 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    23f6:	8b 45 0c             	mov    0xc(%ebp),%eax
    23f9:	8b 00                	mov    (%eax),%eax
    23fb:	8d 48 01             	lea    0x1(%eax),%ecx
    23fe:	8b 55 0c             	mov    0xc(%ebp),%edx
    2401:	89 0a                	mov    %ecx,(%edx)
    2403:	89 c2                	mov    %eax,%edx
    2405:	8b 45 08             	mov    0x8(%ebp),%eax
    2408:	01 c2                	add    %eax,%edx
    240a:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    240d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2410:	01 c8                	add    %ecx,%eax
    2412:	0f b6 00             	movzbl (%eax),%eax
    2415:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2417:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    241b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    241f:	79 d5                	jns    23f6 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2421:	90                   	nop
    2422:	83 c4 20             	add    $0x20,%esp
    2425:	5b                   	pop    %ebx
    2426:	5d                   	pop    %ebp
    2427:	c3                   	ret    

00002428 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2428:	55                   	push   %ebp
    2429:	89 e5                	mov    %esp,%ebp
    242b:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    242e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2435:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    243c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2443:	8d 45 0c             	lea    0xc(%ebp),%eax
    2446:	83 c0 04             	add    $0x4,%eax
    2449:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    244c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2453:	e9 d9 01 00 00       	jmp    2631 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2458:	8b 55 0c             	mov    0xc(%ebp),%edx
    245b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    245e:	01 d0                	add    %edx,%eax
    2460:	0f b6 00             	movzbl (%eax),%eax
    2463:	0f be c0             	movsbl %al,%eax
    2466:	25 ff 00 00 00       	and    $0xff,%eax
    246b:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    246e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2472:	75 2c                	jne    24a0 <sprintf+0x78>
            if(c == '%'){
    2474:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2478:	75 0c                	jne    2486 <sprintf+0x5e>
                state = '%';
    247a:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2481:	e9 a7 01 00 00       	jmp    262d <sprintf+0x205>
            } else {
                dst[j++] = c;
    2486:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2489:	8d 50 01             	lea    0x1(%eax),%edx
    248c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    248f:	89 c2                	mov    %eax,%edx
    2491:	8b 45 08             	mov    0x8(%ebp),%eax
    2494:	01 d0                	add    %edx,%eax
    2496:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2499:	88 10                	mov    %dl,(%eax)
    249b:	e9 8d 01 00 00       	jmp    262d <sprintf+0x205>
            }
        } else if(state == '%'){
    24a0:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    24a4:	0f 85 83 01 00 00    	jne    262d <sprintf+0x205>
            if(c == 'd'){
    24aa:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    24ae:	75 4c                	jne    24fc <sprintf+0xd4>
                buf[bi] = '\0';
    24b0:	8d 55 ce             	lea    -0x32(%ebp),%edx
    24b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24b6:	01 d0                	add    %edx,%eax
    24b8:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    24bb:	83 ec 0c             	sub    $0xc,%esp
    24be:	8d 45 ce             	lea    -0x32(%ebp),%eax
    24c1:	50                   	push   %eax
    24c2:	e8 bb de ff ff       	call   382 <atoi>
    24c7:	83 c4 10             	add    $0x10,%esp
    24ca:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    24cd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    24d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24d7:	8b 00                	mov    (%eax),%eax
    24d9:	83 ec 08             	sub    $0x8,%esp
    24dc:	ff 75 d8             	pushl  -0x28(%ebp)
    24df:	6a 01                	push   $0x1
    24e1:	6a 0a                	push   $0xa
    24e3:	50                   	push   %eax
    24e4:	8d 45 c8             	lea    -0x38(%ebp),%eax
    24e7:	50                   	push   %eax
    24e8:	ff 75 08             	pushl  0x8(%ebp)
    24eb:	e8 56 fe ff ff       	call   2346 <sprintint>
    24f0:	83 c4 20             	add    $0x20,%esp
                ap++;
    24f3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    24f7:	e9 2a 01 00 00       	jmp    2626 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    24fc:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2500:	74 06                	je     2508 <sprintf+0xe0>
    2502:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2506:	75 4c                	jne    2554 <sprintf+0x12c>
                buf[bi] = '\0';
    2508:	8d 55 ce             	lea    -0x32(%ebp),%edx
    250b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    250e:	01 d0                	add    %edx,%eax
    2510:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2513:	83 ec 0c             	sub    $0xc,%esp
    2516:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2519:	50                   	push   %eax
    251a:	e8 63 de ff ff       	call   382 <atoi>
    251f:	83 c4 10             	add    $0x10,%esp
    2522:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2525:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    252c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    252f:	8b 00                	mov    (%eax),%eax
    2531:	83 ec 08             	sub    $0x8,%esp
    2534:	ff 75 dc             	pushl  -0x24(%ebp)
    2537:	6a 00                	push   $0x0
    2539:	6a 10                	push   $0x10
    253b:	50                   	push   %eax
    253c:	8d 45 c8             	lea    -0x38(%ebp),%eax
    253f:	50                   	push   %eax
    2540:	ff 75 08             	pushl  0x8(%ebp)
    2543:	e8 fe fd ff ff       	call   2346 <sprintint>
    2548:	83 c4 20             	add    $0x20,%esp
                ap++;
    254b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    254f:	e9 d2 00 00 00       	jmp    2626 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2554:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2558:	75 46                	jne    25a0 <sprintf+0x178>
                s = (char*)*ap;
    255a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    255d:	8b 00                	mov    (%eax),%eax
    255f:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2562:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2566:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    256a:	75 25                	jne    2591 <sprintf+0x169>
                    s = "(null)";
    256c:	c7 45 f4 24 28 00 00 	movl   $0x2824,-0xc(%ebp)
                while(*s != 0){
    2573:	eb 1c                	jmp    2591 <sprintf+0x169>
                    dst[j++] = *s;
    2575:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2578:	8d 50 01             	lea    0x1(%eax),%edx
    257b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    257e:	89 c2                	mov    %eax,%edx
    2580:	8b 45 08             	mov    0x8(%ebp),%eax
    2583:	01 c2                	add    %eax,%edx
    2585:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2588:	0f b6 00             	movzbl (%eax),%eax
    258b:	88 02                	mov    %al,(%edx)
                    s++;
    258d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2591:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2594:	0f b6 00             	movzbl (%eax),%eax
    2597:	84 c0                	test   %al,%al
    2599:	75 da                	jne    2575 <sprintf+0x14d>
    259b:	e9 86 00 00 00       	jmp    2626 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    25a0:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    25a4:	75 1d                	jne    25c3 <sprintf+0x19b>
                dst[j++] = *ap;
    25a6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    25a9:	8d 50 01             	lea    0x1(%eax),%edx
    25ac:	89 55 c8             	mov    %edx,-0x38(%ebp)
    25af:	89 c2                	mov    %eax,%edx
    25b1:	8b 45 08             	mov    0x8(%ebp),%eax
    25b4:	01 c2                	add    %eax,%edx
    25b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    25b9:	8b 00                	mov    (%eax),%eax
    25bb:	88 02                	mov    %al,(%edx)
                ap++;
    25bd:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    25c1:	eb 63                	jmp    2626 <sprintf+0x1fe>
            } else if(c == '%'){
    25c3:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    25c7:	75 17                	jne    25e0 <sprintf+0x1b8>
                dst[j++] = c;
    25c9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    25cc:	8d 50 01             	lea    0x1(%eax),%edx
    25cf:	89 55 c8             	mov    %edx,-0x38(%ebp)
    25d2:	89 c2                	mov    %eax,%edx
    25d4:	8b 45 08             	mov    0x8(%ebp),%eax
    25d7:	01 d0                	add    %edx,%eax
    25d9:	8b 55 e0             	mov    -0x20(%ebp),%edx
    25dc:	88 10                	mov    %dl,(%eax)
    25de:	eb 46                	jmp    2626 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    25e0:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    25e4:	7e 18                	jle    25fe <sprintf+0x1d6>
    25e6:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    25ea:	7f 12                	jg     25fe <sprintf+0x1d6>
            {
                buf[bi++] = c;
    25ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
    25ef:	8d 50 01             	lea    0x1(%eax),%edx
    25f2:	89 55 f0             	mov    %edx,-0x10(%ebp)
    25f5:	8b 55 e0             	mov    -0x20(%ebp),%edx
    25f8:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    25fc:	eb 2f                	jmp    262d <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    25fe:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2601:	8d 50 01             	lea    0x1(%eax),%edx
    2604:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2607:	89 c2                	mov    %eax,%edx
    2609:	8b 45 08             	mov    0x8(%ebp),%eax
    260c:	01 d0                	add    %edx,%eax
    260e:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2611:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2614:	8d 50 01             	lea    0x1(%eax),%edx
    2617:	89 55 c8             	mov    %edx,-0x38(%ebp)
    261a:	89 c2                	mov    %eax,%edx
    261c:	8b 45 08             	mov    0x8(%ebp),%eax
    261f:	01 d0                	add    %edx,%eax
    2621:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2624:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2626:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    262d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2631:	8b 55 0c             	mov    0xc(%ebp),%edx
    2634:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2637:	01 d0                	add    %edx,%eax
    2639:	0f b6 00             	movzbl (%eax),%eax
    263c:	84 c0                	test   %al,%al
    263e:	0f 85 14 fe ff ff    	jne    2458 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2644:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2647:	8d 50 01             	lea    0x1(%eax),%edx
    264a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    264d:	89 c2                	mov    %eax,%edx
    264f:	8b 45 08             	mov    0x8(%ebp),%eax
    2652:	01 d0                	add    %edx,%eax
    2654:	c6 00 00             	movb   $0x0,(%eax)
}
    2657:	90                   	nop
    2658:	c9                   	leave  
    2659:	c3                   	ret    
