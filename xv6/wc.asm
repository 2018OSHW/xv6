
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
      32:	05 e0 69 00 00       	add    $0x69e0,%eax
      37:	0f b6 00             	movzbl (%eax),%eax
      3a:	3c 0a                	cmp    $0xa,%al
      3c:	75 04                	jne    42 <wc+0x42>
        l++;
      3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
      42:	8b 45 f4             	mov    -0xc(%ebp),%eax
      45:	05 e0 69 00 00       	add    $0x69e0,%eax
      4a:	0f b6 00             	movzbl (%eax),%eax
      4d:	0f be c0             	movsbl %al,%eax
      50:	83 ec 08             	sub    $0x8,%esp
      53:	50                   	push   %eax
      54:	68 ec 25 00 00       	push   $0x25ec
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
      93:	68 e0 69 00 00       	push   $0x69e0
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
      b9:	68 f2 25 00 00       	push   $0x25f2
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
      dc:	68 02 26 00 00       	push   $0x2602
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
     10a:	68 0f 26 00 00       	push   $0x260f
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
     167:	68 10 26 00 00       	push   $0x2610
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
     56f:	0f b6 80 60 2d 00 00 	movzbl 0x2d60(%eax),%eax
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
     6ad:	c7 45 f4 24 26 00 00 	movl   $0x2624,-0xc(%ebp)
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
     773:	a1 c8 69 00 00       	mov    0x69c8,%eax
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
     83e:	a3 c8 69 00 00       	mov    %eax,0x69c8
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
     89f:	a1 c8 69 00 00       	mov    0x69c8,%eax
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
     8bb:	a1 c8 69 00 00       	mov    0x69c8,%eax
     8c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8c7:	75 23                	jne    8ec <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     8c9:	c7 45 f0 c0 69 00 00 	movl   $0x69c0,-0x10(%ebp)
     8d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8d3:	a3 c8 69 00 00       	mov    %eax,0x69c8
     8d8:	a1 c8 69 00 00       	mov    0x69c8,%eax
     8dd:	a3 c0 69 00 00       	mov    %eax,0x69c0
    base.s.size = 0;
     8e2:	c7 05 c4 69 00 00 00 	movl   $0x0,0x69c4
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
     93f:	a3 c8 69 00 00       	mov    %eax,0x69c8
      return (void*)(p + 1);
     944:	8b 45 f4             	mov    -0xc(%ebp),%eax
     947:	83 c0 08             	add    $0x8,%eax
     94a:	eb 3b                	jmp    987 <malloc+0xe1>
    }
    if(p == freep)
     94c:	a1 c8 69 00 00       	mov    0x69c8,%eax
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
     a92:	68 2b 26 00 00       	push   $0x262b
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
    1436:	05 80 2d 00 00       	add    $0x2d80,%eax
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
    16a7:	68 98 00 00 00       	push   $0x98
    16ac:	e8 f5 f1 ff ff       	call   8a6 <malloc>
    16b1:	83 c4 10             	add    $0x10,%esp
    16b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    16b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16bb:	75 15                	jne    16d2 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    16bd:	83 ec 04             	sub    $0x4,%esp
    16c0:	ff 75 08             	pushl  0x8(%ebp)
    16c3:	68 3c 26 00 00       	push   $0x263c
    16c8:	6a 01                	push   $0x1
    16ca:	e8 04 ef ff ff       	call   5d3 <printf>
    16cf:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    16d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d5:	05 84 00 00 00       	add    $0x84,%eax
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
    1738:	68 5c 26 00 00       	push   $0x265c
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
    17dc:	68 80 26 00 00       	push   $0x2680
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
    18c1:	68 a8 26 00 00       	push   $0x26a8
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
    1913:	74 02                	je     1917 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1915:	eb 7c                	jmp    1993 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1917:	8b 45 08             	mov    0x8(%ebp),%eax
    191a:	8b 58 1c             	mov    0x1c(%eax),%ebx
    191d:	8b 45 08             	mov    0x8(%ebp),%eax
    1920:	8b 48 18             	mov    0x18(%eax),%ecx
    1923:	8b 45 08             	mov    0x8(%ebp),%eax
    1926:	8b 50 5c             	mov    0x5c(%eax),%edx
    1929:	8b 45 08             	mov    0x8(%ebp),%eax
    192c:	8b 40 58             	mov    0x58(%eax),%eax
    192f:	8b 75 08             	mov    0x8(%ebp),%esi
    1932:	83 c6 58             	add    $0x58,%esi
    1935:	83 ec 04             	sub    $0x4,%esp
    1938:	53                   	push   %ebx
    1939:	51                   	push   %ecx
    193a:	6a 00                	push   $0x0
    193c:	52                   	push   %edx
    193d:	50                   	push   %eax
    193e:	6a 00                	push   $0x0
    1940:	6a 00                	push   $0x0
    1942:	56                   	push   %esi
    1943:	6a 00                	push   $0x0
    1945:	6a 00                	push   $0x0
    1947:	ff 75 08             	pushl  0x8(%ebp)
    194a:	e8 65 eb ff ff       	call   4b4 <paintWindow>
    194f:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1952:	8b 45 08             	mov    0x8(%ebp),%eax
    1955:	8b 70 1c             	mov    0x1c(%eax),%esi
    1958:	8b 45 08             	mov    0x8(%ebp),%eax
    195b:	8b 58 18             	mov    0x18(%eax),%ebx
    195e:	8b 45 08             	mov    0x8(%ebp),%eax
    1961:	8b 48 08             	mov    0x8(%eax),%ecx
    1964:	8b 45 08             	mov    0x8(%ebp),%eax
    1967:	8b 50 40             	mov    0x40(%eax),%edx
    196a:	8b 45 08             	mov    0x8(%ebp),%eax
    196d:	8b 40 3c             	mov    0x3c(%eax),%eax
    1970:	8b 7d 08             	mov    0x8(%ebp),%edi
    1973:	83 c7 3c             	add    $0x3c,%edi
    1976:	83 ec 04             	sub    $0x4,%esp
    1979:	56                   	push   %esi
    197a:	53                   	push   %ebx
    197b:	51                   	push   %ecx
    197c:	52                   	push   %edx
    197d:	50                   	push   %eax
    197e:	6a 00                	push   $0x0
    1980:	6a 00                	push   $0x0
    1982:	57                   	push   %edi
    1983:	6a 32                	push   $0x32
    1985:	6a 00                	push   $0x0
    1987:	ff 75 08             	pushl  0x8(%ebp)
    198a:	e8 25 eb ff ff       	call   4b4 <paintWindow>
    198f:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1992:	90                   	nop
        default: break;
            
            
    }
    return False;
    1993:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1998:	8d 65 f4             	lea    -0xc(%ebp),%esp
    199b:	5b                   	pop    %ebx
    199c:	5e                   	pop    %esi
    199d:	5f                   	pop    %edi
    199e:	5d                   	pop    %ebp
    199f:	c3                   	ret    

000019a0 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    19a0:	55                   	push   %ebp
    19a1:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    19a3:	8b 45 0c             	mov    0xc(%ebp),%eax
    19a6:	8b 50 08             	mov    0x8(%eax),%edx
    19a9:	8b 45 08             	mov    0x8(%ebp),%eax
    19ac:	8b 00                	mov    (%eax),%eax
    19ae:	39 c2                	cmp    %eax,%edx
    19b0:	74 07                	je     19b9 <APPreJudge+0x19>
        return False;
    19b2:	b8 00 00 00 00       	mov    $0x0,%eax
    19b7:	eb 05                	jmp    19be <APPreJudge+0x1e>
    return True;
    19b9:	b8 01 00 00 00       	mov    $0x1,%eax
}
    19be:	5d                   	pop    %ebp
    19bf:	c3                   	ret    

