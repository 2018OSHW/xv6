
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
      32:	05 20 27 00 00       	add    $0x2720,%eax
      37:	0f b6 00             	movzbl (%eax),%eax
      3a:	3c 0a                	cmp    $0xa,%al
      3c:	75 04                	jne    42 <wc+0x42>
        l++;
      3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
      42:	8b 45 f4             	mov    -0xc(%ebp),%eax
      45:	05 20 27 00 00       	add    $0x2720,%eax
      4a:	0f b6 00             	movzbl (%eax),%eax
      4d:	0f be c0             	movsbl %al,%eax
      50:	83 ec 08             	sub    $0x8,%esp
      53:	50                   	push   %eax
      54:	68 f8 1f 00 00       	push   $0x1ff8
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
      93:	68 20 27 00 00       	push   $0x2720
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
      b9:	68 fe 1f 00 00       	push   $0x1ffe
      be:	6a 01                	push   $0x1
      c0:	e8 ee 04 00 00       	call   5b3 <printf>
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
      dc:	68 0e 20 00 00       	push   $0x200e
      e1:	6a 01                	push   $0x1
      e3:	e8 cb 04 00 00       	call   5b3 <printf>
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
     10a:	68 1b 20 00 00       	push   $0x201b
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
     167:	68 1c 20 00 00       	push   $0x201c
     16c:	6a 01                	push   $0x1
     16e:	e8 40 04 00 00       	call   5b3 <printf>
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

000004bc <initStringFigure>:
SYSCALL(initStringFigure)
     4bc:	b8 17 00 00 00       	mov    $0x17,%eax
     4c1:	cd 40                	int    $0x40
     4c3:	c3                   	ret    

000004c4 <sendMessage>:
SYSCALL(sendMessage)
     4c4:	b8 18 00 00 00       	mov    $0x18,%eax
     4c9:	cd 40                	int    $0x40
     4cb:	c3                   	ret    

000004cc <getMessage>:
SYSCALL(getMessage)
     4cc:	b8 1a 00 00 00       	mov    $0x1a,%eax
     4d1:	cd 40                	int    $0x40
     4d3:	c3                   	ret    

000004d4 <registWindow>:
SYSCALL(registWindow)
     4d4:	b8 19 00 00 00       	mov    $0x19,%eax
     4d9:	cd 40                	int    $0x40
     4db:	c3                   	ret    

000004dc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     4dc:	55                   	push   %ebp
     4dd:	89 e5                	mov    %esp,%ebp
     4df:	83 ec 18             	sub    $0x18,%esp
     4e2:	8b 45 0c             	mov    0xc(%ebp),%eax
     4e5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     4e8:	83 ec 04             	sub    $0x4,%esp
     4eb:	6a 01                	push   $0x1
     4ed:	8d 45 f4             	lea    -0xc(%ebp),%eax
     4f0:	50                   	push   %eax
     4f1:	ff 75 08             	pushl  0x8(%ebp)
     4f4:	e8 3b ff ff ff       	call   434 <write>
     4f9:	83 c4 10             	add    $0x10,%esp
}
     4fc:	90                   	nop
     4fd:	c9                   	leave  
     4fe:	c3                   	ret    

000004ff <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     4ff:	55                   	push   %ebp
     500:	89 e5                	mov    %esp,%ebp
     502:	53                   	push   %ebx
     503:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     506:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     50d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     511:	74 17                	je     52a <printint+0x2b>
     513:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     517:	79 11                	jns    52a <printint+0x2b>
    neg = 1;
     519:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     520:	8b 45 0c             	mov    0xc(%ebp),%eax
     523:	f7 d8                	neg    %eax
     525:	89 45 ec             	mov    %eax,-0x14(%ebp)
     528:	eb 06                	jmp    530 <printint+0x31>
  } else {
    x = xx;
     52a:	8b 45 0c             	mov    0xc(%ebp),%eax
     52d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     530:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     537:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     53a:	8d 41 01             	lea    0x1(%ecx),%eax
     53d:	89 45 f4             	mov    %eax,-0xc(%ebp)
     540:	8b 5d 10             	mov    0x10(%ebp),%ebx
     543:	8b 45 ec             	mov    -0x14(%ebp),%eax
     546:	ba 00 00 00 00       	mov    $0x0,%edx
     54b:	f7 f3                	div    %ebx
     54d:	89 d0                	mov    %edx,%eax
     54f:	0f b6 80 c0 26 00 00 	movzbl 0x26c0(%eax),%eax
     556:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     55a:	8b 5d 10             	mov    0x10(%ebp),%ebx
     55d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     560:	ba 00 00 00 00       	mov    $0x0,%edx
     565:	f7 f3                	div    %ebx
     567:	89 45 ec             	mov    %eax,-0x14(%ebp)
     56a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     56e:	75 c7                	jne    537 <printint+0x38>
  if(neg)
     570:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     574:	74 2d                	je     5a3 <printint+0xa4>
    buf[i++] = '-';
     576:	8b 45 f4             	mov    -0xc(%ebp),%eax
     579:	8d 50 01             	lea    0x1(%eax),%edx
     57c:	89 55 f4             	mov    %edx,-0xc(%ebp)
     57f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     584:	eb 1d                	jmp    5a3 <printint+0xa4>
    putc(fd, buf[i]);
     586:	8d 55 dc             	lea    -0x24(%ebp),%edx
     589:	8b 45 f4             	mov    -0xc(%ebp),%eax
     58c:	01 d0                	add    %edx,%eax
     58e:	0f b6 00             	movzbl (%eax),%eax
     591:	0f be c0             	movsbl %al,%eax
     594:	83 ec 08             	sub    $0x8,%esp
     597:	50                   	push   %eax
     598:	ff 75 08             	pushl  0x8(%ebp)
     59b:	e8 3c ff ff ff       	call   4dc <putc>
     5a0:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     5a3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     5a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5ab:	79 d9                	jns    586 <printint+0x87>
    putc(fd, buf[i]);
}
     5ad:	90                   	nop
     5ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5b1:	c9                   	leave  
     5b2:	c3                   	ret    

000005b3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     5b3:	55                   	push   %ebp
     5b4:	89 e5                	mov    %esp,%ebp
     5b6:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     5b9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     5c0:	8d 45 0c             	lea    0xc(%ebp),%eax
     5c3:	83 c0 04             	add    $0x4,%eax
     5c6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     5c9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     5d0:	e9 59 01 00 00       	jmp    72e <printf+0x17b>
    c = fmt[i] & 0xff;
     5d5:	8b 55 0c             	mov    0xc(%ebp),%edx
     5d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5db:	01 d0                	add    %edx,%eax
     5dd:	0f b6 00             	movzbl (%eax),%eax
     5e0:	0f be c0             	movsbl %al,%eax
     5e3:	25 ff 00 00 00       	and    $0xff,%eax
     5e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     5eb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     5ef:	75 2c                	jne    61d <printf+0x6a>
      if(c == '%'){
     5f1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5f5:	75 0c                	jne    603 <printf+0x50>
        state = '%';
     5f7:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     5fe:	e9 27 01 00 00       	jmp    72a <printf+0x177>
      } else {
        putc(fd, c);
     603:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     606:	0f be c0             	movsbl %al,%eax
     609:	83 ec 08             	sub    $0x8,%esp
     60c:	50                   	push   %eax
     60d:	ff 75 08             	pushl  0x8(%ebp)
     610:	e8 c7 fe ff ff       	call   4dc <putc>
     615:	83 c4 10             	add    $0x10,%esp
     618:	e9 0d 01 00 00       	jmp    72a <printf+0x177>
      }
    } else if(state == '%'){
     61d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     621:	0f 85 03 01 00 00    	jne    72a <printf+0x177>
      if(c == 'd'){
     627:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     62b:	75 1e                	jne    64b <printf+0x98>
        printint(fd, *ap, 10, 1);
     62d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     630:	8b 00                	mov    (%eax),%eax
     632:	6a 01                	push   $0x1
     634:	6a 0a                	push   $0xa
     636:	50                   	push   %eax
     637:	ff 75 08             	pushl  0x8(%ebp)
     63a:	e8 c0 fe ff ff       	call   4ff <printint>
     63f:	83 c4 10             	add    $0x10,%esp
        ap++;
     642:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     646:	e9 d8 00 00 00       	jmp    723 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     64b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     64f:	74 06                	je     657 <printf+0xa4>
     651:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     655:	75 1e                	jne    675 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     657:	8b 45 e8             	mov    -0x18(%ebp),%eax
     65a:	8b 00                	mov    (%eax),%eax
     65c:	6a 00                	push   $0x0
     65e:	6a 10                	push   $0x10
     660:	50                   	push   %eax
     661:	ff 75 08             	pushl  0x8(%ebp)
     664:	e8 96 fe ff ff       	call   4ff <printint>
     669:	83 c4 10             	add    $0x10,%esp
        ap++;
     66c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     670:	e9 ae 00 00 00       	jmp    723 <printf+0x170>
      } else if(c == 's'){
     675:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     679:	75 43                	jne    6be <printf+0x10b>
        s = (char*)*ap;
     67b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     67e:	8b 00                	mov    (%eax),%eax
     680:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     683:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     687:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     68b:	75 25                	jne    6b2 <printf+0xff>
          s = "(null)";
     68d:	c7 45 f4 30 20 00 00 	movl   $0x2030,-0xc(%ebp)
        while(*s != 0){
     694:	eb 1c                	jmp    6b2 <printf+0xff>
          putc(fd, *s);
     696:	8b 45 f4             	mov    -0xc(%ebp),%eax
     699:	0f b6 00             	movzbl (%eax),%eax
     69c:	0f be c0             	movsbl %al,%eax
     69f:	83 ec 08             	sub    $0x8,%esp
     6a2:	50                   	push   %eax
     6a3:	ff 75 08             	pushl  0x8(%ebp)
     6a6:	e8 31 fe ff ff       	call   4dc <putc>
     6ab:	83 c4 10             	add    $0x10,%esp
          s++;
     6ae:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     6b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6b5:	0f b6 00             	movzbl (%eax),%eax
     6b8:	84 c0                	test   %al,%al
     6ba:	75 da                	jne    696 <printf+0xe3>
     6bc:	eb 65                	jmp    723 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     6be:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     6c2:	75 1d                	jne    6e1 <printf+0x12e>
        putc(fd, *ap);
     6c4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6c7:	8b 00                	mov    (%eax),%eax
     6c9:	0f be c0             	movsbl %al,%eax
     6cc:	83 ec 08             	sub    $0x8,%esp
     6cf:	50                   	push   %eax
     6d0:	ff 75 08             	pushl  0x8(%ebp)
     6d3:	e8 04 fe ff ff       	call   4dc <putc>
     6d8:	83 c4 10             	add    $0x10,%esp
        ap++;
     6db:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     6df:	eb 42                	jmp    723 <printf+0x170>
      } else if(c == '%'){
     6e1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     6e5:	75 17                	jne    6fe <printf+0x14b>
        putc(fd, c);
     6e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6ea:	0f be c0             	movsbl %al,%eax
     6ed:	83 ec 08             	sub    $0x8,%esp
     6f0:	50                   	push   %eax
     6f1:	ff 75 08             	pushl  0x8(%ebp)
     6f4:	e8 e3 fd ff ff       	call   4dc <putc>
     6f9:	83 c4 10             	add    $0x10,%esp
     6fc:	eb 25                	jmp    723 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     6fe:	83 ec 08             	sub    $0x8,%esp
     701:	6a 25                	push   $0x25
     703:	ff 75 08             	pushl  0x8(%ebp)
     706:	e8 d1 fd ff ff       	call   4dc <putc>
     70b:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     70e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     711:	0f be c0             	movsbl %al,%eax
     714:	83 ec 08             	sub    $0x8,%esp
     717:	50                   	push   %eax
     718:	ff 75 08             	pushl  0x8(%ebp)
     71b:	e8 bc fd ff ff       	call   4dc <putc>
     720:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     723:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     72a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     72e:	8b 55 0c             	mov    0xc(%ebp),%edx
     731:	8b 45 f0             	mov    -0x10(%ebp),%eax
     734:	01 d0                	add    %edx,%eax
     736:	0f b6 00             	movzbl (%eax),%eax
     739:	84 c0                	test   %al,%al
     73b:	0f 85 94 fe ff ff    	jne    5d5 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     741:	90                   	nop
     742:	c9                   	leave  
     743:	c3                   	ret    

00000744 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     744:	55                   	push   %ebp
     745:	89 e5                	mov    %esp,%ebp
     747:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     74a:	8b 45 08             	mov    0x8(%ebp),%eax
     74d:	83 e8 08             	sub    $0x8,%eax
     750:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     753:	a1 08 27 00 00       	mov    0x2708,%eax
     758:	89 45 fc             	mov    %eax,-0x4(%ebp)
     75b:	eb 24                	jmp    781 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     75d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     760:	8b 00                	mov    (%eax),%eax
     762:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     765:	77 12                	ja     779 <free+0x35>
     767:	8b 45 f8             	mov    -0x8(%ebp),%eax
     76a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     76d:	77 24                	ja     793 <free+0x4f>
     76f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     772:	8b 00                	mov    (%eax),%eax
     774:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     777:	77 1a                	ja     793 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     779:	8b 45 fc             	mov    -0x4(%ebp),%eax
     77c:	8b 00                	mov    (%eax),%eax
     77e:	89 45 fc             	mov    %eax,-0x4(%ebp)
     781:	8b 45 f8             	mov    -0x8(%ebp),%eax
     784:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     787:	76 d4                	jbe    75d <free+0x19>
     789:	8b 45 fc             	mov    -0x4(%ebp),%eax
     78c:	8b 00                	mov    (%eax),%eax
     78e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     791:	76 ca                	jbe    75d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     793:	8b 45 f8             	mov    -0x8(%ebp),%eax
     796:	8b 40 04             	mov    0x4(%eax),%eax
     799:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     7a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7a3:	01 c2                	add    %eax,%edx
     7a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7a8:	8b 00                	mov    (%eax),%eax
     7aa:	39 c2                	cmp    %eax,%edx
     7ac:	75 24                	jne    7d2 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     7ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7b1:	8b 50 04             	mov    0x4(%eax),%edx
     7b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7b7:	8b 00                	mov    (%eax),%eax
     7b9:	8b 40 04             	mov    0x4(%eax),%eax
     7bc:	01 c2                	add    %eax,%edx
     7be:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7c1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     7c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7c7:	8b 00                	mov    (%eax),%eax
     7c9:	8b 10                	mov    (%eax),%edx
     7cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7ce:	89 10                	mov    %edx,(%eax)
     7d0:	eb 0a                	jmp    7dc <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     7d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7d5:	8b 10                	mov    (%eax),%edx
     7d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7da:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     7dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7df:	8b 40 04             	mov    0x4(%eax),%eax
     7e2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     7e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7ec:	01 d0                	add    %edx,%eax
     7ee:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     7f1:	75 20                	jne    813 <free+0xcf>
    p->s.size += bp->s.size;
     7f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7f6:	8b 50 04             	mov    0x4(%eax),%edx
     7f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7fc:	8b 40 04             	mov    0x4(%eax),%eax
     7ff:	01 c2                	add    %eax,%edx
     801:	8b 45 fc             	mov    -0x4(%ebp),%eax
     804:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     807:	8b 45 f8             	mov    -0x8(%ebp),%eax
     80a:	8b 10                	mov    (%eax),%edx
     80c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     80f:	89 10                	mov    %edx,(%eax)
     811:	eb 08                	jmp    81b <free+0xd7>
  } else
    p->s.ptr = bp;
     813:	8b 45 fc             	mov    -0x4(%ebp),%eax
     816:	8b 55 f8             	mov    -0x8(%ebp),%edx
     819:	89 10                	mov    %edx,(%eax)
  freep = p;
     81b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     81e:	a3 08 27 00 00       	mov    %eax,0x2708
}
     823:	90                   	nop
     824:	c9                   	leave  
     825:	c3                   	ret    

00000826 <morecore>:

static Header*
morecore(uint nu)
{
     826:	55                   	push   %ebp
     827:	89 e5                	mov    %esp,%ebp
     829:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     82c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     833:	77 07                	ja     83c <morecore+0x16>
    nu = 4096;
     835:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     83c:	8b 45 08             	mov    0x8(%ebp),%eax
     83f:	c1 e0 03             	shl    $0x3,%eax
     842:	83 ec 0c             	sub    $0xc,%esp
     845:	50                   	push   %eax
     846:	e8 51 fc ff ff       	call   49c <sbrk>
     84b:	83 c4 10             	add    $0x10,%esp
     84e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     851:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     855:	75 07                	jne    85e <morecore+0x38>
    return 0;
     857:	b8 00 00 00 00       	mov    $0x0,%eax
     85c:	eb 26                	jmp    884 <morecore+0x5e>
  hp = (Header*)p;
     85e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     861:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     864:	8b 45 f0             	mov    -0x10(%ebp),%eax
     867:	8b 55 08             	mov    0x8(%ebp),%edx
     86a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     86d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     870:	83 c0 08             	add    $0x8,%eax
     873:	83 ec 0c             	sub    $0xc,%esp
     876:	50                   	push   %eax
     877:	e8 c8 fe ff ff       	call   744 <free>
     87c:	83 c4 10             	add    $0x10,%esp
  return freep;
     87f:	a1 08 27 00 00       	mov    0x2708,%eax
}
     884:	c9                   	leave  
     885:	c3                   	ret    

00000886 <malloc>:

void*
malloc(uint nbytes)
{
     886:	55                   	push   %ebp
     887:	89 e5                	mov    %esp,%ebp
     889:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     88c:	8b 45 08             	mov    0x8(%ebp),%eax
     88f:	83 c0 07             	add    $0x7,%eax
     892:	c1 e8 03             	shr    $0x3,%eax
     895:	83 c0 01             	add    $0x1,%eax
     898:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     89b:	a1 08 27 00 00       	mov    0x2708,%eax
     8a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8a3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8a7:	75 23                	jne    8cc <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     8a9:	c7 45 f0 00 27 00 00 	movl   $0x2700,-0x10(%ebp)
     8b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8b3:	a3 08 27 00 00       	mov    %eax,0x2708
     8b8:	a1 08 27 00 00       	mov    0x2708,%eax
     8bd:	a3 00 27 00 00       	mov    %eax,0x2700
    base.s.size = 0;
     8c2:	c7 05 04 27 00 00 00 	movl   $0x0,0x2704
     8c9:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8cf:	8b 00                	mov    (%eax),%eax
     8d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     8d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d7:	8b 40 04             	mov    0x4(%eax),%eax
     8da:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     8dd:	72 4d                	jb     92c <malloc+0xa6>
      if(p->s.size == nunits)
     8df:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8e2:	8b 40 04             	mov    0x4(%eax),%eax
     8e5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     8e8:	75 0c                	jne    8f6 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     8ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8ed:	8b 10                	mov    (%eax),%edx
     8ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8f2:	89 10                	mov    %edx,(%eax)
     8f4:	eb 26                	jmp    91c <malloc+0x96>
      else {
        p->s.size -= nunits;
     8f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f9:	8b 40 04             	mov    0x4(%eax),%eax
     8fc:	2b 45 ec             	sub    -0x14(%ebp),%eax
     8ff:	89 c2                	mov    %eax,%edx
     901:	8b 45 f4             	mov    -0xc(%ebp),%eax
     904:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     907:	8b 45 f4             	mov    -0xc(%ebp),%eax
     90a:	8b 40 04             	mov    0x4(%eax),%eax
     90d:	c1 e0 03             	shl    $0x3,%eax
     910:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     913:	8b 45 f4             	mov    -0xc(%ebp),%eax
     916:	8b 55 ec             	mov    -0x14(%ebp),%edx
     919:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     91c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     91f:	a3 08 27 00 00       	mov    %eax,0x2708
      return (void*)(p + 1);
     924:	8b 45 f4             	mov    -0xc(%ebp),%eax
     927:	83 c0 08             	add    $0x8,%eax
     92a:	eb 3b                	jmp    967 <malloc+0xe1>
    }
    if(p == freep)
     92c:	a1 08 27 00 00       	mov    0x2708,%eax
     931:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     934:	75 1e                	jne    954 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     936:	83 ec 0c             	sub    $0xc,%esp
     939:	ff 75 ec             	pushl  -0x14(%ebp)
     93c:	e8 e5 fe ff ff       	call   826 <morecore>
     941:	83 c4 10             	add    $0x10,%esp
     944:	89 45 f4             	mov    %eax,-0xc(%ebp)
     947:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     94b:	75 07                	jne    954 <malloc+0xce>
        return 0;
     94d:	b8 00 00 00 00       	mov    $0x0,%eax
     952:	eb 13                	jmp    967 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     954:	8b 45 f4             	mov    -0xc(%ebp),%eax
     957:	89 45 f0             	mov    %eax,-0x10(%ebp)
     95a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     95d:	8b 00                	mov    (%eax),%eax
     95f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     962:	e9 6d ff ff ff       	jmp    8d4 <malloc+0x4e>
}
     967:	c9                   	leave  
     968:	c3                   	ret    

00000969 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     969:	55                   	push   %ebp
     96a:	89 e5                	mov    %esp,%ebp
     96c:	83 ec 1c             	sub    $0x1c,%esp
     96f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     972:	8b 55 10             	mov    0x10(%ebp),%edx
     975:	8b 45 14             	mov    0x14(%ebp),%eax
     978:	88 4d ec             	mov    %cl,-0x14(%ebp)
     97b:	88 55 e8             	mov    %dl,-0x18(%ebp)
     97e:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     981:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     985:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     988:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     98c:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     98f:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     993:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     996:	8b 45 08             	mov    0x8(%ebp),%eax
     999:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     99d:	66 89 10             	mov    %dx,(%eax)
     9a0:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     9a4:	88 50 02             	mov    %dl,0x2(%eax)
}
     9a7:	8b 45 08             	mov    0x8(%ebp),%eax
     9aa:	c9                   	leave  
     9ab:	c2 04 00             	ret    $0x4

