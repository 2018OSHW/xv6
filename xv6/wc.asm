
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
      54:	68 f8 21 00 00       	push   $0x21f8
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
      b9:	68 fe 21 00 00       	push   $0x21fe
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
      dc:	68 0e 22 00 00       	push   $0x220e
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
     10a:	68 1b 22 00 00       	push   $0x221b
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
     167:	68 1c 22 00 00       	push   $0x221c
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
     54f:	0f b6 80 dc 28 00 00 	movzbl 0x28dc(%eax),%eax
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
     68d:	c7 45 f4 30 22 00 00 	movl   $0x2230,-0xc(%ebp)
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
     753:	a1 28 29 00 00       	mov    0x2928,%eax
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
     81e:	a3 28 29 00 00       	mov    %eax,0x2928
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
     87f:	a1 28 29 00 00       	mov    0x2928,%eax
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
     89b:	a1 28 29 00 00       	mov    0x2928,%eax
     8a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8a3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8a7:	75 23                	jne    8cc <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     8a9:	c7 45 f0 20 29 00 00 	movl   $0x2920,-0x10(%ebp)
     8b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8b3:	a3 28 29 00 00       	mov    %eax,0x2928
     8b8:	a1 28 29 00 00       	mov    0x2928,%eax
     8bd:	a3 20 29 00 00       	mov    %eax,0x2920
    base.s.size = 0;
     8c2:	c7 05 24 29 00 00 00 	movl   $0x0,0x2924
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
     91f:	a3 28 29 00 00       	mov    %eax,0x2928
      return (void*)(p + 1);
     924:	8b 45 f4             	mov    -0xc(%ebp),%eax
     927:	83 c0 08             	add    $0x8,%eax
     92a:	eb 3b                	jmp    967 <malloc+0xe1>
    }
    if(p == freep)
     92c:	a1 28 29 00 00       	mov    0x2928,%eax
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
     a3c:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     a3f:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     a46:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a49:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     a4c:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     a53:	83 ec 08             	sub    $0x8,%esp
     a56:	6a 00                	push   $0x0
     a58:	ff 75 0c             	pushl  0xc(%ebp)
     a5b:	e8 f4 f9 ff ff       	call   454 <open>
     a60:	83 c4 10             	add    $0x10,%esp
     a63:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     a66:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     a6a:	79 2e                	jns    a9a <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     a6c:	83 ec 04             	sub    $0x4,%esp
     a6f:	ff 75 0c             	pushl  0xc(%ebp)
     a72:	68 37 22 00 00       	push   $0x2237
     a77:	6a 01                	push   $0x1
     a79:	e8 35 fb ff ff       	call   5b3 <printf>
     a7e:	83 c4 10             	add    $0x10,%esp
        return bmp;
     a81:	8b 45 08             	mov    0x8(%ebp),%eax
     a84:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a87:	89 10                	mov    %edx,(%eax)
     a89:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a8c:	89 50 04             	mov    %edx,0x4(%eax)
     a8f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a92:	89 50 08             	mov    %edx,0x8(%eax)
     a95:	e9 d2 01 00 00       	jmp    c6c <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     a9a:	83 ec 04             	sub    $0x4,%esp
     a9d:	6a 0e                	push   $0xe
     a9f:	8d 45 ba             	lea    -0x46(%ebp),%eax
     aa2:	50                   	push   %eax
     aa3:	ff 75 ec             	pushl  -0x14(%ebp)
     aa6:	e8 81 f9 ff ff       	call   42c <read>
     aab:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     aae:	83 ec 04             	sub    $0x4,%esp
     ab1:	6a 28                	push   $0x28
     ab3:	8d 45 92             	lea    -0x6e(%ebp),%eax
     ab6:	50                   	push   %eax
     ab7:	ff 75 ec             	pushl  -0x14(%ebp)
     aba:	e8 6d f9 ff ff       	call   42c <read>
     abf:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     ac2:	8b 45 96             	mov    -0x6a(%ebp),%eax
     ac5:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     ac8:	8b 45 9a             	mov    -0x66(%ebp),%eax
     acb:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     ace:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ad1:	8b 45 cc             	mov    -0x34(%ebp),%eax
     ad4:	0f af d0             	imul   %eax,%edx
     ad7:	89 d0                	mov    %edx,%eax
     ad9:	01 c0                	add    %eax,%eax
     adb:	01 d0                	add    %edx,%eax
     add:	83 ec 0c             	sub    $0xc,%esp
     ae0:	50                   	push   %eax
     ae1:	e8 a0 fd ff ff       	call   886 <malloc>
     ae6:	83 c4 10             	add    $0x10,%esp
     ae9:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     aec:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     af0:	0f b7 c0             	movzwl %ax,%eax
     af3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     af6:	8b 55 c8             	mov    -0x38(%ebp),%edx
     af9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     afc:	0f af c2             	imul   %edx,%eax
     aff:	83 c0 1f             	add    $0x1f,%eax
     b02:	c1 e8 05             	shr    $0x5,%eax
     b05:	c1 e0 02             	shl    $0x2,%eax
     b08:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     b0b:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b0e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b11:	0f af c2             	imul   %edx,%eax
     b14:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     b17:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b1a:	83 ec 0c             	sub    $0xc,%esp
     b1d:	50                   	push   %eax
     b1e:	e8 63 fd ff ff       	call   886 <malloc>
     b23:	83 c4 10             	add    $0x10,%esp
     b26:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     b29:	83 ec 04             	sub    $0x4,%esp
     b2c:	ff 75 e0             	pushl  -0x20(%ebp)
     b2f:	ff 75 dc             	pushl  -0x24(%ebp)
     b32:	ff 75 ec             	pushl  -0x14(%ebp)
     b35:	e8 f2 f8 ff ff       	call   42c <read>
     b3a:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     b3d:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     b41:	66 c1 e8 03          	shr    $0x3,%ax
     b45:	0f b7 c0             	movzwl %ax,%eax
     b48:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     b4b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     b52:	e9 e5 00 00 00       	jmp    c3c <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     b57:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b5d:	29 c2                	sub    %eax,%edx
     b5f:	89 d0                	mov    %edx,%eax
     b61:	8d 50 ff             	lea    -0x1(%eax),%edx
     b64:	8b 45 c8             	mov    -0x38(%ebp),%eax
     b67:	0f af c2             	imul   %edx,%eax
     b6a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     b6d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b74:	e9 b1 00 00 00       	jmp    c2a <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     b79:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b7c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b82:	01 c8                	add    %ecx,%eax
     b84:	89 c1                	mov    %eax,%ecx
     b86:	89 c8                	mov    %ecx,%eax
     b88:	01 c0                	add    %eax,%eax
     b8a:	01 c8                	add    %ecx,%eax
     b8c:	01 c2                	add    %eax,%edx
     b8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b91:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b95:	89 c1                	mov    %eax,%ecx
     b97:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b9a:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b9e:	01 c1                	add    %eax,%ecx
     ba0:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ba3:	01 c8                	add    %ecx,%eax
     ba5:	8d 48 ff             	lea    -0x1(%eax),%ecx
     ba8:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bab:	01 c8                	add    %ecx,%eax
     bad:	0f b6 00             	movzbl (%eax),%eax
     bb0:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     bb3:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bb6:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     bb9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bbc:	01 c8                	add    %ecx,%eax
     bbe:	89 c1                	mov    %eax,%ecx
     bc0:	89 c8                	mov    %ecx,%eax
     bc2:	01 c0                	add    %eax,%eax
     bc4:	01 c8                	add    %ecx,%eax
     bc6:	01 c2                	add    %eax,%edx
     bc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bcb:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     bcf:	89 c1                	mov    %eax,%ecx
     bd1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bd4:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     bd8:	01 c1                	add    %eax,%ecx
     bda:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bdd:	01 c8                	add    %ecx,%eax
     bdf:	8d 48 fe             	lea    -0x2(%eax),%ecx
     be2:	8b 45 dc             	mov    -0x24(%ebp),%eax
     be5:	01 c8                	add    %ecx,%eax
     be7:	0f b6 00             	movzbl (%eax),%eax
     bea:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     bed:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bf0:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     bf3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bf6:	01 c8                	add    %ecx,%eax
     bf8:	89 c1                	mov    %eax,%ecx
     bfa:	89 c8                	mov    %ecx,%eax
     bfc:	01 c0                	add    %eax,%eax
     bfe:	01 c8                	add    %ecx,%eax
     c00:	01 c2                	add    %eax,%edx
     c02:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c05:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     c09:	89 c1                	mov    %eax,%ecx
     c0b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c0e:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     c12:	01 c1                	add    %eax,%ecx
     c14:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c17:	01 c8                	add    %ecx,%eax
     c19:	8d 48 fd             	lea    -0x3(%eax),%ecx
     c1c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c1f:	01 c8                	add    %ecx,%eax
     c21:	0f b6 00             	movzbl (%eax),%eax
     c24:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     c26:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     c2a:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c30:	39 c2                	cmp    %eax,%edx
     c32:	0f 87 41 ff ff ff    	ja     b79 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     c38:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c3c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c42:	39 c2                	cmp    %eax,%edx
     c44:	0f 87 0d ff ff ff    	ja     b57 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     c4a:	83 ec 0c             	sub    $0xc,%esp
     c4d:	ff 75 ec             	pushl  -0x14(%ebp)
     c50:	e8 e7 f7 ff ff       	call   43c <close>
     c55:	83 c4 10             	add    $0x10,%esp
    return bmp;
     c58:	8b 45 08             	mov    0x8(%ebp),%eax
     c5b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c5e:	89 10                	mov    %edx,(%eax)
     c60:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c63:	89 50 04             	mov    %edx,0x4(%eax)
     c66:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c69:	89 50 08             	mov    %edx,0x8(%eax)
}
     c6c:	8b 45 08             	mov    0x8(%ebp),%eax
     c6f:	c9                   	leave  
     c70:	c2 04 00             	ret    $0x4

00000c73 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     c73:	55                   	push   %ebp
     c74:	89 e5                	mov    %esp,%ebp
     c76:	53                   	push   %ebx
     c77:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     c7a:	83 ec 0c             	sub    $0xc,%esp
     c7d:	6a 1c                	push   $0x1c
     c7f:	e8 02 fc ff ff       	call   886 <malloc>
     c84:	83 c4 10             	add    $0x10,%esp
     c87:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     c8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c8d:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     c94:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c97:	8d 45 d8             	lea    -0x28(%ebp),%eax
     c9a:	6a 0c                	push   $0xc
     c9c:	6a 0c                	push   $0xc
     c9e:	6a 0c                	push   $0xc
     ca0:	50                   	push   %eax
     ca1:	e8 c3 fc ff ff       	call   969 <RGB>
     ca6:	83 c4 0c             	add    $0xc,%esp
     ca9:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     cad:	66 89 43 13          	mov    %ax,0x13(%ebx)
     cb1:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     cb5:	88 43 15             	mov    %al,0x15(%ebx)
     cb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cbb:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cbe:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     cc2:	66 89 48 10          	mov    %cx,0x10(%eax)
     cc6:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     cca:	88 50 12             	mov    %dl,0x12(%eax)
     ccd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cd0:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cd3:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     cd7:	66 89 48 08          	mov    %cx,0x8(%eax)
     cdb:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     cdf:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     ce2:	8b 45 08             	mov    0x8(%ebp),%eax
     ce5:	89 c2                	mov    %eax,%edx
     ce7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cea:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     cec:	8b 45 0c             	mov    0xc(%ebp),%eax
     cef:	89 c2                	mov    %eax,%edx
     cf1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf4:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     cf7:	8b 55 10             	mov    0x10(%ebp),%edx
     cfa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cfd:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     d00:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     d03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d06:	c9                   	leave  
     d07:	c3                   	ret    