000019c0 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    19c0:	55                   	push   %ebp
    19c1:	89 e5                	mov    %esp,%ebp
    19c3:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    19c6:	8b 45 08             	mov    0x8(%ebp),%eax
    19c9:	8b 55 0c             	mov    0xc(%ebp),%edx
    19cc:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    19d2:	83 ec 0c             	sub    $0xc,%esp
    19d5:	ff 75 08             	pushl  0x8(%ebp)
    19d8:	e8 ef ea ff ff       	call   4cc <registWindow>
    19dd:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    19e0:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    19e7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ea:	8b 00                	mov    (%eax),%eax
    19ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    19ef:	ff 75 f4             	pushl  -0xc(%ebp)
    19f2:	ff 75 f0             	pushl  -0x10(%ebp)
    19f5:	ff 75 ec             	pushl  -0x14(%ebp)
    19f8:	ff 75 08             	pushl  0x8(%ebp)
    19fb:	e8 80 fc ff ff       	call   1680 <APSendMessage>
    1a00:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1a03:	83 ec 0c             	sub    $0xc,%esp
    1a06:	ff 75 08             	pushl  0x8(%ebp)
    1a09:	e8 b6 ea ff ff       	call   4c4 <getMessage>
    1a0e:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1a11:	8b 45 08             	mov    0x8(%ebp),%eax
    1a14:	83 c0 74             	add    $0x74,%eax
    1a17:	83 ec 08             	sub    $0x8,%esp
    1a1a:	50                   	push   %eax
    1a1b:	ff 75 08             	pushl  0x8(%ebp)
    1a1e:	e8 7d ff ff ff       	call   19a0 <APPreJudge>
    1a23:	83 c4 10             	add    $0x10,%esp
    1a26:	84 c0                	test   %al,%al
    1a28:	74 1b                	je     1a45 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1a2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2d:	ff 70 7c             	pushl  0x7c(%eax)
    1a30:	ff 70 78             	pushl  0x78(%eax)
    1a33:	ff 70 74             	pushl  0x74(%eax)
    1a36:	ff 75 08             	pushl  0x8(%ebp)
    1a39:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a3c:	ff d0                	call   *%eax
    1a3e:	83 c4 10             	add    $0x10,%esp
    1a41:	84 c0                	test   %al,%al
    1a43:	75 0c                	jne    1a51 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1a45:	8b 45 08             	mov    0x8(%ebp),%eax
    1a48:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1a4f:	eb b2                	jmp    1a03 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1a51:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1a52:	90                   	nop
    1a53:	c9                   	leave  
    1a54:	c3                   	ret    