000009ae <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     9ae:	55                   	push   %ebp
     9af:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     9b1:	8b 45 08             	mov    0x8(%ebp),%eax
     9b4:	2b 45 10             	sub    0x10(%ebp),%eax
     9b7:	89 c2                	mov    %eax,%edx
     9b9:	8b 45 08             	mov    0x8(%ebp),%eax
     9bc:	2b 45 10             	sub    0x10(%ebp),%eax
     9bf:	0f af d0             	imul   %eax,%edx
     9c2:	8b 45 0c             	mov    0xc(%ebp),%eax
     9c5:	2b 45 14             	sub    0x14(%ebp),%eax
     9c8:	89 c1                	mov    %eax,%ecx
     9ca:	8b 45 0c             	mov    0xc(%ebp),%eax
     9cd:	2b 45 14             	sub    0x14(%ebp),%eax
     9d0:	0f af c1             	imul   %ecx,%eax
     9d3:	01 d0                	add    %edx,%eax
}
     9d5:	5d                   	pop    %ebp
     9d6:	c3                   	ret    

000009d7 <abs_int>:

static inline int abs_int(int x)
{
     9d7:	55                   	push   %ebp
     9d8:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     9da:	8b 45 08             	mov    0x8(%ebp),%eax
     9dd:	99                   	cltd   
     9de:	89 d0                	mov    %edx,%eax
     9e0:	33 45 08             	xor    0x8(%ebp),%eax
     9e3:	29 d0                	sub    %edx,%eax
}
     9e5:	5d                   	pop    %ebp
     9e6:	c3                   	ret    

000009e7 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     9e7:	55                   	push   %ebp
     9e8:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     9ea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     9ee:	79 07                	jns    9f7 <APGetIndex+0x10>
        return X_SMALLER;
     9f0:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     9f5:	eb 40                	jmp    a37 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     9f7:	8b 45 08             	mov    0x8(%ebp),%eax
     9fa:	8b 00                	mov    (%eax),%eax
     9fc:	3b 45 0c             	cmp    0xc(%ebp),%eax
     9ff:	7f 07                	jg     a08 <APGetIndex+0x21>
        return X_BIGGER;
     a01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a06:	eb 2f                	jmp    a37 <APGetIndex+0x50>
    if (y < 0)
     a08:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     a0c:	79 07                	jns    a15 <APGetIndex+0x2e>
        return Y_SMALLER;
     a0e:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     a13:	eb 22                	jmp    a37 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     a15:	8b 45 08             	mov    0x8(%ebp),%eax
     a18:	8b 40 04             	mov    0x4(%eax),%eax
     a1b:	3b 45 10             	cmp    0x10(%ebp),%eax
     a1e:	7f 07                	jg     a27 <APGetIndex+0x40>
        return Y_BIGGER;
     a20:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     a25:	eb 10                	jmp    a37 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     a27:	8b 45 08             	mov    0x8(%ebp),%eax
     a2a:	8b 00                	mov    (%eax),%eax
     a2c:	0f af 45 10          	imul   0x10(%ebp),%eax
     a30:	89 c2                	mov    %eax,%edx
     a32:	8b 45 0c             	mov    0xc(%ebp),%eax
     a35:	01 d0                	add    %edx,%eax
}
     a37:	5d                   	pop    %ebp
     a38:	c3                   	ret    

