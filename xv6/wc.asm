
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
      32:	05 40 29 00 00       	add    $0x2940,%eax
      37:	0f b6 00             	movzbl (%eax),%eax
      3a:	3c 0a                	cmp    $0xa,%al
      3c:	75 04                	jne    42 <wc+0x42>
        l++;
      3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
      42:	8b 45 f4             	mov    -0xc(%ebp),%eax
      45:	05 40 29 00 00       	add    $0x2940,%eax
      4a:	0f b6 00             	movzbl (%eax),%eax
      4d:	0f be c0             	movsbl %al,%eax
      50:	83 ec 08             	sub    $0x8,%esp
      53:	50                   	push   %eax
      54:	68 00 22 00 00       	push   $0x2200
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
      93:	68 40 29 00 00       	push   $0x2940
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
      b9:	68 06 22 00 00       	push   $0x2206
      be:	6a 01                	push   $0x1
      c0:	e8 f6 04 00 00       	call   5bb <printf>
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
      dc:	68 16 22 00 00       	push   $0x2216
      e1:	6a 01                	push   $0x1
      e3:	e8 d3 04 00 00       	call   5bb <printf>
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
     10a:	68 23 22 00 00       	push   $0x2223
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
     167:	68 24 22 00 00       	push   $0x2224
     16c:	6a 01                	push   $0x1
     16e:	e8 48 04 00 00       	call   5bb <printf>
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

000004dc <changePosition>:
SYSCALL(changePosition)
     4dc:	b8 1b 00 00 00       	mov    $0x1b,%eax
     4e1:	cd 40                	int    $0x40
     4e3:	c3                   	ret    

000004e4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     4e4:	55                   	push   %ebp
     4e5:	89 e5                	mov    %esp,%ebp
     4e7:	83 ec 18             	sub    $0x18,%esp
     4ea:	8b 45 0c             	mov    0xc(%ebp),%eax
     4ed:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     4f0:	83 ec 04             	sub    $0x4,%esp
     4f3:	6a 01                	push   $0x1
     4f5:	8d 45 f4             	lea    -0xc(%ebp),%eax
     4f8:	50                   	push   %eax
     4f9:	ff 75 08             	pushl  0x8(%ebp)
     4fc:	e8 33 ff ff ff       	call   434 <write>
     501:	83 c4 10             	add    $0x10,%esp
}
     504:	90                   	nop
     505:	c9                   	leave  
     506:	c3                   	ret    

00000507 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     507:	55                   	push   %ebp
     508:	89 e5                	mov    %esp,%ebp
     50a:	53                   	push   %ebx
     50b:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     50e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     515:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     519:	74 17                	je     532 <printint+0x2b>
     51b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     51f:	79 11                	jns    532 <printint+0x2b>
    neg = 1;
     521:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     528:	8b 45 0c             	mov    0xc(%ebp),%eax
     52b:	f7 d8                	neg    %eax
     52d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     530:	eb 06                	jmp    538 <printint+0x31>
  } else {
    x = xx;
     532:	8b 45 0c             	mov    0xc(%ebp),%eax
     535:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     538:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     53f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     542:	8d 41 01             	lea    0x1(%ecx),%eax
     545:	89 45 f4             	mov    %eax,-0xc(%ebp)
     548:	8b 5d 10             	mov    0x10(%ebp),%ebx
     54b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     54e:	ba 00 00 00 00       	mov    $0x0,%edx
     553:	f7 f3                	div    %ebx
     555:	89 d0                	mov    %edx,%eax
     557:	0f b6 80 e4 28 00 00 	movzbl 0x28e4(%eax),%eax
     55e:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     562:	8b 5d 10             	mov    0x10(%ebp),%ebx
     565:	8b 45 ec             	mov    -0x14(%ebp),%eax
     568:	ba 00 00 00 00       	mov    $0x0,%edx
     56d:	f7 f3                	div    %ebx
     56f:	89 45 ec             	mov    %eax,-0x14(%ebp)
     572:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     576:	75 c7                	jne    53f <printint+0x38>
  if(neg)
     578:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     57c:	74 2d                	je     5ab <printint+0xa4>
    buf[i++] = '-';
     57e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     581:	8d 50 01             	lea    0x1(%eax),%edx
     584:	89 55 f4             	mov    %edx,-0xc(%ebp)
     587:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     58c:	eb 1d                	jmp    5ab <printint+0xa4>
    putc(fd, buf[i]);
     58e:	8d 55 dc             	lea    -0x24(%ebp),%edx
     591:	8b 45 f4             	mov    -0xc(%ebp),%eax
     594:	01 d0                	add    %edx,%eax
     596:	0f b6 00             	movzbl (%eax),%eax
     599:	0f be c0             	movsbl %al,%eax
     59c:	83 ec 08             	sub    $0x8,%esp
     59f:	50                   	push   %eax
     5a0:	ff 75 08             	pushl  0x8(%ebp)
     5a3:	e8 3c ff ff ff       	call   4e4 <putc>
     5a8:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     5ab:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     5af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5b3:	79 d9                	jns    58e <printint+0x87>
    putc(fd, buf[i]);
}
     5b5:	90                   	nop
     5b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5b9:	c9                   	leave  
     5ba:	c3                   	ret    

000005bb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     5bb:	55                   	push   %ebp
     5bc:	89 e5                	mov    %esp,%ebp
     5be:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     5c1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     5c8:	8d 45 0c             	lea    0xc(%ebp),%eax
     5cb:	83 c0 04             	add    $0x4,%eax
     5ce:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     5d1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     5d8:	e9 59 01 00 00       	jmp    736 <printf+0x17b>
    c = fmt[i] & 0xff;
     5dd:	8b 55 0c             	mov    0xc(%ebp),%edx
     5e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5e3:	01 d0                	add    %edx,%eax
     5e5:	0f b6 00             	movzbl (%eax),%eax
     5e8:	0f be c0             	movsbl %al,%eax
     5eb:	25 ff 00 00 00       	and    $0xff,%eax
     5f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     5f3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     5f7:	75 2c                	jne    625 <printf+0x6a>
      if(c == '%'){
     5f9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5fd:	75 0c                	jne    60b <printf+0x50>
        state = '%';
     5ff:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     606:	e9 27 01 00 00       	jmp    732 <printf+0x177>
      } else {
        putc(fd, c);
     60b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     60e:	0f be c0             	movsbl %al,%eax
     611:	83 ec 08             	sub    $0x8,%esp
     614:	50                   	push   %eax
     615:	ff 75 08             	pushl  0x8(%ebp)
     618:	e8 c7 fe ff ff       	call   4e4 <putc>
     61d:	83 c4 10             	add    $0x10,%esp
     620:	e9 0d 01 00 00       	jmp    732 <printf+0x177>
      }
    } else if(state == '%'){
     625:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     629:	0f 85 03 01 00 00    	jne    732 <printf+0x177>
      if(c == 'd'){
     62f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     633:	75 1e                	jne    653 <printf+0x98>
        printint(fd, *ap, 10, 1);
     635:	8b 45 e8             	mov    -0x18(%ebp),%eax
     638:	8b 00                	mov    (%eax),%eax
     63a:	6a 01                	push   $0x1
     63c:	6a 0a                	push   $0xa
     63e:	50                   	push   %eax
     63f:	ff 75 08             	pushl  0x8(%ebp)
     642:	e8 c0 fe ff ff       	call   507 <printint>
     647:	83 c4 10             	add    $0x10,%esp
        ap++;
     64a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     64e:	e9 d8 00 00 00       	jmp    72b <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     653:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     657:	74 06                	je     65f <printf+0xa4>
     659:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     65d:	75 1e                	jne    67d <printf+0xc2>
        printint(fd, *ap, 16, 0);
     65f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     662:	8b 00                	mov    (%eax),%eax
     664:	6a 00                	push   $0x0
     666:	6a 10                	push   $0x10
     668:	50                   	push   %eax
     669:	ff 75 08             	pushl  0x8(%ebp)
     66c:	e8 96 fe ff ff       	call   507 <printint>
     671:	83 c4 10             	add    $0x10,%esp
        ap++;
     674:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     678:	e9 ae 00 00 00       	jmp    72b <printf+0x170>
      } else if(c == 's'){
     67d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     681:	75 43                	jne    6c6 <printf+0x10b>
        s = (char*)*ap;
     683:	8b 45 e8             	mov    -0x18(%ebp),%eax
     686:	8b 00                	mov    (%eax),%eax
     688:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     68b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     68f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     693:	75 25                	jne    6ba <printf+0xff>
          s = "(null)";
     695:	c7 45 f4 38 22 00 00 	movl   $0x2238,-0xc(%ebp)
        while(*s != 0){
     69c:	eb 1c                	jmp    6ba <printf+0xff>
          putc(fd, *s);
     69e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6a1:	0f b6 00             	movzbl (%eax),%eax
     6a4:	0f be c0             	movsbl %al,%eax
     6a7:	83 ec 08             	sub    $0x8,%esp
     6aa:	50                   	push   %eax
     6ab:	ff 75 08             	pushl  0x8(%ebp)
     6ae:	e8 31 fe ff ff       	call   4e4 <putc>
     6b3:	83 c4 10             	add    $0x10,%esp
          s++;
     6b6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     6ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6bd:	0f b6 00             	movzbl (%eax),%eax
     6c0:	84 c0                	test   %al,%al
     6c2:	75 da                	jne    69e <printf+0xe3>
     6c4:	eb 65                	jmp    72b <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     6c6:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     6ca:	75 1d                	jne    6e9 <printf+0x12e>
        putc(fd, *ap);
     6cc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6cf:	8b 00                	mov    (%eax),%eax
     6d1:	0f be c0             	movsbl %al,%eax
     6d4:	83 ec 08             	sub    $0x8,%esp
     6d7:	50                   	push   %eax
     6d8:	ff 75 08             	pushl  0x8(%ebp)
     6db:	e8 04 fe ff ff       	call   4e4 <putc>
     6e0:	83 c4 10             	add    $0x10,%esp
        ap++;
     6e3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     6e7:	eb 42                	jmp    72b <printf+0x170>
      } else if(c == '%'){
     6e9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     6ed:	75 17                	jne    706 <printf+0x14b>
        putc(fd, c);
     6ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6f2:	0f be c0             	movsbl %al,%eax
     6f5:	83 ec 08             	sub    $0x8,%esp
     6f8:	50                   	push   %eax
     6f9:	ff 75 08             	pushl  0x8(%ebp)
     6fc:	e8 e3 fd ff ff       	call   4e4 <putc>
     701:	83 c4 10             	add    $0x10,%esp
     704:	eb 25                	jmp    72b <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     706:	83 ec 08             	sub    $0x8,%esp
     709:	6a 25                	push   $0x25
     70b:	ff 75 08             	pushl  0x8(%ebp)
     70e:	e8 d1 fd ff ff       	call   4e4 <putc>
     713:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     716:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     719:	0f be c0             	movsbl %al,%eax
     71c:	83 ec 08             	sub    $0x8,%esp
     71f:	50                   	push   %eax
     720:	ff 75 08             	pushl  0x8(%ebp)
     723:	e8 bc fd ff ff       	call   4e4 <putc>
     728:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     72b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     732:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     736:	8b 55 0c             	mov    0xc(%ebp),%edx
     739:	8b 45 f0             	mov    -0x10(%ebp),%eax
     73c:	01 d0                	add    %edx,%eax
     73e:	0f b6 00             	movzbl (%eax),%eax
     741:	84 c0                	test   %al,%al
     743:	0f 85 94 fe ff ff    	jne    5dd <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     749:	90                   	nop
     74a:	c9                   	leave  
     74b:	c3                   	ret    

0000074c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     74c:	55                   	push   %ebp
     74d:	89 e5                	mov    %esp,%ebp
     74f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     752:	8b 45 08             	mov    0x8(%ebp),%eax
     755:	83 e8 08             	sub    $0x8,%eax
     758:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     75b:	a1 28 29 00 00       	mov    0x2928,%eax
     760:	89 45 fc             	mov    %eax,-0x4(%ebp)
     763:	eb 24                	jmp    789 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     765:	8b 45 fc             	mov    -0x4(%ebp),%eax
     768:	8b 00                	mov    (%eax),%eax
     76a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     76d:	77 12                	ja     781 <free+0x35>
     76f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     772:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     775:	77 24                	ja     79b <free+0x4f>
     777:	8b 45 fc             	mov    -0x4(%ebp),%eax
     77a:	8b 00                	mov    (%eax),%eax
     77c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     77f:	77 1a                	ja     79b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     781:	8b 45 fc             	mov    -0x4(%ebp),%eax
     784:	8b 00                	mov    (%eax),%eax
     786:	89 45 fc             	mov    %eax,-0x4(%ebp)
     789:	8b 45 f8             	mov    -0x8(%ebp),%eax
     78c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     78f:	76 d4                	jbe    765 <free+0x19>
     791:	8b 45 fc             	mov    -0x4(%ebp),%eax
     794:	8b 00                	mov    (%eax),%eax
     796:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     799:	76 ca                	jbe    765 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     79b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     79e:	8b 40 04             	mov    0x4(%eax),%eax
     7a1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     7a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7ab:	01 c2                	add    %eax,%edx
     7ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7b0:	8b 00                	mov    (%eax),%eax
     7b2:	39 c2                	cmp    %eax,%edx
     7b4:	75 24                	jne    7da <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     7b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7b9:	8b 50 04             	mov    0x4(%eax),%edx
     7bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7bf:	8b 00                	mov    (%eax),%eax
     7c1:	8b 40 04             	mov    0x4(%eax),%eax
     7c4:	01 c2                	add    %eax,%edx
     7c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7c9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     7cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7cf:	8b 00                	mov    (%eax),%eax
     7d1:	8b 10                	mov    (%eax),%edx
     7d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7d6:	89 10                	mov    %edx,(%eax)
     7d8:	eb 0a                	jmp    7e4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     7da:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7dd:	8b 10                	mov    (%eax),%edx
     7df:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7e2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     7e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7e7:	8b 40 04             	mov    0x4(%eax),%eax
     7ea:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     7f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7f4:	01 d0                	add    %edx,%eax
     7f6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     7f9:	75 20                	jne    81b <free+0xcf>
    p->s.size += bp->s.size;
     7fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7fe:	8b 50 04             	mov    0x4(%eax),%edx
     801:	8b 45 f8             	mov    -0x8(%ebp),%eax
     804:	8b 40 04             	mov    0x4(%eax),%eax
     807:	01 c2                	add    %eax,%edx
     809:	8b 45 fc             	mov    -0x4(%ebp),%eax
     80c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     80f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     812:	8b 10                	mov    (%eax),%edx
     814:	8b 45 fc             	mov    -0x4(%ebp),%eax
     817:	89 10                	mov    %edx,(%eax)
     819:	eb 08                	jmp    823 <free+0xd7>
  } else
    p->s.ptr = bp;
     81b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     81e:	8b 55 f8             	mov    -0x8(%ebp),%edx
     821:	89 10                	mov    %edx,(%eax)
  freep = p;
     823:	8b 45 fc             	mov    -0x4(%ebp),%eax
     826:	a3 28 29 00 00       	mov    %eax,0x2928
}
     82b:	90                   	nop
     82c:	c9                   	leave  
     82d:	c3                   	ret    

0000082e <morecore>:

static Header*
morecore(uint nu)
{
     82e:	55                   	push   %ebp
     82f:	89 e5                	mov    %esp,%ebp
     831:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     834:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     83b:	77 07                	ja     844 <morecore+0x16>
    nu = 4096;
     83d:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     844:	8b 45 08             	mov    0x8(%ebp),%eax
     847:	c1 e0 03             	shl    $0x3,%eax
     84a:	83 ec 0c             	sub    $0xc,%esp
     84d:	50                   	push   %eax
     84e:	e8 49 fc ff ff       	call   49c <sbrk>
     853:	83 c4 10             	add    $0x10,%esp
     856:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     859:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     85d:	75 07                	jne    866 <morecore+0x38>
    return 0;
     85f:	b8 00 00 00 00       	mov    $0x0,%eax
     864:	eb 26                	jmp    88c <morecore+0x5e>
  hp = (Header*)p;
     866:	8b 45 f4             	mov    -0xc(%ebp),%eax
     869:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     86c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     86f:	8b 55 08             	mov    0x8(%ebp),%edx
     872:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     875:	8b 45 f0             	mov    -0x10(%ebp),%eax
     878:	83 c0 08             	add    $0x8,%eax
     87b:	83 ec 0c             	sub    $0xc,%esp
     87e:	50                   	push   %eax
     87f:	e8 c8 fe ff ff       	call   74c <free>
     884:	83 c4 10             	add    $0x10,%esp
  return freep;
     887:	a1 28 29 00 00       	mov    0x2928,%eax
}
     88c:	c9                   	leave  
     88d:	c3                   	ret    

0000088e <malloc>:

void*
malloc(uint nbytes)
{
     88e:	55                   	push   %ebp
     88f:	89 e5                	mov    %esp,%ebp
     891:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     894:	8b 45 08             	mov    0x8(%ebp),%eax
     897:	83 c0 07             	add    $0x7,%eax
     89a:	c1 e8 03             	shr    $0x3,%eax
     89d:	83 c0 01             	add    $0x1,%eax
     8a0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     8a3:	a1 28 29 00 00       	mov    0x2928,%eax
     8a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8ab:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8af:	75 23                	jne    8d4 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     8b1:	c7 45 f0 20 29 00 00 	movl   $0x2920,-0x10(%ebp)
     8b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8bb:	a3 28 29 00 00       	mov    %eax,0x2928
     8c0:	a1 28 29 00 00       	mov    0x2928,%eax
     8c5:	a3 20 29 00 00       	mov    %eax,0x2920
    base.s.size = 0;
     8ca:	c7 05 24 29 00 00 00 	movl   $0x0,0x2924
     8d1:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8d7:	8b 00                	mov    (%eax),%eax
     8d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     8dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8df:	8b 40 04             	mov    0x4(%eax),%eax
     8e2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     8e5:	72 4d                	jb     934 <malloc+0xa6>
      if(p->s.size == nunits)
     8e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8ea:	8b 40 04             	mov    0x4(%eax),%eax
     8ed:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     8f0:	75 0c                	jne    8fe <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     8f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f5:	8b 10                	mov    (%eax),%edx
     8f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8fa:	89 10                	mov    %edx,(%eax)
     8fc:	eb 26                	jmp    924 <malloc+0x96>
      else {
        p->s.size -= nunits;
     8fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     901:	8b 40 04             	mov    0x4(%eax),%eax
     904:	2b 45 ec             	sub    -0x14(%ebp),%eax
     907:	89 c2                	mov    %eax,%edx
     909:	8b 45 f4             	mov    -0xc(%ebp),%eax
     90c:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     90f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     912:	8b 40 04             	mov    0x4(%eax),%eax
     915:	c1 e0 03             	shl    $0x3,%eax
     918:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     91b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     91e:	8b 55 ec             	mov    -0x14(%ebp),%edx
     921:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     924:	8b 45 f0             	mov    -0x10(%ebp),%eax
     927:	a3 28 29 00 00       	mov    %eax,0x2928
      return (void*)(p + 1);
     92c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     92f:	83 c0 08             	add    $0x8,%eax
     932:	eb 3b                	jmp    96f <malloc+0xe1>
    }
    if(p == freep)
     934:	a1 28 29 00 00       	mov    0x2928,%eax
     939:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     93c:	75 1e                	jne    95c <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     93e:	83 ec 0c             	sub    $0xc,%esp
     941:	ff 75 ec             	pushl  -0x14(%ebp)
     944:	e8 e5 fe ff ff       	call   82e <morecore>
     949:	83 c4 10             	add    $0x10,%esp
     94c:	89 45 f4             	mov    %eax,-0xc(%ebp)
     94f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     953:	75 07                	jne    95c <malloc+0xce>
        return 0;
     955:	b8 00 00 00 00       	mov    $0x0,%eax
     95a:	eb 13                	jmp    96f <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     95c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     95f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     962:	8b 45 f4             	mov    -0xc(%ebp),%eax
     965:	8b 00                	mov    (%eax),%eax
     967:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     96a:	e9 6d ff ff ff       	jmp    8dc <malloc+0x4e>
}
     96f:	c9                   	leave  
     970:	c3                   	ret    

00000971 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     971:	55                   	push   %ebp
     972:	89 e5                	mov    %esp,%ebp
     974:	83 ec 1c             	sub    $0x1c,%esp
     977:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     97a:	8b 55 10             	mov    0x10(%ebp),%edx
     97d:	8b 45 14             	mov    0x14(%ebp),%eax
     980:	88 4d ec             	mov    %cl,-0x14(%ebp)
     983:	88 55 e8             	mov    %dl,-0x18(%ebp)
     986:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     989:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     98d:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     990:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     994:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     997:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     99b:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     99e:	8b 45 08             	mov    0x8(%ebp),%eax
     9a1:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     9a5:	66 89 10             	mov    %dx,(%eax)
     9a8:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     9ac:	88 50 02             	mov    %dl,0x2(%eax)
}
     9af:	8b 45 08             	mov    0x8(%ebp),%eax
     9b2:	c9                   	leave  
     9b3:	c2 04 00             	ret    $0x4