00000d08 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     d08:	55                   	push   %ebp
     d09:	89 e5                	mov    %esp,%ebp
     d0b:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     d0e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d11:	8b 50 08             	mov    0x8(%eax),%edx
     d14:	89 55 f8             	mov    %edx,-0x8(%ebp)
     d17:	8b 40 0c             	mov    0xc(%eax),%eax
     d1a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     d1d:	8b 45 0c             	mov    0xc(%ebp),%eax
     d20:	8b 55 10             	mov    0x10(%ebp),%edx
     d23:	89 50 08             	mov    %edx,0x8(%eax)
     d26:	8b 55 14             	mov    0x14(%ebp),%edx
     d29:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     d2c:	8b 45 08             	mov    0x8(%ebp),%eax
     d2f:	8b 55 f8             	mov    -0x8(%ebp),%edx
     d32:	89 10                	mov    %edx,(%eax)
     d34:	8b 55 fc             	mov    -0x4(%ebp),%edx
     d37:	89 50 04             	mov    %edx,0x4(%eax)
}
     d3a:	8b 45 08             	mov    0x8(%ebp),%eax
     d3d:	c9                   	leave  
     d3e:	c2 04 00             	ret    $0x4

00000d41 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     d41:	55                   	push   %ebp
     d42:	89 e5                	mov    %esp,%ebp
     d44:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     d47:	8b 45 0c             	mov    0xc(%ebp),%eax
     d4a:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     d4e:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     d52:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     d56:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     d59:	8b 45 0c             	mov    0xc(%ebp),%eax
     d5c:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     d60:	66 89 50 10          	mov    %dx,0x10(%eax)
     d64:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     d68:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     d6b:	8b 45 08             	mov    0x8(%ebp),%eax
     d6e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d72:	66 89 10             	mov    %dx,(%eax)
     d75:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d79:	88 50 02             	mov    %dl,0x2(%eax)
}
     d7c:	8b 45 08             	mov    0x8(%ebp),%eax
     d7f:	c9                   	leave  
     d80:	c2 04 00             	ret    $0x4