00000a39 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     a39:	55                   	push   %ebp
     a3a:	89 e5                	mov    %esp,%ebp
     a3c:	56                   	push   %esi
     a3d:	53                   	push   %ebx
     a3e:	83 ec 70             	sub    $0x70,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     a41:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     a48:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a4b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     a4e:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     a55:	83 ec 08             	sub    $0x8,%esp
     a58:	6a 00                	push   $0x0
     a5a:	ff 75 0c             	pushl  0xc(%ebp)
     a5d:	e8 f2 f9 ff ff       	call   454 <open>
     a62:	83 c4 10             	add    $0x10,%esp
     a65:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     a68:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     a6c:	79 2e                	jns    a9c <APLoadBitmap+0x63>
    {
        printf(1, "Cannot open %s\n", filename);
     a6e:	83 ec 04             	sub    $0x4,%esp
     a71:	ff 75 0c             	pushl  0xc(%ebp)
     a74:	68 38 20 00 00       	push   $0x2038
     a79:	6a 01                	push   $0x1
     a7b:	e8 33 fb ff ff       	call   5b3 <printf>
     a80:	83 c4 10             	add    $0x10,%esp
        return bmp;
     a83:	8b 45 08             	mov    0x8(%ebp),%eax
     a86:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a89:	89 10                	mov    %edx,(%eax)
     a8b:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a8e:	89 50 04             	mov    %edx,0x4(%eax)
     a91:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a94:	89 50 08             	mov    %edx,0x8(%eax)
     a97:	e9 1b 02 00 00       	jmp    cb7 <APLoadBitmap+0x27e>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     a9c:	83 ec 04             	sub    $0x4,%esp
     a9f:	6a 10                	push   $0x10
     aa1:	8d 45 b8             	lea    -0x48(%ebp),%eax
     aa4:	50                   	push   %eax
     aa5:	ff 75 ec             	pushl  -0x14(%ebp)
     aa8:	e8 7f f9 ff ff       	call   42c <read>
     aad:	83 c4 10             	add    $0x10,%esp
    printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
     ab0:	0f b7 45 c2          	movzwl -0x3e(%ebp),%eax
     ab4:	0f b7 f0             	movzwl %ax,%esi
     ab7:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
     abb:	0f b7 d8             	movzwl %ax,%ebx
     abe:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
     ac1:	8b 55 bc             	mov    -0x44(%ebp),%edx
     ac4:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
     ac8:	0f b7 c0             	movzwl %ax,%eax
     acb:	83 ec 04             	sub    $0x4,%esp
     ace:	56                   	push   %esi
     acf:	53                   	push   %ebx
     ad0:	51                   	push   %ecx
     ad1:	52                   	push   %edx
     ad2:	50                   	push   %eax
     ad3:	68 48 20 00 00       	push   $0x2048
     ad8:	6a 01                	push   $0x1
     ada:	e8 d4 fa ff ff       	call   5b3 <printf>
     adf:	83 c4 20             	add    $0x20,%esp
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     ae2:	83 ec 04             	sub    $0x4,%esp
     ae5:	6a 28                	push   $0x28
     ae7:	8d 45 90             	lea    -0x70(%ebp),%eax
     aea:	50                   	push   %eax
     aeb:	ff 75 ec             	pushl  -0x14(%ebp)
     aee:	e8 39 f9 ff ff       	call   42c <read>
     af3:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     af6:	8b 45 94             	mov    -0x6c(%ebp),%eax
     af9:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     afc:	8b 45 98             	mov    -0x68(%ebp),%eax
     aff:	89 45 cc             	mov    %eax,-0x34(%ebp)
    printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
     b02:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b05:	8b 45 cc             	mov    -0x34(%ebp),%eax
     b08:	52                   	push   %edx
     b09:	50                   	push   %eax
     b0a:	68 58 20 00 00       	push   $0x2058
     b0f:	6a 01                	push   $0x1
     b11:	e8 9d fa ff ff       	call   5b3 <printf>
     b16:	83 c4 10             	add    $0x10,%esp
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     b19:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b1c:	8b 45 cc             	mov    -0x34(%ebp),%eax
     b1f:	0f af d0             	imul   %eax,%edx
     b22:	89 d0                	mov    %edx,%eax
     b24:	01 c0                	add    %eax,%eax
     b26:	01 d0                	add    %edx,%eax
     b28:	83 ec 0c             	sub    $0xc,%esp
     b2b:	50                   	push   %eax
     b2c:	e8 55 fd ff ff       	call   886 <malloc>
     b31:	83 c4 10             	add    $0x10,%esp
     b34:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     b37:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     b3b:	0f b7 c0             	movzwl %ax,%eax
     b3e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     b41:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b44:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b47:	0f af c2             	imul   %edx,%eax
     b4a:	83 c0 1f             	add    $0x1f,%eax
     b4d:	c1 e8 05             	shr    $0x5,%eax
     b50:	c1 e0 02             	shl    $0x2,%eax
     b53:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     b56:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b59:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b5c:	0f af c2             	imul   %edx,%eax
     b5f:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     b62:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b65:	83 ec 0c             	sub    $0xc,%esp
     b68:	50                   	push   %eax
     b69:	e8 18 fd ff ff       	call   886 <malloc>
     b6e:	83 c4 10             	add    $0x10,%esp
     b71:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     b74:	83 ec 04             	sub    $0x4,%esp
     b77:	ff 75 e0             	pushl  -0x20(%ebp)
     b7a:	ff 75 dc             	pushl  -0x24(%ebp)
     b7d:	ff 75 ec             	pushl  -0x14(%ebp)
     b80:	e8 a7 f8 ff ff       	call   42c <read>
     b85:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     b88:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     b8c:	66 c1 e8 03          	shr    $0x3,%ax
     b90:	0f b7 c0             	movzwl %ax,%eax
     b93:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     b96:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     b9d:	e9 e5 00 00 00       	jmp    c87 <APLoadBitmap+0x24e>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     ba2:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ba5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba8:	29 c2                	sub    %eax,%edx
     baa:	89 d0                	mov    %edx,%eax
     bac:	8d 50 ff             	lea    -0x1(%eax),%edx
     baf:	8b 45 c8             	mov    -0x38(%ebp),%eax
     bb2:	0f af c2             	imul   %edx,%eax
     bb5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     bb8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     bbf:	e9 b1 00 00 00       	jmp    c75 <APLoadBitmap+0x23c>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     bc4:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bc7:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     bca:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bcd:	01 c8                	add    %ecx,%eax
     bcf:	89 c1                	mov    %eax,%ecx
     bd1:	89 c8                	mov    %ecx,%eax
     bd3:	01 c0                	add    %eax,%eax
     bd5:	01 c8                	add    %ecx,%eax
     bd7:	01 c2                	add    %eax,%edx
     bd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bdc:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     be0:	89 c1                	mov    %eax,%ecx
     be2:	8b 45 d8             	mov    -0x28(%ebp),%eax
     be5:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     be9:	01 c1                	add    %eax,%ecx
     beb:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bee:	01 c8                	add    %ecx,%eax
     bf0:	8d 48 ff             	lea    -0x1(%eax),%ecx
     bf3:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bf6:	01 c8                	add    %ecx,%eax
     bf8:	0f b6 00             	movzbl (%eax),%eax
     bfb:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     bfe:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c01:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     c04:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c07:	01 c8                	add    %ecx,%eax
     c09:	89 c1                	mov    %eax,%ecx
     c0b:	89 c8                	mov    %ecx,%eax
     c0d:	01 c0                	add    %eax,%eax
     c0f:	01 c8                	add    %ecx,%eax
     c11:	01 c2                	add    %eax,%edx
     c13:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c16:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     c1a:	89 c1                	mov    %eax,%ecx
     c1c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c1f:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     c23:	01 c1                	add    %eax,%ecx
     c25:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c28:	01 c8                	add    %ecx,%eax
     c2a:	8d 48 fe             	lea    -0x2(%eax),%ecx
     c2d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c30:	01 c8                	add    %ecx,%eax
     c32:	0f b6 00             	movzbl (%eax),%eax
     c35:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     c38:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c3b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     c3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c41:	01 c8                	add    %ecx,%eax
     c43:	89 c1                	mov    %eax,%ecx
     c45:	89 c8                	mov    %ecx,%eax
     c47:	01 c0                	add    %eax,%eax
     c49:	01 c8                	add    %ecx,%eax
     c4b:	01 c2                	add    %eax,%edx
     c4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c50:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     c54:	89 c1                	mov    %eax,%ecx
     c56:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c59:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     c5d:	01 c1                	add    %eax,%ecx
     c5f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c62:	01 c8                	add    %ecx,%eax
     c64:	8d 48 fd             	lea    -0x3(%eax),%ecx
     c67:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c6a:	01 c8                	add    %ecx,%eax
     c6c:	0f b6 00             	movzbl (%eax),%eax
     c6f:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     c71:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     c75:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c78:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c7b:	39 c2                	cmp    %eax,%edx
     c7d:	0f 87 41 ff ff ff    	ja     bc4 <APLoadBitmap+0x18b>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     c83:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c87:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c8d:	39 c2                	cmp    %eax,%edx
     c8f:	0f 87 0d ff ff ff    	ja     ba2 <APLoadBitmap+0x169>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     c95:	83 ec 0c             	sub    $0xc,%esp
     c98:	ff 75 ec             	pushl  -0x14(%ebp)
     c9b:	e8 9c f7 ff ff       	call   43c <close>
     ca0:	83 c4 10             	add    $0x10,%esp
    return bmp;
     ca3:	8b 45 08             	mov    0x8(%ebp),%eax
     ca6:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ca9:	89 10                	mov    %edx,(%eax)
     cab:	8b 55 cc             	mov    -0x34(%ebp),%edx
     cae:	89 50 04             	mov    %edx,0x4(%eax)
     cb1:	8b 55 d0             	mov    -0x30(%ebp),%edx
     cb4:	89 50 08             	mov    %edx,0x8(%eax)
}
     cb7:	8b 45 08             	mov    0x8(%ebp),%eax
     cba:	8d 65 f8             	lea    -0x8(%ebp),%esp
     cbd:	5b                   	pop    %ebx
     cbe:	5e                   	pop    %esi
     cbf:	5d                   	pop    %ebp
     cc0:	c2 04 00             	ret    $0x4

00000cc3 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     cc3:	55                   	push   %ebp
     cc4:	89 e5                	mov    %esp,%ebp
     cc6:	53                   	push   %ebx
     cc7:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     cca:	83 ec 0c             	sub    $0xc,%esp
     ccd:	6a 1c                	push   $0x1c
     ccf:	e8 b2 fb ff ff       	call   886 <malloc>
     cd4:	83 c4 10             	add    $0x10,%esp
     cd7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     cda:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cdd:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     ce4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     ce7:	8d 45 d8             	lea    -0x28(%ebp),%eax
     cea:	6a 0c                	push   $0xc
     cec:	6a 0c                	push   $0xc
     cee:	6a 0c                	push   $0xc
     cf0:	50                   	push   %eax
     cf1:	e8 73 fc ff ff       	call   969 <RGB>
     cf6:	83 c4 0c             	add    $0xc,%esp
     cf9:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     cfd:	66 89 43 13          	mov    %ax,0x13(%ebx)
     d01:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     d05:	88 43 15             	mov    %al,0x15(%ebx)
     d08:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d0b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d0e:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     d12:	66 89 48 10          	mov    %cx,0x10(%eax)
     d16:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     d1a:	88 50 12             	mov    %dl,0x12(%eax)
     d1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d20:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d23:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     d27:	66 89 48 08          	mov    %cx,0x8(%eax)
     d2b:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     d2f:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     d32:	8b 45 08             	mov    0x8(%ebp),%eax
     d35:	89 c2                	mov    %eax,%edx
     d37:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d3a:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     d3c:	8b 45 0c             	mov    0xc(%ebp),%eax
     d3f:	89 c2                	mov    %eax,%edx
     d41:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d44:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     d47:	8b 55 10             	mov    0x10(%ebp),%edx
     d4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d4d:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "%d %d\n", hdc->size.cx, hdc->size.cy);
    return hdc;
     d50:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     d53:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d56:	c9                   	leave  
     d57:	c3                   	ret    

00000d58 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     d58:	55                   	push   %ebp
     d59:	89 e5                	mov    %esp,%ebp
     d5b:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     d5e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d61:	8b 50 08             	mov    0x8(%eax),%edx
     d64:	89 55 f8             	mov    %edx,-0x8(%ebp)
     d67:	8b 40 0c             	mov    0xc(%eax),%eax
     d6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     d6d:	8b 45 0c             	mov    0xc(%ebp),%eax
     d70:	8b 55 10             	mov    0x10(%ebp),%edx
     d73:	89 50 08             	mov    %edx,0x8(%eax)
     d76:	8b 55 14             	mov    0x14(%ebp),%edx
     d79:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     d7c:	8b 45 08             	mov    0x8(%ebp),%eax
     d7f:	8b 55 f8             	mov    -0x8(%ebp),%edx
     d82:	89 10                	mov    %edx,(%eax)
     d84:	8b 55 fc             	mov    -0x4(%ebp),%edx
     d87:	89 50 04             	mov    %edx,0x4(%eax)
}
     d8a:	8b 45 08             	mov    0x8(%ebp),%eax
     d8d:	c9                   	leave  
     d8e:	c2 04 00             	ret    $0x4

00000d91 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     d91:	55                   	push   %ebp
     d92:	89 e5                	mov    %esp,%ebp
     d94:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     d97:	8b 45 0c             	mov    0xc(%ebp),%eax
     d9a:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     d9e:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     da2:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     da6:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     da9:	8b 45 0c             	mov    0xc(%ebp),%eax
     dac:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     db0:	66 89 50 10          	mov    %dx,0x10(%eax)
     db4:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     db8:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     dbb:	8b 45 08             	mov    0x8(%ebp),%eax
     dbe:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     dc2:	66 89 10             	mov    %dx,(%eax)
     dc5:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     dc9:	88 50 02             	mov    %dl,0x2(%eax)
}
     dcc:	8b 45 08             	mov    0x8(%ebp),%eax
     dcf:	c9                   	leave  
     dd0:	c2 04 00             	ret    $0x4