000009b6 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     9b6:	55                   	push   %ebp
     9b7:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     9b9:	8b 45 08             	mov    0x8(%ebp),%eax
     9bc:	2b 45 10             	sub    0x10(%ebp),%eax
     9bf:	89 c2                	mov    %eax,%edx
     9c1:	8b 45 08             	mov    0x8(%ebp),%eax
     9c4:	2b 45 10             	sub    0x10(%ebp),%eax
     9c7:	0f af d0             	imul   %eax,%edx
     9ca:	8b 45 0c             	mov    0xc(%ebp),%eax
     9cd:	2b 45 14             	sub    0x14(%ebp),%eax
     9d0:	89 c1                	mov    %eax,%ecx
     9d2:	8b 45 0c             	mov    0xc(%ebp),%eax
     9d5:	2b 45 14             	sub    0x14(%ebp),%eax
     9d8:	0f af c1             	imul   %ecx,%eax
     9db:	01 d0                	add    %edx,%eax
}
     9dd:	5d                   	pop    %ebp
     9de:	c3                   	ret    

000009df <abs_int>:

static inline int abs_int(int x)
{
     9df:	55                   	push   %ebp
     9e0:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     9e2:	8b 45 08             	mov    0x8(%ebp),%eax
     9e5:	99                   	cltd   
     9e6:	89 d0                	mov    %edx,%eax
     9e8:	33 45 08             	xor    0x8(%ebp),%eax
     9eb:	29 d0                	sub    %edx,%eax
}
     9ed:	5d                   	pop    %ebp
     9ee:	c3                   	ret    

000009ef <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     9ef:	55                   	push   %ebp
     9f0:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     9f2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     9f6:	79 07                	jns    9ff <APGetIndex+0x10>
        return X_SMALLER;
     9f8:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     9fd:	eb 40                	jmp    a3f <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     9ff:	8b 45 08             	mov    0x8(%ebp),%eax
     a02:	8b 00                	mov    (%eax),%eax
     a04:	3b 45 0c             	cmp    0xc(%ebp),%eax
     a07:	7f 07                	jg     a10 <APGetIndex+0x21>
        return X_BIGGER;
     a09:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a0e:	eb 2f                	jmp    a3f <APGetIndex+0x50>
    if (y < 0)
     a10:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     a14:	79 07                	jns    a1d <APGetIndex+0x2e>
        return Y_SMALLER;
     a16:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     a1b:	eb 22                	jmp    a3f <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     a1d:	8b 45 08             	mov    0x8(%ebp),%eax
     a20:	8b 40 04             	mov    0x4(%eax),%eax
     a23:	3b 45 10             	cmp    0x10(%ebp),%eax
     a26:	7f 07                	jg     a2f <APGetIndex+0x40>
        return Y_BIGGER;
     a28:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     a2d:	eb 10                	jmp    a3f <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     a2f:	8b 45 08             	mov    0x8(%ebp),%eax
     a32:	8b 00                	mov    (%eax),%eax
     a34:	0f af 45 10          	imul   0x10(%ebp),%eax
     a38:	89 c2                	mov    %eax,%edx
     a3a:	8b 45 0c             	mov    0xc(%ebp),%eax
     a3d:	01 d0                	add    %edx,%eax
}
     a3f:	5d                   	pop    %ebp
     a40:	c3                   	ret    

00000a41 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     a41:	55                   	push   %ebp
     a42:	89 e5                	mov    %esp,%ebp
     a44:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     a47:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     a4e:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a51:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     a54:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     a5b:	83 ec 08             	sub    $0x8,%esp
     a5e:	6a 00                	push   $0x0
     a60:	ff 75 0c             	pushl  0xc(%ebp)
     a63:	e8 ec f9 ff ff       	call   454 <open>
     a68:	83 c4 10             	add    $0x10,%esp
     a6b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     a6e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     a72:	79 2e                	jns    aa2 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     a74:	83 ec 04             	sub    $0x4,%esp
     a77:	ff 75 0c             	pushl  0xc(%ebp)
     a7a:	68 3f 22 00 00       	push   $0x223f
     a7f:	6a 01                	push   $0x1
     a81:	e8 35 fb ff ff       	call   5bb <printf>
     a86:	83 c4 10             	add    $0x10,%esp
        return bmp;
     a89:	8b 45 08             	mov    0x8(%ebp),%eax
     a8c:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a8f:	89 10                	mov    %edx,(%eax)
     a91:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a94:	89 50 04             	mov    %edx,0x4(%eax)
     a97:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a9a:	89 50 08             	mov    %edx,0x8(%eax)
     a9d:	e9 d2 01 00 00       	jmp    c74 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     aa2:	83 ec 04             	sub    $0x4,%esp
     aa5:	6a 0e                	push   $0xe
     aa7:	8d 45 ba             	lea    -0x46(%ebp),%eax
     aaa:	50                   	push   %eax
     aab:	ff 75 ec             	pushl  -0x14(%ebp)
     aae:	e8 79 f9 ff ff       	call   42c <read>
     ab3:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     ab6:	83 ec 04             	sub    $0x4,%esp
     ab9:	6a 28                	push   $0x28
     abb:	8d 45 92             	lea    -0x6e(%ebp),%eax
     abe:	50                   	push   %eax
     abf:	ff 75 ec             	pushl  -0x14(%ebp)
     ac2:	e8 65 f9 ff ff       	call   42c <read>
     ac7:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     aca:	8b 45 96             	mov    -0x6a(%ebp),%eax
     acd:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     ad0:	8b 45 9a             	mov    -0x66(%ebp),%eax
     ad3:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     ad6:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ad9:	8b 45 cc             	mov    -0x34(%ebp),%eax
     adc:	0f af d0             	imul   %eax,%edx
     adf:	89 d0                	mov    %edx,%eax
     ae1:	01 c0                	add    %eax,%eax
     ae3:	01 d0                	add    %edx,%eax
     ae5:	83 ec 0c             	sub    $0xc,%esp
     ae8:	50                   	push   %eax
     ae9:	e8 a0 fd ff ff       	call   88e <malloc>
     aee:	83 c4 10             	add    $0x10,%esp
     af1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     af4:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     af8:	0f b7 c0             	movzwl %ax,%eax
     afb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     afe:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b01:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b04:	0f af c2             	imul   %edx,%eax
     b07:	83 c0 1f             	add    $0x1f,%eax
     b0a:	c1 e8 05             	shr    $0x5,%eax
     b0d:	c1 e0 02             	shl    $0x2,%eax
     b10:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     b13:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b19:	0f af c2             	imul   %edx,%eax
     b1c:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     b1f:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b22:	83 ec 0c             	sub    $0xc,%esp
     b25:	50                   	push   %eax
     b26:	e8 63 fd ff ff       	call   88e <malloc>
     b2b:	83 c4 10             	add    $0x10,%esp
     b2e:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     b31:	83 ec 04             	sub    $0x4,%esp
     b34:	ff 75 e0             	pushl  -0x20(%ebp)
     b37:	ff 75 dc             	pushl  -0x24(%ebp)
     b3a:	ff 75 ec             	pushl  -0x14(%ebp)
     b3d:	e8 ea f8 ff ff       	call   42c <read>
     b42:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     b45:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     b49:	66 c1 e8 03          	shr    $0x3,%ax
     b4d:	0f b7 c0             	movzwl %ax,%eax
     b50:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     b53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     b5a:	e9 e5 00 00 00       	jmp    c44 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     b5f:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b62:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b65:	29 c2                	sub    %eax,%edx
     b67:	89 d0                	mov    %edx,%eax
     b69:	8d 50 ff             	lea    -0x1(%eax),%edx
     b6c:	8b 45 c8             	mov    -0x38(%ebp),%eax
     b6f:	0f af c2             	imul   %edx,%eax
     b72:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     b75:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b7c:	e9 b1 00 00 00       	jmp    c32 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     b81:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b84:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b87:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b8a:	01 c8                	add    %ecx,%eax
     b8c:	89 c1                	mov    %eax,%ecx
     b8e:	89 c8                	mov    %ecx,%eax
     b90:	01 c0                	add    %eax,%eax
     b92:	01 c8                	add    %ecx,%eax
     b94:	01 c2                	add    %eax,%edx
     b96:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b99:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b9d:	89 c1                	mov    %eax,%ecx
     b9f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ba2:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ba6:	01 c1                	add    %eax,%ecx
     ba8:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bab:	01 c8                	add    %ecx,%eax
     bad:	8d 48 ff             	lea    -0x1(%eax),%ecx
     bb0:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bb3:	01 c8                	add    %ecx,%eax
     bb5:	0f b6 00             	movzbl (%eax),%eax
     bb8:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     bbb:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bbe:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     bc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bc4:	01 c8                	add    %ecx,%eax
     bc6:	89 c1                	mov    %eax,%ecx
     bc8:	89 c8                	mov    %ecx,%eax
     bca:	01 c0                	add    %eax,%eax
     bcc:	01 c8                	add    %ecx,%eax
     bce:	01 c2                	add    %eax,%edx
     bd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd3:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     bd7:	89 c1                	mov    %eax,%ecx
     bd9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bdc:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     be0:	01 c1                	add    %eax,%ecx
     be2:	8b 45 d8             	mov    -0x28(%ebp),%eax
     be5:	01 c8                	add    %ecx,%eax
     be7:	8d 48 fe             	lea    -0x2(%eax),%ecx
     bea:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bed:	01 c8                	add    %ecx,%eax
     bef:	0f b6 00             	movzbl (%eax),%eax
     bf2:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     bf5:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bf8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     bfb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bfe:	01 c8                	add    %ecx,%eax
     c00:	89 c1                	mov    %eax,%ecx
     c02:	89 c8                	mov    %ecx,%eax
     c04:	01 c0                	add    %eax,%eax
     c06:	01 c8                	add    %ecx,%eax
     c08:	01 c2                	add    %eax,%edx
     c0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c0d:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     c11:	89 c1                	mov    %eax,%ecx
     c13:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c16:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     c1a:	01 c1                	add    %eax,%ecx
     c1c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c1f:	01 c8                	add    %ecx,%eax
     c21:	8d 48 fd             	lea    -0x3(%eax),%ecx
     c24:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c27:	01 c8                	add    %ecx,%eax
     c29:	0f b6 00             	movzbl (%eax),%eax
     c2c:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     c2e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     c32:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c35:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c38:	39 c2                	cmp    %eax,%edx
     c3a:	0f 87 41 ff ff ff    	ja     b81 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     c40:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c44:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c47:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c4a:	39 c2                	cmp    %eax,%edx
     c4c:	0f 87 0d ff ff ff    	ja     b5f <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     c52:	83 ec 0c             	sub    $0xc,%esp
     c55:	ff 75 ec             	pushl  -0x14(%ebp)
     c58:	e8 df f7 ff ff       	call   43c <close>
     c5d:	83 c4 10             	add    $0x10,%esp
    return bmp;
     c60:	8b 45 08             	mov    0x8(%ebp),%eax
     c63:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c66:	89 10                	mov    %edx,(%eax)
     c68:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c6b:	89 50 04             	mov    %edx,0x4(%eax)
     c6e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c71:	89 50 08             	mov    %edx,0x8(%eax)
}
     c74:	8b 45 08             	mov    0x8(%ebp),%eax
     c77:	c9                   	leave  
     c78:	c2 04 00             	ret    $0x4