00000d83 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     d83:	55                   	push   %ebp
     d84:	89 e5                	mov    %esp,%ebp
     d86:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     d89:	8b 45 08             	mov    0x8(%ebp),%eax
     d8c:	8b 40 0c             	mov    0xc(%eax),%eax
     d8f:	89 c2                	mov    %eax,%edx
     d91:	c1 ea 1f             	shr    $0x1f,%edx
     d94:	01 d0                	add    %edx,%eax
     d96:	d1 f8                	sar    %eax
     d98:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     d9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d9e:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     da2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     da5:	8b 45 10             	mov    0x10(%ebp),%eax
     da8:	2b 45 f4             	sub    -0xc(%ebp),%eax
     dab:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     dae:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     db2:	0f 89 98 00 00 00    	jns    e50 <APDrawPoint+0xcd>
        i = 0;
     db8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     dbf:	e9 8c 00 00 00       	jmp    e50 <APDrawPoint+0xcd>
    {
        j = x - off;
     dc4:	8b 45 0c             	mov    0xc(%ebp),%eax
     dc7:	2b 45 f4             	sub    -0xc(%ebp),%eax
     dca:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     dcd:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     dd1:	79 69                	jns    e3c <APDrawPoint+0xb9>
            j = 0;
     dd3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     dda:	eb 60                	jmp    e3c <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     ddc:	ff 75 fc             	pushl  -0x4(%ebp)
     ddf:	ff 75 f8             	pushl  -0x8(%ebp)
     de2:	ff 75 08             	pushl  0x8(%ebp)
     de5:	e8 fd fb ff ff       	call   9e7 <APGetIndex>
     dea:	83 c4 0c             	add    $0xc,%esp
     ded:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     df0:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     df4:	74 55                	je     e4b <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     df6:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     dfa:	74 67                	je     e63 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     dfc:	ff 75 10             	pushl  0x10(%ebp)
     dff:	ff 75 0c             	pushl  0xc(%ebp)
     e02:	ff 75 fc             	pushl  -0x4(%ebp)
     e05:	ff 75 f8             	pushl  -0x8(%ebp)
     e08:	e8 a1 fb ff ff       	call   9ae <distance_2>
     e0d:	83 c4 10             	add    $0x10,%esp
     e10:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     e13:	7f 23                	jg     e38 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     e15:	8b 45 08             	mov    0x8(%ebp),%eax
     e18:	8b 48 18             	mov    0x18(%eax),%ecx
     e1b:	8b 55 ec             	mov    -0x14(%ebp),%edx
     e1e:	89 d0                	mov    %edx,%eax
     e20:	01 c0                	add    %eax,%eax
     e22:	01 d0                	add    %edx,%eax
     e24:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     e27:	8b 45 08             	mov    0x8(%ebp),%eax
     e2a:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     e2e:	66 89 0a             	mov    %cx,(%edx)
     e31:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     e35:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     e38:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     e3c:	8b 55 0c             	mov    0xc(%ebp),%edx
     e3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e42:	01 d0                	add    %edx,%eax
     e44:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     e47:	7d 93                	jge    ddc <APDrawPoint+0x59>
     e49:	eb 01                	jmp    e4c <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     e4b:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     e4c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     e50:	8b 55 10             	mov    0x10(%ebp),%edx
     e53:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e56:	01 d0                	add    %edx,%eax
     e58:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e5b:	0f 8d 63 ff ff ff    	jge    dc4 <APDrawPoint+0x41>
     e61:	eb 01                	jmp    e64 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     e63:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     e64:	c9                   	leave  
     e65:	c3                   	ret    

00000e66 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     e66:	55                   	push   %ebp
     e67:	89 e5                	mov    %esp,%ebp
     e69:	53                   	push   %ebx
     e6a:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     e6d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e70:	3b 45 14             	cmp    0x14(%ebp),%eax
     e73:	0f 85 80 00 00 00    	jne    ef9 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     e79:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e7d:	0f 88 9d 02 00 00    	js     1120 <APDrawLine+0x2ba>
     e83:	8b 45 08             	mov    0x8(%ebp),%eax
     e86:	8b 00                	mov    (%eax),%eax
     e88:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e8b:	0f 8e 8f 02 00 00    	jle    1120 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     e91:	8b 45 10             	mov    0x10(%ebp),%eax
     e94:	3b 45 18             	cmp    0x18(%ebp),%eax
     e97:	7e 12                	jle    eab <APDrawLine+0x45>
        {
            int tmp = y2;
     e99:	8b 45 18             	mov    0x18(%ebp),%eax
     e9c:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     e9f:	8b 45 10             	mov    0x10(%ebp),%eax
     ea2:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     ea5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ea8:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     eab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     eaf:	79 07                	jns    eb8 <APDrawLine+0x52>
     eb1:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     eb8:	8b 45 08             	mov    0x8(%ebp),%eax
     ebb:	8b 40 04             	mov    0x4(%eax),%eax
     ebe:	3b 45 18             	cmp    0x18(%ebp),%eax
     ec1:	7d 0c                	jge    ecf <APDrawLine+0x69>
     ec3:	8b 45 08             	mov    0x8(%ebp),%eax
     ec6:	8b 40 04             	mov    0x4(%eax),%eax
     ec9:	83 e8 01             	sub    $0x1,%eax
     ecc:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     ecf:	8b 45 10             	mov    0x10(%ebp),%eax
     ed2:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ed5:	eb 15                	jmp    eec <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     ed7:	ff 75 f4             	pushl  -0xc(%ebp)
     eda:	ff 75 0c             	pushl  0xc(%ebp)
     edd:	ff 75 08             	pushl  0x8(%ebp)
     ee0:	e8 9e fe ff ff       	call   d83 <APDrawPoint>
     ee5:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     ee8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     eec:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eef:	3b 45 18             	cmp    0x18(%ebp),%eax
     ef2:	7e e3                	jle    ed7 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     ef4:	e9 2b 02 00 00       	jmp    1124 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     ef9:	8b 45 10             	mov    0x10(%ebp),%eax
     efc:	3b 45 18             	cmp    0x18(%ebp),%eax
     eff:	75 7f                	jne    f80 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     f01:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     f05:	0f 88 18 02 00 00    	js     1123 <APDrawLine+0x2bd>
     f0b:	8b 45 08             	mov    0x8(%ebp),%eax
     f0e:	8b 40 04             	mov    0x4(%eax),%eax
     f11:	3b 45 10             	cmp    0x10(%ebp),%eax
     f14:	0f 8e 09 02 00 00    	jle    1123 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     f1a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f1d:	3b 45 14             	cmp    0x14(%ebp),%eax
     f20:	7e 12                	jle    f34 <APDrawLine+0xce>
        {
            int tmp = x2;
     f22:	8b 45 14             	mov    0x14(%ebp),%eax
     f25:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     f28:	8b 45 0c             	mov    0xc(%ebp),%eax
     f2b:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     f2e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     f31:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     f34:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f38:	79 07                	jns    f41 <APDrawLine+0xdb>
     f3a:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     f41:	8b 45 08             	mov    0x8(%ebp),%eax
     f44:	8b 00                	mov    (%eax),%eax
     f46:	3b 45 14             	cmp    0x14(%ebp),%eax
     f49:	7d 0b                	jge    f56 <APDrawLine+0xf0>
     f4b:	8b 45 08             	mov    0x8(%ebp),%eax
     f4e:	8b 00                	mov    (%eax),%eax
     f50:	83 e8 01             	sub    $0x1,%eax
     f53:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     f56:	8b 45 0c             	mov    0xc(%ebp),%eax
     f59:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f5c:	eb 15                	jmp    f73 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     f5e:	ff 75 10             	pushl  0x10(%ebp)
     f61:	ff 75 f0             	pushl  -0x10(%ebp)
     f64:	ff 75 08             	pushl  0x8(%ebp)
     f67:	e8 17 fe ff ff       	call   d83 <APDrawPoint>
     f6c:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     f6f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f73:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f76:	3b 45 14             	cmp    0x14(%ebp),%eax
     f79:	7e e3                	jle    f5e <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     f7b:	e9 a4 01 00 00       	jmp    1124 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     f80:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f87:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     f8e:	8b 45 0c             	mov    0xc(%ebp),%eax
     f91:	2b 45 14             	sub    0x14(%ebp),%eax
     f94:	50                   	push   %eax
     f95:	e8 3d fa ff ff       	call   9d7 <abs_int>
     f9a:	83 c4 04             	add    $0x4,%esp
     f9d:	89 c3                	mov    %eax,%ebx
     f9f:	8b 45 10             	mov    0x10(%ebp),%eax
     fa2:	2b 45 18             	sub    0x18(%ebp),%eax
     fa5:	50                   	push   %eax
     fa6:	e8 2c fa ff ff       	call   9d7 <abs_int>
     fab:	83 c4 04             	add    $0x4,%esp
     fae:	39 c3                	cmp    %eax,%ebx
     fb0:	0f 8e b5 00 00 00    	jle    106b <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     fb6:	8b 45 10             	mov    0x10(%ebp),%eax
     fb9:	2b 45 18             	sub    0x18(%ebp),%eax
     fbc:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fbf:	db 45 b0             	fildl  -0x50(%ebp)
     fc2:	8b 45 0c             	mov    0xc(%ebp),%eax
     fc5:	2b 45 14             	sub    0x14(%ebp),%eax
     fc8:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fcb:	db 45 b0             	fildl  -0x50(%ebp)
     fce:	de f9                	fdivrp %st,%st(1)
     fd0:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     fd3:	8b 45 14             	mov    0x14(%ebp),%eax
     fd6:	3b 45 0c             	cmp    0xc(%ebp),%eax
     fd9:	7e 0e                	jle    fe9 <APDrawLine+0x183>
        {
            s = x1;
     fdb:	8b 45 0c             	mov    0xc(%ebp),%eax
     fde:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     fe1:	8b 45 14             	mov    0x14(%ebp),%eax
     fe4:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fe7:	eb 0c                	jmp    ff5 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     fe9:	8b 45 14             	mov    0x14(%ebp),%eax
     fec:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     fef:	8b 45 0c             	mov    0xc(%ebp),%eax
     ff2:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     ff5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ff9:	79 07                	jns    1002 <APDrawLine+0x19c>
     ffb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1002:	8b 45 08             	mov    0x8(%ebp),%eax
    1005:	8b 00                	mov    (%eax),%eax
    1007:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    100a:	7f 0b                	jg     1017 <APDrawLine+0x1b1>
    100c:	8b 45 08             	mov    0x8(%ebp),%eax
    100f:	8b 00                	mov    (%eax),%eax
    1011:	83 e8 01             	sub    $0x1,%eax
    1014:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1017:	8b 45 ec             	mov    -0x14(%ebp),%eax
    101a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    101d:	eb 3f                	jmp    105e <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    101f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1022:	2b 45 0c             	sub    0xc(%ebp),%eax
    1025:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1028:	db 45 b0             	fildl  -0x50(%ebp)
    102b:	dc 4d d0             	fmull  -0x30(%ebp)
    102e:	db 45 10             	fildl  0x10(%ebp)
    1031:	de c1                	faddp  %st,%st(1)
    1033:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1036:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    103a:	b4 0c                	mov    $0xc,%ah
    103c:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1040:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1043:	db 5d cc             	fistpl -0x34(%ebp)
    1046:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1049:	ff 75 cc             	pushl  -0x34(%ebp)
    104c:	ff 75 e4             	pushl  -0x1c(%ebp)
    104f:	ff 75 08             	pushl  0x8(%ebp)
    1052:	e8 2c fd ff ff       	call   d83 <APDrawPoint>
    1057:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    105a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    105e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1061:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1064:	7e b9                	jle    101f <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1066:	e9 b9 00 00 00       	jmp    1124 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    106b:	8b 45 0c             	mov    0xc(%ebp),%eax
    106e:	2b 45 14             	sub    0x14(%ebp),%eax
    1071:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1074:	db 45 b0             	fildl  -0x50(%ebp)
    1077:	8b 45 10             	mov    0x10(%ebp),%eax
    107a:	2b 45 18             	sub    0x18(%ebp),%eax
    107d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1080:	db 45 b0             	fildl  -0x50(%ebp)
    1083:	de f9                	fdivrp %st,%st(1)
    1085:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1088:	8b 45 10             	mov    0x10(%ebp),%eax
    108b:	3b 45 18             	cmp    0x18(%ebp),%eax
    108e:	7e 0e                	jle    109e <APDrawLine+0x238>
    {
        s = y2;
    1090:	8b 45 18             	mov    0x18(%ebp),%eax
    1093:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1096:	8b 45 10             	mov    0x10(%ebp),%eax
    1099:	89 45 e8             	mov    %eax,-0x18(%ebp)
    109c:	eb 0c                	jmp    10aa <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    109e:	8b 45 10             	mov    0x10(%ebp),%eax
    10a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    10a4:	8b 45 18             	mov    0x18(%ebp),%eax
    10a7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    10aa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10ae:	79 07                	jns    10b7 <APDrawLine+0x251>
    10b0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    10b7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ba:	8b 40 04             	mov    0x4(%eax),%eax
    10bd:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10c0:	7f 0c                	jg     10ce <APDrawLine+0x268>
    10c2:	8b 45 08             	mov    0x8(%ebp),%eax
    10c5:	8b 40 04             	mov    0x4(%eax),%eax
    10c8:	83 e8 01             	sub    $0x1,%eax
    10cb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    10ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    10d4:	eb 3f                	jmp    1115 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    10d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10d9:	2b 45 10             	sub    0x10(%ebp),%eax
    10dc:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10df:	db 45 b0             	fildl  -0x50(%ebp)
    10e2:	dc 4d c0             	fmull  -0x40(%ebp)
    10e5:	db 45 0c             	fildl  0xc(%ebp)
    10e8:	de c1                	faddp  %st,%st(1)
    10ea:	d9 7d b6             	fnstcw -0x4a(%ebp)
    10ed:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    10f1:	b4 0c                	mov    $0xc,%ah
    10f3:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    10f7:	d9 6d b4             	fldcw  -0x4c(%ebp)
    10fa:	db 5d bc             	fistpl -0x44(%ebp)
    10fd:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1100:	ff 75 e0             	pushl  -0x20(%ebp)
    1103:	ff 75 bc             	pushl  -0x44(%ebp)
    1106:	ff 75 08             	pushl  0x8(%ebp)
    1109:	e8 75 fc ff ff       	call   d83 <APDrawPoint>
    110e:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1111:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1115:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1118:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    111b:	7e b9                	jle    10d6 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    111d:	90                   	nop
    111e:	eb 04                	jmp    1124 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1120:	90                   	nop
    1121:	eb 01                	jmp    1124 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1123:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1124:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1127:	c9                   	leave  
    1128:	c3                   	ret    

00001129 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1129:	55                   	push   %ebp
    112a:	89 e5                	mov    %esp,%ebp
    112c:	53                   	push   %ebx
    112d:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1130:	8b 55 10             	mov    0x10(%ebp),%edx
    1133:	8b 45 18             	mov    0x18(%ebp),%eax
    1136:	01 d0                	add    %edx,%eax
    1138:	83 e8 01             	sub    $0x1,%eax
    113b:	83 ec 04             	sub    $0x4,%esp
    113e:	50                   	push   %eax
    113f:	ff 75 0c             	pushl  0xc(%ebp)
    1142:	ff 75 10             	pushl  0x10(%ebp)
    1145:	ff 75 0c             	pushl  0xc(%ebp)
    1148:	ff 75 08             	pushl  0x8(%ebp)
    114b:	e8 16 fd ff ff       	call   e66 <APDrawLine>
    1150:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1153:	8b 55 0c             	mov    0xc(%ebp),%edx
    1156:	8b 45 14             	mov    0x14(%ebp),%eax
    1159:	01 d0                	add    %edx,%eax
    115b:	83 e8 01             	sub    $0x1,%eax
    115e:	83 ec 04             	sub    $0x4,%esp
    1161:	ff 75 10             	pushl  0x10(%ebp)
    1164:	50                   	push   %eax
    1165:	ff 75 10             	pushl  0x10(%ebp)
    1168:	ff 75 0c             	pushl  0xc(%ebp)
    116b:	ff 75 08             	pushl  0x8(%ebp)
    116e:	e8 f3 fc ff ff       	call   e66 <APDrawLine>
    1173:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1176:	8b 55 10             	mov    0x10(%ebp),%edx
    1179:	8b 45 18             	mov    0x18(%ebp),%eax
    117c:	01 d0                	add    %edx,%eax
    117e:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1181:	8b 55 0c             	mov    0xc(%ebp),%edx
    1184:	8b 45 14             	mov    0x14(%ebp),%eax
    1187:	01 d0                	add    %edx,%eax
    1189:	8d 50 ff             	lea    -0x1(%eax),%edx
    118c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    118f:	8b 45 14             	mov    0x14(%ebp),%eax
    1192:	01 d8                	add    %ebx,%eax
    1194:	83 e8 01             	sub    $0x1,%eax
    1197:	83 ec 04             	sub    $0x4,%esp
    119a:	51                   	push   %ecx
    119b:	52                   	push   %edx
    119c:	ff 75 10             	pushl  0x10(%ebp)
    119f:	50                   	push   %eax
    11a0:	ff 75 08             	pushl  0x8(%ebp)
    11a3:	e8 be fc ff ff       	call   e66 <APDrawLine>
    11a8:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    11ab:	8b 55 10             	mov    0x10(%ebp),%edx
    11ae:	8b 45 18             	mov    0x18(%ebp),%eax
    11b1:	01 d0                	add    %edx,%eax
    11b3:	8d 48 ff             	lea    -0x1(%eax),%ecx
    11b6:	8b 55 0c             	mov    0xc(%ebp),%edx
    11b9:	8b 45 14             	mov    0x14(%ebp),%eax
    11bc:	01 d0                	add    %edx,%eax
    11be:	8d 50 ff             	lea    -0x1(%eax),%edx
    11c1:	8b 5d 10             	mov    0x10(%ebp),%ebx
    11c4:	8b 45 18             	mov    0x18(%ebp),%eax
    11c7:	01 d8                	add    %ebx,%eax
    11c9:	83 e8 01             	sub    $0x1,%eax
    11cc:	83 ec 04             	sub    $0x4,%esp
    11cf:	51                   	push   %ecx
    11d0:	52                   	push   %edx
    11d1:	50                   	push   %eax
    11d2:	ff 75 0c             	pushl  0xc(%ebp)
    11d5:	ff 75 08             	pushl  0x8(%ebp)
    11d8:	e8 89 fc ff ff       	call   e66 <APDrawLine>
    11dd:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    11e0:	8b 55 0c             	mov    0xc(%ebp),%edx
    11e3:	8b 45 14             	mov    0x14(%ebp),%eax
    11e6:	01 d0                	add    %edx,%eax
    11e8:	8d 50 ff             	lea    -0x1(%eax),%edx
    11eb:	8b 45 08             	mov    0x8(%ebp),%eax
    11ee:	8b 40 0c             	mov    0xc(%eax),%eax
    11f1:	89 c1                	mov    %eax,%ecx
    11f3:	c1 e9 1f             	shr    $0x1f,%ecx
    11f6:	01 c8                	add    %ecx,%eax
    11f8:	d1 f8                	sar    %eax
    11fa:	29 c2                	sub    %eax,%edx
    11fc:	89 d0                	mov    %edx,%eax
    11fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1201:	8b 55 10             	mov    0x10(%ebp),%edx
    1204:	8b 45 18             	mov    0x18(%ebp),%eax
    1207:	01 d0                	add    %edx,%eax
    1209:	8d 50 ff             	lea    -0x1(%eax),%edx
    120c:	8b 45 08             	mov    0x8(%ebp),%eax
    120f:	8b 40 0c             	mov    0xc(%eax),%eax
    1212:	89 c1                	mov    %eax,%ecx
    1214:	c1 e9 1f             	shr    $0x1f,%ecx
    1217:	01 c8                	add    %ecx,%eax
    1219:	d1 f8                	sar    %eax
    121b:	29 c2                	sub    %eax,%edx
    121d:	89 d0                	mov    %edx,%eax
    121f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1222:	8b 45 08             	mov    0x8(%ebp),%eax
    1225:	8b 40 0c             	mov    0xc(%eax),%eax
    1228:	89 c2                	mov    %eax,%edx
    122a:	c1 ea 1f             	shr    $0x1f,%edx
    122d:	01 d0                	add    %edx,%eax
    122f:	d1 f8                	sar    %eax
    1231:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1234:	8b 45 08             	mov    0x8(%ebp),%eax
    1237:	8b 40 0c             	mov    0xc(%eax),%eax
    123a:	89 c2                	mov    %eax,%edx
    123c:	c1 ea 1f             	shr    $0x1f,%edx
    123f:	01 d0                	add    %edx,%eax
    1241:	d1 f8                	sar    %eax
    1243:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1246:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    124a:	0f 88 d8 00 00 00    	js     1328 <APDrawRect+0x1ff>
    1250:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1254:	0f 88 ce 00 00 00    	js     1328 <APDrawRect+0x1ff>
    125a:	8b 45 08             	mov    0x8(%ebp),%eax
    125d:	8b 00                	mov    (%eax),%eax
    125f:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1262:	0f 8e c0 00 00 00    	jle    1328 <APDrawRect+0x1ff>
    1268:	8b 45 08             	mov    0x8(%ebp),%eax
    126b:	8b 40 04             	mov    0x4(%eax),%eax
    126e:	3b 45 10             	cmp    0x10(%ebp),%eax
    1271:	0f 8e b1 00 00 00    	jle    1328 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1277:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    127b:	79 07                	jns    1284 <APDrawRect+0x15b>
    127d:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1284:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1288:	79 07                	jns    1291 <APDrawRect+0x168>
    128a:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1291:	8b 45 08             	mov    0x8(%ebp),%eax
    1294:	8b 00                	mov    (%eax),%eax
    1296:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1299:	7f 0b                	jg     12a6 <APDrawRect+0x17d>
    129b:	8b 45 08             	mov    0x8(%ebp),%eax
    129e:	8b 00                	mov    (%eax),%eax
    12a0:	83 e8 01             	sub    $0x1,%eax
    12a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    12a6:	8b 45 08             	mov    0x8(%ebp),%eax
    12a9:	8b 40 04             	mov    0x4(%eax),%eax
    12ac:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12af:	7f 0c                	jg     12bd <APDrawRect+0x194>
    12b1:	8b 45 08             	mov    0x8(%ebp),%eax
    12b4:	8b 40 04             	mov    0x4(%eax),%eax
    12b7:	83 e8 01             	sub    $0x1,%eax
    12ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    12bd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12c4:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12ca:	eb 52                	jmp    131e <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    12cc:	8b 45 10             	mov    0x10(%ebp),%eax
    12cf:	89 45 e8             	mov    %eax,-0x18(%ebp)
    12d2:	eb 3e                	jmp    1312 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    12d4:	83 ec 04             	sub    $0x4,%esp
    12d7:	ff 75 e8             	pushl  -0x18(%ebp)
    12da:	ff 75 ec             	pushl  -0x14(%ebp)
    12dd:	ff 75 08             	pushl  0x8(%ebp)
    12e0:	e8 02 f7 ff ff       	call   9e7 <APGetIndex>
    12e5:	83 c4 10             	add    $0x10,%esp
    12e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    12eb:	8b 45 08             	mov    0x8(%ebp),%eax
    12ee:	8b 48 18             	mov    0x18(%eax),%ecx
    12f1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    12f4:	89 d0                	mov    %edx,%eax
    12f6:	01 c0                	add    %eax,%eax
    12f8:	01 d0                	add    %edx,%eax
    12fa:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    12fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1300:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1304:	66 89 0a             	mov    %cx,(%edx)
    1307:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    130b:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    130e:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1312:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1315:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1318:	7e ba                	jle    12d4 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    131a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    131e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1321:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1324:	7e a6                	jle    12cc <APDrawRect+0x1a3>
    1326:	eb 01                	jmp    1329 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1328:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1329:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    132c:	c9                   	leave  
    132d:	c3                   	ret    

0000132e <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    132e:	55                   	push   %ebp
    132f:	89 e5                	mov    %esp,%ebp
    1331:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1334:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1338:	0f 88 8e 01 00 00    	js     14cc <APDcCopy+0x19e>
    133e:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1342:	0f 88 84 01 00 00    	js     14cc <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1348:	8b 55 0c             	mov    0xc(%ebp),%edx
    134b:	8b 45 20             	mov    0x20(%ebp),%eax
    134e:	01 d0                	add    %edx,%eax
    1350:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1353:	8b 55 10             	mov    0x10(%ebp),%edx
    1356:	8b 45 24             	mov    0x24(%ebp),%eax
    1359:	01 d0                	add    %edx,%eax
    135b:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    135e:	8b 55 18             	mov    0x18(%ebp),%edx
    1361:	8b 45 20             	mov    0x20(%ebp),%eax
    1364:	01 d0                	add    %edx,%eax
    1366:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1369:	8b 55 1c             	mov    0x1c(%ebp),%edx
    136c:	8b 45 24             	mov    0x24(%ebp),%eax
    136f:	01 d0                	add    %edx,%eax
    1371:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1374:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1378:	0f 88 51 01 00 00    	js     14cf <APDcCopy+0x1a1>
    137e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1382:	0f 88 47 01 00 00    	js     14cf <APDcCopy+0x1a1>
    1388:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    138c:	0f 88 3d 01 00 00    	js     14cf <APDcCopy+0x1a1>
    1392:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1396:	0f 88 33 01 00 00    	js     14cf <APDcCopy+0x1a1>
    139c:	8b 45 14             	mov    0x14(%ebp),%eax
    139f:	8b 00                	mov    (%eax),%eax
    13a1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13a4:	0f 8c 25 01 00 00    	jl     14cf <APDcCopy+0x1a1>
    13aa:	8b 45 14             	mov    0x14(%ebp),%eax
    13ad:	8b 40 04             	mov    0x4(%eax),%eax
    13b0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    13b3:	0f 8c 16 01 00 00    	jl     14cf <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    13b9:	8b 45 08             	mov    0x8(%ebp),%eax
    13bc:	8b 00                	mov    (%eax),%eax
    13be:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    13c1:	7f 0b                	jg     13ce <APDcCopy+0xa0>
    13c3:	8b 45 08             	mov    0x8(%ebp),%eax
    13c6:	8b 00                	mov    (%eax),%eax
    13c8:	83 e8 01             	sub    $0x1,%eax
    13cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    13ce:	8b 45 08             	mov    0x8(%ebp),%eax
    13d1:	8b 40 04             	mov    0x4(%eax),%eax
    13d4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13d7:	7f 0c                	jg     13e5 <APDcCopy+0xb7>
    13d9:	8b 45 08             	mov    0x8(%ebp),%eax
    13dc:	8b 40 04             	mov    0x4(%eax),%eax
    13df:	83 e8 01             	sub    $0x1,%eax
    13e2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    13e5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    13ec:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    13f3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13fa:	e9 bc 00 00 00       	jmp    14bb <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    13ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1402:	8b 00                	mov    (%eax),%eax
    1404:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1407:	8b 55 10             	mov    0x10(%ebp),%edx
    140a:	01 ca                	add    %ecx,%edx
    140c:	0f af d0             	imul   %eax,%edx
    140f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1412:	01 d0                	add    %edx,%eax
    1414:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1417:	8b 45 14             	mov    0x14(%ebp),%eax
    141a:	8b 00                	mov    (%eax),%eax
    141c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    141f:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1422:	01 ca                	add    %ecx,%edx
    1424:	0f af d0             	imul   %eax,%edx
    1427:	8b 45 18             	mov    0x18(%ebp),%eax
    142a:	01 d0                	add    %edx,%eax
    142c:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    142f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1436:	eb 74                	jmp    14ac <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1438:	8b 45 14             	mov    0x14(%ebp),%eax
    143b:	8b 50 18             	mov    0x18(%eax),%edx
    143e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1441:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1444:	01 c8                	add    %ecx,%eax
    1446:	89 c1                	mov    %eax,%ecx
    1448:	89 c8                	mov    %ecx,%eax
    144a:	01 c0                	add    %eax,%eax
    144c:	01 c8                	add    %ecx,%eax
    144e:	01 d0                	add    %edx,%eax
    1450:	0f b7 10             	movzwl (%eax),%edx
    1453:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1457:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    145b:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    145e:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1462:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1466:	38 c2                	cmp    %al,%dl
    1468:	75 18                	jne    1482 <APDcCopy+0x154>
    146a:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    146e:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1472:	38 c2                	cmp    %al,%dl
    1474:	75 0c                	jne    1482 <APDcCopy+0x154>
    1476:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    147a:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    147e:	38 c2                	cmp    %al,%dl
    1480:	74 26                	je     14a8 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1482:	8b 45 08             	mov    0x8(%ebp),%eax
    1485:	8b 50 18             	mov    0x18(%eax),%edx
    1488:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    148b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    148e:	01 c8                	add    %ecx,%eax
    1490:	89 c1                	mov    %eax,%ecx
    1492:	89 c8                	mov    %ecx,%eax
    1494:	01 c0                	add    %eax,%eax
    1496:	01 c8                	add    %ecx,%eax
    1498:	01 d0                	add    %edx,%eax
    149a:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    149e:	66 89 10             	mov    %dx,(%eax)
    14a1:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    14a5:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    14a8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14af:	2b 45 0c             	sub    0xc(%ebp),%eax
    14b2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14b5:	7d 81                	jge    1438 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    14b7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14be:	2b 45 10             	sub    0x10(%ebp),%eax
    14c1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14c4:	0f 8d 35 ff ff ff    	jge    13ff <APDcCopy+0xd1>
    14ca:	eb 04                	jmp    14d0 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    14cc:	90                   	nop
    14cd:	eb 01                	jmp    14d0 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    14cf:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    14d0:	c9                   	leave  
    14d1:	c3                   	ret    

000014d2 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    14d2:	55                   	push   %ebp
    14d3:	89 e5                	mov    %esp,%ebp
    14d5:	83 ec 1c             	sub    $0x1c,%esp
    14d8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    14db:	8b 55 10             	mov    0x10(%ebp),%edx
    14de:	8b 45 14             	mov    0x14(%ebp),%eax
    14e1:	88 4d ec             	mov    %cl,-0x14(%ebp)
    14e4:	88 55 e8             	mov    %dl,-0x18(%ebp)
    14e7:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    14ea:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    14ee:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    14f1:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    14f5:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    14f8:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    14fc:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    14ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1502:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1506:	66 89 10             	mov    %dx,(%eax)
    1509:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    150d:	88 50 02             	mov    %dl,0x2(%eax)
}
    1510:	8b 45 08             	mov    0x8(%ebp),%eax
    1513:	c9                   	leave  
    1514:	c2 04 00             	ret    $0x4

00001517 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1517:	55                   	push   %ebp
    1518:	89 e5                	mov    %esp,%ebp
    151a:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    151d:	8b 45 08             	mov    0x8(%ebp),%eax
    1520:	8b 00                	mov    (%eax),%eax
    1522:	83 ec 08             	sub    $0x8,%esp
    1525:	8d 55 0c             	lea    0xc(%ebp),%edx
    1528:	52                   	push   %edx
    1529:	50                   	push   %eax
    152a:	e8 95 ef ff ff       	call   4c4 <sendMessage>
    152f:	83 c4 10             	add    $0x10,%esp
}
    1532:	90                   	nop
    1533:	c9                   	leave  
    1534:	c3                   	ret    

00001535 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1535:	55                   	push   %ebp
    1536:	89 e5                	mov    %esp,%ebp
    1538:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    153b:	83 ec 0c             	sub    $0xc,%esp
    153e:	68 90 00 00 00       	push   $0x90
    1543:	e8 3e f3 ff ff       	call   886 <malloc>
    1548:	83 c4 10             	add    $0x10,%esp
    154b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    154e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1552:	75 15                	jne    1569 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1554:	83 ec 04             	sub    $0x4,%esp
    1557:	ff 75 08             	pushl  0x8(%ebp)
    155a:	68 48 22 00 00       	push   $0x2248
    155f:	6a 01                	push   $0x1
    1561:	e8 4d f0 ff ff       	call   5b3 <printf>
    1566:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1569:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156c:	83 c0 7c             	add    $0x7c,%eax
    156f:	83 ec 08             	sub    $0x8,%esp
    1572:	ff 75 08             	pushl  0x8(%ebp)
    1575:	50                   	push   %eax
    1576:	e8 68 ec ff ff       	call   1e3 <strcpy>
    157b:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    157e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1581:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1588:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158b:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1592:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1595:	8b 40 34             	mov    0x34(%eax),%eax
    1598:	89 c2                	mov    %eax,%edx
    159a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159d:	8b 40 38             	mov    0x38(%eax),%eax
    15a0:	0f af d0             	imul   %eax,%edx
    15a3:	89 d0                	mov    %edx,%eax
    15a5:	01 c0                	add    %eax,%eax
    15a7:	01 d0                	add    %edx,%eax
    15a9:	83 ec 0c             	sub    $0xc,%esp
    15ac:	50                   	push   %eax
    15ad:	e8 d4 f2 ff ff       	call   886 <malloc>
    15b2:	83 c4 10             	add    $0x10,%esp
    15b5:	89 c2                	mov    %eax,%edx
    15b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ba:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    15bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c0:	8b 40 4c             	mov    0x4c(%eax),%eax
    15c3:	85 c0                	test   %eax,%eax
    15c5:	75 15                	jne    15dc <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    15c7:	83 ec 04             	sub    $0x4,%esp
    15ca:	ff 75 08             	pushl  0x8(%ebp)
    15cd:	68 68 22 00 00       	push   $0x2268
    15d2:	6a 01                	push   $0x1
    15d4:	e8 da ef ff ff       	call   5b3 <printf>
    15d9:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15df:	8b 40 34             	mov    0x34(%eax),%eax
    15e2:	89 c2                	mov    %eax,%edx
    15e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e7:	8b 40 38             	mov    0x38(%eax),%eax
    15ea:	0f af d0             	imul   %eax,%edx
    15ed:	89 d0                	mov    %edx,%eax
    15ef:	01 c0                	add    %eax,%eax
    15f1:	01 c2                	add    %eax,%edx
    15f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f6:	8b 40 4c             	mov    0x4c(%eax),%eax
    15f9:	83 ec 04             	sub    $0x4,%esp
    15fc:	52                   	push   %edx
    15fd:	68 ff ff ff 00       	push   $0xffffff
    1602:	50                   	push   %eax
    1603:	e8 71 ec ff ff       	call   279 <memset>
    1608:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    160b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160e:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    1615:	e8 7a ee ff ff       	call   494 <getpid>
    161a:	89 c2                	mov    %eax,%edx
    161c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161f:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1622:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1625:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    162c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162f:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1636:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1639:	8b 40 50             	mov    0x50(%eax),%eax
    163c:	89 c2                	mov    %eax,%edx
    163e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1641:	8b 40 54             	mov    0x54(%eax),%eax
    1644:	0f af d0             	imul   %eax,%edx
    1647:	89 d0                	mov    %edx,%eax
    1649:	01 c0                	add    %eax,%eax
    164b:	01 d0                	add    %edx,%eax
    164d:	83 ec 0c             	sub    $0xc,%esp
    1650:	50                   	push   %eax
    1651:	e8 30 f2 ff ff       	call   886 <malloc>
    1656:	83 c4 10             	add    $0x10,%esp
    1659:	89 c2                	mov    %eax,%edx
    165b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165e:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    1661:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1664:	8b 40 68             	mov    0x68(%eax),%eax
    1667:	85 c0                	test   %eax,%eax
    1669:	75 15                	jne    1680 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    166b:	83 ec 04             	sub    $0x4,%esp
    166e:	ff 75 08             	pushl  0x8(%ebp)
    1671:	68 8c 22 00 00       	push   $0x228c
    1676:	6a 01                	push   $0x1
    1678:	e8 36 ef ff ff       	call   5b3 <printf>
    167d:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1680:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1683:	8b 40 34             	mov    0x34(%eax),%eax
    1686:	89 c2                	mov    %eax,%edx
    1688:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168b:	8b 40 38             	mov    0x38(%eax),%eax
    168e:	0f af d0             	imul   %eax,%edx
    1691:	89 d0                	mov    %edx,%eax
    1693:	01 c0                	add    %eax,%eax
    1695:	01 c2                	add    %eax,%edx
    1697:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169a:	8b 40 4c             	mov    0x4c(%eax),%eax
    169d:	83 ec 04             	sub    $0x4,%esp
    16a0:	52                   	push   %edx
    16a1:	68 ff 00 00 00       	push   $0xff
    16a6:	50                   	push   %eax
    16a7:	e8 cd eb ff ff       	call   279 <memset>
    16ac:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    16af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b2:	8b 55 0c             	mov    0xc(%ebp),%edx
    16b5:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    16b8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16bc:	74 35                	je     16f3 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    16be:	8b 45 10             	mov    0x10(%ebp),%eax
    16c1:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    16c7:	83 ec 0c             	sub    $0xc,%esp
    16ca:	50                   	push   %eax
    16cb:	e8 b6 f1 ff ff       	call   886 <malloc>
    16d0:	83 c4 10             	add    $0x10,%esp
    16d3:	89 c2                	mov    %eax,%edx
    16d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d8:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    16db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16de:	8b 55 10             	mov    0x10(%ebp),%edx
    16e1:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    16e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e7:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    16ee:	e9 8d 00 00 00       	jmp    1780 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    16f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f6:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    16fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1700:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1707:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170a:	8b 40 18             	mov    0x18(%eax),%eax
    170d:	89 c2                	mov    %eax,%edx
    170f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1712:	8b 40 1c             	mov    0x1c(%eax),%eax
    1715:	0f af d0             	imul   %eax,%edx
    1718:	89 d0                	mov    %edx,%eax
    171a:	01 c0                	add    %eax,%eax
    171c:	01 d0                	add    %edx,%eax
    171e:	83 ec 0c             	sub    $0xc,%esp
    1721:	50                   	push   %eax
    1722:	e8 5f f1 ff ff       	call   886 <malloc>
    1727:	83 c4 10             	add    $0x10,%esp
    172a:	89 c2                	mov    %eax,%edx
    172c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172f:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    1732:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1735:	8b 40 30             	mov    0x30(%eax),%eax
    1738:	85 c0                	test   %eax,%eax
    173a:	75 15                	jne    1751 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    173c:	83 ec 04             	sub    $0x4,%esp
    173f:	ff 75 08             	pushl  0x8(%ebp)
    1742:	68 b4 22 00 00       	push   $0x22b4
    1747:	6a 01                	push   $0x1
    1749:	e8 65 ee ff ff       	call   5b3 <printf>
    174e:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1751:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1754:	8b 40 18             	mov    0x18(%eax),%eax
    1757:	89 c2                	mov    %eax,%edx
    1759:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175c:	8b 40 1c             	mov    0x1c(%eax),%eax
    175f:	0f af d0             	imul   %eax,%edx
    1762:	89 d0                	mov    %edx,%eax
    1764:	01 c0                	add    %eax,%eax
    1766:	01 c2                	add    %eax,%edx
    1768:	8b 45 f4             	mov    -0xc(%ebp),%eax
    176b:	8b 40 30             	mov    0x30(%eax),%eax
    176e:	83 ec 04             	sub    $0x4,%esp
    1771:	52                   	push   %edx
    1772:	68 ff ff ff 00       	push   $0xffffff
    1777:	50                   	push   %eax
    1778:	e8 fc ea ff ff       	call   279 <memset>
    177d:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1780:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1783:	c9                   	leave  
    1784:	c3                   	ret    

00001785 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1785:	55                   	push   %ebp
    1786:	89 e5                	mov    %esp,%ebp
    1788:	53                   	push   %ebx
    1789:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    178c:	8b 45 0c             	mov    0xc(%ebp),%eax
    178f:	83 f8 03             	cmp    $0x3,%eax
    1792:	74 02                	je     1796 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1794:	eb 33                	jmp    17c9 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1796:	8b 45 08             	mov    0x8(%ebp),%eax
    1799:	8b 48 08             	mov    0x8(%eax),%ecx
    179c:	8b 45 08             	mov    0x8(%ebp),%eax
    179f:	8b 50 38             	mov    0x38(%eax),%edx
    17a2:	8b 45 08             	mov    0x8(%ebp),%eax
    17a5:	8b 40 34             	mov    0x34(%eax),%eax
    17a8:	8b 5d 08             	mov    0x8(%ebp),%ebx
    17ab:	83 c3 34             	add    $0x34,%ebx
    17ae:	83 ec 0c             	sub    $0xc,%esp
    17b1:	51                   	push   %ecx
    17b2:	52                   	push   %edx
    17b3:	50                   	push   %eax
    17b4:	6a 00                	push   $0x0
    17b6:	6a 00                	push   $0x0
    17b8:	53                   	push   %ebx
    17b9:	6a 32                	push   $0x32
    17bb:	6a 00                	push   $0x0
    17bd:	ff 75 08             	pushl  0x8(%ebp)
    17c0:	e8 ef ec ff ff       	call   4b4 <paintWindow>
    17c5:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    17c8:	90                   	nop
        default: break;
            
            
    }
    return False;
    17c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    17ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    17d1:	c9                   	leave  
    17d2:	c3                   	ret    

000017d3 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    17d3:	55                   	push   %ebp
    17d4:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    17d6:	8b 45 0c             	mov    0xc(%ebp),%eax
    17d9:	8b 50 08             	mov    0x8(%eax),%edx
    17dc:	8b 45 08             	mov    0x8(%ebp),%eax
    17df:	8b 00                	mov    (%eax),%eax
    17e1:	39 c2                	cmp    %eax,%edx
    17e3:	74 07                	je     17ec <APPreJudge+0x19>
        return False;
    17e5:	b8 00 00 00 00       	mov    $0x0,%eax
    17ea:	eb 05                	jmp    17f1 <APPreJudge+0x1e>
    return True;
    17ec:	b8 01 00 00 00       	mov    $0x1,%eax
}
    17f1:	5d                   	pop    %ebp
    17f2:	c3                   	ret    

000017f3 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    17f3:	55                   	push   %ebp
    17f4:	89 e5                	mov    %esp,%ebp
    17f6:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    17f9:	8b 45 08             	mov    0x8(%ebp),%eax
    17fc:	8b 55 0c             	mov    0xc(%ebp),%edx
    17ff:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    1802:	83 ec 0c             	sub    $0xc,%esp
    1805:	ff 75 08             	pushl  0x8(%ebp)
    1808:	e8 c7 ec ff ff       	call   4d4 <registWindow>
    180d:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1810:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1817:	8b 45 08             	mov    0x8(%ebp),%eax
    181a:	8b 00                	mov    (%eax),%eax
    181c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    181f:	ff 75 f4             	pushl  -0xc(%ebp)
    1822:	ff 75 f0             	pushl  -0x10(%ebp)
    1825:	ff 75 ec             	pushl  -0x14(%ebp)
    1828:	ff 75 08             	pushl  0x8(%ebp)
    182b:	e8 e7 fc ff ff       	call   1517 <APSendMessage>
    1830:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1833:	83 ec 0c             	sub    $0xc,%esp
    1836:	ff 75 08             	pushl  0x8(%ebp)
    1839:	e8 8e ec ff ff       	call   4cc <getMessage>
    183e:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1841:	8b 45 08             	mov    0x8(%ebp),%eax
    1844:	83 c0 6c             	add    $0x6c,%eax
    1847:	83 ec 08             	sub    $0x8,%esp
    184a:	50                   	push   %eax
    184b:	ff 75 08             	pushl  0x8(%ebp)
    184e:	e8 80 ff ff ff       	call   17d3 <APPreJudge>
    1853:	83 c4 10             	add    $0x10,%esp
    1856:	84 c0                	test   %al,%al
    1858:	74 1b                	je     1875 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    185a:	8b 45 08             	mov    0x8(%ebp),%eax
    185d:	ff 70 74             	pushl  0x74(%eax)
    1860:	ff 70 70             	pushl  0x70(%eax)
    1863:	ff 70 6c             	pushl  0x6c(%eax)
    1866:	ff 75 08             	pushl  0x8(%ebp)
    1869:	8b 45 0c             	mov    0xc(%ebp),%eax
    186c:	ff d0                	call   *%eax
    186e:	83 c4 10             	add    $0x10,%esp
    1871:	84 c0                	test   %al,%al
    1873:	75 0c                	jne    1881 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1875:	8b 45 08             	mov    0x8(%ebp),%eax
    1878:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    187f:	eb b2                	jmp    1833 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1881:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1882:	90                   	nop
    1883:	c9                   	leave  
    1884:	c3                   	ret    

00001885 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1885:	55                   	push   %ebp
    1886:	89 e5                	mov    %esp,%ebp
    1888:	57                   	push   %edi
    1889:	56                   	push   %esi
    188a:	53                   	push   %ebx
    188b:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    188e:	a1 2c 29 00 00       	mov    0x292c,%eax
    1893:	85 c0                	test   %eax,%eax
    1895:	0f 85 2c 02 00 00    	jne    1ac7 <APGridPaint+0x242>
    {
        iconReady = 1;
    189b:	c7 05 2c 29 00 00 01 	movl   $0x1,0x292c
    18a2:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    18a5:	8d 45 98             	lea    -0x68(%ebp),%eax
    18a8:	83 ec 08             	sub    $0x8,%esp
    18ab:	68 db 22 00 00       	push   $0x22db
    18b0:	50                   	push   %eax
    18b1:	e8 83 f1 ff ff       	call   a39 <APLoadBitmap>
    18b6:	83 c4 0c             	add    $0xc,%esp
    18b9:	8b 45 98             	mov    -0x68(%ebp),%eax
    18bc:	a3 60 2b 00 00       	mov    %eax,0x2b60
    18c1:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18c4:	a3 64 2b 00 00       	mov    %eax,0x2b64
    18c9:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18cc:	a3 68 2b 00 00       	mov    %eax,0x2b68
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    18d1:	83 ec 04             	sub    $0x4,%esp
    18d4:	ff 35 68 2b 00 00    	pushl  0x2b68
    18da:	ff 35 64 2b 00 00    	pushl  0x2b64
    18e0:	ff 35 60 2b 00 00    	pushl  0x2b60
    18e6:	e8 88 f3 ff ff       	call   c73 <APCreateCompatibleDCFromBitmap>
    18eb:	83 c4 10             	add    $0x10,%esp
    18ee:	a3 6c 2b 00 00       	mov    %eax,0x2b6c
        grid_river = APLoadBitmap ("grid_river.bmp");
    18f3:	8d 45 98             	lea    -0x68(%ebp),%eax
    18f6:	83 ec 08             	sub    $0x8,%esp
    18f9:	68 e9 22 00 00       	push   $0x22e9
    18fe:	50                   	push   %eax
    18ff:	e8 35 f1 ff ff       	call   a39 <APLoadBitmap>
    1904:	83 c4 0c             	add    $0xc,%esp
    1907:	8b 45 98             	mov    -0x68(%ebp),%eax
    190a:	a3 9c 2b 00 00       	mov    %eax,0x2b9c
    190f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1912:	a3 a0 2b 00 00       	mov    %eax,0x2ba0
    1917:	8b 45 a0             	mov    -0x60(%ebp),%eax
    191a:	a3 a4 2b 00 00       	mov    %eax,0x2ba4
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    191f:	83 ec 04             	sub    $0x4,%esp
    1922:	ff 35 a4 2b 00 00    	pushl  0x2ba4
    1928:	ff 35 a0 2b 00 00    	pushl  0x2ba0
    192e:	ff 35 9c 2b 00 00    	pushl  0x2b9c
    1934:	e8 3a f3 ff ff       	call   c73 <APCreateCompatibleDCFromBitmap>
    1939:	83 c4 10             	add    $0x10,%esp
    193c:	a3 8c 2b 00 00       	mov    %eax,0x2b8c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1941:	8d 45 98             	lea    -0x68(%ebp),%eax
    1944:	83 ec 08             	sub    $0x8,%esp
    1947:	68 f8 22 00 00       	push   $0x22f8
    194c:	50                   	push   %eax
    194d:	e8 e7 f0 ff ff       	call   a39 <APLoadBitmap>
    1952:	83 c4 0c             	add    $0xc,%esp
    1955:	8b 45 98             	mov    -0x68(%ebp),%eax
    1958:	a3 90 2b 00 00       	mov    %eax,0x2b90
    195d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1960:	a3 94 2b 00 00       	mov    %eax,0x2b94
    1965:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1968:	a3 98 2b 00 00       	mov    %eax,0x2b98
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    196d:	83 ec 04             	sub    $0x4,%esp
    1970:	ff 35 98 2b 00 00    	pushl  0x2b98
    1976:	ff 35 94 2b 00 00    	pushl  0x2b94
    197c:	ff 35 90 2b 00 00    	pushl  0x2b90
    1982:	e8 ec f2 ff ff       	call   c73 <APCreateCompatibleDCFromBitmap>
    1987:	83 c4 10             	add    $0x10,%esp
    198a:	a3 40 2b 00 00       	mov    %eax,0x2b40
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    198f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1992:	83 ec 08             	sub    $0x8,%esp
    1995:	68 07 23 00 00       	push   $0x2307
    199a:	50                   	push   %eax
    199b:	e8 99 f0 ff ff       	call   a39 <APLoadBitmap>
    19a0:	83 c4 0c             	add    $0xc,%esp
    19a3:	8b 45 98             	mov    -0x68(%ebp),%eax
    19a6:	a3 74 2b 00 00       	mov    %eax,0x2b74
    19ab:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19ae:	a3 78 2b 00 00       	mov    %eax,0x2b78
    19b3:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19b6:	a3 7c 2b 00 00       	mov    %eax,0x2b7c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    19bb:	83 ec 04             	sub    $0x4,%esp
    19be:	ff 35 7c 2b 00 00    	pushl  0x2b7c
    19c4:	ff 35 78 2b 00 00    	pushl  0x2b78
    19ca:	ff 35 74 2b 00 00    	pushl  0x2b74
    19d0:	e8 9e f2 ff ff       	call   c73 <APCreateCompatibleDCFromBitmap>
    19d5:	83 c4 10             	add    $0x10,%esp
    19d8:	a3 a8 2b 00 00       	mov    %eax,0x2ba8
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    19dd:	8d 45 98             	lea    -0x68(%ebp),%eax
    19e0:	83 ec 08             	sub    $0x8,%esp
    19e3:	68 15 23 00 00       	push   $0x2315
    19e8:	50                   	push   %eax
    19e9:	e8 4b f0 ff ff       	call   a39 <APLoadBitmap>
    19ee:	83 c4 0c             	add    $0xc,%esp
    19f1:	8b 45 98             	mov    -0x68(%ebp),%eax
    19f4:	a3 50 2b 00 00       	mov    %eax,0x2b50
    19f9:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19fc:	a3 54 2b 00 00       	mov    %eax,0x2b54
    1a01:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a04:	a3 58 2b 00 00       	mov    %eax,0x2b58
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1a09:	83 ec 04             	sub    $0x4,%esp
    1a0c:	ff 35 58 2b 00 00    	pushl  0x2b58
    1a12:	ff 35 54 2b 00 00    	pushl  0x2b54
    1a18:	ff 35 50 2b 00 00    	pushl  0x2b50
    1a1e:	e8 50 f2 ff ff       	call   c73 <APCreateCompatibleDCFromBitmap>
    1a23:	83 c4 10             	add    $0x10,%esp
    1a26:	a3 70 2b 00 00       	mov    %eax,0x2b70
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1a2b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a2e:	83 ec 08             	sub    $0x8,%esp
    1a31:	68 25 23 00 00       	push   $0x2325
    1a36:	50                   	push   %eax
    1a37:	e8 fd ef ff ff       	call   a39 <APLoadBitmap>
    1a3c:	83 c4 0c             	add    $0xc,%esp
    1a3f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a42:	a3 44 2b 00 00       	mov    %eax,0x2b44
    1a47:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a4a:	a3 48 2b 00 00       	mov    %eax,0x2b48
    1a4f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a52:	a3 4c 2b 00 00       	mov    %eax,0x2b4c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1a57:	83 ec 04             	sub    $0x4,%esp
    1a5a:	ff 35 4c 2b 00 00    	pushl  0x2b4c
    1a60:	ff 35 48 2b 00 00    	pushl  0x2b48
    1a66:	ff 35 44 2b 00 00    	pushl  0x2b44
    1a6c:	e8 02 f2 ff ff       	call   c73 <APCreateCompatibleDCFromBitmap>
    1a71:	83 c4 10             	add    $0x10,%esp
    1a74:	a3 5c 2b 00 00       	mov    %eax,0x2b5c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1a79:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a7c:	83 ec 08             	sub    $0x8,%esp
    1a7f:	68 37 23 00 00       	push   $0x2337
    1a84:	50                   	push   %eax
    1a85:	e8 af ef ff ff       	call   a39 <APLoadBitmap>
    1a8a:	83 c4 0c             	add    $0xc,%esp
    1a8d:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a90:	a3 80 2b 00 00       	mov    %eax,0x2b80
    1a95:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a98:	a3 84 2b 00 00       	mov    %eax,0x2b84
    1a9d:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1aa0:	a3 88 2b 00 00       	mov    %eax,0x2b88
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1aa5:	83 ec 04             	sub    $0x4,%esp
    1aa8:	ff 35 88 2b 00 00    	pushl  0x2b88
    1aae:	ff 35 84 2b 00 00    	pushl  0x2b84
    1ab4:	ff 35 80 2b 00 00    	pushl  0x2b80
    1aba:	e8 b4 f1 ff ff       	call   c73 <APCreateCompatibleDCFromBitmap>
    1abf:	83 c4 10             	add    $0x10,%esp
    1ac2:	a3 ac 2b 00 00       	mov    %eax,0x2bac
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1ac7:	8b 45 08             	mov    0x8(%ebp),%eax
    1aca:	8b 40 08             	mov    0x8(%eax),%eax
    1acd:	85 c0                	test   %eax,%eax
    1acf:	75 17                	jne    1ae8 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1ad1:	83 ec 08             	sub    $0x8,%esp
    1ad4:	68 48 23 00 00       	push   $0x2348
    1ad9:	6a 01                	push   $0x1
    1adb:	e8 d3 ea ff ff       	call   5b3 <printf>
    1ae0:	83 c4 10             	add    $0x10,%esp
        return;
    1ae3:	e9 f2 03 00 00       	jmp    1eda <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1ae8:	8b 45 08             	mov    0x8(%ebp),%eax
    1aeb:	8b 40 10             	mov    0x10(%eax),%eax
    1aee:	85 c0                	test   %eax,%eax
    1af0:	7e 10                	jle    1b02 <APGridPaint+0x27d>
    1af2:	8b 45 08             	mov    0x8(%ebp),%eax
    1af5:	8b 50 14             	mov    0x14(%eax),%edx
    1af8:	8b 45 08             	mov    0x8(%ebp),%eax
    1afb:	8b 40 10             	mov    0x10(%eax),%eax
    1afe:	39 c2                	cmp    %eax,%edx
    1b00:	7c 17                	jl     1b19 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1b02:	83 ec 08             	sub    $0x8,%esp
    1b05:	68 6e 23 00 00       	push   $0x236e
    1b0a:	6a 01                	push   $0x1
    1b0c:	e8 a2 ea ff ff       	call   5b3 <printf>
    1b11:	83 c4 10             	add    $0x10,%esp
        return;
    1b14:	e9 c1 03 00 00       	jmp    1eda <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1b19:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1c:	8b 40 14             	mov    0x14(%eax),%eax
    1b1f:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1b25:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1b28:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1b2b:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1b2e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1b35:	e9 96 03 00 00       	jmp    1ed0 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1b3a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1b41:	e9 7c 03 00 00       	jmp    1ec2 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1b46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b49:	c1 e0 04             	shl    $0x4,%eax
    1b4c:	89 c2                	mov    %eax,%edx
    1b4e:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b51:	01 c2                	add    %eax,%edx
    1b53:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b56:	01 d0                	add    %edx,%eax
    1b58:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1b5b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b5e:	8b 40 0c             	mov    0xc(%eax),%eax
    1b61:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1b64:	c1 e2 02             	shl    $0x2,%edx
    1b67:	01 d0                	add    %edx,%eax
    1b69:	8b 00                	mov    (%eax),%eax
    1b6b:	83 f8 07             	cmp    $0x7,%eax
    1b6e:	0f 87 49 03 00 00    	ja     1ebd <APGridPaint+0x638>
    1b74:	8b 04 85 84 23 00 00 	mov    0x2384(,%eax,4),%eax
    1b7b:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b7d:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1b80:	6a 0c                	push   $0xc
    1b82:	6a 0c                	push   $0xc
    1b84:	6a 0c                	push   $0xc
    1b86:	50                   	push   %eax
    1b87:	e8 46 f9 ff ff       	call   14d2 <RGB>
    1b8c:	83 c4 0c             	add    $0xc,%esp
    1b8f:	8b 1d 6c 2b 00 00    	mov    0x2b6c,%ebx
    1b95:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b98:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b9b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b9e:	6b c0 32             	imul   $0x32,%eax,%eax
    1ba1:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ba4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba7:	8d 78 34             	lea    0x34(%eax),%edi
    1baa:	83 ec 0c             	sub    $0xc,%esp
    1bad:	83 ec 04             	sub    $0x4,%esp
    1bb0:	89 e0                	mov    %esp,%eax
    1bb2:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1bb6:	66 89 30             	mov    %si,(%eax)
    1bb9:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1bbd:	88 50 02             	mov    %dl,0x2(%eax)
    1bc0:	6a 32                	push   $0x32
    1bc2:	6a 32                	push   $0x32
    1bc4:	6a 00                	push   $0x0
    1bc6:	6a 00                	push   $0x0
    1bc8:	53                   	push   %ebx
    1bc9:	51                   	push   %ecx
    1bca:	ff 75 94             	pushl  -0x6c(%ebp)
    1bcd:	57                   	push   %edi
    1bce:	e8 5b f7 ff ff       	call   132e <APDcCopy>
    1bd3:	83 c4 30             	add    $0x30,%esp
                    break;
    1bd6:	e9 e3 02 00 00       	jmp    1ebe <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1bdb:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bde:	6a 69                	push   $0x69
    1be0:	6a 69                	push   $0x69
    1be2:	6a 69                	push   $0x69
    1be4:	50                   	push   %eax
    1be5:	e8 e8 f8 ff ff       	call   14d2 <RGB>
    1bea:	83 c4 0c             	add    $0xc,%esp
    1bed:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1bf1:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1bf5:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1bf9:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1bfc:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1c03:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c06:	6a 69                	push   $0x69
    1c08:	6a 69                	push   $0x69
    1c0a:	6a 69                	push   $0x69
    1c0c:	50                   	push   %eax
    1c0d:	e8 c0 f8 ff ff       	call   14d2 <RGB>
    1c12:	83 c4 0c             	add    $0xc,%esp
    1c15:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1c19:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1c1d:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1c21:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1c24:	8b 45 08             	mov    0x8(%ebp),%eax
    1c27:	8d 50 34             	lea    0x34(%eax),%edx
    1c2a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c2d:	ff 75 bc             	pushl  -0x44(%ebp)
    1c30:	ff 75 b8             	pushl  -0x48(%ebp)
    1c33:	52                   	push   %edx
    1c34:	50                   	push   %eax
    1c35:	e8 ce f0 ff ff       	call   d08 <APSetPen>
    1c3a:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1c3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c40:	8d 58 34             	lea    0x34(%eax),%ebx
    1c43:	8d 55 98             	lea    -0x68(%ebp),%edx
    1c46:	83 ec 04             	sub    $0x4,%esp
    1c49:	83 ec 04             	sub    $0x4,%esp
    1c4c:	89 e0                	mov    %esp,%eax
    1c4e:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1c52:	66 89 08             	mov    %cx,(%eax)
    1c55:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1c59:	88 48 02             	mov    %cl,0x2(%eax)
    1c5c:	53                   	push   %ebx
    1c5d:	52                   	push   %edx
    1c5e:	e8 de f0 ff ff       	call   d41 <APSetBrush>
    1c63:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1c66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c69:	6b d0 32             	imul   $0x32,%eax,%edx
    1c6c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c6f:	6b c0 32             	imul   $0x32,%eax,%eax
    1c72:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c75:	83 c1 34             	add    $0x34,%ecx
    1c78:	83 ec 0c             	sub    $0xc,%esp
    1c7b:	6a 32                	push   $0x32
    1c7d:	6a 32                	push   $0x32
    1c7f:	52                   	push   %edx
    1c80:	50                   	push   %eax
    1c81:	51                   	push   %ecx
    1c82:	e8 a2 f4 ff ff       	call   1129 <APDrawRect>
    1c87:	83 c4 20             	add    $0x20,%esp
                    break;
    1c8a:	e9 2f 02 00 00       	jmp    1ebe <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c8f:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1c92:	6a 0c                	push   $0xc
    1c94:	6a 0c                	push   $0xc
    1c96:	6a 0c                	push   $0xc
    1c98:	50                   	push   %eax
    1c99:	e8 34 f8 ff ff       	call   14d2 <RGB>
    1c9e:	83 c4 0c             	add    $0xc,%esp
    1ca1:	8b 1d ac 2b 00 00    	mov    0x2bac,%ebx
    1ca7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1caa:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cad:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cb0:	6b c0 32             	imul   $0x32,%eax,%eax
    1cb3:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cb6:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb9:	8d 78 34             	lea    0x34(%eax),%edi
    1cbc:	83 ec 0c             	sub    $0xc,%esp
    1cbf:	83 ec 04             	sub    $0x4,%esp
    1cc2:	89 e0                	mov    %esp,%eax
    1cc4:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1cc8:	66 89 30             	mov    %si,(%eax)
    1ccb:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1ccf:	88 50 02             	mov    %dl,0x2(%eax)
    1cd2:	6a 32                	push   $0x32
    1cd4:	6a 32                	push   $0x32
    1cd6:	6a 00                	push   $0x0
    1cd8:	6a 00                	push   $0x0
    1cda:	53                   	push   %ebx
    1cdb:	51                   	push   %ecx
    1cdc:	ff 75 94             	pushl  -0x6c(%ebp)
    1cdf:	57                   	push   %edi
    1ce0:	e8 49 f6 ff ff       	call   132e <APDcCopy>
    1ce5:	83 c4 30             	add    $0x30,%esp
                    break;
    1ce8:	e9 d1 01 00 00       	jmp    1ebe <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ced:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1cf0:	6a 0c                	push   $0xc
    1cf2:	6a 0c                	push   $0xc
    1cf4:	6a 0c                	push   $0xc
    1cf6:	50                   	push   %eax
    1cf7:	e8 d6 f7 ff ff       	call   14d2 <RGB>
    1cfc:	83 c4 0c             	add    $0xc,%esp
    1cff:	8b 1d 8c 2b 00 00    	mov    0x2b8c,%ebx
    1d05:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d08:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d0b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d0e:	6b c0 32             	imul   $0x32,%eax,%eax
    1d11:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d14:	8b 45 08             	mov    0x8(%ebp),%eax
    1d17:	8d 78 34             	lea    0x34(%eax),%edi
    1d1a:	83 ec 0c             	sub    $0xc,%esp
    1d1d:	83 ec 04             	sub    $0x4,%esp
    1d20:	89 e0                	mov    %esp,%eax
    1d22:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1d26:	66 89 30             	mov    %si,(%eax)
    1d29:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1d2d:	88 50 02             	mov    %dl,0x2(%eax)
    1d30:	6a 32                	push   $0x32
    1d32:	6a 32                	push   $0x32
    1d34:	6a 00                	push   $0x0
    1d36:	6a 00                	push   $0x0
    1d38:	53                   	push   %ebx
    1d39:	51                   	push   %ecx
    1d3a:	ff 75 94             	pushl  -0x6c(%ebp)
    1d3d:	57                   	push   %edi
    1d3e:	e8 eb f5 ff ff       	call   132e <APDcCopy>
    1d43:	83 c4 30             	add    $0x30,%esp
                    break;
    1d46:	e9 73 01 00 00       	jmp    1ebe <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d4b:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1d4e:	6a 0c                	push   $0xc
    1d50:	6a 0c                	push   $0xc
    1d52:	6a 0c                	push   $0xc
    1d54:	50                   	push   %eax
    1d55:	e8 78 f7 ff ff       	call   14d2 <RGB>
    1d5a:	83 c4 0c             	add    $0xc,%esp
    1d5d:	8b 1d 70 2b 00 00    	mov    0x2b70,%ebx
    1d63:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d66:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d69:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d6c:	6b c0 32             	imul   $0x32,%eax,%eax
    1d6f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d72:	8b 45 08             	mov    0x8(%ebp),%eax
    1d75:	8d 78 34             	lea    0x34(%eax),%edi
    1d78:	83 ec 0c             	sub    $0xc,%esp
    1d7b:	83 ec 04             	sub    $0x4,%esp
    1d7e:	89 e0                	mov    %esp,%eax
    1d80:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1d84:	66 89 30             	mov    %si,(%eax)
    1d87:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1d8b:	88 50 02             	mov    %dl,0x2(%eax)
    1d8e:	6a 32                	push   $0x32
    1d90:	6a 32                	push   $0x32
    1d92:	6a 00                	push   $0x0
    1d94:	6a 00                	push   $0x0
    1d96:	53                   	push   %ebx
    1d97:	51                   	push   %ecx
    1d98:	ff 75 94             	pushl  -0x6c(%ebp)
    1d9b:	57                   	push   %edi
    1d9c:	e8 8d f5 ff ff       	call   132e <APDcCopy>
    1da1:	83 c4 30             	add    $0x30,%esp
                    break;
    1da4:	e9 15 01 00 00       	jmp    1ebe <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1da9:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1dac:	6a 0c                	push   $0xc
    1dae:	6a 0c                	push   $0xc
    1db0:	6a 0c                	push   $0xc
    1db2:	50                   	push   %eax
    1db3:	e8 1a f7 ff ff       	call   14d2 <RGB>
    1db8:	83 c4 0c             	add    $0xc,%esp
    1dbb:	8b 1d a8 2b 00 00    	mov    0x2ba8,%ebx
    1dc1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dc4:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dc7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dca:	6b c0 32             	imul   $0x32,%eax,%eax
    1dcd:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dd0:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd3:	8d 78 34             	lea    0x34(%eax),%edi
    1dd6:	83 ec 0c             	sub    $0xc,%esp
    1dd9:	83 ec 04             	sub    $0x4,%esp
    1ddc:	89 e0                	mov    %esp,%eax
    1dde:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1de2:	66 89 30             	mov    %si,(%eax)
    1de5:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1de9:	88 50 02             	mov    %dl,0x2(%eax)
    1dec:	6a 32                	push   $0x32
    1dee:	6a 32                	push   $0x32
    1df0:	6a 00                	push   $0x0
    1df2:	6a 00                	push   $0x0
    1df4:	53                   	push   %ebx
    1df5:	51                   	push   %ecx
    1df6:	ff 75 94             	pushl  -0x6c(%ebp)
    1df9:	57                   	push   %edi
    1dfa:	e8 2f f5 ff ff       	call   132e <APDcCopy>
    1dff:	83 c4 30             	add    $0x30,%esp
                    break;
    1e02:	e9 b7 00 00 00       	jmp    1ebe <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e07:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1e0a:	6a 0c                	push   $0xc
    1e0c:	6a 0c                	push   $0xc
    1e0e:	6a 0c                	push   $0xc
    1e10:	50                   	push   %eax
    1e11:	e8 bc f6 ff ff       	call   14d2 <RGB>
    1e16:	83 c4 0c             	add    $0xc,%esp
    1e19:	8b 1d 40 2b 00 00    	mov    0x2b40,%ebx
    1e1f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e22:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e25:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e28:	6b c0 32             	imul   $0x32,%eax,%eax
    1e2b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e31:	8d 78 34             	lea    0x34(%eax),%edi
    1e34:	83 ec 0c             	sub    $0xc,%esp
    1e37:	83 ec 04             	sub    $0x4,%esp
    1e3a:	89 e0                	mov    %esp,%eax
    1e3c:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1e40:	66 89 30             	mov    %si,(%eax)
    1e43:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1e47:	88 50 02             	mov    %dl,0x2(%eax)
    1e4a:	6a 32                	push   $0x32
    1e4c:	6a 32                	push   $0x32
    1e4e:	6a 00                	push   $0x0
    1e50:	6a 00                	push   $0x0
    1e52:	53                   	push   %ebx
    1e53:	51                   	push   %ecx
    1e54:	ff 75 94             	pushl  -0x6c(%ebp)
    1e57:	57                   	push   %edi
    1e58:	e8 d1 f4 ff ff       	call   132e <APDcCopy>
    1e5d:	83 c4 30             	add    $0x30,%esp
                    break;
    1e60:	eb 5c                	jmp    1ebe <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e62:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1e65:	6a 0c                	push   $0xc
    1e67:	6a 0c                	push   $0xc
    1e69:	6a 0c                	push   $0xc
    1e6b:	50                   	push   %eax
    1e6c:	e8 61 f6 ff ff       	call   14d2 <RGB>
    1e71:	83 c4 0c             	add    $0xc,%esp
    1e74:	8b 1d 5c 2b 00 00    	mov    0x2b5c,%ebx
    1e7a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e7d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e80:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e83:	6b c0 32             	imul   $0x32,%eax,%eax
    1e86:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e89:	8b 45 08             	mov    0x8(%ebp),%eax
    1e8c:	8d 78 34             	lea    0x34(%eax),%edi
    1e8f:	83 ec 0c             	sub    $0xc,%esp
    1e92:	83 ec 04             	sub    $0x4,%esp
    1e95:	89 e0                	mov    %esp,%eax
    1e97:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1e9b:	66 89 30             	mov    %si,(%eax)
    1e9e:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1ea2:	88 50 02             	mov    %dl,0x2(%eax)
    1ea5:	6a 32                	push   $0x32
    1ea7:	6a 32                	push   $0x32
    1ea9:	6a 00                	push   $0x0
    1eab:	6a 00                	push   $0x0
    1ead:	53                   	push   %ebx
    1eae:	51                   	push   %ecx
    1eaf:	ff 75 94             	pushl  -0x6c(%ebp)
    1eb2:	57                   	push   %edi
    1eb3:	e8 76 f4 ff ff       	call   132e <APDcCopy>
    1eb8:	83 c4 30             	add    $0x30,%esp
                    break;
    1ebb:	eb 01                	jmp    1ebe <APGridPaint+0x639>
                default: break;
    1ebd:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1ebe:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1ec2:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1ec6:	0f 8e 7a fc ff ff    	jle    1b46 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1ecc:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1ed0:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1ed4:	0f 8e 60 fc ff ff    	jle    1b3a <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1eda:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1edd:	5b                   	pop    %ebx
    1ede:	5e                   	pop    %esi
    1edf:	5f                   	pop    %edi
    1ee0:	5d                   	pop    %ebp
    1ee1:	c3                   	ret    

00001ee2 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1ee2:	55                   	push   %ebp
    1ee3:	89 e5                	mov    %esp,%ebp
    1ee5:	53                   	push   %ebx
    1ee6:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1ee9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1ef0:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1ef4:	74 17                	je     1f0d <sprintint+0x2b>
    1ef6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1efa:	79 11                	jns    1f0d <sprintint+0x2b>
        neg = 1;
    1efc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1f03:	8b 45 10             	mov    0x10(%ebp),%eax
    1f06:	f7 d8                	neg    %eax
    1f08:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f0b:	eb 06                	jmp    1f13 <sprintint+0x31>
    } else {
        x = xx;
    1f0d:	8b 45 10             	mov    0x10(%ebp),%eax
    1f10:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1f13:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1f1a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1f1d:	8d 41 01             	lea    0x1(%ecx),%eax
    1f20:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1f23:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f26:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f29:	ba 00 00 00 00       	mov    $0x0,%edx
    1f2e:	f7 f3                	div    %ebx
    1f30:	89 d0                	mov    %edx,%eax
    1f32:	0f b6 80 f0 28 00 00 	movzbl 0x28f0(%eax),%eax
    1f39:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1f3d:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f40:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f43:	ba 00 00 00 00       	mov    $0x0,%edx
    1f48:	f7 f3                	div    %ebx
    1f4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f4d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f51:	75 c7                	jne    1f1a <sprintint+0x38>
    if(neg)
    1f53:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f57:	74 0e                	je     1f67 <sprintint+0x85>
        buf[i++] = '-';
    1f59:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f5c:	8d 50 01             	lea    0x1(%eax),%edx
    1f5f:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1f62:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1f67:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f6a:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1f6d:	eb 1b                	jmp    1f8a <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1f6f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f72:	8b 00                	mov    (%eax),%eax
    1f74:	8d 48 01             	lea    0x1(%eax),%ecx
    1f77:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f7a:	89 0a                	mov    %ecx,(%edx)
    1f7c:	89 c2                	mov    %eax,%edx
    1f7e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f81:	01 d0                	add    %edx,%eax
    1f83:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1f86:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1f8a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1f8e:	7f df                	jg     1f6f <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1f90:	eb 21                	jmp    1fb3 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1f92:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f95:	8b 00                	mov    (%eax),%eax
    1f97:	8d 48 01             	lea    0x1(%eax),%ecx
    1f9a:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f9d:	89 0a                	mov    %ecx,(%edx)
    1f9f:	89 c2                	mov    %eax,%edx
    1fa1:	8b 45 08             	mov    0x8(%ebp),%eax
    1fa4:	01 c2                	add    %eax,%edx
    1fa6:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1fa9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fac:	01 c8                	add    %ecx,%eax
    1fae:	0f b6 00             	movzbl (%eax),%eax
    1fb1:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fb3:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1fb7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1fbb:	79 d5                	jns    1f92 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1fbd:	90                   	nop
    1fbe:	83 c4 20             	add    $0x20,%esp
    1fc1:	5b                   	pop    %ebx
    1fc2:	5d                   	pop    %ebp
    1fc3:	c3                   	ret    

00001fc4 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1fc4:	55                   	push   %ebp
    1fc5:	89 e5                	mov    %esp,%ebp
    1fc7:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1fca:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1fd1:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1fd8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1fdf:	8d 45 0c             	lea    0xc(%ebp),%eax
    1fe2:	83 c0 04             	add    $0x4,%eax
    1fe5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1fe8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1fef:	e9 d9 01 00 00       	jmp    21cd <sprintf+0x209>
        c = fmt[i] & 0xff;
    1ff4:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ff7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ffa:	01 d0                	add    %edx,%eax
    1ffc:	0f b6 00             	movzbl (%eax),%eax
    1fff:	0f be c0             	movsbl %al,%eax
    2002:	25 ff 00 00 00       	and    $0xff,%eax
    2007:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    200a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    200e:	75 2c                	jne    203c <sprintf+0x78>
            if(c == '%'){
    2010:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2014:	75 0c                	jne    2022 <sprintf+0x5e>
                state = '%';
    2016:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    201d:	e9 a7 01 00 00       	jmp    21c9 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2022:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2025:	8d 50 01             	lea    0x1(%eax),%edx
    2028:	89 55 c8             	mov    %edx,-0x38(%ebp)
    202b:	89 c2                	mov    %eax,%edx
    202d:	8b 45 08             	mov    0x8(%ebp),%eax
    2030:	01 d0                	add    %edx,%eax
    2032:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2035:	88 10                	mov    %dl,(%eax)
    2037:	e9 8d 01 00 00       	jmp    21c9 <sprintf+0x205>
            }
        } else if(state == '%'){
    203c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2040:	0f 85 83 01 00 00    	jne    21c9 <sprintf+0x205>
            if(c == 'd'){
    2046:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    204a:	75 4c                	jne    2098 <sprintf+0xd4>
                buf[bi] = '\0';
    204c:	8d 55 ce             	lea    -0x32(%ebp),%edx
    204f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2052:	01 d0                	add    %edx,%eax
    2054:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2057:	83 ec 0c             	sub    $0xc,%esp
    205a:	8d 45 ce             	lea    -0x32(%ebp),%eax
    205d:	50                   	push   %eax
    205e:	e8 1f e3 ff ff       	call   382 <atoi>
    2063:	83 c4 10             	add    $0x10,%esp
    2066:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2069:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2070:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2073:	8b 00                	mov    (%eax),%eax
    2075:	83 ec 08             	sub    $0x8,%esp
    2078:	ff 75 d8             	pushl  -0x28(%ebp)
    207b:	6a 01                	push   $0x1
    207d:	6a 0a                	push   $0xa
    207f:	50                   	push   %eax
    2080:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2083:	50                   	push   %eax
    2084:	ff 75 08             	pushl  0x8(%ebp)
    2087:	e8 56 fe ff ff       	call   1ee2 <sprintint>
    208c:	83 c4 20             	add    $0x20,%esp
                ap++;
    208f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2093:	e9 2a 01 00 00       	jmp    21c2 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2098:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    209c:	74 06                	je     20a4 <sprintf+0xe0>
    209e:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    20a2:	75 4c                	jne    20f0 <sprintf+0x12c>
                buf[bi] = '\0';
    20a4:	8d 55 ce             	lea    -0x32(%ebp),%edx
    20a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20aa:	01 d0                	add    %edx,%eax
    20ac:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    20af:	83 ec 0c             	sub    $0xc,%esp
    20b2:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20b5:	50                   	push   %eax
    20b6:	e8 c7 e2 ff ff       	call   382 <atoi>
    20bb:	83 c4 10             	add    $0x10,%esp
    20be:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    20c1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    20c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20cb:	8b 00                	mov    (%eax),%eax
    20cd:	83 ec 08             	sub    $0x8,%esp
    20d0:	ff 75 dc             	pushl  -0x24(%ebp)
    20d3:	6a 00                	push   $0x0
    20d5:	6a 10                	push   $0x10
    20d7:	50                   	push   %eax
    20d8:	8d 45 c8             	lea    -0x38(%ebp),%eax
    20db:	50                   	push   %eax
    20dc:	ff 75 08             	pushl  0x8(%ebp)
    20df:	e8 fe fd ff ff       	call   1ee2 <sprintint>
    20e4:	83 c4 20             	add    $0x20,%esp
                ap++;
    20e7:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    20eb:	e9 d2 00 00 00       	jmp    21c2 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    20f0:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    20f4:	75 46                	jne    213c <sprintf+0x178>
                s = (char*)*ap;
    20f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20f9:	8b 00                	mov    (%eax),%eax
    20fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    20fe:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2102:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2106:	75 25                	jne    212d <sprintf+0x169>
                    s = "(null)";
    2108:	c7 45 f4 a4 23 00 00 	movl   $0x23a4,-0xc(%ebp)
                while(*s != 0){
    210f:	eb 1c                	jmp    212d <sprintf+0x169>
                    dst[j++] = *s;
    2111:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2114:	8d 50 01             	lea    0x1(%eax),%edx
    2117:	89 55 c8             	mov    %edx,-0x38(%ebp)
    211a:	89 c2                	mov    %eax,%edx
    211c:	8b 45 08             	mov    0x8(%ebp),%eax
    211f:	01 c2                	add    %eax,%edx
    2121:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2124:	0f b6 00             	movzbl (%eax),%eax
    2127:	88 02                	mov    %al,(%edx)
                    s++;
    2129:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    212d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2130:	0f b6 00             	movzbl (%eax),%eax
    2133:	84 c0                	test   %al,%al
    2135:	75 da                	jne    2111 <sprintf+0x14d>
    2137:	e9 86 00 00 00       	jmp    21c2 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    213c:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2140:	75 1d                	jne    215f <sprintf+0x19b>
                dst[j++] = *ap;
    2142:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2145:	8d 50 01             	lea    0x1(%eax),%edx
    2148:	89 55 c8             	mov    %edx,-0x38(%ebp)
    214b:	89 c2                	mov    %eax,%edx
    214d:	8b 45 08             	mov    0x8(%ebp),%eax
    2150:	01 c2                	add    %eax,%edx
    2152:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2155:	8b 00                	mov    (%eax),%eax
    2157:	88 02                	mov    %al,(%edx)
                ap++;
    2159:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    215d:	eb 63                	jmp    21c2 <sprintf+0x1fe>
            } else if(c == '%'){
    215f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2163:	75 17                	jne    217c <sprintf+0x1b8>
                dst[j++] = c;
    2165:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2168:	8d 50 01             	lea    0x1(%eax),%edx
    216b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    216e:	89 c2                	mov    %eax,%edx
    2170:	8b 45 08             	mov    0x8(%ebp),%eax
    2173:	01 d0                	add    %edx,%eax
    2175:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2178:	88 10                	mov    %dl,(%eax)
    217a:	eb 46                	jmp    21c2 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    217c:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2180:	7e 18                	jle    219a <sprintf+0x1d6>
    2182:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2186:	7f 12                	jg     219a <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2188:	8b 45 f0             	mov    -0x10(%ebp),%eax
    218b:	8d 50 01             	lea    0x1(%eax),%edx
    218e:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2191:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2194:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2198:	eb 2f                	jmp    21c9 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    219a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    219d:	8d 50 01             	lea    0x1(%eax),%edx
    21a0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21a3:	89 c2                	mov    %eax,%edx
    21a5:	8b 45 08             	mov    0x8(%ebp),%eax
    21a8:	01 d0                	add    %edx,%eax
    21aa:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    21ad:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21b0:	8d 50 01             	lea    0x1(%eax),%edx
    21b3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21b6:	89 c2                	mov    %eax,%edx
    21b8:	8b 45 08             	mov    0x8(%ebp),%eax
    21bb:	01 d0                	add    %edx,%eax
    21bd:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21c0:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    21c2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    21c9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    21cd:	8b 55 0c             	mov    0xc(%ebp),%edx
    21d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    21d3:	01 d0                	add    %edx,%eax
    21d5:	0f b6 00             	movzbl (%eax),%eax
    21d8:	84 c0                	test   %al,%al
    21da:	0f 85 14 fe ff ff    	jne    1ff4 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    21e0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21e3:	8d 50 01             	lea    0x1(%eax),%edx
    21e6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21e9:	89 c2                	mov    %eax,%edx
    21eb:	8b 45 08             	mov    0x8(%ebp),%eax
    21ee:	01 d0                	add    %edx,%eax
    21f0:	c6 00 00             	movb   $0x0,(%eax)
}
    21f3:	90                   	nop
    21f4:	c9                   	leave  
    21f5:	c3                   	ret    