00000dd3 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     dd3:	55                   	push   %ebp
     dd4:	89 e5                	mov    %esp,%ebp
     dd6:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     dd9:	8b 45 08             	mov    0x8(%ebp),%eax
     ddc:	8b 40 0c             	mov    0xc(%eax),%eax
     ddf:	89 c2                	mov    %eax,%edx
     de1:	c1 ea 1f             	shr    $0x1f,%edx
     de4:	01 d0                	add    %edx,%eax
     de6:	d1 f8                	sar    %eax
     de8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     deb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dee:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     df2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     df5:	8b 45 10             	mov    0x10(%ebp),%eax
     df8:	2b 45 f4             	sub    -0xc(%ebp),%eax
     dfb:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     dfe:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     e02:	0f 89 98 00 00 00    	jns    ea0 <APDrawPoint+0xcd>
        i = 0;
     e08:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     e0f:	e9 8c 00 00 00       	jmp    ea0 <APDrawPoint+0xcd>
    {
        j = x - off;
     e14:	8b 45 0c             	mov    0xc(%ebp),%eax
     e17:	2b 45 f4             	sub    -0xc(%ebp),%eax
     e1a:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     e1d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     e21:	79 69                	jns    e8c <APDrawPoint+0xb9>
            j = 0;
     e23:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     e2a:	eb 60                	jmp    e8c <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     e2c:	ff 75 fc             	pushl  -0x4(%ebp)
     e2f:	ff 75 f8             	pushl  -0x8(%ebp)
     e32:	ff 75 08             	pushl  0x8(%ebp)
     e35:	e8 ad fb ff ff       	call   9e7 <APGetIndex>
     e3a:	83 c4 0c             	add    $0xc,%esp
     e3d:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     e40:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     e44:	74 55                	je     e9b <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     e46:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     e4a:	74 67                	je     eb3 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     e4c:	ff 75 10             	pushl  0x10(%ebp)
     e4f:	ff 75 0c             	pushl  0xc(%ebp)
     e52:	ff 75 fc             	pushl  -0x4(%ebp)
     e55:	ff 75 f8             	pushl  -0x8(%ebp)
     e58:	e8 51 fb ff ff       	call   9ae <distance_2>
     e5d:	83 c4 10             	add    $0x10,%esp
     e60:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     e63:	7f 23                	jg     e88 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     e65:	8b 45 08             	mov    0x8(%ebp),%eax
     e68:	8b 48 18             	mov    0x18(%eax),%ecx
     e6b:	8b 55 ec             	mov    -0x14(%ebp),%edx
     e6e:	89 d0                	mov    %edx,%eax
     e70:	01 c0                	add    %eax,%eax
     e72:	01 d0                	add    %edx,%eax
     e74:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     e77:	8b 45 08             	mov    0x8(%ebp),%eax
     e7a:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     e7e:	66 89 0a             	mov    %cx,(%edx)
     e81:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     e85:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     e88:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     e8c:	8b 55 0c             	mov    0xc(%ebp),%edx
     e8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e92:	01 d0                	add    %edx,%eax
     e94:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     e97:	7d 93                	jge    e2c <APDrawPoint+0x59>
     e99:	eb 01                	jmp    e9c <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     e9b:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     e9c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     ea0:	8b 55 10             	mov    0x10(%ebp),%edx
     ea3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ea6:	01 d0                	add    %edx,%eax
     ea8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     eab:	0f 8d 63 ff ff ff    	jge    e14 <APDrawPoint+0x41>
     eb1:	eb 01                	jmp    eb4 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     eb3:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     eb4:	c9                   	leave  
     eb5:	c3                   	ret    

00000eb6 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     eb6:	55                   	push   %ebp
     eb7:	89 e5                	mov    %esp,%ebp
     eb9:	53                   	push   %ebx
     eba:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     ebd:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec0:	3b 45 14             	cmp    0x14(%ebp),%eax
     ec3:	0f 85 80 00 00 00    	jne    f49 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     ec9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ecd:	0f 88 9d 02 00 00    	js     1170 <APDrawLine+0x2ba>
     ed3:	8b 45 08             	mov    0x8(%ebp),%eax
     ed6:	8b 00                	mov    (%eax),%eax
     ed8:	3b 45 0c             	cmp    0xc(%ebp),%eax
     edb:	0f 8e 8f 02 00 00    	jle    1170 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     ee1:	8b 45 10             	mov    0x10(%ebp),%eax
     ee4:	3b 45 18             	cmp    0x18(%ebp),%eax
     ee7:	7e 12                	jle    efb <APDrawLine+0x45>
        {
            int tmp = y2;
     ee9:	8b 45 18             	mov    0x18(%ebp),%eax
     eec:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     eef:	8b 45 10             	mov    0x10(%ebp),%eax
     ef2:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     ef5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ef8:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     efb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     eff:	79 07                	jns    f08 <APDrawLine+0x52>
     f01:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     f08:	8b 45 08             	mov    0x8(%ebp),%eax
     f0b:	8b 40 04             	mov    0x4(%eax),%eax
     f0e:	3b 45 18             	cmp    0x18(%ebp),%eax
     f11:	7d 0c                	jge    f1f <APDrawLine+0x69>
     f13:	8b 45 08             	mov    0x8(%ebp),%eax
     f16:	8b 40 04             	mov    0x4(%eax),%eax
     f19:	83 e8 01             	sub    $0x1,%eax
     f1c:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     f1f:	8b 45 10             	mov    0x10(%ebp),%eax
     f22:	89 45 f4             	mov    %eax,-0xc(%ebp)
     f25:	eb 15                	jmp    f3c <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     f27:	ff 75 f4             	pushl  -0xc(%ebp)
     f2a:	ff 75 0c             	pushl  0xc(%ebp)
     f2d:	ff 75 08             	pushl  0x8(%ebp)
     f30:	e8 9e fe ff ff       	call   dd3 <APDrawPoint>
     f35:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     f38:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f3f:	3b 45 18             	cmp    0x18(%ebp),%eax
     f42:	7e e3                	jle    f27 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     f44:	e9 2b 02 00 00       	jmp    1174 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     f49:	8b 45 10             	mov    0x10(%ebp),%eax
     f4c:	3b 45 18             	cmp    0x18(%ebp),%eax
     f4f:	75 7f                	jne    fd0 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     f51:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     f55:	0f 88 18 02 00 00    	js     1173 <APDrawLine+0x2bd>
     f5b:	8b 45 08             	mov    0x8(%ebp),%eax
     f5e:	8b 40 04             	mov    0x4(%eax),%eax
     f61:	3b 45 10             	cmp    0x10(%ebp),%eax
     f64:	0f 8e 09 02 00 00    	jle    1173 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     f6a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f6d:	3b 45 14             	cmp    0x14(%ebp),%eax
     f70:	7e 12                	jle    f84 <APDrawLine+0xce>
        {
            int tmp = x2;
     f72:	8b 45 14             	mov    0x14(%ebp),%eax
     f75:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     f78:	8b 45 0c             	mov    0xc(%ebp),%eax
     f7b:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     f7e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     f81:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     f84:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f88:	79 07                	jns    f91 <APDrawLine+0xdb>
     f8a:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     f91:	8b 45 08             	mov    0x8(%ebp),%eax
     f94:	8b 00                	mov    (%eax),%eax
     f96:	3b 45 14             	cmp    0x14(%ebp),%eax
     f99:	7d 0b                	jge    fa6 <APDrawLine+0xf0>
     f9b:	8b 45 08             	mov    0x8(%ebp),%eax
     f9e:	8b 00                	mov    (%eax),%eax
     fa0:	83 e8 01             	sub    $0x1,%eax
     fa3:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     fa6:	8b 45 0c             	mov    0xc(%ebp),%eax
     fa9:	89 45 f0             	mov    %eax,-0x10(%ebp)
     fac:	eb 15                	jmp    fc3 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     fae:	ff 75 10             	pushl  0x10(%ebp)
     fb1:	ff 75 f0             	pushl  -0x10(%ebp)
     fb4:	ff 75 08             	pushl  0x8(%ebp)
     fb7:	e8 17 fe ff ff       	call   dd3 <APDrawPoint>
     fbc:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     fbf:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     fc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fc6:	3b 45 14             	cmp    0x14(%ebp),%eax
     fc9:	7e e3                	jle    fae <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     fcb:	e9 a4 01 00 00       	jmp    1174 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     fd0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     fd7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     fde:	8b 45 0c             	mov    0xc(%ebp),%eax
     fe1:	2b 45 14             	sub    0x14(%ebp),%eax
     fe4:	50                   	push   %eax
     fe5:	e8 ed f9 ff ff       	call   9d7 <abs_int>
     fea:	83 c4 04             	add    $0x4,%esp
     fed:	89 c3                	mov    %eax,%ebx
     fef:	8b 45 10             	mov    0x10(%ebp),%eax
     ff2:	2b 45 18             	sub    0x18(%ebp),%eax
     ff5:	50                   	push   %eax
     ff6:	e8 dc f9 ff ff       	call   9d7 <abs_int>
     ffb:	83 c4 04             	add    $0x4,%esp
     ffe:	39 c3                	cmp    %eax,%ebx
    1000:	0f 8e b5 00 00 00    	jle    10bb <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1006:	8b 45 10             	mov    0x10(%ebp),%eax
    1009:	2b 45 18             	sub    0x18(%ebp),%eax
    100c:	89 45 b0             	mov    %eax,-0x50(%ebp)
    100f:	db 45 b0             	fildl  -0x50(%ebp)
    1012:	8b 45 0c             	mov    0xc(%ebp),%eax
    1015:	2b 45 14             	sub    0x14(%ebp),%eax
    1018:	89 45 b0             	mov    %eax,-0x50(%ebp)
    101b:	db 45 b0             	fildl  -0x50(%ebp)
    101e:	de f9                	fdivrp %st,%st(1)
    1020:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1023:	8b 45 14             	mov    0x14(%ebp),%eax
    1026:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1029:	7e 0e                	jle    1039 <APDrawLine+0x183>
        {
            s = x1;
    102b:	8b 45 0c             	mov    0xc(%ebp),%eax
    102e:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    1031:	8b 45 14             	mov    0x14(%ebp),%eax
    1034:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1037:	eb 0c                	jmp    1045 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1039:	8b 45 14             	mov    0x14(%ebp),%eax
    103c:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    103f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1042:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1045:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1049:	79 07                	jns    1052 <APDrawLine+0x19c>
    104b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1052:	8b 45 08             	mov    0x8(%ebp),%eax
    1055:	8b 00                	mov    (%eax),%eax
    1057:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    105a:	7f 0b                	jg     1067 <APDrawLine+0x1b1>
    105c:	8b 45 08             	mov    0x8(%ebp),%eax
    105f:	8b 00                	mov    (%eax),%eax
    1061:	83 e8 01             	sub    $0x1,%eax
    1064:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1067:	8b 45 ec             	mov    -0x14(%ebp),%eax
    106a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    106d:	eb 3f                	jmp    10ae <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    106f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1072:	2b 45 0c             	sub    0xc(%ebp),%eax
    1075:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1078:	db 45 b0             	fildl  -0x50(%ebp)
    107b:	dc 4d d0             	fmull  -0x30(%ebp)
    107e:	db 45 10             	fildl  0x10(%ebp)
    1081:	de c1                	faddp  %st,%st(1)
    1083:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1086:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    108a:	b4 0c                	mov    $0xc,%ah
    108c:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1090:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1093:	db 5d cc             	fistpl -0x34(%ebp)
    1096:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1099:	ff 75 cc             	pushl  -0x34(%ebp)
    109c:	ff 75 e4             	pushl  -0x1c(%ebp)
    109f:	ff 75 08             	pushl  0x8(%ebp)
    10a2:	e8 2c fd ff ff       	call   dd3 <APDrawPoint>
    10a7:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    10aa:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    10ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10b1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10b4:	7e b9                	jle    106f <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    10b6:	e9 b9 00 00 00       	jmp    1174 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    10bb:	8b 45 0c             	mov    0xc(%ebp),%eax
    10be:	2b 45 14             	sub    0x14(%ebp),%eax
    10c1:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10c4:	db 45 b0             	fildl  -0x50(%ebp)
    10c7:	8b 45 10             	mov    0x10(%ebp),%eax
    10ca:	2b 45 18             	sub    0x18(%ebp),%eax
    10cd:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10d0:	db 45 b0             	fildl  -0x50(%ebp)
    10d3:	de f9                	fdivrp %st,%st(1)
    10d5:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    10d8:	8b 45 10             	mov    0x10(%ebp),%eax
    10db:	3b 45 18             	cmp    0x18(%ebp),%eax
    10de:	7e 0e                	jle    10ee <APDrawLine+0x238>
    {
        s = y2;
    10e0:	8b 45 18             	mov    0x18(%ebp),%eax
    10e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    10e6:	8b 45 10             	mov    0x10(%ebp),%eax
    10e9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    10ec:	eb 0c                	jmp    10fa <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    10ee:	8b 45 10             	mov    0x10(%ebp),%eax
    10f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    10f4:	8b 45 18             	mov    0x18(%ebp),%eax
    10f7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    10fa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10fe:	79 07                	jns    1107 <APDrawLine+0x251>
    1100:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1107:	8b 45 08             	mov    0x8(%ebp),%eax
    110a:	8b 40 04             	mov    0x4(%eax),%eax
    110d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1110:	7f 0c                	jg     111e <APDrawLine+0x268>
    1112:	8b 45 08             	mov    0x8(%ebp),%eax
    1115:	8b 40 04             	mov    0x4(%eax),%eax
    1118:	83 e8 01             	sub    $0x1,%eax
    111b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    111e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1121:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1124:	eb 3f                	jmp    1165 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1126:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1129:	2b 45 10             	sub    0x10(%ebp),%eax
    112c:	89 45 b0             	mov    %eax,-0x50(%ebp)
    112f:	db 45 b0             	fildl  -0x50(%ebp)
    1132:	dc 4d c0             	fmull  -0x40(%ebp)
    1135:	db 45 0c             	fildl  0xc(%ebp)
    1138:	de c1                	faddp  %st,%st(1)
    113a:	d9 7d b6             	fnstcw -0x4a(%ebp)
    113d:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1141:	b4 0c                	mov    $0xc,%ah
    1143:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1147:	d9 6d b4             	fldcw  -0x4c(%ebp)
    114a:	db 5d bc             	fistpl -0x44(%ebp)
    114d:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1150:	ff 75 e0             	pushl  -0x20(%ebp)
    1153:	ff 75 bc             	pushl  -0x44(%ebp)
    1156:	ff 75 08             	pushl  0x8(%ebp)
    1159:	e8 75 fc ff ff       	call   dd3 <APDrawPoint>
    115e:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1161:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1165:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1168:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    116b:	7e b9                	jle    1126 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    116d:	90                   	nop
    116e:	eb 04                	jmp    1174 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1170:	90                   	nop
    1171:	eb 01                	jmp    1174 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1173:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1174:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1177:	c9                   	leave  
    1178:	c3                   	ret    

00001179 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1179:	55                   	push   %ebp
    117a:	89 e5                	mov    %esp,%ebp
    117c:	53                   	push   %ebx
    117d:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1180:	8b 55 10             	mov    0x10(%ebp),%edx
    1183:	8b 45 18             	mov    0x18(%ebp),%eax
    1186:	01 d0                	add    %edx,%eax
    1188:	83 e8 01             	sub    $0x1,%eax
    118b:	83 ec 04             	sub    $0x4,%esp
    118e:	50                   	push   %eax
    118f:	ff 75 0c             	pushl  0xc(%ebp)
    1192:	ff 75 10             	pushl  0x10(%ebp)
    1195:	ff 75 0c             	pushl  0xc(%ebp)
    1198:	ff 75 08             	pushl  0x8(%ebp)
    119b:	e8 16 fd ff ff       	call   eb6 <APDrawLine>
    11a0:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    11a3:	8b 55 0c             	mov    0xc(%ebp),%edx
    11a6:	8b 45 14             	mov    0x14(%ebp),%eax
    11a9:	01 d0                	add    %edx,%eax
    11ab:	83 e8 01             	sub    $0x1,%eax
    11ae:	83 ec 04             	sub    $0x4,%esp
    11b1:	ff 75 10             	pushl  0x10(%ebp)
    11b4:	50                   	push   %eax
    11b5:	ff 75 10             	pushl  0x10(%ebp)
    11b8:	ff 75 0c             	pushl  0xc(%ebp)
    11bb:	ff 75 08             	pushl  0x8(%ebp)
    11be:	e8 f3 fc ff ff       	call   eb6 <APDrawLine>
    11c3:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    11c6:	8b 55 10             	mov    0x10(%ebp),%edx
    11c9:	8b 45 18             	mov    0x18(%ebp),%eax
    11cc:	01 d0                	add    %edx,%eax
    11ce:	8d 48 ff             	lea    -0x1(%eax),%ecx
    11d1:	8b 55 0c             	mov    0xc(%ebp),%edx
    11d4:	8b 45 14             	mov    0x14(%ebp),%eax
    11d7:	01 d0                	add    %edx,%eax
    11d9:	8d 50 ff             	lea    -0x1(%eax),%edx
    11dc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    11df:	8b 45 14             	mov    0x14(%ebp),%eax
    11e2:	01 d8                	add    %ebx,%eax
    11e4:	83 e8 01             	sub    $0x1,%eax
    11e7:	83 ec 04             	sub    $0x4,%esp
    11ea:	51                   	push   %ecx
    11eb:	52                   	push   %edx
    11ec:	ff 75 10             	pushl  0x10(%ebp)
    11ef:	50                   	push   %eax
    11f0:	ff 75 08             	pushl  0x8(%ebp)
    11f3:	e8 be fc ff ff       	call   eb6 <APDrawLine>
    11f8:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    11fb:	8b 55 10             	mov    0x10(%ebp),%edx
    11fe:	8b 45 18             	mov    0x18(%ebp),%eax
    1201:	01 d0                	add    %edx,%eax
    1203:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1206:	8b 55 0c             	mov    0xc(%ebp),%edx
    1209:	8b 45 14             	mov    0x14(%ebp),%eax
    120c:	01 d0                	add    %edx,%eax
    120e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1211:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1214:	8b 45 18             	mov    0x18(%ebp),%eax
    1217:	01 d8                	add    %ebx,%eax
    1219:	83 e8 01             	sub    $0x1,%eax
    121c:	83 ec 04             	sub    $0x4,%esp
    121f:	51                   	push   %ecx
    1220:	52                   	push   %edx
    1221:	50                   	push   %eax
    1222:	ff 75 0c             	pushl  0xc(%ebp)
    1225:	ff 75 08             	pushl  0x8(%ebp)
    1228:	e8 89 fc ff ff       	call   eb6 <APDrawLine>
    122d:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1230:	8b 55 0c             	mov    0xc(%ebp),%edx
    1233:	8b 45 14             	mov    0x14(%ebp),%eax
    1236:	01 d0                	add    %edx,%eax
    1238:	8d 50 ff             	lea    -0x1(%eax),%edx
    123b:	8b 45 08             	mov    0x8(%ebp),%eax
    123e:	8b 40 0c             	mov    0xc(%eax),%eax
    1241:	89 c1                	mov    %eax,%ecx
    1243:	c1 e9 1f             	shr    $0x1f,%ecx
    1246:	01 c8                	add    %ecx,%eax
    1248:	d1 f8                	sar    %eax
    124a:	29 c2                	sub    %eax,%edx
    124c:	89 d0                	mov    %edx,%eax
    124e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1251:	8b 55 10             	mov    0x10(%ebp),%edx
    1254:	8b 45 18             	mov    0x18(%ebp),%eax
    1257:	01 d0                	add    %edx,%eax
    1259:	8d 50 ff             	lea    -0x1(%eax),%edx
    125c:	8b 45 08             	mov    0x8(%ebp),%eax
    125f:	8b 40 0c             	mov    0xc(%eax),%eax
    1262:	89 c1                	mov    %eax,%ecx
    1264:	c1 e9 1f             	shr    $0x1f,%ecx
    1267:	01 c8                	add    %ecx,%eax
    1269:	d1 f8                	sar    %eax
    126b:	29 c2                	sub    %eax,%edx
    126d:	89 d0                	mov    %edx,%eax
    126f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1272:	8b 45 08             	mov    0x8(%ebp),%eax
    1275:	8b 40 0c             	mov    0xc(%eax),%eax
    1278:	89 c2                	mov    %eax,%edx
    127a:	c1 ea 1f             	shr    $0x1f,%edx
    127d:	01 d0                	add    %edx,%eax
    127f:	d1 f8                	sar    %eax
    1281:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1284:	8b 45 08             	mov    0x8(%ebp),%eax
    1287:	8b 40 0c             	mov    0xc(%eax),%eax
    128a:	89 c2                	mov    %eax,%edx
    128c:	c1 ea 1f             	shr    $0x1f,%edx
    128f:	01 d0                	add    %edx,%eax
    1291:	d1 f8                	sar    %eax
    1293:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1296:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    129a:	0f 88 d8 00 00 00    	js     1378 <APDrawRect+0x1ff>
    12a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    12a4:	0f 88 ce 00 00 00    	js     1378 <APDrawRect+0x1ff>
    12aa:	8b 45 08             	mov    0x8(%ebp),%eax
    12ad:	8b 00                	mov    (%eax),%eax
    12af:	3b 45 0c             	cmp    0xc(%ebp),%eax
    12b2:	0f 8e c0 00 00 00    	jle    1378 <APDrawRect+0x1ff>
    12b8:	8b 45 08             	mov    0x8(%ebp),%eax
    12bb:	8b 40 04             	mov    0x4(%eax),%eax
    12be:	3b 45 10             	cmp    0x10(%ebp),%eax
    12c1:	0f 8e b1 00 00 00    	jle    1378 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    12c7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    12cb:	79 07                	jns    12d4 <APDrawRect+0x15b>
    12cd:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    12d4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12d8:	79 07                	jns    12e1 <APDrawRect+0x168>
    12da:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    12e1:	8b 45 08             	mov    0x8(%ebp),%eax
    12e4:	8b 00                	mov    (%eax),%eax
    12e6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    12e9:	7f 0b                	jg     12f6 <APDrawRect+0x17d>
    12eb:	8b 45 08             	mov    0x8(%ebp),%eax
    12ee:	8b 00                	mov    (%eax),%eax
    12f0:	83 e8 01             	sub    $0x1,%eax
    12f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    12f6:	8b 45 08             	mov    0x8(%ebp),%eax
    12f9:	8b 40 04             	mov    0x4(%eax),%eax
    12fc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12ff:	7f 0c                	jg     130d <APDrawRect+0x194>
    1301:	8b 45 08             	mov    0x8(%ebp),%eax
    1304:	8b 40 04             	mov    0x4(%eax),%eax
    1307:	83 e8 01             	sub    $0x1,%eax
    130a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    130d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1314:	8b 45 0c             	mov    0xc(%ebp),%eax
    1317:	89 45 ec             	mov    %eax,-0x14(%ebp)
    131a:	eb 52                	jmp    136e <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    131c:	8b 45 10             	mov    0x10(%ebp),%eax
    131f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1322:	eb 3e                	jmp    1362 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1324:	83 ec 04             	sub    $0x4,%esp
    1327:	ff 75 e8             	pushl  -0x18(%ebp)
    132a:	ff 75 ec             	pushl  -0x14(%ebp)
    132d:	ff 75 08             	pushl  0x8(%ebp)
    1330:	e8 b2 f6 ff ff       	call   9e7 <APGetIndex>
    1335:	83 c4 10             	add    $0x10,%esp
    1338:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    133b:	8b 45 08             	mov    0x8(%ebp),%eax
    133e:	8b 48 18             	mov    0x18(%eax),%ecx
    1341:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1344:	89 d0                	mov    %edx,%eax
    1346:	01 c0                	add    %eax,%eax
    1348:	01 d0                	add    %edx,%eax
    134a:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    134d:	8b 45 08             	mov    0x8(%ebp),%eax
    1350:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1354:	66 89 0a             	mov    %cx,(%edx)
    1357:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    135b:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    135e:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1362:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1365:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1368:	7e ba                	jle    1324 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    136a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    136e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1371:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1374:	7e a6                	jle    131c <APDrawRect+0x1a3>
    1376:	eb 01                	jmp    1379 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1378:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1379:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    137c:	c9                   	leave  
    137d:	c3                   	ret    

0000137e <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    137e:	55                   	push   %ebp
    137f:	89 e5                	mov    %esp,%ebp
    1381:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1384:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1388:	0f 88 8e 01 00 00    	js     151c <APDcCopy+0x19e>
    138e:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1392:	0f 88 84 01 00 00    	js     151c <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1398:	8b 55 0c             	mov    0xc(%ebp),%edx
    139b:	8b 45 20             	mov    0x20(%ebp),%eax
    139e:	01 d0                	add    %edx,%eax
    13a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    13a3:	8b 55 10             	mov    0x10(%ebp),%edx
    13a6:	8b 45 24             	mov    0x24(%ebp),%eax
    13a9:	01 d0                	add    %edx,%eax
    13ab:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w, y_r = y + h;
    13ae:	8b 55 18             	mov    0x18(%ebp),%edx
    13b1:	8b 45 20             	mov    0x20(%ebp),%eax
    13b4:	01 d0                	add    %edx,%eax
    13b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13b9:	8b 55 1c             	mov    0x1c(%ebp),%edx
    13bc:	8b 45 24             	mov    0x24(%ebp),%eax
    13bf:	01 d0                	add    %edx,%eax
    13c1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
    13c4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13c8:	0f 88 51 01 00 00    	js     151f <APDcCopy+0x1a1>
    13ce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    13d2:	0f 88 47 01 00 00    	js     151f <APDcCopy+0x1a1>
    13d8:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    13dc:	0f 88 3d 01 00 00    	js     151f <APDcCopy+0x1a1>
    13e2:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    13e6:	0f 88 33 01 00 00    	js     151f <APDcCopy+0x1a1>
    13ec:	8b 45 14             	mov    0x14(%ebp),%eax
    13ef:	8b 00                	mov    (%eax),%eax
    13f1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13f4:	0f 8e 25 01 00 00    	jle    151f <APDcCopy+0x1a1>
    13fa:	8b 45 14             	mov    0x14(%ebp),%eax
    13fd:	8b 40 04             	mov    0x4(%eax),%eax
    1400:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1403:	0f 8e 16 01 00 00    	jle    151f <APDcCopy+0x1a1>
        return;
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    1409:	8b 45 08             	mov    0x8(%ebp),%eax
    140c:	8b 00                	mov    (%eax),%eax
    140e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1411:	7d 0b                	jge    141e <APDcCopy+0xa0>
    1413:	8b 45 08             	mov    0x8(%ebp),%eax
    1416:	8b 00                	mov    (%eax),%eax
    1418:	83 e8 01             	sub    $0x1,%eax
    141b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    141e:	8b 45 08             	mov    0x8(%ebp),%eax
    1421:	8b 40 04             	mov    0x4(%eax),%eax
    1424:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1427:	7d 0c                	jge    1435 <APDcCopy+0xb7>
    1429:	8b 45 08             	mov    0x8(%ebp),%eax
    142c:	8b 40 04             	mov    0x4(%eax),%eax
    142f:	83 e8 01             	sub    $0x1,%eax
    1432:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1435:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    143c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j < wy_r - wy; j++)
    1443:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    144a:	e9 bc 00 00 00       	jmp    150b <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    144f:	8b 45 08             	mov    0x8(%ebp),%eax
    1452:	8b 00                	mov    (%eax),%eax
    1454:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1457:	8b 55 10             	mov    0x10(%ebp),%edx
    145a:	01 ca                	add    %ecx,%edx
    145c:	0f af d0             	imul   %eax,%edx
    145f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1462:	01 d0                	add    %edx,%eax
    1464:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1467:	8b 45 14             	mov    0x14(%ebp),%eax
    146a:	8b 00                	mov    (%eax),%eax
    146c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    146f:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1472:	01 ca                	add    %ecx,%edx
    1474:	0f af d0             	imul   %eax,%edx
    1477:	8b 45 18             	mov    0x18(%ebp),%eax
    147a:	01 d0                	add    %edx,%eax
    147c:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i < wx_r - wx; i++)
    147f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1486:	eb 74                	jmp    14fc <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1488:	8b 45 14             	mov    0x14(%ebp),%eax
    148b:	8b 50 18             	mov    0x18(%eax),%edx
    148e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1491:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1494:	01 c8                	add    %ecx,%eax
    1496:	89 c1                	mov    %eax,%ecx
    1498:	89 c8                	mov    %ecx,%eax
    149a:	01 c0                	add    %eax,%eax
    149c:	01 c8                	add    %ecx,%eax
    149e:	01 d0                	add    %edx,%eax
    14a0:	0f b7 10             	movzwl (%eax),%edx
    14a3:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    14a7:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    14ab:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    14ae:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    14b2:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    14b6:	38 c2                	cmp    %al,%dl
    14b8:	75 18                	jne    14d2 <APDcCopy+0x154>
    14ba:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    14be:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    14c2:	38 c2                	cmp    %al,%dl
    14c4:	75 0c                	jne    14d2 <APDcCopy+0x154>
    14c6:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    14ca:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    14ce:	38 c2                	cmp    %al,%dl
    14d0:	74 26                	je     14f8 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    14d2:	8b 45 08             	mov    0x8(%ebp),%eax
    14d5:	8b 50 18             	mov    0x18(%eax),%edx
    14d8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    14db:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14de:	01 c8                	add    %ecx,%eax
    14e0:	89 c1                	mov    %eax,%ecx
    14e2:	89 c8                	mov    %ecx,%eax
    14e4:	01 c0                	add    %eax,%eax
    14e6:	01 c8                	add    %ecx,%eax
    14e8:	01 d0                	add    %edx,%eax
    14ea:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    14ee:	66 89 10             	mov    %dx,(%eax)
    14f1:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    14f5:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i < wx_r - wx; i++)
    14f8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14ff:	2b 45 0c             	sub    0xc(%ebp),%eax
    1502:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1505:	7f 81                	jg     1488 <APDcCopy+0x10a>
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    1507:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    150b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    150e:	2b 45 10             	sub    0x10(%ebp),%eax
    1511:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1514:	0f 8f 35 ff ff ff    	jg     144f <APDcCopy+0xd1>
    151a:	eb 04                	jmp    1520 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    151c:	90                   	nop
    151d:	eb 01                	jmp    1520 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w, y_r = y + h;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
        return;
    151f:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1520:	c9                   	leave  
    1521:	c3                   	ret    

00001522 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1522:	55                   	push   %ebp
    1523:	89 e5                	mov    %esp,%ebp
    1525:	83 ec 1c             	sub    $0x1c,%esp
    1528:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    152b:	8b 55 10             	mov    0x10(%ebp),%edx
    152e:	8b 45 14             	mov    0x14(%ebp),%eax
    1531:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1534:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1537:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    153a:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    153e:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1541:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1545:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1548:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    154c:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    154f:	8b 45 08             	mov    0x8(%ebp),%eax
    1552:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1556:	66 89 10             	mov    %dx,(%eax)
    1559:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    155d:	88 50 02             	mov    %dl,0x2(%eax)
}
    1560:	8b 45 08             	mov    0x8(%ebp),%eax
    1563:	c9                   	leave  
    1564:	c2 04 00             	ret    $0x4

00001567 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1567:	55                   	push   %ebp
    1568:	89 e5                	mov    %esp,%ebp
    156a:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    156d:	8b 45 08             	mov    0x8(%ebp),%eax
    1570:	8b 00                	mov    (%eax),%eax
    1572:	83 ec 08             	sub    $0x8,%esp
    1575:	8d 55 0c             	lea    0xc(%ebp),%edx
    1578:	52                   	push   %edx
    1579:	50                   	push   %eax
    157a:	e8 45 ef ff ff       	call   4c4 <sendMessage>
    157f:	83 c4 10             	add    $0x10,%esp
}
    1582:	90                   	nop
    1583:	c9                   	leave  
    1584:	c3                   	ret    