00000c7b <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     c7b:	55                   	push   %ebp
     c7c:	89 e5                	mov    %esp,%ebp
     c7e:	53                   	push   %ebx
     c7f:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     c82:	83 ec 0c             	sub    $0xc,%esp
     c85:	6a 1c                	push   $0x1c
     c87:	e8 02 fc ff ff       	call   88e <malloc>
     c8c:	83 c4 10             	add    $0x10,%esp
     c8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     c92:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c95:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     c9c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c9f:	8d 45 d8             	lea    -0x28(%ebp),%eax
     ca2:	6a 0c                	push   $0xc
     ca4:	6a 0c                	push   $0xc
     ca6:	6a 0c                	push   $0xc
     ca8:	50                   	push   %eax
     ca9:	e8 c3 fc ff ff       	call   971 <RGB>
     cae:	83 c4 0c             	add    $0xc,%esp
     cb1:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     cb5:	66 89 43 13          	mov    %ax,0x13(%ebx)
     cb9:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     cbd:	88 43 15             	mov    %al,0x15(%ebx)
     cc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc3:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cc6:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     cca:	66 89 48 10          	mov    %cx,0x10(%eax)
     cce:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     cd2:	88 50 12             	mov    %dl,0x12(%eax)
     cd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cd8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cdb:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     cdf:	66 89 48 08          	mov    %cx,0x8(%eax)
     ce3:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     ce7:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     cea:	8b 45 08             	mov    0x8(%ebp),%eax
     ced:	89 c2                	mov    %eax,%edx
     cef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf2:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     cf4:	8b 45 0c             	mov    0xc(%ebp),%eax
     cf7:	89 c2                	mov    %eax,%edx
     cf9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cfc:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     cff:	8b 55 10             	mov    0x10(%ebp),%edx
     d02:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d05:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     d08:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     d0b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d0e:	c9                   	leave  
     d0f:	c3                   	ret    

00000d10 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     d16:	8b 45 0c             	mov    0xc(%ebp),%eax
     d19:	8b 50 08             	mov    0x8(%eax),%edx
     d1c:	89 55 f8             	mov    %edx,-0x8(%ebp)
     d1f:	8b 40 0c             	mov    0xc(%eax),%eax
     d22:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     d25:	8b 45 0c             	mov    0xc(%ebp),%eax
     d28:	8b 55 10             	mov    0x10(%ebp),%edx
     d2b:	89 50 08             	mov    %edx,0x8(%eax)
     d2e:	8b 55 14             	mov    0x14(%ebp),%edx
     d31:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     d34:	8b 45 08             	mov    0x8(%ebp),%eax
     d37:	8b 55 f8             	mov    -0x8(%ebp),%edx
     d3a:	89 10                	mov    %edx,(%eax)
     d3c:	8b 55 fc             	mov    -0x4(%ebp),%edx
     d3f:	89 50 04             	mov    %edx,0x4(%eax)
}
     d42:	8b 45 08             	mov    0x8(%ebp),%eax
     d45:	c9                   	leave  
     d46:	c2 04 00             	ret    $0x4

00000d49 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     d49:	55                   	push   %ebp
     d4a:	89 e5                	mov    %esp,%ebp
     d4c:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     d4f:	8b 45 0c             	mov    0xc(%ebp),%eax
     d52:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     d56:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     d5a:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     d5e:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     d61:	8b 45 0c             	mov    0xc(%ebp),%eax
     d64:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     d68:	66 89 50 10          	mov    %dx,0x10(%eax)
     d6c:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     d70:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     d73:	8b 45 08             	mov    0x8(%ebp),%eax
     d76:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d7a:	66 89 10             	mov    %dx,(%eax)
     d7d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d81:	88 50 02             	mov    %dl,0x2(%eax)
}
     d84:	8b 45 08             	mov    0x8(%ebp),%eax
     d87:	c9                   	leave  
     d88:	c2 04 00             	ret    $0x4