00001a55 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1a55:	55                   	push   %ebp
    1a56:	89 e5                	mov    %esp,%ebp
    1a58:	57                   	push   %edi
    1a59:	56                   	push   %esi
    1a5a:	53                   	push   %ebx
    1a5b:	83 ec 7c             	sub    $0x7c,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    1a5e:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a61:	6a 08                	push   $0x8
    1a63:	6a 08                	push   $0x8
    1a65:	6a 08                	push   $0x8
    1a67:	50                   	push   %eax
    1a68:	e8 ce fb ff ff       	call   163b <RGB>
    1a6d:	83 c4 0c             	add    $0xc,%esp
    1a70:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1a74:	66 89 45 bd          	mov    %ax,-0x43(%ebp)
    1a78:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1a7c:	88 45 bf             	mov    %al,-0x41(%ebp)
    APSetFont(&wnd->TitleDc,font);
    1a7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a82:	8d 58 58             	lea    0x58(%eax),%ebx
    1a85:	8d 55 88             	lea    -0x78(%ebp),%edx
    1a88:	83 ec 04             	sub    $0x4,%esp
    1a8b:	83 ec 04             	sub    $0x4,%esp
    1a8e:	89 e0                	mov    %esp,%eax
    1a90:	0f b7 4d bd          	movzwl -0x43(%ebp),%ecx
    1a94:	66 89 08             	mov    %cx,(%eax)
    1a97:	0f b6 4d bf          	movzbl -0x41(%ebp),%ecx
    1a9b:	88 48 02             	mov    %cl,0x2(%eax)
    1a9e:	53                   	push   %ebx
    1a9f:	52                   	push   %edx
    1aa0:	e8 fe f2 ff ff       	call   da3 <APSetFont>
    1aa5:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    1aa8:	8b 45 08             	mov    0x8(%ebp),%eax
    1aab:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    1ab1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab4:	83 c0 58             	add    $0x58,%eax
    1ab7:	6a 14                	push   $0x14
    1ab9:	6a 14                	push   $0x14
    1abb:	52                   	push   %edx
    1abc:	50                   	push   %eax
    1abd:	e8 ce f8 ff ff       	call   1390 <APDrawText>
    1ac2:	83 c4 10             	add    $0x10,%esp
    
    if (!iconReady)
    1ac5:	a1 cc 69 00 00       	mov    0x69cc,%eax
    1aca:	85 c0                	test   %eax,%eax
    1acc:	0f 85 7a 02 00 00    	jne    1d4c <APGridPaint+0x2f7>
    {
        iconReady = 1;
    1ad2:	c7 05 cc 69 00 00 01 	movl   $0x1,0x69cc
    1ad9:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1adc:	8d 45 88             	lea    -0x78(%ebp),%eax
    1adf:	83 ec 08             	sub    $0x8,%esp
    1ae2:	68 cf 26 00 00       	push   $0x26cf
    1ae7:	50                   	push   %eax
    1ae8:	e8 6c ef ff ff       	call   a59 <APLoadBitmap>
    1aed:	83 c4 0c             	add    $0xc,%esp
    1af0:	8b 45 88             	mov    -0x78(%ebp),%eax
    1af3:	a3 00 6c 00 00       	mov    %eax,0x6c00
    1af8:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1afb:	a3 04 6c 00 00       	mov    %eax,0x6c04
    1b00:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b03:	a3 08 6c 00 00       	mov    %eax,0x6c08
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1b08:	83 ec 04             	sub    $0x4,%esp
    1b0b:	ff 35 08 6c 00 00    	pushl  0x6c08
    1b11:	ff 35 04 6c 00 00    	pushl  0x6c04
    1b17:	ff 35 00 6c 00 00    	pushl  0x6c00
    1b1d:	e8 71 f1 ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1b22:	83 c4 10             	add    $0x10,%esp
    1b25:	a3 0c 6c 00 00       	mov    %eax,0x6c0c
        grid_river = APLoadBitmap ("grid_river.bmp");
    1b2a:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b2d:	83 ec 08             	sub    $0x8,%esp
    1b30:	68 dd 26 00 00       	push   $0x26dd
    1b35:	50                   	push   %eax
    1b36:	e8 1e ef ff ff       	call   a59 <APLoadBitmap>
    1b3b:	83 c4 0c             	add    $0xc,%esp
    1b3e:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b41:	a3 48 6c 00 00       	mov    %eax,0x6c48
    1b46:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b49:	a3 4c 6c 00 00       	mov    %eax,0x6c4c
    1b4e:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b51:	a3 50 6c 00 00       	mov    %eax,0x6c50
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1b56:	83 ec 04             	sub    $0x4,%esp
    1b59:	ff 35 50 6c 00 00    	pushl  0x6c50
    1b5f:	ff 35 4c 6c 00 00    	pushl  0x6c4c
    1b65:	ff 35 48 6c 00 00    	pushl  0x6c48
    1b6b:	e8 23 f1 ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1b70:	83 c4 10             	add    $0x10,%esp
    1b73:	a3 38 6c 00 00       	mov    %eax,0x6c38
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1b78:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b7b:	83 ec 08             	sub    $0x8,%esp
    1b7e:	68 ec 26 00 00       	push   $0x26ec
    1b83:	50                   	push   %eax
    1b84:	e8 d0 ee ff ff       	call   a59 <APLoadBitmap>
    1b89:	83 c4 0c             	add    $0xc,%esp
    1b8c:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b8f:	a3 3c 6c 00 00       	mov    %eax,0x6c3c
    1b94:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b97:	a3 40 6c 00 00       	mov    %eax,0x6c40
    1b9c:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b9f:	a3 44 6c 00 00       	mov    %eax,0x6c44
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1ba4:	83 ec 04             	sub    $0x4,%esp
    1ba7:	ff 35 44 6c 00 00    	pushl  0x6c44
    1bad:	ff 35 40 6c 00 00    	pushl  0x6c40
    1bb3:	ff 35 3c 6c 00 00    	pushl  0x6c3c
    1bb9:	e8 d5 f0 ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1bbe:	83 c4 10             	add    $0x10,%esp
    1bc1:	a3 e0 6b 00 00       	mov    %eax,0x6be0
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1bc6:	8d 45 88             	lea    -0x78(%ebp),%eax
    1bc9:	83 ec 08             	sub    $0x8,%esp
    1bcc:	68 fb 26 00 00       	push   $0x26fb
    1bd1:	50                   	push   %eax
    1bd2:	e8 82 ee ff ff       	call   a59 <APLoadBitmap>
    1bd7:	83 c4 0c             	add    $0xc,%esp
    1bda:	8b 45 88             	mov    -0x78(%ebp),%eax
    1bdd:	a3 14 6c 00 00       	mov    %eax,0x6c14
    1be2:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1be5:	a3 18 6c 00 00       	mov    %eax,0x6c18
    1bea:	8b 45 90             	mov    -0x70(%ebp),%eax
    1bed:	a3 1c 6c 00 00       	mov    %eax,0x6c1c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1bf2:	83 ec 04             	sub    $0x4,%esp
    1bf5:	ff 35 1c 6c 00 00    	pushl  0x6c1c
    1bfb:	ff 35 18 6c 00 00    	pushl  0x6c18
    1c01:	ff 35 14 6c 00 00    	pushl  0x6c14
    1c07:	e8 87 f0 ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1c0c:	83 c4 10             	add    $0x10,%esp
    1c0f:	a3 58 6c 00 00       	mov    %eax,0x6c58
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1c14:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c17:	83 ec 08             	sub    $0x8,%esp
    1c1a:	68 09 27 00 00       	push   $0x2709
    1c1f:	50                   	push   %eax
    1c20:	e8 34 ee ff ff       	call   a59 <APLoadBitmap>
    1c25:	83 c4 0c             	add    $0xc,%esp
    1c28:	8b 45 88             	mov    -0x78(%ebp),%eax
    1c2b:	a3 f0 6b 00 00       	mov    %eax,0x6bf0
    1c30:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1c33:	a3 f4 6b 00 00       	mov    %eax,0x6bf4
    1c38:	8b 45 90             	mov    -0x70(%ebp),%eax
    1c3b:	a3 f8 6b 00 00       	mov    %eax,0x6bf8
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1c40:	83 ec 04             	sub    $0x4,%esp
    1c43:	ff 35 f8 6b 00 00    	pushl  0x6bf8
    1c49:	ff 35 f4 6b 00 00    	pushl  0x6bf4
    1c4f:	ff 35 f0 6b 00 00    	pushl  0x6bf0
    1c55:	e8 39 f0 ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1c5a:	83 c4 10             	add    $0x10,%esp
    1c5d:	a3 10 6c 00 00       	mov    %eax,0x6c10
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1c62:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c65:	83 ec 08             	sub    $0x8,%esp
    1c68:	68 19 27 00 00       	push   $0x2719
    1c6d:	50                   	push   %eax
    1c6e:	e8 e6 ed ff ff       	call   a59 <APLoadBitmap>
    1c73:	83 c4 0c             	add    $0xc,%esp
    1c76:	8b 45 88             	mov    -0x78(%ebp),%eax
    1c79:	a3 e4 6b 00 00       	mov    %eax,0x6be4
    1c7e:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1c81:	a3 e8 6b 00 00       	mov    %eax,0x6be8
    1c86:	8b 45 90             	mov    -0x70(%ebp),%eax
    1c89:	a3 ec 6b 00 00       	mov    %eax,0x6bec
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1c8e:	83 ec 04             	sub    $0x4,%esp
    1c91:	ff 35 ec 6b 00 00    	pushl  0x6bec
    1c97:	ff 35 e8 6b 00 00    	pushl  0x6be8
    1c9d:	ff 35 e4 6b 00 00    	pushl  0x6be4
    1ca3:	e8 eb ef ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1ca8:	83 c4 10             	add    $0x10,%esp
    1cab:	a3 fc 6b 00 00       	mov    %eax,0x6bfc
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1cb0:	8d 45 88             	lea    -0x78(%ebp),%eax
    1cb3:	83 ec 08             	sub    $0x8,%esp
    1cb6:	68 2b 27 00 00       	push   $0x272b
    1cbb:	50                   	push   %eax
    1cbc:	e8 98 ed ff ff       	call   a59 <APLoadBitmap>
    1cc1:	83 c4 0c             	add    $0xc,%esp
    1cc4:	8b 45 88             	mov    -0x78(%ebp),%eax
    1cc7:	a3 2c 6c 00 00       	mov    %eax,0x6c2c
    1ccc:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1ccf:	a3 30 6c 00 00       	mov    %eax,0x6c30
    1cd4:	8b 45 90             	mov    -0x70(%ebp),%eax
    1cd7:	a3 34 6c 00 00       	mov    %eax,0x6c34
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1cdc:	83 ec 04             	sub    $0x4,%esp
    1cdf:	ff 35 34 6c 00 00    	pushl  0x6c34
    1ce5:	ff 35 30 6c 00 00    	pushl  0x6c30
    1ceb:	ff 35 2c 6c 00 00    	pushl  0x6c2c
    1cf1:	e8 9d ef ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1cf6:	83 c4 10             	add    $0x10,%esp
    1cf9:	a3 5c 6c 00 00       	mov    %eax,0x6c5c
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    1cfe:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d01:	83 ec 08             	sub    $0x8,%esp
    1d04:	68 3a 27 00 00       	push   $0x273a
    1d09:	50                   	push   %eax
    1d0a:	e8 4a ed ff ff       	call   a59 <APLoadBitmap>
    1d0f:	83 c4 0c             	add    $0xc,%esp
    1d12:	8b 45 88             	mov    -0x78(%ebp),%eax
    1d15:	a3 20 6c 00 00       	mov    %eax,0x6c20
    1d1a:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1d1d:	a3 24 6c 00 00       	mov    %eax,0x6c24
    1d22:	8b 45 90             	mov    -0x70(%ebp),%eax
    1d25:	a3 28 6c 00 00       	mov    %eax,0x6c28
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    1d2a:	83 ec 04             	sub    $0x4,%esp
    1d2d:	ff 35 28 6c 00 00    	pushl  0x6c28
    1d33:	ff 35 24 6c 00 00    	pushl  0x6c24
    1d39:	ff 35 20 6c 00 00    	pushl  0x6c20
    1d3f:	e8 4f ef ff ff       	call   c93 <APCreateCompatibleDCFromBitmap>
    1d44:	83 c4 10             	add    $0x10,%esp
    1d47:	a3 54 6c 00 00       	mov    %eax,0x6c54
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1d4c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d4f:	8b 40 08             	mov    0x8(%eax),%eax
    1d52:	85 c0                	test   %eax,%eax
    1d54:	75 17                	jne    1d6d <APGridPaint+0x318>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1d56:	83 ec 08             	sub    $0x8,%esp
    1d59:	68 4c 27 00 00       	push   $0x274c
    1d5e:	6a 01                	push   $0x1
    1d60:	e8 6e e8 ff ff       	call   5d3 <printf>
    1d65:	83 c4 10             	add    $0x10,%esp
        return;
    1d68:	e9 fe 04 00 00       	jmp    226b <APGridPaint+0x816>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1d6d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d70:	8b 40 10             	mov    0x10(%eax),%eax
    1d73:	85 c0                	test   %eax,%eax
    1d75:	7e 10                	jle    1d87 <APGridPaint+0x332>
    1d77:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7a:	8b 50 14             	mov    0x14(%eax),%edx
    1d7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d80:	8b 40 10             	mov    0x10(%eax),%eax
    1d83:	39 c2                	cmp    %eax,%edx
    1d85:	7c 17                	jl     1d9e <APGridPaint+0x349>
    {
        printf(1,"Grid mode page error!");
    1d87:	83 ec 08             	sub    $0x8,%esp
    1d8a:	68 72 27 00 00       	push   $0x2772
    1d8f:	6a 01                	push   $0x1
    1d91:	e8 3d e8 ff ff       	call   5d3 <printf>
    1d96:	83 c4 10             	add    $0x10,%esp
        return;
    1d99:	e9 cd 04 00 00       	jmp    226b <APGridPaint+0x816>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1d9e:	8b 45 08             	mov    0x8(%ebp),%eax
    1da1:	8b 40 14             	mov    0x14(%eax),%eax
    1da4:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1daa:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1dad:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1db0:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1db3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1dba:	e9 f4 03 00 00       	jmp    21b3 <APGridPaint+0x75e>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1dbf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1dc6:	e9 da 03 00 00       	jmp    21a5 <APGridPaint+0x750>
        {
            index = start + GRID_W_NUMBER * j + i;
    1dcb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dce:	c1 e0 04             	shl    $0x4,%eax
    1dd1:	89 c2                	mov    %eax,%edx
    1dd3:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1dd6:	01 c2                	add    %eax,%edx
    1dd8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ddb:	01 d0                	add    %edx,%eax
    1ddd:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1de0:	8b 45 08             	mov    0x8(%ebp),%eax
    1de3:	8b 40 0c             	mov    0xc(%eax),%eax
    1de6:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1de9:	c1 e2 02             	shl    $0x2,%edx
    1dec:	01 d0                	add    %edx,%eax
    1dee:	8b 00                	mov    (%eax),%eax
    1df0:	83 f8 0a             	cmp    $0xa,%eax
    1df3:	0f 87 a7 03 00 00    	ja     21a0 <APGridPaint+0x74b>
    1df9:	8b 04 85 88 27 00 00 	mov    0x2788(,%eax,4),%eax
    1e00:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e02:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1e05:	6a 0c                	push   $0xc
    1e07:	6a 0c                	push   $0xc
    1e09:	6a 0c                	push   $0xc
    1e0b:	50                   	push   %eax
    1e0c:	e8 2a f8 ff ff       	call   163b <RGB>
    1e11:	83 c4 0c             	add    $0xc,%esp
    1e14:	8b 1d 0c 6c 00 00    	mov    0x6c0c,%ebx
    1e1a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e1d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e20:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e23:	6b c0 32             	imul   $0x32,%eax,%eax
    1e26:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e29:	8b 45 08             	mov    0x8(%ebp),%eax
    1e2c:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e2f:	83 ec 0c             	sub    $0xc,%esp
    1e32:	83 ec 04             	sub    $0x4,%esp
    1e35:	89 e0                	mov    %esp,%eax
    1e37:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    1e3b:	66 89 30             	mov    %si,(%eax)
    1e3e:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    1e42:	88 50 02             	mov    %dl,0x2(%eax)
    1e45:	6a 32                	push   $0x32
    1e47:	6a 32                	push   $0x32
    1e49:	6a 00                	push   $0x0
    1e4b:	6a 00                	push   $0x0
    1e4d:	53                   	push   %ebx
    1e4e:	51                   	push   %ecx
    1e4f:	ff 75 84             	pushl  -0x7c(%ebp)
    1e52:	57                   	push   %edi
    1e53:	e8 3f f6 ff ff       	call   1497 <APDcCopy>
    1e58:	83 c4 30             	add    $0x30,%esp
                    break;
    1e5b:	e9 41 03 00 00       	jmp    21a1 <APGridPaint+0x74c>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1e60:	8d 45 88             	lea    -0x78(%ebp),%eax
    1e63:	6a 69                	push   $0x69
    1e65:	6a 69                	push   $0x69
    1e67:	6a 69                	push   $0x69
    1e69:	50                   	push   %eax
    1e6a:	e8 cc f7 ff ff       	call   163b <RGB>
    1e6f:	83 c4 0c             	add    $0xc,%esp
    1e72:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1e76:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1e7a:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1e7e:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1e81:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1e88:	8d 45 88             	lea    -0x78(%ebp),%eax
    1e8b:	6a 69                	push   $0x69
    1e8d:	6a 69                	push   $0x69
    1e8f:	6a 69                	push   $0x69
    1e91:	50                   	push   %eax
    1e92:	e8 a4 f7 ff ff       	call   163b <RGB>
    1e97:	83 c4 0c             	add    $0xc,%esp
    1e9a:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1e9e:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1ea2:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1ea6:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1ea9:	8b 45 08             	mov    0x8(%ebp),%eax
    1eac:	8d 50 3c             	lea    0x3c(%eax),%edx
    1eaf:	8d 45 88             	lea    -0x78(%ebp),%eax
    1eb2:	ff 75 ac             	pushl  -0x54(%ebp)
    1eb5:	ff 75 a8             	pushl  -0x58(%ebp)
    1eb8:	52                   	push   %edx
    1eb9:	50                   	push   %eax
    1eba:	e8 69 ee ff ff       	call   d28 <APSetPen>
    1ebf:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1ec2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec5:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1ec8:	8d 55 88             	lea    -0x78(%ebp),%edx
    1ecb:	83 ec 04             	sub    $0x4,%esp
    1ece:	83 ec 04             	sub    $0x4,%esp
    1ed1:	89 e0                	mov    %esp,%eax
    1ed3:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1ed7:	66 89 08             	mov    %cx,(%eax)
    1eda:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    1ede:	88 48 02             	mov    %cl,0x2(%eax)
    1ee1:	53                   	push   %ebx
    1ee2:	52                   	push   %edx
    1ee3:	e8 79 ee ff ff       	call   d61 <APSetBrush>
    1ee8:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1eeb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1eee:	6b d0 32             	imul   $0x32,%eax,%edx
    1ef1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ef4:	6b c0 32             	imul   $0x32,%eax,%eax
    1ef7:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1efa:	83 c1 3c             	add    $0x3c,%ecx
    1efd:	83 ec 0c             	sub    $0xc,%esp
    1f00:	6a 32                	push   $0x32
    1f02:	6a 32                	push   $0x32
    1f04:	52                   	push   %edx
    1f05:	50                   	push   %eax
    1f06:	51                   	push   %ecx
    1f07:	e8 7f f2 ff ff       	call   118b <APDrawRect>
    1f0c:	83 c4 20             	add    $0x20,%esp
                    break;
    1f0f:	e9 8d 02 00 00       	jmp    21a1 <APGridPaint+0x74c>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f14:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1f17:	6a 0c                	push   $0xc
    1f19:	6a 0c                	push   $0xc
    1f1b:	6a 0c                	push   $0xc
    1f1d:	50                   	push   %eax
    1f1e:	e8 18 f7 ff ff       	call   163b <RGB>
    1f23:	83 c4 0c             	add    $0xc,%esp
    1f26:	8b 1d 5c 6c 00 00    	mov    0x6c5c,%ebx
    1f2c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f2f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f32:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f35:	6b c0 32             	imul   $0x32,%eax,%eax
    1f38:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f3b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f3e:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f41:	83 ec 0c             	sub    $0xc,%esp
    1f44:	83 ec 04             	sub    $0x4,%esp
    1f47:	89 e0                	mov    %esp,%eax
    1f49:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1f4d:	66 89 30             	mov    %si,(%eax)
    1f50:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1f54:	88 50 02             	mov    %dl,0x2(%eax)
    1f57:	6a 32                	push   $0x32
    1f59:	6a 32                	push   $0x32
    1f5b:	6a 00                	push   $0x0
    1f5d:	6a 00                	push   $0x0
    1f5f:	53                   	push   %ebx
    1f60:	51                   	push   %ecx
    1f61:	ff 75 84             	pushl  -0x7c(%ebp)
    1f64:	57                   	push   %edi
    1f65:	e8 2d f5 ff ff       	call   1497 <APDcCopy>
    1f6a:	83 c4 30             	add    $0x30,%esp
                    break;
    1f6d:	e9 2f 02 00 00       	jmp    21a1 <APGridPaint+0x74c>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f72:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1f75:	6a 0c                	push   $0xc
    1f77:	6a 0c                	push   $0xc
    1f79:	6a 0c                	push   $0xc
    1f7b:	50                   	push   %eax
    1f7c:	e8 ba f6 ff ff       	call   163b <RGB>
    1f81:	83 c4 0c             	add    $0xc,%esp
    1f84:	8b 1d 38 6c 00 00    	mov    0x6c38,%ebx
    1f8a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f8d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f90:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f93:	6b c0 32             	imul   $0x32,%eax,%eax
    1f96:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f99:	8b 45 08             	mov    0x8(%ebp),%eax
    1f9c:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f9f:	83 ec 0c             	sub    $0xc,%esp
    1fa2:	83 ec 04             	sub    $0x4,%esp
    1fa5:	89 e0                	mov    %esp,%eax
    1fa7:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1fab:	66 89 30             	mov    %si,(%eax)
    1fae:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1fb2:	88 50 02             	mov    %dl,0x2(%eax)
    1fb5:	6a 32                	push   $0x32
    1fb7:	6a 32                	push   $0x32
    1fb9:	6a 00                	push   $0x0
    1fbb:	6a 00                	push   $0x0
    1fbd:	53                   	push   %ebx
    1fbe:	51                   	push   %ecx
    1fbf:	ff 75 84             	pushl  -0x7c(%ebp)
    1fc2:	57                   	push   %edi
    1fc3:	e8 cf f4 ff ff       	call   1497 <APDcCopy>
    1fc8:	83 c4 30             	add    $0x30,%esp
                    break;
    1fcb:	e9 d1 01 00 00       	jmp    21a1 <APGridPaint+0x74c>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fd0:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1fd3:	6a 0c                	push   $0xc
    1fd5:	6a 0c                	push   $0xc
    1fd7:	6a 0c                	push   $0xc
    1fd9:	50                   	push   %eax
    1fda:	e8 5c f6 ff ff       	call   163b <RGB>
    1fdf:	83 c4 0c             	add    $0xc,%esp
    1fe2:	8b 1d 10 6c 00 00    	mov    0x6c10,%ebx
    1fe8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1feb:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fee:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ff1:	6b c0 32             	imul   $0x32,%eax,%eax
    1ff4:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1ff7:	8b 45 08             	mov    0x8(%ebp),%eax
    1ffa:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ffd:	83 ec 0c             	sub    $0xc,%esp
    2000:	83 ec 04             	sub    $0x4,%esp
    2003:	89 e0                	mov    %esp,%eax
    2005:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    2009:	66 89 30             	mov    %si,(%eax)
    200c:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    2010:	88 50 02             	mov    %dl,0x2(%eax)
    2013:	6a 32                	push   $0x32
    2015:	6a 32                	push   $0x32
    2017:	6a 00                	push   $0x0
    2019:	6a 00                	push   $0x0
    201b:	53                   	push   %ebx
    201c:	51                   	push   %ecx
    201d:	ff 75 84             	pushl  -0x7c(%ebp)
    2020:	57                   	push   %edi
    2021:	e8 71 f4 ff ff       	call   1497 <APDcCopy>
    2026:	83 c4 30             	add    $0x30,%esp
                    break;
    2029:	e9 73 01 00 00       	jmp    21a1 <APGridPaint+0x74c>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    202e:	8d 45 cc             	lea    -0x34(%ebp),%eax
    2031:	6a 0c                	push   $0xc
    2033:	6a 0c                	push   $0xc
    2035:	6a 0c                	push   $0xc
    2037:	50                   	push   %eax
    2038:	e8 fe f5 ff ff       	call   163b <RGB>
    203d:	83 c4 0c             	add    $0xc,%esp
    2040:	8b 1d 58 6c 00 00    	mov    0x6c58,%ebx
    2046:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2049:	6b c8 32             	imul   $0x32,%eax,%ecx
    204c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    204f:	6b c0 32             	imul   $0x32,%eax,%eax
    2052:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2055:	8b 45 08             	mov    0x8(%ebp),%eax
    2058:	8d 78 3c             	lea    0x3c(%eax),%edi
    205b:	83 ec 0c             	sub    $0xc,%esp
    205e:	83 ec 04             	sub    $0x4,%esp
    2061:	89 e0                	mov    %esp,%eax
    2063:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    2067:	66 89 30             	mov    %si,(%eax)
    206a:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    206e:	88 50 02             	mov    %dl,0x2(%eax)
    2071:	6a 32                	push   $0x32
    2073:	6a 32                	push   $0x32
    2075:	6a 00                	push   $0x0
    2077:	6a 00                	push   $0x0
    2079:	53                   	push   %ebx
    207a:	51                   	push   %ecx
    207b:	ff 75 84             	pushl  -0x7c(%ebp)
    207e:	57                   	push   %edi
    207f:	e8 13 f4 ff ff       	call   1497 <APDcCopy>
    2084:	83 c4 30             	add    $0x30,%esp
                    break;
    2087:	e9 15 01 00 00       	jmp    21a1 <APGridPaint+0x74c>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    208c:	8d 45 cf             	lea    -0x31(%ebp),%eax
    208f:	6a 0c                	push   $0xc
    2091:	6a 0c                	push   $0xc
    2093:	6a 0c                	push   $0xc
    2095:	50                   	push   %eax
    2096:	e8 a0 f5 ff ff       	call   163b <RGB>
    209b:	83 c4 0c             	add    $0xc,%esp
    209e:	8b 1d e0 6b 00 00    	mov    0x6be0,%ebx
    20a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20a7:	6b c8 32             	imul   $0x32,%eax,%ecx
    20aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
    20ad:	6b c0 32             	imul   $0x32,%eax,%eax
    20b0:	89 45 84             	mov    %eax,-0x7c(%ebp)
    20b3:	8b 45 08             	mov    0x8(%ebp),%eax
    20b6:	8d 78 3c             	lea    0x3c(%eax),%edi
    20b9:	83 ec 0c             	sub    $0xc,%esp
    20bc:	83 ec 04             	sub    $0x4,%esp
    20bf:	89 e0                	mov    %esp,%eax
    20c1:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    20c5:	66 89 30             	mov    %si,(%eax)
    20c8:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    20cc:	88 50 02             	mov    %dl,0x2(%eax)
    20cf:	6a 32                	push   $0x32
    20d1:	6a 32                	push   $0x32
    20d3:	6a 00                	push   $0x0
    20d5:	6a 00                	push   $0x0
    20d7:	53                   	push   %ebx
    20d8:	51                   	push   %ecx
    20d9:	ff 75 84             	pushl  -0x7c(%ebp)
    20dc:	57                   	push   %edi
    20dd:	e8 b5 f3 ff ff       	call   1497 <APDcCopy>
    20e2:	83 c4 30             	add    $0x30,%esp
                    break;
    20e5:	e9 b7 00 00 00       	jmp    21a1 <APGridPaint+0x74c>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    20ea:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    20ed:	6a 0c                	push   $0xc
    20ef:	6a 0c                	push   $0xc
    20f1:	6a 0c                	push   $0xc
    20f3:	50                   	push   %eax
    20f4:	e8 42 f5 ff ff       	call   163b <RGB>
    20f9:	83 c4 0c             	add    $0xc,%esp
    20fc:	8b 1d fc 6b 00 00    	mov    0x6bfc,%ebx
    2102:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2105:	6b c8 32             	imul   $0x32,%eax,%ecx
    2108:	8b 45 e0             	mov    -0x20(%ebp),%eax
    210b:	6b c0 32             	imul   $0x32,%eax,%eax
    210e:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2111:	8b 45 08             	mov    0x8(%ebp),%eax
    2114:	8d 78 3c             	lea    0x3c(%eax),%edi
    2117:	83 ec 0c             	sub    $0xc,%esp
    211a:	83 ec 04             	sub    $0x4,%esp
    211d:	89 e0                	mov    %esp,%eax
    211f:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2123:	66 89 30             	mov    %si,(%eax)
    2126:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    212a:	88 50 02             	mov    %dl,0x2(%eax)
    212d:	6a 32                	push   $0x32
    212f:	6a 32                	push   $0x32
    2131:	6a 00                	push   $0x0
    2133:	6a 00                	push   $0x0
    2135:	53                   	push   %ebx
    2136:	51                   	push   %ecx
    2137:	ff 75 84             	pushl  -0x7c(%ebp)
    213a:	57                   	push   %edi
    213b:	e8 57 f3 ff ff       	call   1497 <APDcCopy>
    2140:	83 c4 30             	add    $0x30,%esp
                    break;
    2143:	eb 5c                	jmp    21a1 <APGridPaint+0x74c>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2145:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    2148:	6a 0c                	push   $0xc
    214a:	6a 0c                	push   $0xc
    214c:	6a 0c                	push   $0xc
    214e:	50                   	push   %eax
    214f:	e8 e7 f4 ff ff       	call   163b <RGB>
    2154:	83 c4 0c             	add    $0xc,%esp
    2157:	8b 1d 54 6c 00 00    	mov    0x6c54,%ebx
    215d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2160:	6b c8 32             	imul   $0x32,%eax,%ecx
    2163:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2166:	6b c0 32             	imul   $0x32,%eax,%eax
    2169:	89 45 84             	mov    %eax,-0x7c(%ebp)
    216c:	8b 45 08             	mov    0x8(%ebp),%eax
    216f:	8d 78 3c             	lea    0x3c(%eax),%edi
    2172:	83 ec 0c             	sub    $0xc,%esp
    2175:	83 ec 04             	sub    $0x4,%esp
    2178:	89 e0                	mov    %esp,%eax
    217a:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    217e:	66 89 30             	mov    %si,(%eax)
    2181:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2185:	88 50 02             	mov    %dl,0x2(%eax)
    2188:	6a 32                	push   $0x32
    218a:	6a 32                	push   $0x32
    218c:	6a 00                	push   $0x0
    218e:	6a 00                	push   $0x0
    2190:	53                   	push   %ebx
    2191:	51                   	push   %ecx
    2192:	ff 75 84             	pushl  -0x7c(%ebp)
    2195:	57                   	push   %edi
    2196:	e8 fc f2 ff ff       	call   1497 <APDcCopy>
    219b:	83 c4 30             	add    $0x30,%esp
                    break;
    219e:	eb 01                	jmp    21a1 <APGridPaint+0x74c>
                default: break;
    21a0:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    21a1:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    21a5:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    21a9:	0f 8e 1c fc ff ff    	jle    1dcb <APGridPaint+0x376>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    21af:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    21b3:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    21b7:	0f 8e 02 fc ff ff    	jle    1dbf <APGridPaint+0x36a>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    21bd:	8d 45 88             	lea    -0x78(%ebp),%eax
    21c0:	68 cd 00 00 00       	push   $0xcd
    21c5:	6a 74                	push   $0x74
    21c7:	6a 18                	push   $0x18
    21c9:	50                   	push   %eax
    21ca:	e8 6c f4 ff ff       	call   163b <RGB>
    21cf:	83 c4 0c             	add    $0xc,%esp
    21d2:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    21d6:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    21da:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    21de:	88 45 b6             	mov    %al,-0x4a(%ebp)
    pen.size = 1;
    21e1:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    21e8:	8d 45 88             	lea    -0x78(%ebp),%eax
    21eb:	68 cd 00 00 00       	push   $0xcd
    21f0:	6a 74                	push   $0x74
    21f2:	6a 18                	push   $0x18
    21f4:	50                   	push   %eax
    21f5:	e8 41 f4 ff ff       	call   163b <RGB>
    21fa:	83 c4 0c             	add    $0xc,%esp
    21fd:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2201:	66 89 45 b1          	mov    %ax,-0x4f(%ebp)
    2205:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2209:	88 45 b3             	mov    %al,-0x4d(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    220c:	8b 45 08             	mov    0x8(%ebp),%eax
    220f:	8d 50 58             	lea    0x58(%eax),%edx
    2212:	8d 45 88             	lea    -0x78(%ebp),%eax
    2215:	ff 75 b8             	pushl  -0x48(%ebp)
    2218:	ff 75 b4             	pushl  -0x4c(%ebp)
    221b:	52                   	push   %edx
    221c:	50                   	push   %eax
    221d:	e8 06 eb ff ff       	call   d28 <APSetPen>
    2222:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2225:	8b 45 08             	mov    0x8(%ebp),%eax
    2228:	8d 58 58             	lea    0x58(%eax),%ebx
    222b:	8d 55 88             	lea    -0x78(%ebp),%edx
    222e:	83 ec 04             	sub    $0x4,%esp
    2231:	83 ec 04             	sub    $0x4,%esp
    2234:	89 e0                	mov    %esp,%eax
    2236:	0f b7 4d b1          	movzwl -0x4f(%ebp),%ecx
    223a:	66 89 08             	mov    %cx,(%eax)
    223d:	0f b6 4d b3          	movzbl -0x4d(%ebp),%ecx
    2241:	88 48 02             	mov    %cl,0x2(%eax)
    2244:	53                   	push   %ebx
    2245:	52                   	push   %edx
    2246:	e8 16 eb ff ff       	call   d61 <APSetBrush>
    224b:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    224e:	8b 45 08             	mov    0x8(%ebp),%eax
    2251:	83 c0 58             	add    $0x58,%eax
    2254:	83 ec 0c             	sub    $0xc,%esp
    2257:	6a 32                	push   $0x32
    2259:	68 20 03 00 00       	push   $0x320
    225e:	6a 00                	push   $0x0
    2260:	6a 00                	push   $0x0
    2262:	50                   	push   %eax
    2263:	e8 23 ef ff ff       	call   118b <APDrawRect>
    2268:	83 c4 20             	add    $0x20,%esp
    
    
}
    226b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    226e:	5b                   	pop    %ebx
    226f:	5e                   	pop    %esi
    2270:	5f                   	pop    %edi
    2271:	5d                   	pop    %ebp
    2272:	c3                   	ret    

00002273 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2273:	55                   	push   %ebp
    2274:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2276:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    227a:	7e 08                	jle    2284 <random+0x11>
{
rand_num = seed;
    227c:	8b 45 08             	mov    0x8(%ebp),%eax
    227f:	a3 a0 69 00 00       	mov    %eax,0x69a0
}
rand_num *= 3;
    2284:	8b 15 a0 69 00 00    	mov    0x69a0,%edx
    228a:	89 d0                	mov    %edx,%eax
    228c:	01 c0                	add    %eax,%eax
    228e:	01 d0                	add    %edx,%eax
    2290:	a3 a0 69 00 00       	mov    %eax,0x69a0
if (rand_num < 0)
    2295:	a1 a0 69 00 00       	mov    0x69a0,%eax
    229a:	85 c0                	test   %eax,%eax
    229c:	79 0c                	jns    22aa <random+0x37>
{
rand_num *= (-1);
    229e:	a1 a0 69 00 00       	mov    0x69a0,%eax
    22a3:	f7 d8                	neg    %eax
    22a5:	a3 a0 69 00 00       	mov    %eax,0x69a0
}
return rand_num % 997;
    22aa:	8b 0d a0 69 00 00    	mov    0x69a0,%ecx
    22b0:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    22b5:	89 c8                	mov    %ecx,%eax
    22b7:	f7 ea                	imul   %edx
    22b9:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    22bc:	c1 f8 09             	sar    $0x9,%eax
    22bf:	89 c2                	mov    %eax,%edx
    22c1:	89 c8                	mov    %ecx,%eax
    22c3:	c1 f8 1f             	sar    $0x1f,%eax
    22c6:	29 c2                	sub    %eax,%edx
    22c8:	89 d0                	mov    %edx,%eax
    22ca:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    22d0:	29 c1                	sub    %eax,%ecx
    22d2:	89 c8                	mov    %ecx,%eax
}
    22d4:	5d                   	pop    %ebp
    22d5:	c3                   	ret    

000022d6 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    22d6:	55                   	push   %ebp
    22d7:	89 e5                	mov    %esp,%ebp
    22d9:	53                   	push   %ebx
    22da:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    22dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    22e4:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    22e8:	74 17                	je     2301 <sprintint+0x2b>
    22ea:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    22ee:	79 11                	jns    2301 <sprintint+0x2b>
        neg = 1;
    22f0:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    22f7:	8b 45 10             	mov    0x10(%ebp),%eax
    22fa:	f7 d8                	neg    %eax
    22fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    22ff:	eb 06                	jmp    2307 <sprintint+0x31>
    } else {
        x = xx;
    2301:	8b 45 10             	mov    0x10(%ebp),%eax
    2304:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2307:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    230e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2311:	8d 41 01             	lea    0x1(%ecx),%eax
    2314:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2317:	8b 5d 14             	mov    0x14(%ebp),%ebx
    231a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    231d:	ba 00 00 00 00       	mov    $0x0,%edx
    2322:	f7 f3                	div    %ebx
    2324:	89 d0                	mov    %edx,%eax
    2326:	0f b6 80 a4 69 00 00 	movzbl 0x69a4(%eax),%eax
    232d:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2331:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2334:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2337:	ba 00 00 00 00       	mov    $0x0,%edx
    233c:	f7 f3                	div    %ebx
    233e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2341:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2345:	75 c7                	jne    230e <sprintint+0x38>
    if(neg)
    2347:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    234b:	74 0e                	je     235b <sprintint+0x85>
        buf[i++] = '-';
    234d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2350:	8d 50 01             	lea    0x1(%eax),%edx
    2353:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2356:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    235b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    235e:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2361:	eb 1b                	jmp    237e <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2363:	8b 45 0c             	mov    0xc(%ebp),%eax
    2366:	8b 00                	mov    (%eax),%eax
    2368:	8d 48 01             	lea    0x1(%eax),%ecx
    236b:	8b 55 0c             	mov    0xc(%ebp),%edx
    236e:	89 0a                	mov    %ecx,(%edx)
    2370:	89 c2                	mov    %eax,%edx
    2372:	8b 45 08             	mov    0x8(%ebp),%eax
    2375:	01 d0                	add    %edx,%eax
    2377:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    237a:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    237e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2382:	7f df                	jg     2363 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2384:	eb 21                	jmp    23a7 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2386:	8b 45 0c             	mov    0xc(%ebp),%eax
    2389:	8b 00                	mov    (%eax),%eax
    238b:	8d 48 01             	lea    0x1(%eax),%ecx
    238e:	8b 55 0c             	mov    0xc(%ebp),%edx
    2391:	89 0a                	mov    %ecx,(%edx)
    2393:	89 c2                	mov    %eax,%edx
    2395:	8b 45 08             	mov    0x8(%ebp),%eax
    2398:	01 c2                	add    %eax,%edx
    239a:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    239d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    23a0:	01 c8                	add    %ecx,%eax
    23a2:	0f b6 00             	movzbl (%eax),%eax
    23a5:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    23a7:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    23ab:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    23af:	79 d5                	jns    2386 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    23b1:	90                   	nop
    23b2:	83 c4 20             	add    $0x20,%esp
    23b5:	5b                   	pop    %ebx
    23b6:	5d                   	pop    %ebp
    23b7:	c3                   	ret    

000023b8 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    23b8:	55                   	push   %ebp
    23b9:	89 e5                	mov    %esp,%ebp
    23bb:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    23be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    23c5:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    23cc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    23d3:	8d 45 0c             	lea    0xc(%ebp),%eax
    23d6:	83 c0 04             	add    $0x4,%eax
    23d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    23dc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    23e3:	e9 d9 01 00 00       	jmp    25c1 <sprintf+0x209>
        c = fmt[i] & 0xff;
    23e8:	8b 55 0c             	mov    0xc(%ebp),%edx
    23eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23ee:	01 d0                	add    %edx,%eax
    23f0:	0f b6 00             	movzbl (%eax),%eax
    23f3:	0f be c0             	movsbl %al,%eax
    23f6:	25 ff 00 00 00       	and    $0xff,%eax
    23fb:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    23fe:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2402:	75 2c                	jne    2430 <sprintf+0x78>
            if(c == '%'){
    2404:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2408:	75 0c                	jne    2416 <sprintf+0x5e>
                state = '%';
    240a:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2411:	e9 a7 01 00 00       	jmp    25bd <sprintf+0x205>
            } else {
                dst[j++] = c;
    2416:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2419:	8d 50 01             	lea    0x1(%eax),%edx
    241c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    241f:	89 c2                	mov    %eax,%edx
    2421:	8b 45 08             	mov    0x8(%ebp),%eax
    2424:	01 d0                	add    %edx,%eax
    2426:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2429:	88 10                	mov    %dl,(%eax)
    242b:	e9 8d 01 00 00       	jmp    25bd <sprintf+0x205>
            }
        } else if(state == '%'){
    2430:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2434:	0f 85 83 01 00 00    	jne    25bd <sprintf+0x205>
            if(c == 'd'){
    243a:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    243e:	75 4c                	jne    248c <sprintf+0xd4>
                buf[bi] = '\0';
    2440:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2443:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2446:	01 d0                	add    %edx,%eax
    2448:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    244b:	83 ec 0c             	sub    $0xc,%esp
    244e:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2451:	50                   	push   %eax
    2452:	e8 2b df ff ff       	call   382 <atoi>
    2457:	83 c4 10             	add    $0x10,%esp
    245a:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    245d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2464:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2467:	8b 00                	mov    (%eax),%eax
    2469:	83 ec 08             	sub    $0x8,%esp
    246c:	ff 75 d8             	pushl  -0x28(%ebp)
    246f:	6a 01                	push   $0x1
    2471:	6a 0a                	push   $0xa
    2473:	50                   	push   %eax
    2474:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2477:	50                   	push   %eax
    2478:	ff 75 08             	pushl  0x8(%ebp)
    247b:	e8 56 fe ff ff       	call   22d6 <sprintint>
    2480:	83 c4 20             	add    $0x20,%esp
                ap++;
    2483:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2487:	e9 2a 01 00 00       	jmp    25b6 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    248c:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2490:	74 06                	je     2498 <sprintf+0xe0>
    2492:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2496:	75 4c                	jne    24e4 <sprintf+0x12c>
                buf[bi] = '\0';
    2498:	8d 55 ce             	lea    -0x32(%ebp),%edx
    249b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    249e:	01 d0                	add    %edx,%eax
    24a0:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    24a3:	83 ec 0c             	sub    $0xc,%esp
    24a6:	8d 45 ce             	lea    -0x32(%ebp),%eax
    24a9:	50                   	push   %eax
    24aa:	e8 d3 de ff ff       	call   382 <atoi>
    24af:	83 c4 10             	add    $0x10,%esp
    24b2:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    24b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    24bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24bf:	8b 00                	mov    (%eax),%eax
    24c1:	83 ec 08             	sub    $0x8,%esp
    24c4:	ff 75 dc             	pushl  -0x24(%ebp)
    24c7:	6a 00                	push   $0x0
    24c9:	6a 10                	push   $0x10
    24cb:	50                   	push   %eax
    24cc:	8d 45 c8             	lea    -0x38(%ebp),%eax
    24cf:	50                   	push   %eax
    24d0:	ff 75 08             	pushl  0x8(%ebp)
    24d3:	e8 fe fd ff ff       	call   22d6 <sprintint>
    24d8:	83 c4 20             	add    $0x20,%esp
                ap++;
    24db:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    24df:	e9 d2 00 00 00       	jmp    25b6 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    24e4:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    24e8:	75 46                	jne    2530 <sprintf+0x178>
                s = (char*)*ap;
    24ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24ed:	8b 00                	mov    (%eax),%eax
    24ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    24f2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    24f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    24fa:	75 25                	jne    2521 <sprintf+0x169>
                    s = "(null)";
    24fc:	c7 45 f4 b4 27 00 00 	movl   $0x27b4,-0xc(%ebp)
                while(*s != 0){
    2503:	eb 1c                	jmp    2521 <sprintf+0x169>
                    dst[j++] = *s;
    2505:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2508:	8d 50 01             	lea    0x1(%eax),%edx
    250b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    250e:	89 c2                	mov    %eax,%edx
    2510:	8b 45 08             	mov    0x8(%ebp),%eax
    2513:	01 c2                	add    %eax,%edx
    2515:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2518:	0f b6 00             	movzbl (%eax),%eax
    251b:	88 02                	mov    %al,(%edx)
                    s++;
    251d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2521:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2524:	0f b6 00             	movzbl (%eax),%eax
    2527:	84 c0                	test   %al,%al
    2529:	75 da                	jne    2505 <sprintf+0x14d>
    252b:	e9 86 00 00 00       	jmp    25b6 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2530:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2534:	75 1d                	jne    2553 <sprintf+0x19b>
                dst[j++] = *ap;
    2536:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2539:	8d 50 01             	lea    0x1(%eax),%edx
    253c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    253f:	89 c2                	mov    %eax,%edx
    2541:	8b 45 08             	mov    0x8(%ebp),%eax
    2544:	01 c2                	add    %eax,%edx
    2546:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2549:	8b 00                	mov    (%eax),%eax
    254b:	88 02                	mov    %al,(%edx)
                ap++;
    254d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2551:	eb 63                	jmp    25b6 <sprintf+0x1fe>
            } else if(c == '%'){
    2553:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2557:	75 17                	jne    2570 <sprintf+0x1b8>
                dst[j++] = c;
    2559:	8b 45 c8             	mov    -0x38(%ebp),%eax
    255c:	8d 50 01             	lea    0x1(%eax),%edx
    255f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2562:	89 c2                	mov    %eax,%edx
    2564:	8b 45 08             	mov    0x8(%ebp),%eax
    2567:	01 d0                	add    %edx,%eax
    2569:	8b 55 e0             	mov    -0x20(%ebp),%edx
    256c:	88 10                	mov    %dl,(%eax)
    256e:	eb 46                	jmp    25b6 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2570:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2574:	7e 18                	jle    258e <sprintf+0x1d6>
    2576:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    257a:	7f 12                	jg     258e <sprintf+0x1d6>
            {
                buf[bi++] = c;
    257c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    257f:	8d 50 01             	lea    0x1(%eax),%edx
    2582:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2585:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2588:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    258c:	eb 2f                	jmp    25bd <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    258e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2591:	8d 50 01             	lea    0x1(%eax),%edx
    2594:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2597:	89 c2                	mov    %eax,%edx
    2599:	8b 45 08             	mov    0x8(%ebp),%eax
    259c:	01 d0                	add    %edx,%eax
    259e:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    25a1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    25a4:	8d 50 01             	lea    0x1(%eax),%edx
    25a7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    25aa:	89 c2                	mov    %eax,%edx
    25ac:	8b 45 08             	mov    0x8(%ebp),%eax
    25af:	01 d0                	add    %edx,%eax
    25b1:	8b 55 e0             	mov    -0x20(%ebp),%edx
    25b4:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    25b6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    25bd:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    25c1:	8b 55 0c             	mov    0xc(%ebp),%edx
    25c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    25c7:	01 d0                	add    %edx,%eax
    25c9:	0f b6 00             	movzbl (%eax),%eax
    25cc:	84 c0                	test   %al,%al
    25ce:	0f 85 14 fe ff ff    	jne    23e8 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    25d4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    25d7:	8d 50 01             	lea    0x1(%eax),%edx
    25da:	89 55 c8             	mov    %edx,-0x38(%ebp)
    25dd:	89 c2                	mov    %eax,%edx
    25df:	8b 45 08             	mov    0x8(%ebp),%eax
    25e2:	01 d0                	add    %edx,%eax
    25e4:	c6 00 00             	movb   $0x0,(%eax)
}
    25e7:	90                   	nop
    25e8:	c9                   	leave  
    25e9:	c3                   	ret    