00001585 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1585:	55                   	push   %ebp
    1586:	89 e5                	mov    %esp,%ebp
    1588:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    158b:	83 ec 0c             	sub    $0xc,%esp
    158e:	68 90 00 00 00       	push   $0x90
    1593:	e8 ee f2 ff ff       	call   886 <malloc>
    1598:	83 c4 10             	add    $0x10,%esp
    159b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    159e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15a2:	75 15                	jne    15b9 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    15a4:	83 ec 04             	sub    $0x4,%esp
    15a7:	ff 75 08             	pushl  0x8(%ebp)
    15aa:	68 7c 20 00 00       	push   $0x207c
    15af:	6a 01                	push   $0x1
    15b1:	e8 fd ef ff ff       	call   5b3 <printf>
    15b6:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    15b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bc:	83 c0 7c             	add    $0x7c,%eax
    15bf:	83 ec 08             	sub    $0x8,%esp
    15c2:	ff 75 08             	pushl  0x8(%ebp)
    15c5:	50                   	push   %eax
    15c6:	e8 18 ec ff ff       	call   1e3 <strcpy>
    15cb:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    15ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d1:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    15d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15db:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e5:	8b 40 34             	mov    0x34(%eax),%eax
    15e8:	89 c2                	mov    %eax,%edx
    15ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ed:	8b 40 38             	mov    0x38(%eax),%eax
    15f0:	0f af d0             	imul   %eax,%edx
    15f3:	89 d0                	mov    %edx,%eax
    15f5:	01 c0                	add    %eax,%eax
    15f7:	01 d0                	add    %edx,%eax
    15f9:	83 ec 0c             	sub    $0xc,%esp
    15fc:	50                   	push   %eax
    15fd:	e8 84 f2 ff ff       	call   886 <malloc>
    1602:	83 c4 10             	add    $0x10,%esp
    1605:	89 c2                	mov    %eax,%edx
    1607:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160a:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    160d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1610:	8b 40 4c             	mov    0x4c(%eax),%eax
    1613:	85 c0                	test   %eax,%eax
    1615:	75 15                	jne    162c <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1617:	83 ec 04             	sub    $0x4,%esp
    161a:	ff 75 08             	pushl  0x8(%ebp)
    161d:	68 9c 20 00 00       	push   $0x209c
    1622:	6a 01                	push   $0x1
    1624:	e8 8a ef ff ff       	call   5b3 <printf>
    1629:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    162c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162f:	8b 40 34             	mov    0x34(%eax),%eax
    1632:	89 c2                	mov    %eax,%edx
    1634:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1637:	8b 40 38             	mov    0x38(%eax),%eax
    163a:	0f af d0             	imul   %eax,%edx
    163d:	89 d0                	mov    %edx,%eax
    163f:	01 c0                	add    %eax,%eax
    1641:	01 c2                	add    %eax,%edx
    1643:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1646:	8b 40 4c             	mov    0x4c(%eax),%eax
    1649:	83 ec 04             	sub    $0x4,%esp
    164c:	52                   	push   %edx
    164d:	68 ff ff ff 00       	push   $0xffffff
    1652:	50                   	push   %eax
    1653:	e8 21 ec ff ff       	call   279 <memset>
    1658:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    165b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165e:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    1665:	e8 2a ee ff ff       	call   494 <getpid>
    166a:	89 c2                	mov    %eax,%edx
    166c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166f:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1672:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1675:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    167c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167f:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1686:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1689:	8b 40 50             	mov    0x50(%eax),%eax
    168c:	89 c2                	mov    %eax,%edx
    168e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1691:	8b 40 54             	mov    0x54(%eax),%eax
    1694:	0f af d0             	imul   %eax,%edx
    1697:	89 d0                	mov    %edx,%eax
    1699:	01 c0                	add    %eax,%eax
    169b:	01 d0                	add    %edx,%eax
    169d:	83 ec 0c             	sub    $0xc,%esp
    16a0:	50                   	push   %eax
    16a1:	e8 e0 f1 ff ff       	call   886 <malloc>
    16a6:	83 c4 10             	add    $0x10,%esp
    16a9:	89 c2                	mov    %eax,%edx
    16ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ae:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    16b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b4:	8b 40 68             	mov    0x68(%eax),%eax
    16b7:	85 c0                	test   %eax,%eax
    16b9:	75 15                	jne    16d0 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    16bb:	83 ec 04             	sub    $0x4,%esp
    16be:	ff 75 08             	pushl  0x8(%ebp)
    16c1:	68 c0 20 00 00       	push   $0x20c0
    16c6:	6a 01                	push   $0x1
    16c8:	e8 e6 ee ff ff       	call   5b3 <printf>
    16cd:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    16d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d3:	8b 40 34             	mov    0x34(%eax),%eax
    16d6:	89 c2                	mov    %eax,%edx
    16d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16db:	8b 40 38             	mov    0x38(%eax),%eax
    16de:	0f af d0             	imul   %eax,%edx
    16e1:	89 d0                	mov    %edx,%eax
    16e3:	01 c0                	add    %eax,%eax
    16e5:	01 c2                	add    %eax,%edx
    16e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ea:	8b 40 4c             	mov    0x4c(%eax),%eax
    16ed:	83 ec 04             	sub    $0x4,%esp
    16f0:	52                   	push   %edx
    16f1:	68 ff 00 00 00       	push   $0xff
    16f6:	50                   	push   %eax
    16f7:	e8 7d eb ff ff       	call   279 <memset>
    16fc:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    16ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1702:	8b 55 0c             	mov    0xc(%ebp),%edx
    1705:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1708:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    170c:	74 35                	je     1743 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    170e:	8b 45 10             	mov    0x10(%ebp),%eax
    1711:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1717:	83 ec 0c             	sub    $0xc,%esp
    171a:	50                   	push   %eax
    171b:	e8 66 f1 ff ff       	call   886 <malloc>
    1720:	83 c4 10             	add    $0x10,%esp
    1723:	89 c2                	mov    %eax,%edx
    1725:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1728:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    172b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172e:	8b 55 10             	mov    0x10(%ebp),%edx
    1731:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1734:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1737:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    173e:	e9 8d 00 00 00       	jmp    17d0 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1743:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1746:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    174d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1750:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1757:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175a:	8b 40 18             	mov    0x18(%eax),%eax
    175d:	89 c2                	mov    %eax,%edx
    175f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1762:	8b 40 1c             	mov    0x1c(%eax),%eax
    1765:	0f af d0             	imul   %eax,%edx
    1768:	89 d0                	mov    %edx,%eax
    176a:	01 c0                	add    %eax,%eax
    176c:	01 d0                	add    %edx,%eax
    176e:	83 ec 0c             	sub    $0xc,%esp
    1771:	50                   	push   %eax
    1772:	e8 0f f1 ff ff       	call   886 <malloc>
    1777:	83 c4 10             	add    $0x10,%esp
    177a:	89 c2                	mov    %eax,%edx
    177c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177f:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    1782:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1785:	8b 40 30             	mov    0x30(%eax),%eax
    1788:	85 c0                	test   %eax,%eax
    178a:	75 15                	jne    17a1 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    178c:	83 ec 04             	sub    $0x4,%esp
    178f:	ff 75 08             	pushl  0x8(%ebp)
    1792:	68 e8 20 00 00       	push   $0x20e8
    1797:	6a 01                	push   $0x1
    1799:	e8 15 ee ff ff       	call   5b3 <printf>
    179e:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    17a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a4:	8b 40 18             	mov    0x18(%eax),%eax
    17a7:	89 c2                	mov    %eax,%edx
    17a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ac:	8b 40 1c             	mov    0x1c(%eax),%eax
    17af:	0f af d0             	imul   %eax,%edx
    17b2:	89 d0                	mov    %edx,%eax
    17b4:	01 c0                	add    %eax,%eax
    17b6:	01 c2                	add    %eax,%edx
    17b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bb:	8b 40 30             	mov    0x30(%eax),%eax
    17be:	83 ec 04             	sub    $0x4,%esp
    17c1:	52                   	push   %edx
    17c2:	68 ff ff ff 00       	push   $0xffffff
    17c7:	50                   	push   %eax
    17c8:	e8 ac ea ff ff       	call   279 <memset>
    17cd:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    17d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    17d3:	c9                   	leave  
    17d4:	c3                   	ret    