00000d8b <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     d8b:	55                   	push   %ebp
     d8c:	89 e5                	mov    %esp,%ebp
     d8e:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     d91:	8b 45 08             	mov    0x8(%ebp),%eax
     d94:	8b 40 0c             	mov    0xc(%eax),%eax
     d97:	89 c2                	mov    %eax,%edx
     d99:	c1 ea 1f             	shr    $0x1f,%edx
     d9c:	01 d0                	add    %edx,%eax
     d9e:	d1 f8                	sar    %eax
     da0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     da3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da6:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     daa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     dad:	8b 45 10             	mov    0x10(%ebp),%eax
     db0:	2b 45 f4             	sub    -0xc(%ebp),%eax
     db3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     db6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     dba:	0f 89 98 00 00 00    	jns    e58 <APDrawPoint+0xcd>
        i = 0;
     dc0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     dc7:	e9 8c 00 00 00       	jmp    e58 <APDrawPoint+0xcd>
    {
        j = x - off;
     dcc:	8b 45 0c             	mov    0xc(%ebp),%eax
     dcf:	2b 45 f4             	sub    -0xc(%ebp),%eax
     dd2:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     dd5:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     dd9:	79 69                	jns    e44 <APDrawPoint+0xb9>
            j = 0;
     ddb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     de2:	eb 60                	jmp    e44 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     de4:	ff 75 fc             	pushl  -0x4(%ebp)
     de7:	ff 75 f8             	pushl  -0x8(%ebp)
     dea:	ff 75 08             	pushl  0x8(%ebp)
     ded:	e8 fd fb ff ff       	call   9ef <APGetIndex>
     df2:	83 c4 0c             	add    $0xc,%esp
     df5:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     df8:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     dfc:	74 55                	je     e53 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     dfe:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     e02:	74 67                	je     e6b <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     e04:	ff 75 10             	pushl  0x10(%ebp)
     e07:	ff 75 0c             	pushl  0xc(%ebp)
     e0a:	ff 75 fc             	pushl  -0x4(%ebp)
     e0d:	ff 75 f8             	pushl  -0x8(%ebp)
     e10:	e8 a1 fb ff ff       	call   9b6 <distance_2>
     e15:	83 c4 10             	add    $0x10,%esp
     e18:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     e1b:	7f 23                	jg     e40 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     e1d:	8b 45 08             	mov    0x8(%ebp),%eax
     e20:	8b 48 18             	mov    0x18(%eax),%ecx
     e23:	8b 55 ec             	mov    -0x14(%ebp),%edx
     e26:	89 d0                	mov    %edx,%eax
     e28:	01 c0                	add    %eax,%eax
     e2a:	01 d0                	add    %edx,%eax
     e2c:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     e2f:	8b 45 08             	mov    0x8(%ebp),%eax
     e32:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     e36:	66 89 0a             	mov    %cx,(%edx)
     e39:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     e3d:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     e40:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     e44:	8b 55 0c             	mov    0xc(%ebp),%edx
     e47:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e4a:	01 d0                	add    %edx,%eax
     e4c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     e4f:	7d 93                	jge    de4 <APDrawPoint+0x59>
     e51:	eb 01                	jmp    e54 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     e53:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     e54:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     e58:	8b 55 10             	mov    0x10(%ebp),%edx
     e5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e5e:	01 d0                	add    %edx,%eax
     e60:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e63:	0f 8d 63 ff ff ff    	jge    dcc <APDrawPoint+0x41>
     e69:	eb 01                	jmp    e6c <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     e6b:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     e6c:	c9                   	leave  
     e6d:	c3                   	ret    

00000e6e <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     e6e:	55                   	push   %ebp
     e6f:	89 e5                	mov    %esp,%ebp
     e71:	53                   	push   %ebx
     e72:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     e75:	8b 45 0c             	mov    0xc(%ebp),%eax
     e78:	3b 45 14             	cmp    0x14(%ebp),%eax
     e7b:	0f 85 80 00 00 00    	jne    f01 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     e81:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e85:	0f 88 9d 02 00 00    	js     1128 <APDrawLine+0x2ba>
     e8b:	8b 45 08             	mov    0x8(%ebp),%eax
     e8e:	8b 00                	mov    (%eax),%eax
     e90:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e93:	0f 8e 8f 02 00 00    	jle    1128 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     e99:	8b 45 10             	mov    0x10(%ebp),%eax
     e9c:	3b 45 18             	cmp    0x18(%ebp),%eax
     e9f:	7e 12                	jle    eb3 <APDrawLine+0x45>
        {
            int tmp = y2;
     ea1:	8b 45 18             	mov    0x18(%ebp),%eax
     ea4:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     ea7:	8b 45 10             	mov    0x10(%ebp),%eax
     eaa:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     ead:	8b 45 dc             	mov    -0x24(%ebp),%eax
     eb0:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     eb3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     eb7:	79 07                	jns    ec0 <APDrawLine+0x52>
     eb9:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     ec0:	8b 45 08             	mov    0x8(%ebp),%eax
     ec3:	8b 40 04             	mov    0x4(%eax),%eax
     ec6:	3b 45 18             	cmp    0x18(%ebp),%eax
     ec9:	7d 0c                	jge    ed7 <APDrawLine+0x69>
     ecb:	8b 45 08             	mov    0x8(%ebp),%eax
     ece:	8b 40 04             	mov    0x4(%eax),%eax
     ed1:	83 e8 01             	sub    $0x1,%eax
     ed4:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     ed7:	8b 45 10             	mov    0x10(%ebp),%eax
     eda:	89 45 f4             	mov    %eax,-0xc(%ebp)
     edd:	eb 15                	jmp    ef4 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     edf:	ff 75 f4             	pushl  -0xc(%ebp)
     ee2:	ff 75 0c             	pushl  0xc(%ebp)
     ee5:	ff 75 08             	pushl  0x8(%ebp)
     ee8:	e8 9e fe ff ff       	call   d8b <APDrawPoint>
     eed:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     ef0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ef4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ef7:	3b 45 18             	cmp    0x18(%ebp),%eax
     efa:	7e e3                	jle    edf <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     efc:	e9 2b 02 00 00       	jmp    112c <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     f01:	8b 45 10             	mov    0x10(%ebp),%eax
     f04:	3b 45 18             	cmp    0x18(%ebp),%eax
     f07:	75 7f                	jne    f88 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     f09:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     f0d:	0f 88 18 02 00 00    	js     112b <APDrawLine+0x2bd>
     f13:	8b 45 08             	mov    0x8(%ebp),%eax
     f16:	8b 40 04             	mov    0x4(%eax),%eax
     f19:	3b 45 10             	cmp    0x10(%ebp),%eax
     f1c:	0f 8e 09 02 00 00    	jle    112b <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     f22:	8b 45 0c             	mov    0xc(%ebp),%eax
     f25:	3b 45 14             	cmp    0x14(%ebp),%eax
     f28:	7e 12                	jle    f3c <APDrawLine+0xce>
        {
            int tmp = x2;
     f2a:	8b 45 14             	mov    0x14(%ebp),%eax
     f2d:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     f30:	8b 45 0c             	mov    0xc(%ebp),%eax
     f33:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     f36:	8b 45 d8             	mov    -0x28(%ebp),%eax
     f39:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     f3c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f40:	79 07                	jns    f49 <APDrawLine+0xdb>
     f42:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     f49:	8b 45 08             	mov    0x8(%ebp),%eax
     f4c:	8b 00                	mov    (%eax),%eax
     f4e:	3b 45 14             	cmp    0x14(%ebp),%eax
     f51:	7d 0b                	jge    f5e <APDrawLine+0xf0>
     f53:	8b 45 08             	mov    0x8(%ebp),%eax
     f56:	8b 00                	mov    (%eax),%eax
     f58:	83 e8 01             	sub    $0x1,%eax
     f5b:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     f5e:	8b 45 0c             	mov    0xc(%ebp),%eax
     f61:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f64:	eb 15                	jmp    f7b <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     f66:	ff 75 10             	pushl  0x10(%ebp)
     f69:	ff 75 f0             	pushl  -0x10(%ebp)
     f6c:	ff 75 08             	pushl  0x8(%ebp)
     f6f:	e8 17 fe ff ff       	call   d8b <APDrawPoint>
     f74:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     f77:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f7e:	3b 45 14             	cmp    0x14(%ebp),%eax
     f81:	7e e3                	jle    f66 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     f83:	e9 a4 01 00 00       	jmp    112c <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     f88:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f8f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     f96:	8b 45 0c             	mov    0xc(%ebp),%eax
     f99:	2b 45 14             	sub    0x14(%ebp),%eax
     f9c:	50                   	push   %eax
     f9d:	e8 3d fa ff ff       	call   9df <abs_int>
     fa2:	83 c4 04             	add    $0x4,%esp
     fa5:	89 c3                	mov    %eax,%ebx
     fa7:	8b 45 10             	mov    0x10(%ebp),%eax
     faa:	2b 45 18             	sub    0x18(%ebp),%eax
     fad:	50                   	push   %eax
     fae:	e8 2c fa ff ff       	call   9df <abs_int>
     fb3:	83 c4 04             	add    $0x4,%esp
     fb6:	39 c3                	cmp    %eax,%ebx
     fb8:	0f 8e b5 00 00 00    	jle    1073 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     fbe:	8b 45 10             	mov    0x10(%ebp),%eax
     fc1:	2b 45 18             	sub    0x18(%ebp),%eax
     fc4:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fc7:	db 45 b0             	fildl  -0x50(%ebp)
     fca:	8b 45 0c             	mov    0xc(%ebp),%eax
     fcd:	2b 45 14             	sub    0x14(%ebp),%eax
     fd0:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fd3:	db 45 b0             	fildl  -0x50(%ebp)
     fd6:	de f9                	fdivrp %st,%st(1)
     fd8:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     fdb:	8b 45 14             	mov    0x14(%ebp),%eax
     fde:	3b 45 0c             	cmp    0xc(%ebp),%eax
     fe1:	7e 0e                	jle    ff1 <APDrawLine+0x183>
        {
            s = x1;
     fe3:	8b 45 0c             	mov    0xc(%ebp),%eax
     fe6:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     fe9:	8b 45 14             	mov    0x14(%ebp),%eax
     fec:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fef:	eb 0c                	jmp    ffd <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ff1:	8b 45 14             	mov    0x14(%ebp),%eax
     ff4:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     ff7:	8b 45 0c             	mov    0xc(%ebp),%eax
     ffa:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     ffd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1001:	79 07                	jns    100a <APDrawLine+0x19c>
    1003:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    100a:	8b 45 08             	mov    0x8(%ebp),%eax
    100d:	8b 00                	mov    (%eax),%eax
    100f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1012:	7f 0b                	jg     101f <APDrawLine+0x1b1>
    1014:	8b 45 08             	mov    0x8(%ebp),%eax
    1017:	8b 00                	mov    (%eax),%eax
    1019:	83 e8 01             	sub    $0x1,%eax
    101c:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    101f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1022:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1025:	eb 3f                	jmp    1066 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1027:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    102a:	2b 45 0c             	sub    0xc(%ebp),%eax
    102d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1030:	db 45 b0             	fildl  -0x50(%ebp)
    1033:	dc 4d d0             	fmull  -0x30(%ebp)
    1036:	db 45 10             	fildl  0x10(%ebp)
    1039:	de c1                	faddp  %st,%st(1)
    103b:	d9 7d b6             	fnstcw -0x4a(%ebp)
    103e:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1042:	b4 0c                	mov    $0xc,%ah
    1044:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1048:	d9 6d b4             	fldcw  -0x4c(%ebp)
    104b:	db 5d cc             	fistpl -0x34(%ebp)
    104e:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1051:	ff 75 cc             	pushl  -0x34(%ebp)
    1054:	ff 75 e4             	pushl  -0x1c(%ebp)
    1057:	ff 75 08             	pushl  0x8(%ebp)
    105a:	e8 2c fd ff ff       	call   d8b <APDrawPoint>
    105f:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1062:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1066:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1069:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    106c:	7e b9                	jle    1027 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    106e:	e9 b9 00 00 00       	jmp    112c <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1073:	8b 45 0c             	mov    0xc(%ebp),%eax
    1076:	2b 45 14             	sub    0x14(%ebp),%eax
    1079:	89 45 b0             	mov    %eax,-0x50(%ebp)
    107c:	db 45 b0             	fildl  -0x50(%ebp)
    107f:	8b 45 10             	mov    0x10(%ebp),%eax
    1082:	2b 45 18             	sub    0x18(%ebp),%eax
    1085:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1088:	db 45 b0             	fildl  -0x50(%ebp)
    108b:	de f9                	fdivrp %st,%st(1)
    108d:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1090:	8b 45 10             	mov    0x10(%ebp),%eax
    1093:	3b 45 18             	cmp    0x18(%ebp),%eax
    1096:	7e 0e                	jle    10a6 <APDrawLine+0x238>
    {
        s = y2;
    1098:	8b 45 18             	mov    0x18(%ebp),%eax
    109b:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    109e:	8b 45 10             	mov    0x10(%ebp),%eax
    10a1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    10a4:	eb 0c                	jmp    10b2 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    10a6:	8b 45 10             	mov    0x10(%ebp),%eax
    10a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    10ac:	8b 45 18             	mov    0x18(%ebp),%eax
    10af:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    10b2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10b6:	79 07                	jns    10bf <APDrawLine+0x251>
    10b8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    10bf:	8b 45 08             	mov    0x8(%ebp),%eax
    10c2:	8b 40 04             	mov    0x4(%eax),%eax
    10c5:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10c8:	7f 0c                	jg     10d6 <APDrawLine+0x268>
    10ca:	8b 45 08             	mov    0x8(%ebp),%eax
    10cd:	8b 40 04             	mov    0x4(%eax),%eax
    10d0:	83 e8 01             	sub    $0x1,%eax
    10d3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    10d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    10dc:	eb 3f                	jmp    111d <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    10de:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10e1:	2b 45 10             	sub    0x10(%ebp),%eax
    10e4:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10e7:	db 45 b0             	fildl  -0x50(%ebp)
    10ea:	dc 4d c0             	fmull  -0x40(%ebp)
    10ed:	db 45 0c             	fildl  0xc(%ebp)
    10f0:	de c1                	faddp  %st,%st(1)
    10f2:	d9 7d b6             	fnstcw -0x4a(%ebp)
    10f5:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    10f9:	b4 0c                	mov    $0xc,%ah
    10fb:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    10ff:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1102:	db 5d bc             	fistpl -0x44(%ebp)
    1105:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1108:	ff 75 e0             	pushl  -0x20(%ebp)
    110b:	ff 75 bc             	pushl  -0x44(%ebp)
    110e:	ff 75 08             	pushl  0x8(%ebp)
    1111:	e8 75 fc ff ff       	call   d8b <APDrawPoint>
    1116:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1119:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    111d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1120:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1123:	7e b9                	jle    10de <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1125:	90                   	nop
    1126:	eb 04                	jmp    112c <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1128:	90                   	nop
    1129:	eb 01                	jmp    112c <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    112b:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    112c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    112f:	c9                   	leave  
    1130:	c3                   	ret    

00001131 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1131:	55                   	push   %ebp
    1132:	89 e5                	mov    %esp,%ebp
    1134:	53                   	push   %ebx
    1135:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1138:	8b 55 10             	mov    0x10(%ebp),%edx
    113b:	8b 45 18             	mov    0x18(%ebp),%eax
    113e:	01 d0                	add    %edx,%eax
    1140:	83 e8 01             	sub    $0x1,%eax
    1143:	83 ec 04             	sub    $0x4,%esp
    1146:	50                   	push   %eax
    1147:	ff 75 0c             	pushl  0xc(%ebp)
    114a:	ff 75 10             	pushl  0x10(%ebp)
    114d:	ff 75 0c             	pushl  0xc(%ebp)
    1150:	ff 75 08             	pushl  0x8(%ebp)
    1153:	e8 16 fd ff ff       	call   e6e <APDrawLine>
    1158:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    115b:	8b 55 0c             	mov    0xc(%ebp),%edx
    115e:	8b 45 14             	mov    0x14(%ebp),%eax
    1161:	01 d0                	add    %edx,%eax
    1163:	83 e8 01             	sub    $0x1,%eax
    1166:	83 ec 04             	sub    $0x4,%esp
    1169:	ff 75 10             	pushl  0x10(%ebp)
    116c:	50                   	push   %eax
    116d:	ff 75 10             	pushl  0x10(%ebp)
    1170:	ff 75 0c             	pushl  0xc(%ebp)
    1173:	ff 75 08             	pushl  0x8(%ebp)
    1176:	e8 f3 fc ff ff       	call   e6e <APDrawLine>
    117b:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    117e:	8b 55 10             	mov    0x10(%ebp),%edx
    1181:	8b 45 18             	mov    0x18(%ebp),%eax
    1184:	01 d0                	add    %edx,%eax
    1186:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1189:	8b 55 0c             	mov    0xc(%ebp),%edx
    118c:	8b 45 14             	mov    0x14(%ebp),%eax
    118f:	01 d0                	add    %edx,%eax
    1191:	8d 50 ff             	lea    -0x1(%eax),%edx
    1194:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1197:	8b 45 14             	mov    0x14(%ebp),%eax
    119a:	01 d8                	add    %ebx,%eax
    119c:	83 e8 01             	sub    $0x1,%eax
    119f:	83 ec 04             	sub    $0x4,%esp
    11a2:	51                   	push   %ecx
    11a3:	52                   	push   %edx
    11a4:	ff 75 10             	pushl  0x10(%ebp)
    11a7:	50                   	push   %eax
    11a8:	ff 75 08             	pushl  0x8(%ebp)
    11ab:	e8 be fc ff ff       	call   e6e <APDrawLine>
    11b0:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    11b3:	8b 55 10             	mov    0x10(%ebp),%edx
    11b6:	8b 45 18             	mov    0x18(%ebp),%eax
    11b9:	01 d0                	add    %edx,%eax
    11bb:	8d 48 ff             	lea    -0x1(%eax),%ecx
    11be:	8b 55 0c             	mov    0xc(%ebp),%edx
    11c1:	8b 45 14             	mov    0x14(%ebp),%eax
    11c4:	01 d0                	add    %edx,%eax
    11c6:	8d 50 ff             	lea    -0x1(%eax),%edx
    11c9:	8b 5d 10             	mov    0x10(%ebp),%ebx
    11cc:	8b 45 18             	mov    0x18(%ebp),%eax
    11cf:	01 d8                	add    %ebx,%eax
    11d1:	83 e8 01             	sub    $0x1,%eax
    11d4:	83 ec 04             	sub    $0x4,%esp
    11d7:	51                   	push   %ecx
    11d8:	52                   	push   %edx
    11d9:	50                   	push   %eax
    11da:	ff 75 0c             	pushl  0xc(%ebp)
    11dd:	ff 75 08             	pushl  0x8(%ebp)
    11e0:	e8 89 fc ff ff       	call   e6e <APDrawLine>
    11e5:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    11e8:	8b 55 0c             	mov    0xc(%ebp),%edx
    11eb:	8b 45 14             	mov    0x14(%ebp),%eax
    11ee:	01 d0                	add    %edx,%eax
    11f0:	8d 50 ff             	lea    -0x1(%eax),%edx
    11f3:	8b 45 08             	mov    0x8(%ebp),%eax
    11f6:	8b 40 0c             	mov    0xc(%eax),%eax
    11f9:	89 c1                	mov    %eax,%ecx
    11fb:	c1 e9 1f             	shr    $0x1f,%ecx
    11fe:	01 c8                	add    %ecx,%eax
    1200:	d1 f8                	sar    %eax
    1202:	29 c2                	sub    %eax,%edx
    1204:	89 d0                	mov    %edx,%eax
    1206:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1209:	8b 55 10             	mov    0x10(%ebp),%edx
    120c:	8b 45 18             	mov    0x18(%ebp),%eax
    120f:	01 d0                	add    %edx,%eax
    1211:	8d 50 ff             	lea    -0x1(%eax),%edx
    1214:	8b 45 08             	mov    0x8(%ebp),%eax
    1217:	8b 40 0c             	mov    0xc(%eax),%eax
    121a:	89 c1                	mov    %eax,%ecx
    121c:	c1 e9 1f             	shr    $0x1f,%ecx
    121f:	01 c8                	add    %ecx,%eax
    1221:	d1 f8                	sar    %eax
    1223:	29 c2                	sub    %eax,%edx
    1225:	89 d0                	mov    %edx,%eax
    1227:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    122a:	8b 45 08             	mov    0x8(%ebp),%eax
    122d:	8b 40 0c             	mov    0xc(%eax),%eax
    1230:	89 c2                	mov    %eax,%edx
    1232:	c1 ea 1f             	shr    $0x1f,%edx
    1235:	01 d0                	add    %edx,%eax
    1237:	d1 f8                	sar    %eax
    1239:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    123c:	8b 45 08             	mov    0x8(%ebp),%eax
    123f:	8b 40 0c             	mov    0xc(%eax),%eax
    1242:	89 c2                	mov    %eax,%edx
    1244:	c1 ea 1f             	shr    $0x1f,%edx
    1247:	01 d0                	add    %edx,%eax
    1249:	d1 f8                	sar    %eax
    124b:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    124e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1252:	0f 88 d8 00 00 00    	js     1330 <APDrawRect+0x1ff>
    1258:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    125c:	0f 88 ce 00 00 00    	js     1330 <APDrawRect+0x1ff>
    1262:	8b 45 08             	mov    0x8(%ebp),%eax
    1265:	8b 00                	mov    (%eax),%eax
    1267:	3b 45 0c             	cmp    0xc(%ebp),%eax
    126a:	0f 8e c0 00 00 00    	jle    1330 <APDrawRect+0x1ff>
    1270:	8b 45 08             	mov    0x8(%ebp),%eax
    1273:	8b 40 04             	mov    0x4(%eax),%eax
    1276:	3b 45 10             	cmp    0x10(%ebp),%eax
    1279:	0f 8e b1 00 00 00    	jle    1330 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    127f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1283:	79 07                	jns    128c <APDrawRect+0x15b>
    1285:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    128c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1290:	79 07                	jns    1299 <APDrawRect+0x168>
    1292:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1299:	8b 45 08             	mov    0x8(%ebp),%eax
    129c:	8b 00                	mov    (%eax),%eax
    129e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    12a1:	7f 0b                	jg     12ae <APDrawRect+0x17d>
    12a3:	8b 45 08             	mov    0x8(%ebp),%eax
    12a6:	8b 00                	mov    (%eax),%eax
    12a8:	83 e8 01             	sub    $0x1,%eax
    12ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    12ae:	8b 45 08             	mov    0x8(%ebp),%eax
    12b1:	8b 40 04             	mov    0x4(%eax),%eax
    12b4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12b7:	7f 0c                	jg     12c5 <APDrawRect+0x194>
    12b9:	8b 45 08             	mov    0x8(%ebp),%eax
    12bc:	8b 40 04             	mov    0x4(%eax),%eax
    12bf:	83 e8 01             	sub    $0x1,%eax
    12c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    12c5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12cc:	8b 45 0c             	mov    0xc(%ebp),%eax
    12cf:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12d2:	eb 52                	jmp    1326 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    12d4:	8b 45 10             	mov    0x10(%ebp),%eax
    12d7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    12da:	eb 3e                	jmp    131a <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    12dc:	83 ec 04             	sub    $0x4,%esp
    12df:	ff 75 e8             	pushl  -0x18(%ebp)
    12e2:	ff 75 ec             	pushl  -0x14(%ebp)
    12e5:	ff 75 08             	pushl  0x8(%ebp)
    12e8:	e8 02 f7 ff ff       	call   9ef <APGetIndex>
    12ed:	83 c4 10             	add    $0x10,%esp
    12f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    12f3:	8b 45 08             	mov    0x8(%ebp),%eax
    12f6:	8b 48 18             	mov    0x18(%eax),%ecx
    12f9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    12fc:	89 d0                	mov    %edx,%eax
    12fe:	01 c0                	add    %eax,%eax
    1300:	01 d0                	add    %edx,%eax
    1302:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1305:	8b 45 08             	mov    0x8(%ebp),%eax
    1308:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    130c:	66 89 0a             	mov    %cx,(%edx)
    130f:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1313:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1316:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    131a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    131d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1320:	7e ba                	jle    12dc <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1322:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1326:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1329:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    132c:	7e a6                	jle    12d4 <APDrawRect+0x1a3>
    132e:	eb 01                	jmp    1331 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1330:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1331:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1334:	c9                   	leave  
    1335:	c3                   	ret    

00001336 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1336:	55                   	push   %ebp
    1337:	89 e5                	mov    %esp,%ebp
    1339:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    133c:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1340:	0f 88 8e 01 00 00    	js     14d4 <APDcCopy+0x19e>
    1346:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    134a:	0f 88 84 01 00 00    	js     14d4 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1350:	8b 55 0c             	mov    0xc(%ebp),%edx
    1353:	8b 45 20             	mov    0x20(%ebp),%eax
    1356:	01 d0                	add    %edx,%eax
    1358:	89 45 fc             	mov    %eax,-0x4(%ebp)
    135b:	8b 55 10             	mov    0x10(%ebp),%edx
    135e:	8b 45 24             	mov    0x24(%ebp),%eax
    1361:	01 d0                	add    %edx,%eax
    1363:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1366:	8b 55 18             	mov    0x18(%ebp),%edx
    1369:	8b 45 20             	mov    0x20(%ebp),%eax
    136c:	01 d0                	add    %edx,%eax
    136e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1371:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1374:	8b 45 24             	mov    0x24(%ebp),%eax
    1377:	01 d0                	add    %edx,%eax
    1379:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    137c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1380:	0f 88 51 01 00 00    	js     14d7 <APDcCopy+0x1a1>
    1386:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    138a:	0f 88 47 01 00 00    	js     14d7 <APDcCopy+0x1a1>
    1390:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1394:	0f 88 3d 01 00 00    	js     14d7 <APDcCopy+0x1a1>
    139a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    139e:	0f 88 33 01 00 00    	js     14d7 <APDcCopy+0x1a1>
    13a4:	8b 45 14             	mov    0x14(%ebp),%eax
    13a7:	8b 00                	mov    (%eax),%eax
    13a9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13ac:	0f 8c 25 01 00 00    	jl     14d7 <APDcCopy+0x1a1>
    13b2:	8b 45 14             	mov    0x14(%ebp),%eax
    13b5:	8b 40 04             	mov    0x4(%eax),%eax
    13b8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    13bb:	0f 8c 16 01 00 00    	jl     14d7 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    13c1:	8b 45 08             	mov    0x8(%ebp),%eax
    13c4:	8b 00                	mov    (%eax),%eax
    13c6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    13c9:	7f 0b                	jg     13d6 <APDcCopy+0xa0>
    13cb:	8b 45 08             	mov    0x8(%ebp),%eax
    13ce:	8b 00                	mov    (%eax),%eax
    13d0:	83 e8 01             	sub    $0x1,%eax
    13d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    13d6:	8b 45 08             	mov    0x8(%ebp),%eax
    13d9:	8b 40 04             	mov    0x4(%eax),%eax
    13dc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13df:	7f 0c                	jg     13ed <APDcCopy+0xb7>
    13e1:	8b 45 08             	mov    0x8(%ebp),%eax
    13e4:	8b 40 04             	mov    0x4(%eax),%eax
    13e7:	83 e8 01             	sub    $0x1,%eax
    13ea:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    13ed:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    13f4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    13fb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1402:	e9 bc 00 00 00       	jmp    14c3 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1407:	8b 45 08             	mov    0x8(%ebp),%eax
    140a:	8b 00                	mov    (%eax),%eax
    140c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    140f:	8b 55 10             	mov    0x10(%ebp),%edx
    1412:	01 ca                	add    %ecx,%edx
    1414:	0f af d0             	imul   %eax,%edx
    1417:	8b 45 0c             	mov    0xc(%ebp),%eax
    141a:	01 d0                	add    %edx,%eax
    141c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    141f:	8b 45 14             	mov    0x14(%ebp),%eax
    1422:	8b 00                	mov    (%eax),%eax
    1424:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1427:	8b 55 1c             	mov    0x1c(%ebp),%edx
    142a:	01 ca                	add    %ecx,%edx
    142c:	0f af d0             	imul   %eax,%edx
    142f:	8b 45 18             	mov    0x18(%ebp),%eax
    1432:	01 d0                	add    %edx,%eax
    1434:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1437:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    143e:	eb 74                	jmp    14b4 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1440:	8b 45 14             	mov    0x14(%ebp),%eax
    1443:	8b 50 18             	mov    0x18(%eax),%edx
    1446:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1449:	8b 45 f0             	mov    -0x10(%ebp),%eax
    144c:	01 c8                	add    %ecx,%eax
    144e:	89 c1                	mov    %eax,%ecx
    1450:	89 c8                	mov    %ecx,%eax
    1452:	01 c0                	add    %eax,%eax
    1454:	01 c8                	add    %ecx,%eax
    1456:	01 d0                	add    %edx,%eax
    1458:	0f b7 10             	movzwl (%eax),%edx
    145b:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    145f:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1463:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1466:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    146a:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    146e:	38 c2                	cmp    %al,%dl
    1470:	75 18                	jne    148a <APDcCopy+0x154>
    1472:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1476:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    147a:	38 c2                	cmp    %al,%dl
    147c:	75 0c                	jne    148a <APDcCopy+0x154>
    147e:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1482:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1486:	38 c2                	cmp    %al,%dl
    1488:	74 26                	je     14b0 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    148a:	8b 45 08             	mov    0x8(%ebp),%eax
    148d:	8b 50 18             	mov    0x18(%eax),%edx
    1490:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1493:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1496:	01 c8                	add    %ecx,%eax
    1498:	89 c1                	mov    %eax,%ecx
    149a:	89 c8                	mov    %ecx,%eax
    149c:	01 c0                	add    %eax,%eax
    149e:	01 c8                	add    %ecx,%eax
    14a0:	01 d0                	add    %edx,%eax
    14a2:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    14a6:	66 89 10             	mov    %dx,(%eax)
    14a9:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    14ad:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    14b0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14b7:	2b 45 0c             	sub    0xc(%ebp),%eax
    14ba:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14bd:	7d 81                	jge    1440 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    14bf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14c6:	2b 45 10             	sub    0x10(%ebp),%eax
    14c9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14cc:	0f 8d 35 ff ff ff    	jge    1407 <APDcCopy+0xd1>
    14d2:	eb 04                	jmp    14d8 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    14d4:	90                   	nop
    14d5:	eb 01                	jmp    14d8 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    14d7:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    14d8:	c9                   	leave  
    14d9:	c3                   	ret    

000014da <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    14da:	55                   	push   %ebp
    14db:	89 e5                	mov    %esp,%ebp
    14dd:	83 ec 1c             	sub    $0x1c,%esp
    14e0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    14e3:	8b 55 10             	mov    0x10(%ebp),%edx
    14e6:	8b 45 14             	mov    0x14(%ebp),%eax
    14e9:	88 4d ec             	mov    %cl,-0x14(%ebp)
    14ec:	88 55 e8             	mov    %dl,-0x18(%ebp)
    14ef:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    14f2:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    14f6:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    14f9:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    14fd:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1500:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1504:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1507:	8b 45 08             	mov    0x8(%ebp),%eax
    150a:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    150e:	66 89 10             	mov    %dx,(%eax)
    1511:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1515:	88 50 02             	mov    %dl,0x2(%eax)
}
    1518:	8b 45 08             	mov    0x8(%ebp),%eax
    151b:	c9                   	leave  
    151c:	c2 04 00             	ret    $0x4

0000151f <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    151f:	55                   	push   %ebp
    1520:	89 e5                	mov    %esp,%ebp
    1522:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1525:	8b 45 08             	mov    0x8(%ebp),%eax
    1528:	8b 00                	mov    (%eax),%eax
    152a:	83 ec 08             	sub    $0x8,%esp
    152d:	8d 55 0c             	lea    0xc(%ebp),%edx
    1530:	52                   	push   %edx
    1531:	50                   	push   %eax
    1532:	e8 8d ef ff ff       	call   4c4 <sendMessage>
    1537:	83 c4 10             	add    $0x10,%esp
}
    153a:	90                   	nop
    153b:	c9                   	leave  
    153c:	c3                   	ret    

0000153d <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    153d:	55                   	push   %ebp
    153e:	89 e5                	mov    %esp,%ebp
    1540:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1543:	83 ec 0c             	sub    $0xc,%esp
    1546:	68 90 00 00 00       	push   $0x90
    154b:	e8 3e f3 ff ff       	call   88e <malloc>
    1550:	83 c4 10             	add    $0x10,%esp
    1553:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1556:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    155a:	75 15                	jne    1571 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    155c:	83 ec 04             	sub    $0x4,%esp
    155f:	ff 75 08             	pushl  0x8(%ebp)
    1562:	68 50 22 00 00       	push   $0x2250
    1567:	6a 01                	push   $0x1
    1569:	e8 4d f0 ff ff       	call   5bb <printf>
    156e:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1571:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1574:	83 c0 7c             	add    $0x7c,%eax
    1577:	83 ec 08             	sub    $0x8,%esp
    157a:	ff 75 08             	pushl  0x8(%ebp)
    157d:	50                   	push   %eax
    157e:	e8 60 ec ff ff       	call   1e3 <strcpy>
    1583:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1586:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1589:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1590:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1593:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    159a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159d:	8b 40 34             	mov    0x34(%eax),%eax
    15a0:	89 c2                	mov    %eax,%edx
    15a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a5:	8b 40 38             	mov    0x38(%eax),%eax
    15a8:	0f af d0             	imul   %eax,%edx
    15ab:	89 d0                	mov    %edx,%eax
    15ad:	01 c0                	add    %eax,%eax
    15af:	01 d0                	add    %edx,%eax
    15b1:	83 ec 0c             	sub    $0xc,%esp
    15b4:	50                   	push   %eax
    15b5:	e8 d4 f2 ff ff       	call   88e <malloc>
    15ba:	83 c4 10             	add    $0x10,%esp
    15bd:	89 c2                	mov    %eax,%edx
    15bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c2:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    15c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c8:	8b 40 4c             	mov    0x4c(%eax),%eax
    15cb:	85 c0                	test   %eax,%eax
    15cd:	75 15                	jne    15e4 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    15cf:	83 ec 04             	sub    $0x4,%esp
    15d2:	ff 75 08             	pushl  0x8(%ebp)
    15d5:	68 70 22 00 00       	push   $0x2270
    15da:	6a 01                	push   $0x1
    15dc:	e8 da ef ff ff       	call   5bb <printf>
    15e1:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e7:	8b 40 34             	mov    0x34(%eax),%eax
    15ea:	89 c2                	mov    %eax,%edx
    15ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ef:	8b 40 38             	mov    0x38(%eax),%eax
    15f2:	0f af d0             	imul   %eax,%edx
    15f5:	89 d0                	mov    %edx,%eax
    15f7:	01 c0                	add    %eax,%eax
    15f9:	01 c2                	add    %eax,%edx
    15fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15fe:	8b 40 4c             	mov    0x4c(%eax),%eax
    1601:	83 ec 04             	sub    $0x4,%esp
    1604:	52                   	push   %edx
    1605:	68 ff ff ff 00       	push   $0xffffff
    160a:	50                   	push   %eax
    160b:	e8 69 ec ff ff       	call   279 <memset>
    1610:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1613:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1616:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    161d:	e8 72 ee ff ff       	call   494 <getpid>
    1622:	89 c2                	mov    %eax,%edx
    1624:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1627:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    162a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162d:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1634:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1637:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    163e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1641:	8b 40 50             	mov    0x50(%eax),%eax
    1644:	89 c2                	mov    %eax,%edx
    1646:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1649:	8b 40 54             	mov    0x54(%eax),%eax
    164c:	0f af d0             	imul   %eax,%edx
    164f:	89 d0                	mov    %edx,%eax
    1651:	01 c0                	add    %eax,%eax
    1653:	01 d0                	add    %edx,%eax
    1655:	83 ec 0c             	sub    $0xc,%esp
    1658:	50                   	push   %eax
    1659:	e8 30 f2 ff ff       	call   88e <malloc>
    165e:	83 c4 10             	add    $0x10,%esp
    1661:	89 c2                	mov    %eax,%edx
    1663:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1666:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    1669:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166c:	8b 40 68             	mov    0x68(%eax),%eax
    166f:	85 c0                	test   %eax,%eax
    1671:	75 15                	jne    1688 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1673:	83 ec 04             	sub    $0x4,%esp
    1676:	ff 75 08             	pushl  0x8(%ebp)
    1679:	68 94 22 00 00       	push   $0x2294
    167e:	6a 01                	push   $0x1
    1680:	e8 36 ef ff ff       	call   5bb <printf>
    1685:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
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
    16a9:	68 ff 00 00 00       	push   $0xff
    16ae:	50                   	push   %eax
    16af:	e8 c5 eb ff ff       	call   279 <memset>
    16b4:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    16b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ba:	8b 55 0c             	mov    0xc(%ebp),%edx
    16bd:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    16c0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16c4:	74 35                	je     16fb <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    16c6:	8b 45 10             	mov    0x10(%ebp),%eax
    16c9:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    16cf:	83 ec 0c             	sub    $0xc,%esp
    16d2:	50                   	push   %eax
    16d3:	e8 b6 f1 ff ff       	call   88e <malloc>
    16d8:	83 c4 10             	add    $0x10,%esp
    16db:	89 c2                	mov    %eax,%edx
    16dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e0:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    16e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e6:	8b 55 10             	mov    0x10(%ebp),%edx
    16e9:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    16ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ef:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    16f6:	e9 8d 00 00 00       	jmp    1788 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    16fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fe:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1705:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1708:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    170f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1712:	8b 40 18             	mov    0x18(%eax),%eax
    1715:	89 c2                	mov    %eax,%edx
    1717:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171a:	8b 40 1c             	mov    0x1c(%eax),%eax
    171d:	0f af d0             	imul   %eax,%edx
    1720:	89 d0                	mov    %edx,%eax
    1722:	01 c0                	add    %eax,%eax
    1724:	01 d0                	add    %edx,%eax
    1726:	83 ec 0c             	sub    $0xc,%esp
    1729:	50                   	push   %eax
    172a:	e8 5f f1 ff ff       	call   88e <malloc>
    172f:	83 c4 10             	add    $0x10,%esp
    1732:	89 c2                	mov    %eax,%edx
    1734:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1737:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    173a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    173d:	8b 40 30             	mov    0x30(%eax),%eax
    1740:	85 c0                	test   %eax,%eax
    1742:	75 15                	jne    1759 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1744:	83 ec 04             	sub    $0x4,%esp
    1747:	ff 75 08             	pushl  0x8(%ebp)
    174a:	68 bc 22 00 00       	push   $0x22bc
    174f:	6a 01                	push   $0x1
    1751:	e8 65 ee ff ff       	call   5bb <printf>
    1756:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1759:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175c:	8b 40 18             	mov    0x18(%eax),%eax
    175f:	89 c2                	mov    %eax,%edx
    1761:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1764:	8b 40 1c             	mov    0x1c(%eax),%eax
    1767:	0f af d0             	imul   %eax,%edx
    176a:	89 d0                	mov    %edx,%eax
    176c:	01 c0                	add    %eax,%eax
    176e:	01 c2                	add    %eax,%edx
    1770:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1773:	8b 40 30             	mov    0x30(%eax),%eax
    1776:	83 ec 04             	sub    $0x4,%esp
    1779:	52                   	push   %edx
    177a:	68 ff ff ff 00       	push   $0xffffff
    177f:	50                   	push   %eax
    1780:	e8 f4 ea ff ff       	call   279 <memset>
    1785:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1788:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    178b:	c9                   	leave  
    178c:	c3                   	ret    

0000178d <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    178d:	55                   	push   %ebp
    178e:	89 e5                	mov    %esp,%ebp
    1790:	53                   	push   %ebx
    1791:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1794:	8b 45 0c             	mov    0xc(%ebp),%eax
    1797:	83 f8 03             	cmp    $0x3,%eax
    179a:	74 02                	je     179e <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    179c:	eb 33                	jmp    17d1 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    179e:	8b 45 08             	mov    0x8(%ebp),%eax
    17a1:	8b 48 08             	mov    0x8(%eax),%ecx
    17a4:	8b 45 08             	mov    0x8(%ebp),%eax
    17a7:	8b 50 38             	mov    0x38(%eax),%edx
    17aa:	8b 45 08             	mov    0x8(%ebp),%eax
    17ad:	8b 40 34             	mov    0x34(%eax),%eax
    17b0:	8b 5d 08             	mov    0x8(%ebp),%ebx
    17b3:	83 c3 34             	add    $0x34,%ebx
    17b6:	83 ec 0c             	sub    $0xc,%esp
    17b9:	51                   	push   %ecx
    17ba:	52                   	push   %edx
    17bb:	50                   	push   %eax
    17bc:	6a 00                	push   $0x0
    17be:	6a 00                	push   $0x0
    17c0:	53                   	push   %ebx
    17c1:	6a 32                	push   $0x32
    17c3:	6a 00                	push   $0x0
    17c5:	ff 75 08             	pushl  0x8(%ebp)
    17c8:	e8 e7 ec ff ff       	call   4b4 <paintWindow>
    17cd:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    17d0:	90                   	nop
        default: break;
            
            
    }
    return False;
    17d1:	b8 00 00 00 00       	mov    $0x0,%eax
}
    17d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    17d9:	c9                   	leave  
    17da:	c3                   	ret    

000017db <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    17db:	55                   	push   %ebp
    17dc:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    17de:	8b 45 0c             	mov    0xc(%ebp),%eax
    17e1:	8b 50 08             	mov    0x8(%eax),%edx
    17e4:	8b 45 08             	mov    0x8(%ebp),%eax
    17e7:	8b 00                	mov    (%eax),%eax
    17e9:	39 c2                	cmp    %eax,%edx
    17eb:	74 07                	je     17f4 <APPreJudge+0x19>
        return False;
    17ed:	b8 00 00 00 00       	mov    $0x0,%eax
    17f2:	eb 05                	jmp    17f9 <APPreJudge+0x1e>
    return True;
    17f4:	b8 01 00 00 00       	mov    $0x1,%eax
}
    17f9:	5d                   	pop    %ebp
    17fa:	c3                   	ret    