000017d5 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    17d5:	55                   	push   %ebp
    17d6:	89 e5                	mov    %esp,%ebp
    17d8:	53                   	push   %ebx
    17d9:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    17dc:	8b 45 0c             	mov    0xc(%ebp),%eax
    17df:	83 f8 03             	cmp    $0x3,%eax
    17e2:	74 02                	je     17e6 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    17e4:	eb 33                	jmp    1819 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    17e6:	8b 45 08             	mov    0x8(%ebp),%eax
    17e9:	8b 48 08             	mov    0x8(%eax),%ecx
    17ec:	8b 45 08             	mov    0x8(%ebp),%eax
    17ef:	8b 50 38             	mov    0x38(%eax),%edx
    17f2:	8b 45 08             	mov    0x8(%ebp),%eax
    17f5:	8b 40 34             	mov    0x34(%eax),%eax
    17f8:	8b 5d 08             	mov    0x8(%ebp),%ebx
    17fb:	83 c3 34             	add    $0x34,%ebx
    17fe:	83 ec 0c             	sub    $0xc,%esp
    1801:	51                   	push   %ecx
    1802:	52                   	push   %edx
    1803:	50                   	push   %eax
    1804:	6a 00                	push   $0x0
    1806:	6a 00                	push   $0x0
    1808:	53                   	push   %ebx
    1809:	6a 32                	push   $0x32
    180b:	6a 00                	push   $0x0
    180d:	ff 75 08             	pushl  0x8(%ebp)
    1810:	e8 9f ec ff ff       	call   4b4 <paintWindow>
    1815:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1818:	90                   	nop
        default: break;
            
            
    }
    return False;
    1819:	b8 00 00 00 00       	mov    $0x0,%eax
}
    181e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1821:	c9                   	leave  
    1822:	c3                   	ret    

00001823 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1823:	55                   	push   %ebp
    1824:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1826:	8b 45 0c             	mov    0xc(%ebp),%eax
    1829:	8b 50 08             	mov    0x8(%eax),%edx
    182c:	8b 45 08             	mov    0x8(%ebp),%eax
    182f:	8b 00                	mov    (%eax),%eax
    1831:	39 c2                	cmp    %eax,%edx
    1833:	74 07                	je     183c <APPreJudge+0x19>
        return False;
    1835:	b8 00 00 00 00       	mov    $0x0,%eax
    183a:	eb 05                	jmp    1841 <APPreJudge+0x1e>
    return True;
    183c:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1841:	5d                   	pop    %ebp
    1842:	c3                   	ret    

00001843 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1843:	55                   	push   %ebp
    1844:	89 e5                	mov    %esp,%ebp
    1846:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1849:	8b 45 08             	mov    0x8(%ebp),%eax
    184c:	8b 55 0c             	mov    0xc(%ebp),%edx
    184f:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    1852:	83 ec 0c             	sub    $0xc,%esp
    1855:	ff 75 08             	pushl  0x8(%ebp)
    1858:	e8 77 ec ff ff       	call   4d4 <registWindow>
    185d:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1860:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1867:	8b 45 08             	mov    0x8(%ebp),%eax
    186a:	8b 00                	mov    (%eax),%eax
    186c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    186f:	ff 75 f4             	pushl  -0xc(%ebp)
    1872:	ff 75 f0             	pushl  -0x10(%ebp)
    1875:	ff 75 ec             	pushl  -0x14(%ebp)
    1878:	ff 75 08             	pushl  0x8(%ebp)
    187b:	e8 e7 fc ff ff       	call   1567 <APSendMessage>
    1880:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1883:	83 ec 0c             	sub    $0xc,%esp
    1886:	ff 75 08             	pushl  0x8(%ebp)
    1889:	e8 3e ec ff ff       	call   4cc <getMessage>
    188e:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1891:	8b 45 08             	mov    0x8(%ebp),%eax
    1894:	83 c0 6c             	add    $0x6c,%eax
    1897:	83 ec 08             	sub    $0x8,%esp
    189a:	50                   	push   %eax
    189b:	ff 75 08             	pushl  0x8(%ebp)
    189e:	e8 80 ff ff ff       	call   1823 <APPreJudge>
    18a3:	83 c4 10             	add    $0x10,%esp
    18a6:	84 c0                	test   %al,%al
    18a8:	74 1b                	je     18c5 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    18aa:	8b 45 08             	mov    0x8(%ebp),%eax
    18ad:	ff 70 74             	pushl  0x74(%eax)
    18b0:	ff 70 70             	pushl  0x70(%eax)
    18b3:	ff 70 6c             	pushl  0x6c(%eax)
    18b6:	ff 75 08             	pushl  0x8(%ebp)
    18b9:	8b 45 0c             	mov    0xc(%ebp),%eax
    18bc:	ff d0                	call   *%eax
    18be:	83 c4 10             	add    $0x10,%esp
    18c1:	84 c0                	test   %al,%al
    18c3:	75 0c                	jne    18d1 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    18c5:	8b 45 08             	mov    0x8(%ebp),%eax
    18c8:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    18cf:	eb b2                	jmp    1883 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    18d1:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    18d2:	90                   	nop
    18d3:	c9                   	leave  
    18d4:	c3                   	ret    

000018d5 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    18d5:	55                   	push   %ebp
    18d6:	89 e5                	mov    %esp,%ebp
    18d8:	57                   	push   %edi
    18d9:	56                   	push   %esi
    18da:	53                   	push   %ebx
    18db:	83 ec 4c             	sub    $0x4c,%esp
    if (!iconReady)
    18de:	a1 0c 27 00 00       	mov    0x270c,%eax
    18e3:	85 c0                	test   %eax,%eax
    18e5:	75 7c                	jne    1963 <APGridPaint+0x8e>
    {
        iconReady = 1;
    18e7:	c7 05 0c 27 00 00 01 	movl   $0x1,0x270c
    18ee:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("Snake.bmp");
    18f1:	8d 45 b8             	lea    -0x48(%ebp),%eax
    18f4:	83 ec 08             	sub    $0x8,%esp
    18f7:	68 0f 21 00 00       	push   $0x210f
    18fc:	50                   	push   %eax
    18fd:	e8 37 f1 ff ff       	call   a39 <APLoadBitmap>
    1902:	83 c4 0c             	add    $0xc,%esp
    1905:	8b 45 b8             	mov    -0x48(%ebp),%eax
    1908:	a3 20 29 00 00       	mov    %eax,0x2920
    190d:	8b 45 bc             	mov    -0x44(%ebp),%eax
    1910:	a3 24 29 00 00       	mov    %eax,0x2924
    1915:	8b 45 c0             	mov    -0x40(%ebp),%eax
    1918:	a3 28 29 00 00       	mov    %eax,0x2928
        printf(1,"bitmap loaded!\n");
    191d:	83 ec 08             	sub    $0x8,%esp
    1920:	68 19 21 00 00       	push   $0x2119
    1925:	6a 01                	push   $0x1
    1927:	e8 87 ec ff ff       	call   5b3 <printf>
    192c:	83 c4 10             	add    $0x10,%esp
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    192f:	83 ec 04             	sub    $0x4,%esp
    1932:	ff 35 28 29 00 00    	pushl  0x2928
    1938:	ff 35 24 29 00 00    	pushl  0x2924
    193e:	ff 35 20 29 00 00    	pushl  0x2920
    1944:	e8 7a f3 ff ff       	call   cc3 <APCreateCompatibleDCFromBitmap>
    1949:	83 c4 10             	add    $0x10,%esp
    194c:	a3 2c 29 00 00       	mov    %eax,0x292c
        printf(1,"bitmap DC created!\n");
    1951:	83 ec 08             	sub    $0x8,%esp
    1954:	68 29 21 00 00       	push   $0x2129
    1959:	6a 01                	push   $0x1
    195b:	e8 53 ec ff ff       	call   5b3 <printf>
    1960:	83 c4 10             	add    $0x10,%esp
    }
    
    if (!wnd->is_grid)
    1963:	8b 45 08             	mov    0x8(%ebp),%eax
    1966:	8b 40 08             	mov    0x8(%eax),%eax
    1969:	85 c0                	test   %eax,%eax
    196b:	75 17                	jne    1984 <APGridPaint+0xaf>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    196d:	83 ec 08             	sub    $0x8,%esp
    1970:	68 40 21 00 00       	push   $0x2140
    1975:	6a 01                	push   $0x1
    1977:	e8 37 ec ff ff       	call   5b3 <printf>
    197c:	83 c4 10             	add    $0x10,%esp
        return;
    197f:	e9 55 03 00 00       	jmp    1cd9 <APGridPaint+0x404>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1984:	8b 45 08             	mov    0x8(%ebp),%eax
    1987:	8b 40 10             	mov    0x10(%eax),%eax
    198a:	85 c0                	test   %eax,%eax
    198c:	7e 10                	jle    199e <APGridPaint+0xc9>
    198e:	8b 45 08             	mov    0x8(%ebp),%eax
    1991:	8b 50 14             	mov    0x14(%eax),%edx
    1994:	8b 45 08             	mov    0x8(%ebp),%eax
    1997:	8b 40 10             	mov    0x10(%eax),%eax
    199a:	39 c2                	cmp    %eax,%edx
    199c:	7c 17                	jl     19b5 <APGridPaint+0xe0>
    {
        printf(1,"Grid mode page error!");
    199e:	83 ec 08             	sub    $0x8,%esp
    19a1:	68 66 21 00 00       	push   $0x2166
    19a6:	6a 01                	push   $0x1
    19a8:	e8 06 ec ff ff       	call   5b3 <printf>
    19ad:	83 c4 10             	add    $0x10,%esp
        return;
    19b0:	e9 24 03 00 00       	jmp    1cd9 <APGridPaint+0x404>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    19b5:	8b 45 08             	mov    0x8(%ebp),%eax
    19b8:	8b 40 14             	mov    0x14(%eax),%eax
    19bb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    19c1:	89 45 dc             	mov    %eax,-0x24(%ebp)
    19c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
    19c7:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    19ca:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    19d1:	e9 f9 02 00 00       	jmp    1ccf <APGridPaint+0x3fa>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    19d6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    19dd:	e9 df 02 00 00       	jmp    1cc1 <APGridPaint+0x3ec>
        {
            index = start + GRID_W_NUMBER * j + i;
    19e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19e5:	c1 e0 04             	shl    $0x4,%eax
    19e8:	89 c2                	mov    %eax,%edx
    19ea:	8b 45 d8             	mov    -0x28(%ebp),%eax
    19ed:	01 c2                	add    %eax,%edx
    19ef:	8b 45 e0             	mov    -0x20(%ebp),%eax
    19f2:	01 d0                	add    %edx,%eax
    19f4:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    19f7:	8b 45 08             	mov    0x8(%ebp),%eax
    19fa:	8b 40 0c             	mov    0xc(%eax),%eax
    19fd:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a00:	c1 e2 02             	shl    $0x2,%edx
    1a03:	01 d0                	add    %edx,%eax
    1a05:	8b 00                	mov    (%eax),%eax
    1a07:	83 f8 01             	cmp    $0x1,%eax
    1a0a:	0f 84 83 00 00 00    	je     1a93 <APGridPaint+0x1be>
    1a10:	83 f8 01             	cmp    $0x1,%eax
    1a13:	7f 09                	jg     1a1e <APGridPaint+0x149>
    1a15:	85 c0                	test   %eax,%eax
    1a17:	74 1c                	je     1a35 <APGridPaint+0x160>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    1a19:	e9 9f 02 00 00       	jmp    1cbd <APGridPaint+0x3e8>
        for (int i = 0; i < GRID_W_NUMBER;i++)
        {
            index = start + GRID_W_NUMBER * j + i;
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a1e:	83 f8 02             	cmp    $0x2,%eax
    1a21:	0f 84 20 01 00 00    	je     1b47 <APGridPaint+0x272>
    1a27:	83 f8 03             	cmp    $0x3,%eax
    1a2a:	0f 84 d1 01 00 00    	je     1c01 <APGridPaint+0x32c>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    1a30:	e9 88 02 00 00       	jmp    1cbd <APGridPaint+0x3e8>
                    pen.size = 1;
                    brush.color = RGB(0xd2,0x69,0x1e);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);*/
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1a35:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1a38:	6a 0c                	push   $0xc
    1a3a:	6a 0c                	push   $0xc
    1a3c:	6a 0c                	push   $0xc
    1a3e:	50                   	push   %eax
    1a3f:	e8 de fa ff ff       	call   1522 <RGB>
    1a44:	83 c4 0c             	add    $0xc,%esp
    1a47:	8b 1d 2c 29 00 00    	mov    0x292c,%ebx
    1a4d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a50:	6b c8 32             	imul   $0x32,%eax,%ecx
    1a53:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a56:	6b c0 32             	imul   $0x32,%eax,%eax
    1a59:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    1a5c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5f:	8d 78 34             	lea    0x34(%eax),%edi
    1a62:	83 ec 0c             	sub    $0xc,%esp
    1a65:	83 ec 04             	sub    $0x4,%esp
    1a68:	89 e0                	mov    %esp,%eax
    1a6a:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1a6e:	66 89 30             	mov    %si,(%eax)
    1a71:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1a75:	88 50 02             	mov    %dl,0x2(%eax)
    1a78:	6a 32                	push   $0x32
    1a7a:	6a 32                	push   $0x32
    1a7c:	6a 00                	push   $0x0
    1a7e:	6a 00                	push   $0x0
    1a80:	53                   	push   %ebx
    1a81:	51                   	push   %ecx
    1a82:	ff 75 b4             	pushl  -0x4c(%ebp)
    1a85:	57                   	push   %edi
    1a86:	e8 f3 f8 ff ff       	call   137e <APDcCopy>
    1a8b:	83 c4 30             	add    $0x30,%esp
                    break;
    1a8e:	e9 2a 02 00 00       	jmp    1cbd <APGridPaint+0x3e8>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1a93:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a96:	6a 69                	push   $0x69
    1a98:	6a 69                	push   $0x69
    1a9a:	6a 69                	push   $0x69
    1a9c:	50                   	push   %eax
    1a9d:	e8 80 fa ff ff       	call   1522 <RGB>
    1aa2:	83 c4 0c             	add    $0xc,%esp
    1aa5:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1aa9:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1aad:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1ab1:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1ab4:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1abb:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1abe:	6a 69                	push   $0x69
    1ac0:	6a 69                	push   $0x69
    1ac2:	6a 69                	push   $0x69
    1ac4:	50                   	push   %eax
    1ac5:	e8 58 fa ff ff       	call   1522 <RGB>
    1aca:	83 c4 0c             	add    $0xc,%esp
    1acd:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1ad1:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1ad5:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1ad9:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1adc:	8b 45 08             	mov    0x8(%ebp),%eax
    1adf:	8d 50 34             	lea    0x34(%eax),%edx
    1ae2:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1ae5:	ff 75 d0             	pushl  -0x30(%ebp)
    1ae8:	ff 75 cc             	pushl  -0x34(%ebp)
    1aeb:	52                   	push   %edx
    1aec:	50                   	push   %eax
    1aed:	e8 66 f2 ff ff       	call   d58 <APSetPen>
    1af2:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1af5:	8b 45 08             	mov    0x8(%ebp),%eax
    1af8:	8d 58 34             	lea    0x34(%eax),%ebx
    1afb:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1afe:	83 ec 04             	sub    $0x4,%esp
    1b01:	83 ec 04             	sub    $0x4,%esp
    1b04:	89 e0                	mov    %esp,%eax
    1b06:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1b0a:	66 89 08             	mov    %cx,(%eax)
    1b0d:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1b11:	88 48 02             	mov    %cl,0x2(%eax)
    1b14:	53                   	push   %ebx
    1b15:	52                   	push   %edx
    1b16:	e8 76 f2 ff ff       	call   d91 <APSetBrush>
    1b1b:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b1e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b21:	6b d0 32             	imul   $0x32,%eax,%edx
    1b24:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b27:	6b c0 32             	imul   $0x32,%eax,%eax
    1b2a:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b2d:	83 c1 34             	add    $0x34,%ecx
    1b30:	83 ec 0c             	sub    $0xc,%esp
    1b33:	6a 32                	push   $0x32
    1b35:	6a 32                	push   $0x32
    1b37:	52                   	push   %edx
    1b38:	50                   	push   %eax
    1b39:	51                   	push   %ecx
    1b3a:	e8 3a f6 ff ff       	call   1179 <APDrawRect>
    1b3f:	83 c4 20             	add    $0x20,%esp
                    break;
    1b42:	e9 76 01 00 00       	jmp    1cbd <APGridPaint+0x3e8>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    pen.color = RGB(0x00,0x80,0x00);
    1b47:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b4a:	6a 00                	push   $0x0
    1b4c:	68 80 00 00 00       	push   $0x80
    1b51:	6a 00                	push   $0x0
    1b53:	50                   	push   %eax
    1b54:	e8 c9 f9 ff ff       	call   1522 <RGB>
    1b59:	83 c4 0c             	add    $0xc,%esp
    1b5c:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1b60:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1b64:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1b68:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1b6b:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0x80,0x00);
    1b72:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b75:	6a 00                	push   $0x0
    1b77:	68 80 00 00 00       	push   $0x80
    1b7c:	6a 00                	push   $0x0
    1b7e:	50                   	push   %eax
    1b7f:	e8 9e f9 ff ff       	call   1522 <RGB>
    1b84:	83 c4 0c             	add    $0xc,%esp
    1b87:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1b8b:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1b8f:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1b93:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b96:	8b 45 08             	mov    0x8(%ebp),%eax
    1b99:	8d 50 34             	lea    0x34(%eax),%edx
    1b9c:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b9f:	ff 75 d0             	pushl  -0x30(%ebp)
    1ba2:	ff 75 cc             	pushl  -0x34(%ebp)
    1ba5:	52                   	push   %edx
    1ba6:	50                   	push   %eax
    1ba7:	e8 ac f1 ff ff       	call   d58 <APSetPen>
    1bac:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1baf:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb2:	8d 58 34             	lea    0x34(%eax),%ebx
    1bb5:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1bb8:	83 ec 04             	sub    $0x4,%esp
    1bbb:	83 ec 04             	sub    $0x4,%esp
    1bbe:	89 e0                	mov    %esp,%eax
    1bc0:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1bc4:	66 89 08             	mov    %cx,(%eax)
    1bc7:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1bcb:	88 48 02             	mov    %cl,0x2(%eax)
    1bce:	53                   	push   %ebx
    1bcf:	52                   	push   %edx
    1bd0:	e8 bc f1 ff ff       	call   d91 <APSetBrush>
    1bd5:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1bd8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bdb:	6b d0 32             	imul   $0x32,%eax,%edx
    1bde:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1be1:	6b c0 32             	imul   $0x32,%eax,%eax
    1be4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1be7:	83 c1 34             	add    $0x34,%ecx
    1bea:	83 ec 0c             	sub    $0xc,%esp
    1bed:	6a 32                	push   $0x32
    1bef:	6a 32                	push   $0x32
    1bf1:	52                   	push   %edx
    1bf2:	50                   	push   %eax
    1bf3:	51                   	push   %ecx
    1bf4:	e8 80 f5 ff ff       	call   1179 <APDrawRect>
    1bf9:	83 c4 20             	add    $0x20,%esp
                    break;
    1bfc:	e9 bc 00 00 00       	jmp    1cbd <APGridPaint+0x3e8>
                case GRID_RIVER:
                    //printf(1,"Grid_River");
                    pen.color = RGB(0x00,0xbf,0xff);
    1c01:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1c04:	68 ff 00 00 00       	push   $0xff
    1c09:	68 bf 00 00 00       	push   $0xbf
    1c0e:	6a 00                	push   $0x0
    1c10:	50                   	push   %eax
    1c11:	e8 0c f9 ff ff       	call   1522 <RGB>
    1c16:	83 c4 0c             	add    $0xc,%esp
    1c19:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1c1d:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1c21:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1c25:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1c28:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0xbf,0xff);
    1c2f:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1c32:	68 ff 00 00 00       	push   $0xff
    1c37:	68 bf 00 00 00       	push   $0xbf
    1c3c:	6a 00                	push   $0x0
    1c3e:	50                   	push   %eax
    1c3f:	e8 de f8 ff ff       	call   1522 <RGB>
    1c44:	83 c4 0c             	add    $0xc,%esp
    1c47:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1c4b:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1c4f:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1c53:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1c56:	8b 45 08             	mov    0x8(%ebp),%eax
    1c59:	8d 50 34             	lea    0x34(%eax),%edx
    1c5c:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1c5f:	ff 75 d0             	pushl  -0x30(%ebp)
    1c62:	ff 75 cc             	pushl  -0x34(%ebp)
    1c65:	52                   	push   %edx
    1c66:	50                   	push   %eax
    1c67:	e8 ec f0 ff ff       	call   d58 <APSetPen>
    1c6c:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1c6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c72:	8d 58 34             	lea    0x34(%eax),%ebx
    1c75:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1c78:	83 ec 04             	sub    $0x4,%esp
    1c7b:	83 ec 04             	sub    $0x4,%esp
    1c7e:	89 e0                	mov    %esp,%eax
    1c80:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1c84:	66 89 08             	mov    %cx,(%eax)
    1c87:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1c8b:	88 48 02             	mov    %cl,0x2(%eax)
    1c8e:	53                   	push   %ebx
    1c8f:	52                   	push   %edx
    1c90:	e8 fc f0 ff ff       	call   d91 <APSetBrush>
    1c95:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
    1c98:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c9b:	6b d0 32             	imul   $0x32,%eax,%edx
    1c9e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ca1:	6b c0 32             	imul   $0x32,%eax,%eax
    1ca4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1ca7:	83 c1 34             	add    $0x34,%ecx
    1caa:	83 ec 0c             	sub    $0xc,%esp
    1cad:	6a 32                	push   $0x32
    1caf:	6a 32                	push   $0x32
    1cb1:	52                   	push   %edx
    1cb2:	50                   	push   %eax
    1cb3:	51                   	push   %ecx
    1cb4:	e8 c0 f4 ff ff       	call   1179 <APDrawRect>
    1cb9:	83 c4 20             	add    $0x20,%esp
                    break;
    1cbc:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1cbd:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1cc1:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1cc5:	0f 8e 17 fd ff ff    	jle    19e2 <APGridPaint+0x10d>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1ccb:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1ccf:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1cd3:	0f 8e fd fc ff ff    	jle    19d6 <APGridPaint+0x101>
                    break;
                default: break;
            }
        }
    }
}
    1cd9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1cdc:	5b                   	pop    %ebx
    1cdd:	5e                   	pop    %esi
    1cde:	5f                   	pop    %edi
    1cdf:	5d                   	pop    %ebp
    1ce0:	c3                   	ret    