000017fb <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    17fb:	55                   	push   %ebp
    17fc:	89 e5                	mov    %esp,%ebp
    17fe:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1801:	8b 45 08             	mov    0x8(%ebp),%eax
    1804:	8b 55 0c             	mov    0xc(%ebp),%edx
    1807:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    180a:	83 ec 0c             	sub    $0xc,%esp
    180d:	ff 75 08             	pushl  0x8(%ebp)
    1810:	e8 bf ec ff ff       	call   4d4 <registWindow>
    1815:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1818:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    181f:	8b 45 08             	mov    0x8(%ebp),%eax
    1822:	8b 00                	mov    (%eax),%eax
    1824:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1827:	ff 75 f4             	pushl  -0xc(%ebp)
    182a:	ff 75 f0             	pushl  -0x10(%ebp)
    182d:	ff 75 ec             	pushl  -0x14(%ebp)
    1830:	ff 75 08             	pushl  0x8(%ebp)
    1833:	e8 e7 fc ff ff       	call   151f <APSendMessage>
    1838:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    183b:	83 ec 0c             	sub    $0xc,%esp
    183e:	ff 75 08             	pushl  0x8(%ebp)
    1841:	e8 86 ec ff ff       	call   4cc <getMessage>
    1846:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1849:	8b 45 08             	mov    0x8(%ebp),%eax
    184c:	83 c0 6c             	add    $0x6c,%eax
    184f:	83 ec 08             	sub    $0x8,%esp
    1852:	50                   	push   %eax
    1853:	ff 75 08             	pushl  0x8(%ebp)
    1856:	e8 80 ff ff ff       	call   17db <APPreJudge>
    185b:	83 c4 10             	add    $0x10,%esp
    185e:	84 c0                	test   %al,%al
    1860:	74 1b                	je     187d <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    1862:	8b 45 08             	mov    0x8(%ebp),%eax
    1865:	ff 70 74             	pushl  0x74(%eax)
    1868:	ff 70 70             	pushl  0x70(%eax)
    186b:	ff 70 6c             	pushl  0x6c(%eax)
    186e:	ff 75 08             	pushl  0x8(%ebp)
    1871:	8b 45 0c             	mov    0xc(%ebp),%eax
    1874:	ff d0                	call   *%eax
    1876:	83 c4 10             	add    $0x10,%esp
    1879:	84 c0                	test   %al,%al
    187b:	75 0c                	jne    1889 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    187d:	8b 45 08             	mov    0x8(%ebp),%eax
    1880:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1887:	eb b2                	jmp    183b <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1889:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    188a:	90                   	nop
    188b:	c9                   	leave  
    188c:	c3                   	ret    