00001ce1 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1ce1:	55                   	push   %ebp
    1ce2:	89 e5                	mov    %esp,%ebp
    1ce4:	53                   	push   %ebx
    1ce5:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1ce8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1cef:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1cf3:	74 17                	je     1d0c <sprintint+0x2b>
    1cf5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1cf9:	79 11                	jns    1d0c <sprintint+0x2b>
        neg = 1;
    1cfb:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1d02:	8b 45 10             	mov    0x10(%ebp),%eax
    1d05:	f7 d8                	neg    %eax
    1d07:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1d0a:	eb 06                	jmp    1d12 <sprintint+0x31>
    } else {
        x = xx;
    1d0c:	8b 45 10             	mov    0x10(%ebp),%eax
    1d0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1d12:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1d19:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1d1c:	8d 41 01             	lea    0x1(%ecx),%eax
    1d1f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1d22:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1d25:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d28:	ba 00 00 00 00       	mov    $0x0,%edx
    1d2d:	f7 f3                	div    %ebx
    1d2f:	89 d0                	mov    %edx,%eax
    1d31:	0f b6 80 d4 26 00 00 	movzbl 0x26d4(%eax),%eax
    1d38:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1d3c:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1d3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d42:	ba 00 00 00 00       	mov    $0x0,%edx
    1d47:	f7 f3                	div    %ebx
    1d49:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1d4c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d50:	75 c7                	jne    1d19 <sprintint+0x38>
    if(neg)
    1d52:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d56:	74 0e                	je     1d66 <sprintint+0x85>
        buf[i++] = '-';
    1d58:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1d5b:	8d 50 01             	lea    0x1(%eax),%edx
    1d5e:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1d61:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1d66:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1d69:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1d6c:	eb 1b                	jmp    1d89 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1d6e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d71:	8b 00                	mov    (%eax),%eax
    1d73:	8d 48 01             	lea    0x1(%eax),%ecx
    1d76:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d79:	89 0a                	mov    %ecx,(%edx)
    1d7b:	89 c2                	mov    %eax,%edx
    1d7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d80:	01 d0                	add    %edx,%eax
    1d82:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1d85:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1d89:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1d8d:	7f df                	jg     1d6e <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1d8f:	eb 21                	jmp    1db2 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1d91:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d94:	8b 00                	mov    (%eax),%eax
    1d96:	8d 48 01             	lea    0x1(%eax),%ecx
    1d99:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d9c:	89 0a                	mov    %ecx,(%edx)
    1d9e:	89 c2                	mov    %eax,%edx
    1da0:	8b 45 08             	mov    0x8(%ebp),%eax
    1da3:	01 c2                	add    %eax,%edx
    1da5:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1da8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1dab:	01 c8                	add    %ecx,%eax
    1dad:	0f b6 00             	movzbl (%eax),%eax
    1db0:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1db2:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1db6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1dba:	79 d5                	jns    1d91 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1dbc:	90                   	nop
    1dbd:	83 c4 20             	add    $0x20,%esp
    1dc0:	5b                   	pop    %ebx
    1dc1:	5d                   	pop    %ebp
    1dc2:	c3                   	ret    

00001dc3 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1dc3:	55                   	push   %ebp
    1dc4:	89 e5                	mov    %esp,%ebp
    1dc6:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1dc9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1dd0:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1dd7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1dde:	8d 45 0c             	lea    0xc(%ebp),%eax
    1de1:	83 c0 04             	add    $0x4,%eax
    1de4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1de7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1dee:	e9 d9 01 00 00       	jmp    1fcc <sprintf+0x209>
        c = fmt[i] & 0xff;
    1df3:	8b 55 0c             	mov    0xc(%ebp),%edx
    1df6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1df9:	01 d0                	add    %edx,%eax
    1dfb:	0f b6 00             	movzbl (%eax),%eax
    1dfe:	0f be c0             	movsbl %al,%eax
    1e01:	25 ff 00 00 00       	and    $0xff,%eax
    1e06:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1e09:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1e0d:	75 2c                	jne    1e3b <sprintf+0x78>
            if(c == '%'){
    1e0f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1e13:	75 0c                	jne    1e21 <sprintf+0x5e>
                state = '%';
    1e15:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1e1c:	e9 a7 01 00 00       	jmp    1fc8 <sprintf+0x205>
            } else {
                dst[j++] = c;
    1e21:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e24:	8d 50 01             	lea    0x1(%eax),%edx
    1e27:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e2a:	89 c2                	mov    %eax,%edx
    1e2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e2f:	01 d0                	add    %edx,%eax
    1e31:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1e34:	88 10                	mov    %dl,(%eax)
    1e36:	e9 8d 01 00 00       	jmp    1fc8 <sprintf+0x205>
            }
        } else if(state == '%'){
    1e3b:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1e3f:	0f 85 83 01 00 00    	jne    1fc8 <sprintf+0x205>
            if(c == 'd'){
    1e45:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1e49:	75 4c                	jne    1e97 <sprintf+0xd4>
                buf[bi] = '\0';
    1e4b:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1e4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e51:	01 d0                	add    %edx,%eax
    1e53:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1e56:	83 ec 0c             	sub    $0xc,%esp
    1e59:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1e5c:	50                   	push   %eax
    1e5d:	e8 20 e5 ff ff       	call   382 <atoi>
    1e62:	83 c4 10             	add    $0x10,%esp
    1e65:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1e68:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1e6f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e72:	8b 00                	mov    (%eax),%eax
    1e74:	83 ec 08             	sub    $0x8,%esp
    1e77:	ff 75 d8             	pushl  -0x28(%ebp)
    1e7a:	6a 01                	push   $0x1
    1e7c:	6a 0a                	push   $0xa
    1e7e:	50                   	push   %eax
    1e7f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1e82:	50                   	push   %eax
    1e83:	ff 75 08             	pushl  0x8(%ebp)
    1e86:	e8 56 fe ff ff       	call   1ce1 <sprintint>
    1e8b:	83 c4 20             	add    $0x20,%esp
                ap++;
    1e8e:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1e92:	e9 2a 01 00 00       	jmp    1fc1 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1e97:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1e9b:	74 06                	je     1ea3 <sprintf+0xe0>
    1e9d:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1ea1:	75 4c                	jne    1eef <sprintf+0x12c>
                buf[bi] = '\0';
    1ea3:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1ea6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ea9:	01 d0                	add    %edx,%eax
    1eab:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1eae:	83 ec 0c             	sub    $0xc,%esp
    1eb1:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1eb4:	50                   	push   %eax
    1eb5:	e8 c8 e4 ff ff       	call   382 <atoi>
    1eba:	83 c4 10             	add    $0x10,%esp
    1ebd:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1ec0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1ec7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1eca:	8b 00                	mov    (%eax),%eax
    1ecc:	83 ec 08             	sub    $0x8,%esp
    1ecf:	ff 75 dc             	pushl  -0x24(%ebp)
    1ed2:	6a 00                	push   $0x0
    1ed4:	6a 10                	push   $0x10
    1ed6:	50                   	push   %eax
    1ed7:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1eda:	50                   	push   %eax
    1edb:	ff 75 08             	pushl  0x8(%ebp)
    1ede:	e8 fe fd ff ff       	call   1ce1 <sprintint>
    1ee3:	83 c4 20             	add    $0x20,%esp
                ap++;
    1ee6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1eea:	e9 d2 00 00 00       	jmp    1fc1 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1eef:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1ef3:	75 46                	jne    1f3b <sprintf+0x178>
                s = (char*)*ap;
    1ef5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ef8:	8b 00                	mov    (%eax),%eax
    1efa:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1efd:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1f01:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f05:	75 25                	jne    1f2c <sprintf+0x169>
                    s = "(null)";
    1f07:	c7 45 f4 7c 21 00 00 	movl   $0x217c,-0xc(%ebp)
                while(*s != 0){
    1f0e:	eb 1c                	jmp    1f2c <sprintf+0x169>
                    dst[j++] = *s;
    1f10:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f13:	8d 50 01             	lea    0x1(%eax),%edx
    1f16:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f19:	89 c2                	mov    %eax,%edx
    1f1b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f1e:	01 c2                	add    %eax,%edx
    1f20:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f23:	0f b6 00             	movzbl (%eax),%eax
    1f26:	88 02                	mov    %al,(%edx)
                    s++;
    1f28:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    1f2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f2f:	0f b6 00             	movzbl (%eax),%eax
    1f32:	84 c0                	test   %al,%al
    1f34:	75 da                	jne    1f10 <sprintf+0x14d>
    1f36:	e9 86 00 00 00       	jmp    1fc1 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    1f3b:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    1f3f:	75 1d                	jne    1f5e <sprintf+0x19b>
                dst[j++] = *ap;
    1f41:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f44:	8d 50 01             	lea    0x1(%eax),%edx
    1f47:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f4a:	89 c2                	mov    %eax,%edx
    1f4c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f4f:	01 c2                	add    %eax,%edx
    1f51:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f54:	8b 00                	mov    (%eax),%eax
    1f56:	88 02                	mov    %al,(%edx)
                ap++;
    1f58:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1f5c:	eb 63                	jmp    1fc1 <sprintf+0x1fe>
            } else if(c == '%'){
    1f5e:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1f62:	75 17                	jne    1f7b <sprintf+0x1b8>
                dst[j++] = c;
    1f64:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f67:	8d 50 01             	lea    0x1(%eax),%edx
    1f6a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f6d:	89 c2                	mov    %eax,%edx
    1f6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1f72:	01 d0                	add    %edx,%eax
    1f74:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f77:	88 10                	mov    %dl,(%eax)
    1f79:	eb 46                	jmp    1fc1 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    1f7b:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    1f7f:	7e 18                	jle    1f99 <sprintf+0x1d6>
    1f81:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    1f85:	7f 12                	jg     1f99 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    1f87:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f8a:	8d 50 01             	lea    0x1(%eax),%edx
    1f8d:	89 55 f0             	mov    %edx,-0x10(%ebp)
    1f90:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f93:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    1f97:	eb 2f                	jmp    1fc8 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    1f99:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f9c:	8d 50 01             	lea    0x1(%eax),%edx
    1f9f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1fa2:	89 c2                	mov    %eax,%edx
    1fa4:	8b 45 08             	mov    0x8(%ebp),%eax
    1fa7:	01 d0                	add    %edx,%eax
    1fa9:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    1fac:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1faf:	8d 50 01             	lea    0x1(%eax),%edx
    1fb2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1fb5:	89 c2                	mov    %eax,%edx
    1fb7:	8b 45 08             	mov    0x8(%ebp),%eax
    1fba:	01 d0                	add    %edx,%eax
    1fbc:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1fbf:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    1fc1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    1fc8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1fcc:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fcf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1fd2:	01 d0                	add    %edx,%eax
    1fd4:	0f b6 00             	movzbl (%eax),%eax
    1fd7:	84 c0                	test   %al,%al
    1fd9:	0f 85 14 fe ff ff    	jne    1df3 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    1fdf:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1fe2:	8d 50 01             	lea    0x1(%eax),%edx
    1fe5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1fe8:	89 c2                	mov    %eax,%edx
    1fea:	8b 45 08             	mov    0x8(%ebp),%eax
    1fed:	01 d0                	add    %edx,%eax
    1fef:	c6 00 00             	movb   $0x0,(%eax)
}
    1ff2:	90                   	nop
    1ff3:	c9                   	leave  
    1ff4:	c3                   	ret    