0000188d <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    188d:	55                   	push   %ebp
    188e:	89 e5                	mov    %esp,%ebp
    1890:	57                   	push   %edi
    1891:	56                   	push   %esi
    1892:	53                   	push   %ebx
    1893:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1896:	a1 2c 29 00 00       	mov    0x292c,%eax
    189b:	85 c0                	test   %eax,%eax
    189d:	0f 85 2c 02 00 00    	jne    1acf <APGridPaint+0x242>
    {
        iconReady = 1;
    18a3:	c7 05 2c 29 00 00 01 	movl   $0x1,0x292c
    18aa:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    18ad:	8d 45 98             	lea    -0x68(%ebp),%eax
    18b0:	83 ec 08             	sub    $0x8,%esp
    18b3:	68 e3 22 00 00       	push   $0x22e3
    18b8:	50                   	push   %eax
    18b9:	e8 83 f1 ff ff       	call   a41 <APLoadBitmap>
    18be:	83 c4 0c             	add    $0xc,%esp
    18c1:	8b 45 98             	mov    -0x68(%ebp),%eax
    18c4:	a3 60 2b 00 00       	mov    %eax,0x2b60
    18c9:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18cc:	a3 64 2b 00 00       	mov    %eax,0x2b64
    18d1:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18d4:	a3 68 2b 00 00       	mov    %eax,0x2b68
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    18d9:	83 ec 04             	sub    $0x4,%esp
    18dc:	ff 35 68 2b 00 00    	pushl  0x2b68
    18e2:	ff 35 64 2b 00 00    	pushl  0x2b64
    18e8:	ff 35 60 2b 00 00    	pushl  0x2b60
    18ee:	e8 88 f3 ff ff       	call   c7b <APCreateCompatibleDCFromBitmap>
    18f3:	83 c4 10             	add    $0x10,%esp
    18f6:	a3 6c 2b 00 00       	mov    %eax,0x2b6c
        grid_river = APLoadBitmap ("grid_river.bmp");
    18fb:	8d 45 98             	lea    -0x68(%ebp),%eax
    18fe:	83 ec 08             	sub    $0x8,%esp
    1901:	68 f1 22 00 00       	push   $0x22f1
    1906:	50                   	push   %eax
    1907:	e8 35 f1 ff ff       	call   a41 <APLoadBitmap>
    190c:	83 c4 0c             	add    $0xc,%esp
    190f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1912:	a3 9c 2b 00 00       	mov    %eax,0x2b9c
    1917:	8b 45 9c             	mov    -0x64(%ebp),%eax
    191a:	a3 a0 2b 00 00       	mov    %eax,0x2ba0
    191f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1922:	a3 a4 2b 00 00       	mov    %eax,0x2ba4
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1927:	83 ec 04             	sub    $0x4,%esp
    192a:	ff 35 a4 2b 00 00    	pushl  0x2ba4
    1930:	ff 35 a0 2b 00 00    	pushl  0x2ba0
    1936:	ff 35 9c 2b 00 00    	pushl  0x2b9c
    193c:	e8 3a f3 ff ff       	call   c7b <APCreateCompatibleDCFromBitmap>
    1941:	83 c4 10             	add    $0x10,%esp
    1944:	a3 8c 2b 00 00       	mov    %eax,0x2b8c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1949:	8d 45 98             	lea    -0x68(%ebp),%eax
    194c:	83 ec 08             	sub    $0x8,%esp
    194f:	68 00 23 00 00       	push   $0x2300
    1954:	50                   	push   %eax
    1955:	e8 e7 f0 ff ff       	call   a41 <APLoadBitmap>
    195a:	83 c4 0c             	add    $0xc,%esp
    195d:	8b 45 98             	mov    -0x68(%ebp),%eax
    1960:	a3 90 2b 00 00       	mov    %eax,0x2b90
    1965:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1968:	a3 94 2b 00 00       	mov    %eax,0x2b94
    196d:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1970:	a3 98 2b 00 00       	mov    %eax,0x2b98
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1975:	83 ec 04             	sub    $0x4,%esp
    1978:	ff 35 98 2b 00 00    	pushl  0x2b98
    197e:	ff 35 94 2b 00 00    	pushl  0x2b94
    1984:	ff 35 90 2b 00 00    	pushl  0x2b90
    198a:	e8 ec f2 ff ff       	call   c7b <APCreateCompatibleDCFromBitmap>
    198f:	83 c4 10             	add    $0x10,%esp
    1992:	a3 40 2b 00 00       	mov    %eax,0x2b40
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1997:	8d 45 98             	lea    -0x68(%ebp),%eax
    199a:	83 ec 08             	sub    $0x8,%esp
    199d:	68 0f 23 00 00       	push   $0x230f
    19a2:	50                   	push   %eax
    19a3:	e8 99 f0 ff ff       	call   a41 <APLoadBitmap>
    19a8:	83 c4 0c             	add    $0xc,%esp
    19ab:	8b 45 98             	mov    -0x68(%ebp),%eax
    19ae:	a3 74 2b 00 00       	mov    %eax,0x2b74
    19b3:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19b6:	a3 78 2b 00 00       	mov    %eax,0x2b78
    19bb:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19be:	a3 7c 2b 00 00       	mov    %eax,0x2b7c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    19c3:	83 ec 04             	sub    $0x4,%esp
    19c6:	ff 35 7c 2b 00 00    	pushl  0x2b7c
    19cc:	ff 35 78 2b 00 00    	pushl  0x2b78
    19d2:	ff 35 74 2b 00 00    	pushl  0x2b74
    19d8:	e8 9e f2 ff ff       	call   c7b <APCreateCompatibleDCFromBitmap>
    19dd:	83 c4 10             	add    $0x10,%esp
    19e0:	a3 a8 2b 00 00       	mov    %eax,0x2ba8
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    19e5:	8d 45 98             	lea    -0x68(%ebp),%eax
    19e8:	83 ec 08             	sub    $0x8,%esp
    19eb:	68 1d 23 00 00       	push   $0x231d
    19f0:	50                   	push   %eax
    19f1:	e8 4b f0 ff ff       	call   a41 <APLoadBitmap>
    19f6:	83 c4 0c             	add    $0xc,%esp
    19f9:	8b 45 98             	mov    -0x68(%ebp),%eax
    19fc:	a3 50 2b 00 00       	mov    %eax,0x2b50
    1a01:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a04:	a3 54 2b 00 00       	mov    %eax,0x2b54
    1a09:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a0c:	a3 58 2b 00 00       	mov    %eax,0x2b58
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1a11:	83 ec 04             	sub    $0x4,%esp
    1a14:	ff 35 58 2b 00 00    	pushl  0x2b58
    1a1a:	ff 35 54 2b 00 00    	pushl  0x2b54
    1a20:	ff 35 50 2b 00 00    	pushl  0x2b50
    1a26:	e8 50 f2 ff ff       	call   c7b <APCreateCompatibleDCFromBitmap>
    1a2b:	83 c4 10             	add    $0x10,%esp
    1a2e:	a3 70 2b 00 00       	mov    %eax,0x2b70
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1a33:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a36:	83 ec 08             	sub    $0x8,%esp
    1a39:	68 2d 23 00 00       	push   $0x232d
    1a3e:	50                   	push   %eax
    1a3f:	e8 fd ef ff ff       	call   a41 <APLoadBitmap>
    1a44:	83 c4 0c             	add    $0xc,%esp
    1a47:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a4a:	a3 44 2b 00 00       	mov    %eax,0x2b44
    1a4f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a52:	a3 48 2b 00 00       	mov    %eax,0x2b48
    1a57:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a5a:	a3 4c 2b 00 00       	mov    %eax,0x2b4c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1a5f:	83 ec 04             	sub    $0x4,%esp
    1a62:	ff 35 4c 2b 00 00    	pushl  0x2b4c
    1a68:	ff 35 48 2b 00 00    	pushl  0x2b48
    1a6e:	ff 35 44 2b 00 00    	pushl  0x2b44
    1a74:	e8 02 f2 ff ff       	call   c7b <APCreateCompatibleDCFromBitmap>
    1a79:	83 c4 10             	add    $0x10,%esp
    1a7c:	a3 5c 2b 00 00       	mov    %eax,0x2b5c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1a81:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a84:	83 ec 08             	sub    $0x8,%esp
    1a87:	68 3f 23 00 00       	push   $0x233f
    1a8c:	50                   	push   %eax
    1a8d:	e8 af ef ff ff       	call   a41 <APLoadBitmap>
    1a92:	83 c4 0c             	add    $0xc,%esp
    1a95:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a98:	a3 80 2b 00 00       	mov    %eax,0x2b80
    1a9d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1aa0:	a3 84 2b 00 00       	mov    %eax,0x2b84
    1aa5:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1aa8:	a3 88 2b 00 00       	mov    %eax,0x2b88
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1aad:	83 ec 04             	sub    $0x4,%esp
    1ab0:	ff 35 88 2b 00 00    	pushl  0x2b88
    1ab6:	ff 35 84 2b 00 00    	pushl  0x2b84
    1abc:	ff 35 80 2b 00 00    	pushl  0x2b80
    1ac2:	e8 b4 f1 ff ff       	call   c7b <APCreateCompatibleDCFromBitmap>
    1ac7:	83 c4 10             	add    $0x10,%esp
    1aca:	a3 ac 2b 00 00       	mov    %eax,0x2bac
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1acf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad2:	8b 40 08             	mov    0x8(%eax),%eax
    1ad5:	85 c0                	test   %eax,%eax
    1ad7:	75 17                	jne    1af0 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1ad9:	83 ec 08             	sub    $0x8,%esp
    1adc:	68 50 23 00 00       	push   $0x2350
    1ae1:	6a 01                	push   $0x1
    1ae3:	e8 d3 ea ff ff       	call   5bb <printf>
    1ae8:	83 c4 10             	add    $0x10,%esp
        return;
    1aeb:	e9 f2 03 00 00       	jmp    1ee2 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1af0:	8b 45 08             	mov    0x8(%ebp),%eax
    1af3:	8b 40 10             	mov    0x10(%eax),%eax
    1af6:	85 c0                	test   %eax,%eax
    1af8:	7e 10                	jle    1b0a <APGridPaint+0x27d>
    1afa:	8b 45 08             	mov    0x8(%ebp),%eax
    1afd:	8b 50 14             	mov    0x14(%eax),%edx
    1b00:	8b 45 08             	mov    0x8(%ebp),%eax
    1b03:	8b 40 10             	mov    0x10(%eax),%eax
    1b06:	39 c2                	cmp    %eax,%edx
    1b08:	7c 17                	jl     1b21 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1b0a:	83 ec 08             	sub    $0x8,%esp
    1b0d:	68 76 23 00 00       	push   $0x2376
    1b12:	6a 01                	push   $0x1
    1b14:	e8 a2 ea ff ff       	call   5bb <printf>
    1b19:	83 c4 10             	add    $0x10,%esp
        return;
    1b1c:	e9 c1 03 00 00       	jmp    1ee2 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1b21:	8b 45 08             	mov    0x8(%ebp),%eax
    1b24:	8b 40 14             	mov    0x14(%eax),%eax
    1b27:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1b2d:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1b30:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1b33:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1b36:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1b3d:	e9 96 03 00 00       	jmp    1ed8 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1b42:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1b49:	e9 7c 03 00 00       	jmp    1eca <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1b4e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b51:	c1 e0 04             	shl    $0x4,%eax
    1b54:	89 c2                	mov    %eax,%edx
    1b56:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b59:	01 c2                	add    %eax,%edx
    1b5b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b5e:	01 d0                	add    %edx,%eax
    1b60:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1b63:	8b 45 08             	mov    0x8(%ebp),%eax
    1b66:	8b 40 0c             	mov    0xc(%eax),%eax
    1b69:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1b6c:	c1 e2 02             	shl    $0x2,%edx
    1b6f:	01 d0                	add    %edx,%eax
    1b71:	8b 00                	mov    (%eax),%eax
    1b73:	83 f8 07             	cmp    $0x7,%eax
    1b76:	0f 87 49 03 00 00    	ja     1ec5 <APGridPaint+0x638>
    1b7c:	8b 04 85 8c 23 00 00 	mov    0x238c(,%eax,4),%eax
    1b83:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b85:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1b88:	6a 0c                	push   $0xc
    1b8a:	6a 0c                	push   $0xc
    1b8c:	6a 0c                	push   $0xc
    1b8e:	50                   	push   %eax
    1b8f:	e8 46 f9 ff ff       	call   14da <RGB>
    1b94:	83 c4 0c             	add    $0xc,%esp
    1b97:	8b 1d 6c 2b 00 00    	mov    0x2b6c,%ebx
    1b9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ba0:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ba3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ba6:	6b c0 32             	imul   $0x32,%eax,%eax
    1ba9:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bac:	8b 45 08             	mov    0x8(%ebp),%eax
    1baf:	8d 78 34             	lea    0x34(%eax),%edi
    1bb2:	83 ec 0c             	sub    $0xc,%esp
    1bb5:	83 ec 04             	sub    $0x4,%esp
    1bb8:	89 e0                	mov    %esp,%eax
    1bba:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1bbe:	66 89 30             	mov    %si,(%eax)
    1bc1:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1bc5:	88 50 02             	mov    %dl,0x2(%eax)
    1bc8:	6a 32                	push   $0x32
    1bca:	6a 32                	push   $0x32
    1bcc:	6a 00                	push   $0x0
    1bce:	6a 00                	push   $0x0
    1bd0:	53                   	push   %ebx
    1bd1:	51                   	push   %ecx
    1bd2:	ff 75 94             	pushl  -0x6c(%ebp)
    1bd5:	57                   	push   %edi
    1bd6:	e8 5b f7 ff ff       	call   1336 <APDcCopy>
    1bdb:	83 c4 30             	add    $0x30,%esp
                    break;
    1bde:	e9 e3 02 00 00       	jmp    1ec6 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1be3:	8d 45 98             	lea    -0x68(%ebp),%eax
    1be6:	6a 69                	push   $0x69
    1be8:	6a 69                	push   $0x69
    1bea:	6a 69                	push   $0x69
    1bec:	50                   	push   %eax
    1bed:	e8 e8 f8 ff ff       	call   14da <RGB>
    1bf2:	83 c4 0c             	add    $0xc,%esp
    1bf5:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1bf9:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1bfd:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1c01:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1c04:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1c0b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c0e:	6a 69                	push   $0x69
    1c10:	6a 69                	push   $0x69
    1c12:	6a 69                	push   $0x69
    1c14:	50                   	push   %eax
    1c15:	e8 c0 f8 ff ff       	call   14da <RGB>
    1c1a:	83 c4 0c             	add    $0xc,%esp
    1c1d:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1c21:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1c25:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1c29:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1c2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c2f:	8d 50 34             	lea    0x34(%eax),%edx
    1c32:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c35:	ff 75 bc             	pushl  -0x44(%ebp)
    1c38:	ff 75 b8             	pushl  -0x48(%ebp)
    1c3b:	52                   	push   %edx
    1c3c:	50                   	push   %eax
    1c3d:	e8 ce f0 ff ff       	call   d10 <APSetPen>
    1c42:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1c45:	8b 45 08             	mov    0x8(%ebp),%eax
    1c48:	8d 58 34             	lea    0x34(%eax),%ebx
    1c4b:	8d 55 98             	lea    -0x68(%ebp),%edx
    1c4e:	83 ec 04             	sub    $0x4,%esp
    1c51:	83 ec 04             	sub    $0x4,%esp
    1c54:	89 e0                	mov    %esp,%eax
    1c56:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1c5a:	66 89 08             	mov    %cx,(%eax)
    1c5d:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1c61:	88 48 02             	mov    %cl,0x2(%eax)
    1c64:	53                   	push   %ebx
    1c65:	52                   	push   %edx
    1c66:	e8 de f0 ff ff       	call   d49 <APSetBrush>
    1c6b:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1c6e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c71:	6b d0 32             	imul   $0x32,%eax,%edx
    1c74:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c77:	6b c0 32             	imul   $0x32,%eax,%eax
    1c7a:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c7d:	83 c1 34             	add    $0x34,%ecx
    1c80:	83 ec 0c             	sub    $0xc,%esp
    1c83:	6a 32                	push   $0x32
    1c85:	6a 32                	push   $0x32
    1c87:	52                   	push   %edx
    1c88:	50                   	push   %eax
    1c89:	51                   	push   %ecx
    1c8a:	e8 a2 f4 ff ff       	call   1131 <APDrawRect>
    1c8f:	83 c4 20             	add    $0x20,%esp
                    break;
    1c92:	e9 2f 02 00 00       	jmp    1ec6 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c97:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1c9a:	6a 0c                	push   $0xc
    1c9c:	6a 0c                	push   $0xc
    1c9e:	6a 0c                	push   $0xc
    1ca0:	50                   	push   %eax
    1ca1:	e8 34 f8 ff ff       	call   14da <RGB>
    1ca6:	83 c4 0c             	add    $0xc,%esp
    1ca9:	8b 1d ac 2b 00 00    	mov    0x2bac,%ebx
    1caf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cb2:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cb5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cb8:	6b c0 32             	imul   $0x32,%eax,%eax
    1cbb:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cbe:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc1:	8d 78 34             	lea    0x34(%eax),%edi
    1cc4:	83 ec 0c             	sub    $0xc,%esp
    1cc7:	83 ec 04             	sub    $0x4,%esp
    1cca:	89 e0                	mov    %esp,%eax
    1ccc:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1cd0:	66 89 30             	mov    %si,(%eax)
    1cd3:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1cd7:	88 50 02             	mov    %dl,0x2(%eax)
    1cda:	6a 32                	push   $0x32
    1cdc:	6a 32                	push   $0x32
    1cde:	6a 00                	push   $0x0
    1ce0:	6a 00                	push   $0x0
    1ce2:	53                   	push   %ebx
    1ce3:	51                   	push   %ecx
    1ce4:	ff 75 94             	pushl  -0x6c(%ebp)
    1ce7:	57                   	push   %edi
    1ce8:	e8 49 f6 ff ff       	call   1336 <APDcCopy>
    1ced:	83 c4 30             	add    $0x30,%esp
                    break;
    1cf0:	e9 d1 01 00 00       	jmp    1ec6 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cf5:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1cf8:	6a 0c                	push   $0xc
    1cfa:	6a 0c                	push   $0xc
    1cfc:	6a 0c                	push   $0xc
    1cfe:	50                   	push   %eax
    1cff:	e8 d6 f7 ff ff       	call   14da <RGB>
    1d04:	83 c4 0c             	add    $0xc,%esp
    1d07:	8b 1d 8c 2b 00 00    	mov    0x2b8c,%ebx
    1d0d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d10:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d13:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d16:	6b c0 32             	imul   $0x32,%eax,%eax
    1d19:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d1c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d1f:	8d 78 34             	lea    0x34(%eax),%edi
    1d22:	83 ec 0c             	sub    $0xc,%esp
    1d25:	83 ec 04             	sub    $0x4,%esp
    1d28:	89 e0                	mov    %esp,%eax
    1d2a:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1d2e:	66 89 30             	mov    %si,(%eax)
    1d31:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1d35:	88 50 02             	mov    %dl,0x2(%eax)
    1d38:	6a 32                	push   $0x32
    1d3a:	6a 32                	push   $0x32
    1d3c:	6a 00                	push   $0x0
    1d3e:	6a 00                	push   $0x0
    1d40:	53                   	push   %ebx
    1d41:	51                   	push   %ecx
    1d42:	ff 75 94             	pushl  -0x6c(%ebp)
    1d45:	57                   	push   %edi
    1d46:	e8 eb f5 ff ff       	call   1336 <APDcCopy>
    1d4b:	83 c4 30             	add    $0x30,%esp
                    break;
    1d4e:	e9 73 01 00 00       	jmp    1ec6 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d53:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1d56:	6a 0c                	push   $0xc
    1d58:	6a 0c                	push   $0xc
    1d5a:	6a 0c                	push   $0xc
    1d5c:	50                   	push   %eax
    1d5d:	e8 78 f7 ff ff       	call   14da <RGB>
    1d62:	83 c4 0c             	add    $0xc,%esp
    1d65:	8b 1d 70 2b 00 00    	mov    0x2b70,%ebx
    1d6b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d6e:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d71:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d74:	6b c0 32             	imul   $0x32,%eax,%eax
    1d77:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d7a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7d:	8d 78 34             	lea    0x34(%eax),%edi
    1d80:	83 ec 0c             	sub    $0xc,%esp
    1d83:	83 ec 04             	sub    $0x4,%esp
    1d86:	89 e0                	mov    %esp,%eax
    1d88:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1d8c:	66 89 30             	mov    %si,(%eax)
    1d8f:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1d93:	88 50 02             	mov    %dl,0x2(%eax)
    1d96:	6a 32                	push   $0x32
    1d98:	6a 32                	push   $0x32
    1d9a:	6a 00                	push   $0x0
    1d9c:	6a 00                	push   $0x0
    1d9e:	53                   	push   %ebx
    1d9f:	51                   	push   %ecx
    1da0:	ff 75 94             	pushl  -0x6c(%ebp)
    1da3:	57                   	push   %edi
    1da4:	e8 8d f5 ff ff       	call   1336 <APDcCopy>
    1da9:	83 c4 30             	add    $0x30,%esp
                    break;
    1dac:	e9 15 01 00 00       	jmp    1ec6 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1db1:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1db4:	6a 0c                	push   $0xc
    1db6:	6a 0c                	push   $0xc
    1db8:	6a 0c                	push   $0xc
    1dba:	50                   	push   %eax
    1dbb:	e8 1a f7 ff ff       	call   14da <RGB>
    1dc0:	83 c4 0c             	add    $0xc,%esp
    1dc3:	8b 1d a8 2b 00 00    	mov    0x2ba8,%ebx
    1dc9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dcc:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dcf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dd2:	6b c0 32             	imul   $0x32,%eax,%eax
    1dd5:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dd8:	8b 45 08             	mov    0x8(%ebp),%eax
    1ddb:	8d 78 34             	lea    0x34(%eax),%edi
    1dde:	83 ec 0c             	sub    $0xc,%esp
    1de1:	83 ec 04             	sub    $0x4,%esp
    1de4:	89 e0                	mov    %esp,%eax
    1de6:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1dea:	66 89 30             	mov    %si,(%eax)
    1ded:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1df1:	88 50 02             	mov    %dl,0x2(%eax)
    1df4:	6a 32                	push   $0x32
    1df6:	6a 32                	push   $0x32
    1df8:	6a 00                	push   $0x0
    1dfa:	6a 00                	push   $0x0
    1dfc:	53                   	push   %ebx
    1dfd:	51                   	push   %ecx
    1dfe:	ff 75 94             	pushl  -0x6c(%ebp)
    1e01:	57                   	push   %edi
    1e02:	e8 2f f5 ff ff       	call   1336 <APDcCopy>
    1e07:	83 c4 30             	add    $0x30,%esp
                    break;
    1e0a:	e9 b7 00 00 00       	jmp    1ec6 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e0f:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1e12:	6a 0c                	push   $0xc
    1e14:	6a 0c                	push   $0xc
    1e16:	6a 0c                	push   $0xc
    1e18:	50                   	push   %eax
    1e19:	e8 bc f6 ff ff       	call   14da <RGB>
    1e1e:	83 c4 0c             	add    $0xc,%esp
    1e21:	8b 1d 40 2b 00 00    	mov    0x2b40,%ebx
    1e27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e2a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e2d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e30:	6b c0 32             	imul   $0x32,%eax,%eax
    1e33:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e36:	8b 45 08             	mov    0x8(%ebp),%eax
    1e39:	8d 78 34             	lea    0x34(%eax),%edi
    1e3c:	83 ec 0c             	sub    $0xc,%esp
    1e3f:	83 ec 04             	sub    $0x4,%esp
    1e42:	89 e0                	mov    %esp,%eax
    1e44:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1e48:	66 89 30             	mov    %si,(%eax)
    1e4b:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1e4f:	88 50 02             	mov    %dl,0x2(%eax)
    1e52:	6a 32                	push   $0x32
    1e54:	6a 32                	push   $0x32
    1e56:	6a 00                	push   $0x0
    1e58:	6a 00                	push   $0x0
    1e5a:	53                   	push   %ebx
    1e5b:	51                   	push   %ecx
    1e5c:	ff 75 94             	pushl  -0x6c(%ebp)
    1e5f:	57                   	push   %edi
    1e60:	e8 d1 f4 ff ff       	call   1336 <APDcCopy>
    1e65:	83 c4 30             	add    $0x30,%esp
                    break;
    1e68:	eb 5c                	jmp    1ec6 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e6a:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1e6d:	6a 0c                	push   $0xc
    1e6f:	6a 0c                	push   $0xc
    1e71:	6a 0c                	push   $0xc
    1e73:	50                   	push   %eax
    1e74:	e8 61 f6 ff ff       	call   14da <RGB>
    1e79:	83 c4 0c             	add    $0xc,%esp
    1e7c:	8b 1d 5c 2b 00 00    	mov    0x2b5c,%ebx
    1e82:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e85:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e88:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e8b:	6b c0 32             	imul   $0x32,%eax,%eax
    1e8e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e91:	8b 45 08             	mov    0x8(%ebp),%eax
    1e94:	8d 78 34             	lea    0x34(%eax),%edi
    1e97:	83 ec 0c             	sub    $0xc,%esp
    1e9a:	83 ec 04             	sub    $0x4,%esp
    1e9d:	89 e0                	mov    %esp,%eax
    1e9f:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1ea3:	66 89 30             	mov    %si,(%eax)
    1ea6:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1eaa:	88 50 02             	mov    %dl,0x2(%eax)
    1ead:	6a 32                	push   $0x32
    1eaf:	6a 32                	push   $0x32
    1eb1:	6a 00                	push   $0x0
    1eb3:	6a 00                	push   $0x0
    1eb5:	53                   	push   %ebx
    1eb6:	51                   	push   %ecx
    1eb7:	ff 75 94             	pushl  -0x6c(%ebp)
    1eba:	57                   	push   %edi
    1ebb:	e8 76 f4 ff ff       	call   1336 <APDcCopy>
    1ec0:	83 c4 30             	add    $0x30,%esp
                    break;
    1ec3:	eb 01                	jmp    1ec6 <APGridPaint+0x639>
                default: break;
    1ec5:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1ec6:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1eca:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1ece:	0f 8e 7a fc ff ff    	jle    1b4e <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1ed4:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1ed8:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1edc:	0f 8e 60 fc ff ff    	jle    1b42 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1ee2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1ee5:	5b                   	pop    %ebx
    1ee6:	5e                   	pop    %esi
    1ee7:	5f                   	pop    %edi
    1ee8:	5d                   	pop    %ebp
    1ee9:	c3                   	ret    

00001eea <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1eea:	55                   	push   %ebp
    1eeb:	89 e5                	mov    %esp,%ebp
    1eed:	53                   	push   %ebx
    1eee:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1ef1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1ef8:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1efc:	74 17                	je     1f15 <sprintint+0x2b>
    1efe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1f02:	79 11                	jns    1f15 <sprintint+0x2b>
        neg = 1;
    1f04:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1f0b:	8b 45 10             	mov    0x10(%ebp),%eax
    1f0e:	f7 d8                	neg    %eax
    1f10:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f13:	eb 06                	jmp    1f1b <sprintint+0x31>
    } else {
        x = xx;
    1f15:	8b 45 10             	mov    0x10(%ebp),%eax
    1f18:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1f1b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1f22:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1f25:	8d 41 01             	lea    0x1(%ecx),%eax
    1f28:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1f2b:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f31:	ba 00 00 00 00       	mov    $0x0,%edx
    1f36:	f7 f3                	div    %ebx
    1f38:	89 d0                	mov    %edx,%eax
    1f3a:	0f b6 80 f8 28 00 00 	movzbl 0x28f8(%eax),%eax
    1f41:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1f45:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f48:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f4b:	ba 00 00 00 00       	mov    $0x0,%edx
    1f50:	f7 f3                	div    %ebx
    1f52:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f55:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f59:	75 c7                	jne    1f22 <sprintint+0x38>
    if(neg)
    1f5b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f5f:	74 0e                	je     1f6f <sprintint+0x85>
        buf[i++] = '-';
    1f61:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f64:	8d 50 01             	lea    0x1(%eax),%edx
    1f67:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1f6a:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1f6f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f72:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1f75:	eb 1b                	jmp    1f92 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1f77:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f7a:	8b 00                	mov    (%eax),%eax
    1f7c:	8d 48 01             	lea    0x1(%eax),%ecx
    1f7f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f82:	89 0a                	mov    %ecx,(%edx)
    1f84:	89 c2                	mov    %eax,%edx
    1f86:	8b 45 08             	mov    0x8(%ebp),%eax
    1f89:	01 d0                	add    %edx,%eax
    1f8b:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1f8e:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1f92:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1f96:	7f df                	jg     1f77 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1f98:	eb 21                	jmp    1fbb <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1f9a:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f9d:	8b 00                	mov    (%eax),%eax
    1f9f:	8d 48 01             	lea    0x1(%eax),%ecx
    1fa2:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fa5:	89 0a                	mov    %ecx,(%edx)
    1fa7:	89 c2                	mov    %eax,%edx
    1fa9:	8b 45 08             	mov    0x8(%ebp),%eax
    1fac:	01 c2                	add    %eax,%edx
    1fae:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1fb1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fb4:	01 c8                	add    %ecx,%eax
    1fb6:	0f b6 00             	movzbl (%eax),%eax
    1fb9:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fbb:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1fbf:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1fc3:	79 d5                	jns    1f9a <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1fc5:	90                   	nop
    1fc6:	83 c4 20             	add    $0x20,%esp
    1fc9:	5b                   	pop    %ebx
    1fca:	5d                   	pop    %ebp
    1fcb:	c3                   	ret    

00001fcc <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1fcc:	55                   	push   %ebp
    1fcd:	89 e5                	mov    %esp,%ebp
    1fcf:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1fd2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1fd9:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1fe0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1fe7:	8d 45 0c             	lea    0xc(%ebp),%eax
    1fea:	83 c0 04             	add    $0x4,%eax
    1fed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1ff0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1ff7:	e9 d9 01 00 00       	jmp    21d5 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1ffc:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fff:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2002:	01 d0                	add    %edx,%eax
    2004:	0f b6 00             	movzbl (%eax),%eax
    2007:	0f be c0             	movsbl %al,%eax
    200a:	25 ff 00 00 00       	and    $0xff,%eax
    200f:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2012:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2016:	75 2c                	jne    2044 <sprintf+0x78>
            if(c == '%'){
    2018:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    201c:	75 0c                	jne    202a <sprintf+0x5e>
                state = '%';
    201e:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2025:	e9 a7 01 00 00       	jmp    21d1 <sprintf+0x205>
            } else {
                dst[j++] = c;
    202a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    202d:	8d 50 01             	lea    0x1(%eax),%edx
    2030:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2033:	89 c2                	mov    %eax,%edx
    2035:	8b 45 08             	mov    0x8(%ebp),%eax
    2038:	01 d0                	add    %edx,%eax
    203a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    203d:	88 10                	mov    %dl,(%eax)
    203f:	e9 8d 01 00 00       	jmp    21d1 <sprintf+0x205>
            }
        } else if(state == '%'){
    2044:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2048:	0f 85 83 01 00 00    	jne    21d1 <sprintf+0x205>
            if(c == 'd'){
    204e:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2052:	75 4c                	jne    20a0 <sprintf+0xd4>
                buf[bi] = '\0';
    2054:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2057:	8b 45 f0             	mov    -0x10(%ebp),%eax
    205a:	01 d0                	add    %edx,%eax
    205c:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    205f:	83 ec 0c             	sub    $0xc,%esp
    2062:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2065:	50                   	push   %eax
    2066:	e8 17 e3 ff ff       	call   382 <atoi>
    206b:	83 c4 10             	add    $0x10,%esp
    206e:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2071:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2078:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    207b:	8b 00                	mov    (%eax),%eax
    207d:	83 ec 08             	sub    $0x8,%esp
    2080:	ff 75 d8             	pushl  -0x28(%ebp)
    2083:	6a 01                	push   $0x1
    2085:	6a 0a                	push   $0xa
    2087:	50                   	push   %eax
    2088:	8d 45 c8             	lea    -0x38(%ebp),%eax
    208b:	50                   	push   %eax
    208c:	ff 75 08             	pushl  0x8(%ebp)
    208f:	e8 56 fe ff ff       	call   1eea <sprintint>
    2094:	83 c4 20             	add    $0x20,%esp
                ap++;
    2097:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    209b:	e9 2a 01 00 00       	jmp    21ca <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    20a0:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    20a4:	74 06                	je     20ac <sprintf+0xe0>
    20a6:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    20aa:	75 4c                	jne    20f8 <sprintf+0x12c>
                buf[bi] = '\0';
    20ac:	8d 55 ce             	lea    -0x32(%ebp),%edx
    20af:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20b2:	01 d0                	add    %edx,%eax
    20b4:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    20b7:	83 ec 0c             	sub    $0xc,%esp
    20ba:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20bd:	50                   	push   %eax
    20be:	e8 bf e2 ff ff       	call   382 <atoi>
    20c3:	83 c4 10             	add    $0x10,%esp
    20c6:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    20c9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    20d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20d3:	8b 00                	mov    (%eax),%eax
    20d5:	83 ec 08             	sub    $0x8,%esp
    20d8:	ff 75 dc             	pushl  -0x24(%ebp)
    20db:	6a 00                	push   $0x0
    20dd:	6a 10                	push   $0x10
    20df:	50                   	push   %eax
    20e0:	8d 45 c8             	lea    -0x38(%ebp),%eax
    20e3:	50                   	push   %eax
    20e4:	ff 75 08             	pushl  0x8(%ebp)
    20e7:	e8 fe fd ff ff       	call   1eea <sprintint>
    20ec:	83 c4 20             	add    $0x20,%esp
                ap++;
    20ef:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    20f3:	e9 d2 00 00 00       	jmp    21ca <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    20f8:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    20fc:	75 46                	jne    2144 <sprintf+0x178>
                s = (char*)*ap;
    20fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2101:	8b 00                	mov    (%eax),%eax
    2103:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2106:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    210a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    210e:	75 25                	jne    2135 <sprintf+0x169>
                    s = "(null)";
    2110:	c7 45 f4 ac 23 00 00 	movl   $0x23ac,-0xc(%ebp)
                while(*s != 0){
    2117:	eb 1c                	jmp    2135 <sprintf+0x169>
                    dst[j++] = *s;
    2119:	8b 45 c8             	mov    -0x38(%ebp),%eax
    211c:	8d 50 01             	lea    0x1(%eax),%edx
    211f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2122:	89 c2                	mov    %eax,%edx
    2124:	8b 45 08             	mov    0x8(%ebp),%eax
    2127:	01 c2                	add    %eax,%edx
    2129:	8b 45 f4             	mov    -0xc(%ebp),%eax
    212c:	0f b6 00             	movzbl (%eax),%eax
    212f:	88 02                	mov    %al,(%edx)
                    s++;
    2131:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2135:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2138:	0f b6 00             	movzbl (%eax),%eax
    213b:	84 c0                	test   %al,%al
    213d:	75 da                	jne    2119 <sprintf+0x14d>
    213f:	e9 86 00 00 00       	jmp    21ca <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2144:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2148:	75 1d                	jne    2167 <sprintf+0x19b>
                dst[j++] = *ap;
    214a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    214d:	8d 50 01             	lea    0x1(%eax),%edx
    2150:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2153:	89 c2                	mov    %eax,%edx
    2155:	8b 45 08             	mov    0x8(%ebp),%eax
    2158:	01 c2                	add    %eax,%edx
    215a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    215d:	8b 00                	mov    (%eax),%eax
    215f:	88 02                	mov    %al,(%edx)
                ap++;
    2161:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2165:	eb 63                	jmp    21ca <sprintf+0x1fe>
            } else if(c == '%'){
    2167:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    216b:	75 17                	jne    2184 <sprintf+0x1b8>
                dst[j++] = c;
    216d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2170:	8d 50 01             	lea    0x1(%eax),%edx
    2173:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2176:	89 c2                	mov    %eax,%edx
    2178:	8b 45 08             	mov    0x8(%ebp),%eax
    217b:	01 d0                	add    %edx,%eax
    217d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2180:	88 10                	mov    %dl,(%eax)
    2182:	eb 46                	jmp    21ca <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2184:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2188:	7e 18                	jle    21a2 <sprintf+0x1d6>
    218a:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    218e:	7f 12                	jg     21a2 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2190:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2193:	8d 50 01             	lea    0x1(%eax),%edx
    2196:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2199:	8b 55 e0             	mov    -0x20(%ebp),%edx
    219c:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    21a0:	eb 2f                	jmp    21d1 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    21a2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21a5:	8d 50 01             	lea    0x1(%eax),%edx
    21a8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21ab:	89 c2                	mov    %eax,%edx
    21ad:	8b 45 08             	mov    0x8(%ebp),%eax
    21b0:	01 d0                	add    %edx,%eax
    21b2:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    21b5:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21b8:	8d 50 01             	lea    0x1(%eax),%edx
    21bb:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21be:	89 c2                	mov    %eax,%edx
    21c0:	8b 45 08             	mov    0x8(%ebp),%eax
    21c3:	01 d0                	add    %edx,%eax
    21c5:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21c8:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    21ca:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    21d1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    21d5:	8b 55 0c             	mov    0xc(%ebp),%edx
    21d8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    21db:	01 d0                	add    %edx,%eax
    21dd:	0f b6 00             	movzbl (%eax),%eax
    21e0:	84 c0                	test   %al,%al
    21e2:	0f 85 14 fe ff ff    	jne    1ffc <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    21e8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21eb:	8d 50 01             	lea    0x1(%eax),%edx
    21ee:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21f1:	89 c2                	mov    %eax,%edx
    21f3:	8b 45 08             	mov    0x8(%ebp),%eax
    21f6:	01 d0                	add    %edx,%eax
    21f8:	c6 00 00             	movb   $0x0,(%eax)
}
    21fb:	90                   	nop
    21fc:	c9                   	leave  
    21fd:	c3                   	ret    
