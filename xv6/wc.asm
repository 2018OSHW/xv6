
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
      32:	05 00 2b 00 00       	add    $0x2b00,%eax
      37:	0f b6 00             	movzbl (%eax),%eax
      3a:	3c 0a                	cmp    $0xa,%al
      3c:	75 04                	jne    42 <wc+0x42>
        l++;
      3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
      42:	8b 45 f4             	mov    -0xc(%ebp),%eax
      45:	05 00 2b 00 00       	add    $0x2b00,%eax
      4a:	0f b6 00             	movzbl (%eax),%eax
      4d:	0f be c0             	movsbl %al,%eax
      50:	83 ec 08             	sub    $0x8,%esp
      53:	50                   	push   %eax
      54:	68 84 23 00 00       	push   $0x2384
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
      93:	68 00 2b 00 00       	push   $0x2b00
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
      b9:	68 8a 23 00 00       	push   $0x238a
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
      dc:	68 9a 23 00 00       	push   $0x239a
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
     10a:	68 a7 23 00 00       	push   $0x23a7
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
     167:	68 a8 23 00 00       	push   $0x23a8
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
     55f:	0f b6 80 b0 2a 00 00 	movzbl 0x2ab0(%eax),%eax
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
     69d:	c7 45 f4 bc 23 00 00 	movl   $0x23bc,-0xc(%ebp)
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
     763:	a1 e8 2a 00 00       	mov    0x2ae8,%eax
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
     82e:	a3 e8 2a 00 00       	mov    %eax,0x2ae8
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
     88f:	a1 e8 2a 00 00       	mov    0x2ae8,%eax
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
     8ab:	a1 e8 2a 00 00       	mov    0x2ae8,%eax
     8b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8b7:	75 23                	jne    8dc <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     8b9:	c7 45 f0 e0 2a 00 00 	movl   $0x2ae0,-0x10(%ebp)
     8c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8c3:	a3 e8 2a 00 00       	mov    %eax,0x2ae8
     8c8:	a1 e8 2a 00 00       	mov    0x2ae8,%eax
     8cd:	a3 e0 2a 00 00       	mov    %eax,0x2ae0
    base.s.size = 0;
     8d2:	c7 05 e4 2a 00 00 00 	movl   $0x0,0x2ae4
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
     92f:	a3 e8 2a 00 00       	mov    %eax,0x2ae8
      return (void*)(p + 1);
     934:	8b 45 f4             	mov    -0xc(%ebp),%eax
     937:	83 c0 08             	add    $0x8,%eax
     93a:	eb 3b                	jmp    977 <malloc+0xe1>
    }
    if(p == freep)
     93c:	a1 e8 2a 00 00       	mov    0x2ae8,%eax
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
     a82:	68 c3 23 00 00       	push   $0x23c3
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

00000d93 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     d93:	55                   	push   %ebp
     d94:	89 e5                	mov    %esp,%ebp
     d96:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     d99:	8b 45 08             	mov    0x8(%ebp),%eax
     d9c:	8b 40 0c             	mov    0xc(%eax),%eax
     d9f:	89 c2                	mov    %eax,%edx
     da1:	c1 ea 1f             	shr    $0x1f,%edx
     da4:	01 d0                	add    %edx,%eax
     da6:	d1 f8                	sar    %eax
     da8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     dab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dae:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     db2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     db5:	8b 45 10             	mov    0x10(%ebp),%eax
     db8:	2b 45 f4             	sub    -0xc(%ebp),%eax
     dbb:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     dbe:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     dc2:	0f 89 98 00 00 00    	jns    e60 <APDrawPoint+0xcd>
        i = 0;
     dc8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     dcf:	e9 8c 00 00 00       	jmp    e60 <APDrawPoint+0xcd>
    {
        j = x - off;
     dd4:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd7:	2b 45 f4             	sub    -0xc(%ebp),%eax
     dda:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     ddd:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     de1:	79 69                	jns    e4c <APDrawPoint+0xb9>
            j = 0;
     de3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     dea:	eb 60                	jmp    e4c <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     dec:	ff 75 fc             	pushl  -0x4(%ebp)
     def:	ff 75 f8             	pushl  -0x8(%ebp)
     df2:	ff 75 08             	pushl  0x8(%ebp)
     df5:	e8 fd fb ff ff       	call   9f7 <APGetIndex>
     dfa:	83 c4 0c             	add    $0xc,%esp
     dfd:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     e00:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     e04:	74 55                	je     e5b <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     e06:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     e0a:	74 67                	je     e73 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     e0c:	ff 75 10             	pushl  0x10(%ebp)
     e0f:	ff 75 0c             	pushl  0xc(%ebp)
     e12:	ff 75 fc             	pushl  -0x4(%ebp)
     e15:	ff 75 f8             	pushl  -0x8(%ebp)
     e18:	e8 a1 fb ff ff       	call   9be <distance_2>
     e1d:	83 c4 10             	add    $0x10,%esp
     e20:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     e23:	7f 23                	jg     e48 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     e25:	8b 45 08             	mov    0x8(%ebp),%eax
     e28:	8b 48 18             	mov    0x18(%eax),%ecx
     e2b:	8b 55 ec             	mov    -0x14(%ebp),%edx
     e2e:	89 d0                	mov    %edx,%eax
     e30:	01 c0                	add    %eax,%eax
     e32:	01 d0                	add    %edx,%eax
     e34:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     e37:	8b 45 08             	mov    0x8(%ebp),%eax
     e3a:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     e3e:	66 89 0a             	mov    %cx,(%edx)
     e41:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     e45:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     e48:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     e4c:	8b 55 0c             	mov    0xc(%ebp),%edx
     e4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e52:	01 d0                	add    %edx,%eax
     e54:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     e57:	7d 93                	jge    dec <APDrawPoint+0x59>
     e59:	eb 01                	jmp    e5c <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     e5b:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     e5c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     e60:	8b 55 10             	mov    0x10(%ebp),%edx
     e63:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e66:	01 d0                	add    %edx,%eax
     e68:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e6b:	0f 8d 63 ff ff ff    	jge    dd4 <APDrawPoint+0x41>
     e71:	eb 01                	jmp    e74 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     e73:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     e74:	c9                   	leave  
     e75:	c3                   	ret    

00000e76 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     e76:	55                   	push   %ebp
     e77:	89 e5                	mov    %esp,%ebp
     e79:	53                   	push   %ebx
     e7a:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     e7d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e80:	3b 45 14             	cmp    0x14(%ebp),%eax
     e83:	0f 85 80 00 00 00    	jne    f09 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     e89:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e8d:	0f 88 9d 02 00 00    	js     1130 <APDrawLine+0x2ba>
     e93:	8b 45 08             	mov    0x8(%ebp),%eax
     e96:	8b 00                	mov    (%eax),%eax
     e98:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e9b:	0f 8e 8f 02 00 00    	jle    1130 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     ea1:	8b 45 10             	mov    0x10(%ebp),%eax
     ea4:	3b 45 18             	cmp    0x18(%ebp),%eax
     ea7:	7e 12                	jle    ebb <APDrawLine+0x45>
        {
            int tmp = y2;
     ea9:	8b 45 18             	mov    0x18(%ebp),%eax
     eac:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     eaf:	8b 45 10             	mov    0x10(%ebp),%eax
     eb2:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     eb5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     eb8:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     ebb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     ebf:	79 07                	jns    ec8 <APDrawLine+0x52>
     ec1:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     ec8:	8b 45 08             	mov    0x8(%ebp),%eax
     ecb:	8b 40 04             	mov    0x4(%eax),%eax
     ece:	3b 45 18             	cmp    0x18(%ebp),%eax
     ed1:	7d 0c                	jge    edf <APDrawLine+0x69>
     ed3:	8b 45 08             	mov    0x8(%ebp),%eax
     ed6:	8b 40 04             	mov    0x4(%eax),%eax
     ed9:	83 e8 01             	sub    $0x1,%eax
     edc:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     edf:	8b 45 10             	mov    0x10(%ebp),%eax
     ee2:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ee5:	eb 15                	jmp    efc <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     ee7:	ff 75 f4             	pushl  -0xc(%ebp)
     eea:	ff 75 0c             	pushl  0xc(%ebp)
     eed:	ff 75 08             	pushl  0x8(%ebp)
     ef0:	e8 9e fe ff ff       	call   d93 <APDrawPoint>
     ef5:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     ef8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     efc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eff:	3b 45 18             	cmp    0x18(%ebp),%eax
     f02:	7e e3                	jle    ee7 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     f04:	e9 2b 02 00 00       	jmp    1134 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     f09:	8b 45 10             	mov    0x10(%ebp),%eax
     f0c:	3b 45 18             	cmp    0x18(%ebp),%eax
     f0f:	75 7f                	jne    f90 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     f11:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     f15:	0f 88 18 02 00 00    	js     1133 <APDrawLine+0x2bd>
     f1b:	8b 45 08             	mov    0x8(%ebp),%eax
     f1e:	8b 40 04             	mov    0x4(%eax),%eax
     f21:	3b 45 10             	cmp    0x10(%ebp),%eax
     f24:	0f 8e 09 02 00 00    	jle    1133 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     f2a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f2d:	3b 45 14             	cmp    0x14(%ebp),%eax
     f30:	7e 12                	jle    f44 <APDrawLine+0xce>
        {
            int tmp = x2;
     f32:	8b 45 14             	mov    0x14(%ebp),%eax
     f35:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     f38:	8b 45 0c             	mov    0xc(%ebp),%eax
     f3b:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     f3e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     f41:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     f44:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f48:	79 07                	jns    f51 <APDrawLine+0xdb>
     f4a:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     f51:	8b 45 08             	mov    0x8(%ebp),%eax
     f54:	8b 00                	mov    (%eax),%eax
     f56:	3b 45 14             	cmp    0x14(%ebp),%eax
     f59:	7d 0b                	jge    f66 <APDrawLine+0xf0>
     f5b:	8b 45 08             	mov    0x8(%ebp),%eax
     f5e:	8b 00                	mov    (%eax),%eax
     f60:	83 e8 01             	sub    $0x1,%eax
     f63:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     f66:	8b 45 0c             	mov    0xc(%ebp),%eax
     f69:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f6c:	eb 15                	jmp    f83 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     f6e:	ff 75 10             	pushl  0x10(%ebp)
     f71:	ff 75 f0             	pushl  -0x10(%ebp)
     f74:	ff 75 08             	pushl  0x8(%ebp)
     f77:	e8 17 fe ff ff       	call   d93 <APDrawPoint>
     f7c:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     f7f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f83:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f86:	3b 45 14             	cmp    0x14(%ebp),%eax
     f89:	7e e3                	jle    f6e <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     f8b:	e9 a4 01 00 00       	jmp    1134 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     f90:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f97:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     f9e:	8b 45 0c             	mov    0xc(%ebp),%eax
     fa1:	2b 45 14             	sub    0x14(%ebp),%eax
     fa4:	50                   	push   %eax
     fa5:	e8 3d fa ff ff       	call   9e7 <abs_int>
     faa:	83 c4 04             	add    $0x4,%esp
     fad:	89 c3                	mov    %eax,%ebx
     faf:	8b 45 10             	mov    0x10(%ebp),%eax
     fb2:	2b 45 18             	sub    0x18(%ebp),%eax
     fb5:	50                   	push   %eax
     fb6:	e8 2c fa ff ff       	call   9e7 <abs_int>
     fbb:	83 c4 04             	add    $0x4,%esp
     fbe:	39 c3                	cmp    %eax,%ebx
     fc0:	0f 8e b5 00 00 00    	jle    107b <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     fc6:	8b 45 10             	mov    0x10(%ebp),%eax
     fc9:	2b 45 18             	sub    0x18(%ebp),%eax
     fcc:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fcf:	db 45 b0             	fildl  -0x50(%ebp)
     fd2:	8b 45 0c             	mov    0xc(%ebp),%eax
     fd5:	2b 45 14             	sub    0x14(%ebp),%eax
     fd8:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fdb:	db 45 b0             	fildl  -0x50(%ebp)
     fde:	de f9                	fdivrp %st,%st(1)
     fe0:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     fe3:	8b 45 14             	mov    0x14(%ebp),%eax
     fe6:	3b 45 0c             	cmp    0xc(%ebp),%eax
     fe9:	7e 0e                	jle    ff9 <APDrawLine+0x183>
        {
            s = x1;
     feb:	8b 45 0c             	mov    0xc(%ebp),%eax
     fee:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     ff1:	8b 45 14             	mov    0x14(%ebp),%eax
     ff4:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ff7:	eb 0c                	jmp    1005 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ff9:	8b 45 14             	mov    0x14(%ebp),%eax
     ffc:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     fff:	8b 45 0c             	mov    0xc(%ebp),%eax
    1002:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1005:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1009:	79 07                	jns    1012 <APDrawLine+0x19c>
    100b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1012:	8b 45 08             	mov    0x8(%ebp),%eax
    1015:	8b 00                	mov    (%eax),%eax
    1017:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    101a:	7f 0b                	jg     1027 <APDrawLine+0x1b1>
    101c:	8b 45 08             	mov    0x8(%ebp),%eax
    101f:	8b 00                	mov    (%eax),%eax
    1021:	83 e8 01             	sub    $0x1,%eax
    1024:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1027:	8b 45 ec             	mov    -0x14(%ebp),%eax
    102a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    102d:	eb 3f                	jmp    106e <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    102f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1032:	2b 45 0c             	sub    0xc(%ebp),%eax
    1035:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1038:	db 45 b0             	fildl  -0x50(%ebp)
    103b:	dc 4d d0             	fmull  -0x30(%ebp)
    103e:	db 45 10             	fildl  0x10(%ebp)
    1041:	de c1                	faddp  %st,%st(1)
    1043:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1046:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    104a:	b4 0c                	mov    $0xc,%ah
    104c:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1050:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1053:	db 5d cc             	fistpl -0x34(%ebp)
    1056:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1059:	ff 75 cc             	pushl  -0x34(%ebp)
    105c:	ff 75 e4             	pushl  -0x1c(%ebp)
    105f:	ff 75 08             	pushl  0x8(%ebp)
    1062:	e8 2c fd ff ff       	call   d93 <APDrawPoint>
    1067:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    106a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    106e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1071:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1074:	7e b9                	jle    102f <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1076:	e9 b9 00 00 00       	jmp    1134 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    107b:	8b 45 0c             	mov    0xc(%ebp),%eax
    107e:	2b 45 14             	sub    0x14(%ebp),%eax
    1081:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1084:	db 45 b0             	fildl  -0x50(%ebp)
    1087:	8b 45 10             	mov    0x10(%ebp),%eax
    108a:	2b 45 18             	sub    0x18(%ebp),%eax
    108d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1090:	db 45 b0             	fildl  -0x50(%ebp)
    1093:	de f9                	fdivrp %st,%st(1)
    1095:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1098:	8b 45 10             	mov    0x10(%ebp),%eax
    109b:	3b 45 18             	cmp    0x18(%ebp),%eax
    109e:	7e 0e                	jle    10ae <APDrawLine+0x238>
    {
        s = y2;
    10a0:	8b 45 18             	mov    0x18(%ebp),%eax
    10a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    10a6:	8b 45 10             	mov    0x10(%ebp),%eax
    10a9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    10ac:	eb 0c                	jmp    10ba <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    10ae:	8b 45 10             	mov    0x10(%ebp),%eax
    10b1:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    10b4:	8b 45 18             	mov    0x18(%ebp),%eax
    10b7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    10ba:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10be:	79 07                	jns    10c7 <APDrawLine+0x251>
    10c0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    10c7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ca:	8b 40 04             	mov    0x4(%eax),%eax
    10cd:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10d0:	7f 0c                	jg     10de <APDrawLine+0x268>
    10d2:	8b 45 08             	mov    0x8(%ebp),%eax
    10d5:	8b 40 04             	mov    0x4(%eax),%eax
    10d8:	83 e8 01             	sub    $0x1,%eax
    10db:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    10de:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    10e4:	eb 3f                	jmp    1125 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    10e6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10e9:	2b 45 10             	sub    0x10(%ebp),%eax
    10ec:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10ef:	db 45 b0             	fildl  -0x50(%ebp)
    10f2:	dc 4d c0             	fmull  -0x40(%ebp)
    10f5:	db 45 0c             	fildl  0xc(%ebp)
    10f8:	de c1                	faddp  %st,%st(1)
    10fa:	d9 7d b6             	fnstcw -0x4a(%ebp)
    10fd:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1101:	b4 0c                	mov    $0xc,%ah
    1103:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1107:	d9 6d b4             	fldcw  -0x4c(%ebp)
    110a:	db 5d bc             	fistpl -0x44(%ebp)
    110d:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1110:	ff 75 e0             	pushl  -0x20(%ebp)
    1113:	ff 75 bc             	pushl  -0x44(%ebp)
    1116:	ff 75 08             	pushl  0x8(%ebp)
    1119:	e8 75 fc ff ff       	call   d93 <APDrawPoint>
    111e:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1121:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1125:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1128:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    112b:	7e b9                	jle    10e6 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    112d:	90                   	nop
    112e:	eb 04                	jmp    1134 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1130:	90                   	nop
    1131:	eb 01                	jmp    1134 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1133:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1134:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1137:	c9                   	leave  
    1138:	c3                   	ret    

00001139 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1139:	55                   	push   %ebp
    113a:	89 e5                	mov    %esp,%ebp
    113c:	53                   	push   %ebx
    113d:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1140:	8b 55 10             	mov    0x10(%ebp),%edx
    1143:	8b 45 18             	mov    0x18(%ebp),%eax
    1146:	01 d0                	add    %edx,%eax
    1148:	83 e8 01             	sub    $0x1,%eax
    114b:	83 ec 04             	sub    $0x4,%esp
    114e:	50                   	push   %eax
    114f:	ff 75 0c             	pushl  0xc(%ebp)
    1152:	ff 75 10             	pushl  0x10(%ebp)
    1155:	ff 75 0c             	pushl  0xc(%ebp)
    1158:	ff 75 08             	pushl  0x8(%ebp)
    115b:	e8 16 fd ff ff       	call   e76 <APDrawLine>
    1160:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1163:	8b 55 0c             	mov    0xc(%ebp),%edx
    1166:	8b 45 14             	mov    0x14(%ebp),%eax
    1169:	01 d0                	add    %edx,%eax
    116b:	83 e8 01             	sub    $0x1,%eax
    116e:	83 ec 04             	sub    $0x4,%esp
    1171:	ff 75 10             	pushl  0x10(%ebp)
    1174:	50                   	push   %eax
    1175:	ff 75 10             	pushl  0x10(%ebp)
    1178:	ff 75 0c             	pushl  0xc(%ebp)
    117b:	ff 75 08             	pushl  0x8(%ebp)
    117e:	e8 f3 fc ff ff       	call   e76 <APDrawLine>
    1183:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1186:	8b 55 10             	mov    0x10(%ebp),%edx
    1189:	8b 45 18             	mov    0x18(%ebp),%eax
    118c:	01 d0                	add    %edx,%eax
    118e:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1191:	8b 55 0c             	mov    0xc(%ebp),%edx
    1194:	8b 45 14             	mov    0x14(%ebp),%eax
    1197:	01 d0                	add    %edx,%eax
    1199:	8d 50 ff             	lea    -0x1(%eax),%edx
    119c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    119f:	8b 45 14             	mov    0x14(%ebp),%eax
    11a2:	01 d8                	add    %ebx,%eax
    11a4:	83 e8 01             	sub    $0x1,%eax
    11a7:	83 ec 04             	sub    $0x4,%esp
    11aa:	51                   	push   %ecx
    11ab:	52                   	push   %edx
    11ac:	ff 75 10             	pushl  0x10(%ebp)
    11af:	50                   	push   %eax
    11b0:	ff 75 08             	pushl  0x8(%ebp)
    11b3:	e8 be fc ff ff       	call   e76 <APDrawLine>
    11b8:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    11bb:	8b 55 10             	mov    0x10(%ebp),%edx
    11be:	8b 45 18             	mov    0x18(%ebp),%eax
    11c1:	01 d0                	add    %edx,%eax
    11c3:	8d 48 ff             	lea    -0x1(%eax),%ecx
    11c6:	8b 55 0c             	mov    0xc(%ebp),%edx
    11c9:	8b 45 14             	mov    0x14(%ebp),%eax
    11cc:	01 d0                	add    %edx,%eax
    11ce:	8d 50 ff             	lea    -0x1(%eax),%edx
    11d1:	8b 5d 10             	mov    0x10(%ebp),%ebx
    11d4:	8b 45 18             	mov    0x18(%ebp),%eax
    11d7:	01 d8                	add    %ebx,%eax
    11d9:	83 e8 01             	sub    $0x1,%eax
    11dc:	83 ec 04             	sub    $0x4,%esp
    11df:	51                   	push   %ecx
    11e0:	52                   	push   %edx
    11e1:	50                   	push   %eax
    11e2:	ff 75 0c             	pushl  0xc(%ebp)
    11e5:	ff 75 08             	pushl  0x8(%ebp)
    11e8:	e8 89 fc ff ff       	call   e76 <APDrawLine>
    11ed:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    11f0:	8b 55 0c             	mov    0xc(%ebp),%edx
    11f3:	8b 45 14             	mov    0x14(%ebp),%eax
    11f6:	01 d0                	add    %edx,%eax
    11f8:	8d 50 ff             	lea    -0x1(%eax),%edx
    11fb:	8b 45 08             	mov    0x8(%ebp),%eax
    11fe:	8b 40 0c             	mov    0xc(%eax),%eax
    1201:	89 c1                	mov    %eax,%ecx
    1203:	c1 e9 1f             	shr    $0x1f,%ecx
    1206:	01 c8                	add    %ecx,%eax
    1208:	d1 f8                	sar    %eax
    120a:	29 c2                	sub    %eax,%edx
    120c:	89 d0                	mov    %edx,%eax
    120e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1211:	8b 55 10             	mov    0x10(%ebp),%edx
    1214:	8b 45 18             	mov    0x18(%ebp),%eax
    1217:	01 d0                	add    %edx,%eax
    1219:	8d 50 ff             	lea    -0x1(%eax),%edx
    121c:	8b 45 08             	mov    0x8(%ebp),%eax
    121f:	8b 40 0c             	mov    0xc(%eax),%eax
    1222:	89 c1                	mov    %eax,%ecx
    1224:	c1 e9 1f             	shr    $0x1f,%ecx
    1227:	01 c8                	add    %ecx,%eax
    1229:	d1 f8                	sar    %eax
    122b:	29 c2                	sub    %eax,%edx
    122d:	89 d0                	mov    %edx,%eax
    122f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1232:	8b 45 08             	mov    0x8(%ebp),%eax
    1235:	8b 40 0c             	mov    0xc(%eax),%eax
    1238:	89 c2                	mov    %eax,%edx
    123a:	c1 ea 1f             	shr    $0x1f,%edx
    123d:	01 d0                	add    %edx,%eax
    123f:	d1 f8                	sar    %eax
    1241:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1244:	8b 45 08             	mov    0x8(%ebp),%eax
    1247:	8b 40 0c             	mov    0xc(%eax),%eax
    124a:	89 c2                	mov    %eax,%edx
    124c:	c1 ea 1f             	shr    $0x1f,%edx
    124f:	01 d0                	add    %edx,%eax
    1251:	d1 f8                	sar    %eax
    1253:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1256:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    125a:	0f 88 d8 00 00 00    	js     1338 <APDrawRect+0x1ff>
    1260:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1264:	0f 88 ce 00 00 00    	js     1338 <APDrawRect+0x1ff>
    126a:	8b 45 08             	mov    0x8(%ebp),%eax
    126d:	8b 00                	mov    (%eax),%eax
    126f:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1272:	0f 8e c0 00 00 00    	jle    1338 <APDrawRect+0x1ff>
    1278:	8b 45 08             	mov    0x8(%ebp),%eax
    127b:	8b 40 04             	mov    0x4(%eax),%eax
    127e:	3b 45 10             	cmp    0x10(%ebp),%eax
    1281:	0f 8e b1 00 00 00    	jle    1338 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1287:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    128b:	79 07                	jns    1294 <APDrawRect+0x15b>
    128d:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1294:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1298:	79 07                	jns    12a1 <APDrawRect+0x168>
    129a:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    12a1:	8b 45 08             	mov    0x8(%ebp),%eax
    12a4:	8b 00                	mov    (%eax),%eax
    12a6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    12a9:	7f 0b                	jg     12b6 <APDrawRect+0x17d>
    12ab:	8b 45 08             	mov    0x8(%ebp),%eax
    12ae:	8b 00                	mov    (%eax),%eax
    12b0:	83 e8 01             	sub    $0x1,%eax
    12b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    12b6:	8b 45 08             	mov    0x8(%ebp),%eax
    12b9:	8b 40 04             	mov    0x4(%eax),%eax
    12bc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12bf:	7f 0c                	jg     12cd <APDrawRect+0x194>
    12c1:	8b 45 08             	mov    0x8(%ebp),%eax
    12c4:	8b 40 04             	mov    0x4(%eax),%eax
    12c7:	83 e8 01             	sub    $0x1,%eax
    12ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    12cd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12d4:	8b 45 0c             	mov    0xc(%ebp),%eax
    12d7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12da:	eb 52                	jmp    132e <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    12dc:	8b 45 10             	mov    0x10(%ebp),%eax
    12df:	89 45 e8             	mov    %eax,-0x18(%ebp)
    12e2:	eb 3e                	jmp    1322 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    12e4:	83 ec 04             	sub    $0x4,%esp
    12e7:	ff 75 e8             	pushl  -0x18(%ebp)
    12ea:	ff 75 ec             	pushl  -0x14(%ebp)
    12ed:	ff 75 08             	pushl  0x8(%ebp)
    12f0:	e8 02 f7 ff ff       	call   9f7 <APGetIndex>
    12f5:	83 c4 10             	add    $0x10,%esp
    12f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    12fb:	8b 45 08             	mov    0x8(%ebp),%eax
    12fe:	8b 48 18             	mov    0x18(%eax),%ecx
    1301:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1304:	89 d0                	mov    %edx,%eax
    1306:	01 c0                	add    %eax,%eax
    1308:	01 d0                	add    %edx,%eax
    130a:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    130d:	8b 45 08             	mov    0x8(%ebp),%eax
    1310:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1314:	66 89 0a             	mov    %cx,(%edx)
    1317:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    131b:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    131e:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1322:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1325:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1328:	7e ba                	jle    12e4 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    132a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    132e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1331:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1334:	7e a6                	jle    12dc <APDrawRect+0x1a3>
    1336:	eb 01                	jmp    1339 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1338:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1339:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    133c:	c9                   	leave  
    133d:	c3                   	ret    

0000133e <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    133e:	55                   	push   %ebp
    133f:	89 e5                	mov    %esp,%ebp
}
    1341:	90                   	nop
    1342:	5d                   	pop    %ebp
    1343:	c3                   	ret    

00001344 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1344:	55                   	push   %ebp
    1345:	89 e5                	mov    %esp,%ebp
    1347:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    134a:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    134e:	0f 88 8e 01 00 00    	js     14e2 <APDcCopy+0x19e>
    1354:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1358:	0f 88 84 01 00 00    	js     14e2 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    135e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1361:	8b 45 20             	mov    0x20(%ebp),%eax
    1364:	01 d0                	add    %edx,%eax
    1366:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1369:	8b 55 10             	mov    0x10(%ebp),%edx
    136c:	8b 45 24             	mov    0x24(%ebp),%eax
    136f:	01 d0                	add    %edx,%eax
    1371:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1374:	8b 55 18             	mov    0x18(%ebp),%edx
    1377:	8b 45 20             	mov    0x20(%ebp),%eax
    137a:	01 d0                	add    %edx,%eax
    137c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    137f:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1382:	8b 45 24             	mov    0x24(%ebp),%eax
    1385:	01 d0                	add    %edx,%eax
    1387:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    138a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    138e:	0f 88 51 01 00 00    	js     14e5 <APDcCopy+0x1a1>
    1394:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1398:	0f 88 47 01 00 00    	js     14e5 <APDcCopy+0x1a1>
    139e:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    13a2:	0f 88 3d 01 00 00    	js     14e5 <APDcCopy+0x1a1>
    13a8:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    13ac:	0f 88 33 01 00 00    	js     14e5 <APDcCopy+0x1a1>
    13b2:	8b 45 14             	mov    0x14(%ebp),%eax
    13b5:	8b 00                	mov    (%eax),%eax
    13b7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13ba:	0f 8c 25 01 00 00    	jl     14e5 <APDcCopy+0x1a1>
    13c0:	8b 45 14             	mov    0x14(%ebp),%eax
    13c3:	8b 40 04             	mov    0x4(%eax),%eax
    13c6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    13c9:	0f 8c 16 01 00 00    	jl     14e5 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    13cf:	8b 45 08             	mov    0x8(%ebp),%eax
    13d2:	8b 00                	mov    (%eax),%eax
    13d4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    13d7:	7f 0b                	jg     13e4 <APDcCopy+0xa0>
    13d9:	8b 45 08             	mov    0x8(%ebp),%eax
    13dc:	8b 00                	mov    (%eax),%eax
    13de:	83 e8 01             	sub    $0x1,%eax
    13e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    13e4:	8b 45 08             	mov    0x8(%ebp),%eax
    13e7:	8b 40 04             	mov    0x4(%eax),%eax
    13ea:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13ed:	7f 0c                	jg     13fb <APDcCopy+0xb7>
    13ef:	8b 45 08             	mov    0x8(%ebp),%eax
    13f2:	8b 40 04             	mov    0x4(%eax),%eax
    13f5:	83 e8 01             	sub    $0x1,%eax
    13f8:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    13fb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1402:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1409:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1410:	e9 bc 00 00 00       	jmp    14d1 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1415:	8b 45 08             	mov    0x8(%ebp),%eax
    1418:	8b 00                	mov    (%eax),%eax
    141a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    141d:	8b 55 10             	mov    0x10(%ebp),%edx
    1420:	01 ca                	add    %ecx,%edx
    1422:	0f af d0             	imul   %eax,%edx
    1425:	8b 45 0c             	mov    0xc(%ebp),%eax
    1428:	01 d0                	add    %edx,%eax
    142a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    142d:	8b 45 14             	mov    0x14(%ebp),%eax
    1430:	8b 00                	mov    (%eax),%eax
    1432:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1435:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1438:	01 ca                	add    %ecx,%edx
    143a:	0f af d0             	imul   %eax,%edx
    143d:	8b 45 18             	mov    0x18(%ebp),%eax
    1440:	01 d0                	add    %edx,%eax
    1442:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1445:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    144c:	eb 74                	jmp    14c2 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    144e:	8b 45 14             	mov    0x14(%ebp),%eax
    1451:	8b 50 18             	mov    0x18(%eax),%edx
    1454:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1457:	8b 45 f0             	mov    -0x10(%ebp),%eax
    145a:	01 c8                	add    %ecx,%eax
    145c:	89 c1                	mov    %eax,%ecx
    145e:	89 c8                	mov    %ecx,%eax
    1460:	01 c0                	add    %eax,%eax
    1462:	01 c8                	add    %ecx,%eax
    1464:	01 d0                	add    %edx,%eax
    1466:	0f b7 10             	movzwl (%eax),%edx
    1469:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    146d:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1471:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1474:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1478:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    147c:	38 c2                	cmp    %al,%dl
    147e:	75 18                	jne    1498 <APDcCopy+0x154>
    1480:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1484:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1488:	38 c2                	cmp    %al,%dl
    148a:	75 0c                	jne    1498 <APDcCopy+0x154>
    148c:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1490:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1494:	38 c2                	cmp    %al,%dl
    1496:	74 26                	je     14be <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1498:	8b 45 08             	mov    0x8(%ebp),%eax
    149b:	8b 50 18             	mov    0x18(%eax),%edx
    149e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    14a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14a4:	01 c8                	add    %ecx,%eax
    14a6:	89 c1                	mov    %eax,%ecx
    14a8:	89 c8                	mov    %ecx,%eax
    14aa:	01 c0                	add    %eax,%eax
    14ac:	01 c8                	add    %ecx,%eax
    14ae:	01 d0                	add    %edx,%eax
    14b0:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    14b4:	66 89 10             	mov    %dx,(%eax)
    14b7:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    14bb:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    14be:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14c5:	2b 45 0c             	sub    0xc(%ebp),%eax
    14c8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14cb:	7d 81                	jge    144e <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    14cd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14d4:	2b 45 10             	sub    0x10(%ebp),%eax
    14d7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14da:	0f 8d 35 ff ff ff    	jge    1415 <APDcCopy+0xd1>
    14e0:	eb 04                	jmp    14e6 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    14e2:	90                   	nop
    14e3:	eb 01                	jmp    14e6 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    14e5:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    14e6:	c9                   	leave  
    14e7:	c3                   	ret    

000014e8 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    14e8:	55                   	push   %ebp
    14e9:	89 e5                	mov    %esp,%ebp
    14eb:	83 ec 1c             	sub    $0x1c,%esp
    14ee:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    14f1:	8b 55 10             	mov    0x10(%ebp),%edx
    14f4:	8b 45 14             	mov    0x14(%ebp),%eax
    14f7:	88 4d ec             	mov    %cl,-0x14(%ebp)
    14fa:	88 55 e8             	mov    %dl,-0x18(%ebp)
    14fd:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1500:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1504:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1507:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    150b:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    150e:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1512:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1515:	8b 45 08             	mov    0x8(%ebp),%eax
    1518:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    151c:	66 89 10             	mov    %dx,(%eax)
    151f:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1523:	88 50 02             	mov    %dl,0x2(%eax)
}
    1526:	8b 45 08             	mov    0x8(%ebp),%eax
    1529:	c9                   	leave  
    152a:	c2 04 00             	ret    $0x4

0000152d <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    152d:	55                   	push   %ebp
    152e:	89 e5                	mov    %esp,%ebp
    1530:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1533:	8b 45 08             	mov    0x8(%ebp),%eax
    1536:	8b 00                	mov    (%eax),%eax
    1538:	83 ec 08             	sub    $0x8,%esp
    153b:	8d 55 0c             	lea    0xc(%ebp),%edx
    153e:	52                   	push   %edx
    153f:	50                   	push   %eax
    1540:	e8 77 ef ff ff       	call   4bc <sendMessage>
    1545:	83 c4 10             	add    $0x10,%esp
}
    1548:	90                   	nop
    1549:	c9                   	leave  
    154a:	c3                   	ret    

0000154b <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    154b:	55                   	push   %ebp
    154c:	89 e5                	mov    %esp,%ebp
    154e:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1551:	83 ec 0c             	sub    $0xc,%esp
    1554:	68 98 00 00 00       	push   $0x98
    1559:	e8 38 f3 ff ff       	call   896 <malloc>
    155e:	83 c4 10             	add    $0x10,%esp
    1561:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1564:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1568:	75 15                	jne    157f <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    156a:	83 ec 04             	sub    $0x4,%esp
    156d:	ff 75 08             	pushl  0x8(%ebp)
    1570:	68 d4 23 00 00       	push   $0x23d4
    1575:	6a 01                	push   $0x1
    1577:	e8 47 f0 ff ff       	call   5c3 <printf>
    157c:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    157f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1582:	05 84 00 00 00       	add    $0x84,%eax
    1587:	83 ec 08             	sub    $0x8,%esp
    158a:	ff 75 08             	pushl  0x8(%ebp)
    158d:	50                   	push   %eax
    158e:	e8 50 ec ff ff       	call   1e3 <strcpy>
    1593:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1596:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1599:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    15a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a3:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ad:	8b 40 3c             	mov    0x3c(%eax),%eax
    15b0:	89 c2                	mov    %eax,%edx
    15b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b5:	8b 40 40             	mov    0x40(%eax),%eax
    15b8:	0f af d0             	imul   %eax,%edx
    15bb:	89 d0                	mov    %edx,%eax
    15bd:	01 c0                	add    %eax,%eax
    15bf:	01 d0                	add    %edx,%eax
    15c1:	83 ec 0c             	sub    $0xc,%esp
    15c4:	50                   	push   %eax
    15c5:	e8 cc f2 ff ff       	call   896 <malloc>
    15ca:	83 c4 10             	add    $0x10,%esp
    15cd:	89 c2                	mov    %eax,%edx
    15cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d2:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    15d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d8:	8b 40 54             	mov    0x54(%eax),%eax
    15db:	85 c0                	test   %eax,%eax
    15dd:	75 15                	jne    15f4 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    15df:	83 ec 04             	sub    $0x4,%esp
    15e2:	ff 75 08             	pushl  0x8(%ebp)
    15e5:	68 f4 23 00 00       	push   $0x23f4
    15ea:	6a 01                	push   $0x1
    15ec:	e8 d2 ef ff ff       	call   5c3 <printf>
    15f1:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f7:	8b 40 3c             	mov    0x3c(%eax),%eax
    15fa:	89 c2                	mov    %eax,%edx
    15fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ff:	8b 40 40             	mov    0x40(%eax),%eax
    1602:	0f af d0             	imul   %eax,%edx
    1605:	89 d0                	mov    %edx,%eax
    1607:	01 c0                	add    %eax,%eax
    1609:	01 c2                	add    %eax,%edx
    160b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160e:	8b 40 54             	mov    0x54(%eax),%eax
    1611:	83 ec 04             	sub    $0x4,%esp
    1614:	52                   	push   %edx
    1615:	68 ff ff ff 00       	push   $0xffffff
    161a:	50                   	push   %eax
    161b:	e8 59 ec ff ff       	call   279 <memset>
    1620:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1623:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1626:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    162d:	e8 62 ee ff ff       	call   494 <getpid>
    1632:	89 c2                	mov    %eax,%edx
    1634:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1637:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    163a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163d:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1644:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1647:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    164e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1651:	8b 40 58             	mov    0x58(%eax),%eax
    1654:	89 c2                	mov    %eax,%edx
    1656:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1659:	8b 40 5c             	mov    0x5c(%eax),%eax
    165c:	0f af d0             	imul   %eax,%edx
    165f:	89 d0                	mov    %edx,%eax
    1661:	01 c0                	add    %eax,%eax
    1663:	01 d0                	add    %edx,%eax
    1665:	83 ec 0c             	sub    $0xc,%esp
    1668:	50                   	push   %eax
    1669:	e8 28 f2 ff ff       	call   896 <malloc>
    166e:	83 c4 10             	add    $0x10,%esp
    1671:	89 c2                	mov    %eax,%edx
    1673:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1676:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1679:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167c:	8b 40 70             	mov    0x70(%eax),%eax
    167f:	85 c0                	test   %eax,%eax
    1681:	75 15                	jne    1698 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1683:	83 ec 04             	sub    $0x4,%esp
    1686:	ff 75 08             	pushl  0x8(%ebp)
    1689:	68 18 24 00 00       	push   $0x2418
    168e:	6a 01                	push   $0x1
    1690:	e8 2e ef ff ff       	call   5c3 <printf>
    1695:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1698:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169b:	8b 40 3c             	mov    0x3c(%eax),%eax
    169e:	89 c2                	mov    %eax,%edx
    16a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a3:	8b 40 40             	mov    0x40(%eax),%eax
    16a6:	0f af d0             	imul   %eax,%edx
    16a9:	89 d0                	mov    %edx,%eax
    16ab:	01 c0                	add    %eax,%eax
    16ad:	01 c2                	add    %eax,%edx
    16af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b2:	8b 40 54             	mov    0x54(%eax),%eax
    16b5:	83 ec 04             	sub    $0x4,%esp
    16b8:	52                   	push   %edx
    16b9:	68 ff 00 00 00       	push   $0xff
    16be:	50                   	push   %eax
    16bf:	e8 b5 eb ff ff       	call   279 <memset>
    16c4:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    16c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ca:	8b 55 0c             	mov    0xc(%ebp),%edx
    16cd:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    16d0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16d4:	74 49                	je     171f <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    16d6:	8b 45 10             	mov    0x10(%ebp),%eax
    16d9:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    16df:	83 ec 0c             	sub    $0xc,%esp
    16e2:	50                   	push   %eax
    16e3:	e8 ae f1 ff ff       	call   896 <malloc>
    16e8:	83 c4 10             	add    $0x10,%esp
    16eb:	89 c2                	mov    %eax,%edx
    16ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f0:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    16f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f6:	8b 55 10             	mov    0x10(%ebp),%edx
    16f9:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    16fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ff:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1706:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1709:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1710:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1713:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    171a:	e9 8d 00 00 00       	jmp    17ac <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    171f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1722:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1729:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172c:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1733:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1736:	8b 40 20             	mov    0x20(%eax),%eax
    1739:	89 c2                	mov    %eax,%edx
    173b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    173e:	8b 40 24             	mov    0x24(%eax),%eax
    1741:	0f af d0             	imul   %eax,%edx
    1744:	89 d0                	mov    %edx,%eax
    1746:	01 c0                	add    %eax,%eax
    1748:	01 d0                	add    %edx,%eax
    174a:	83 ec 0c             	sub    $0xc,%esp
    174d:	50                   	push   %eax
    174e:	e8 43 f1 ff ff       	call   896 <malloc>
    1753:	83 c4 10             	add    $0x10,%esp
    1756:	89 c2                	mov    %eax,%edx
    1758:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175b:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    175e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1761:	8b 40 38             	mov    0x38(%eax),%eax
    1764:	85 c0                	test   %eax,%eax
    1766:	75 15                	jne    177d <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1768:	83 ec 04             	sub    $0x4,%esp
    176b:	ff 75 08             	pushl  0x8(%ebp)
    176e:	68 40 24 00 00       	push   $0x2440
    1773:	6a 01                	push   $0x1
    1775:	e8 49 ee ff ff       	call   5c3 <printf>
    177a:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    177d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1780:	8b 40 20             	mov    0x20(%eax),%eax
    1783:	89 c2                	mov    %eax,%edx
    1785:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1788:	8b 40 24             	mov    0x24(%eax),%eax
    178b:	0f af d0             	imul   %eax,%edx
    178e:	89 d0                	mov    %edx,%eax
    1790:	01 c0                	add    %eax,%eax
    1792:	01 c2                	add    %eax,%edx
    1794:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1797:	8b 40 38             	mov    0x38(%eax),%eax
    179a:	83 ec 04             	sub    $0x4,%esp
    179d:	52                   	push   %edx
    179e:	68 ff ff ff 00       	push   $0xffffff
    17a3:	50                   	push   %eax
    17a4:	e8 d0 ea ff ff       	call   279 <memset>
    17a9:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    17ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    17af:	c9                   	leave  
    17b0:	c3                   	ret    

000017b1 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    17b1:	55                   	push   %ebp
    17b2:	89 e5                	mov    %esp,%ebp
    17b4:	57                   	push   %edi
    17b5:	56                   	push   %esi
    17b6:	53                   	push   %ebx
    17b7:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    17ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    17bd:	83 f8 03             	cmp    $0x3,%eax
    17c0:	74 02                	je     17c4 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    17c2:	eb 7c                	jmp    1840 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    17c4:	8b 45 08             	mov    0x8(%ebp),%eax
    17c7:	8b 58 1c             	mov    0x1c(%eax),%ebx
    17ca:	8b 45 08             	mov    0x8(%ebp),%eax
    17cd:	8b 48 18             	mov    0x18(%eax),%ecx
    17d0:	8b 45 08             	mov    0x8(%ebp),%eax
    17d3:	8b 50 5c             	mov    0x5c(%eax),%edx
    17d6:	8b 45 08             	mov    0x8(%ebp),%eax
    17d9:	8b 40 58             	mov    0x58(%eax),%eax
    17dc:	8b 75 08             	mov    0x8(%ebp),%esi
    17df:	83 c6 58             	add    $0x58,%esi
    17e2:	83 ec 04             	sub    $0x4,%esp
    17e5:	53                   	push   %ebx
    17e6:	51                   	push   %ecx
    17e7:	6a 00                	push   $0x0
    17e9:	52                   	push   %edx
    17ea:	50                   	push   %eax
    17eb:	6a 00                	push   $0x0
    17ed:	6a 00                	push   $0x0
    17ef:	56                   	push   %esi
    17f0:	6a 00                	push   $0x0
    17f2:	6a 00                	push   $0x0
    17f4:	ff 75 08             	pushl  0x8(%ebp)
    17f7:	e8 b8 ec ff ff       	call   4b4 <paintWindow>
    17fc:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    17ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1802:	8b 70 1c             	mov    0x1c(%eax),%esi
    1805:	8b 45 08             	mov    0x8(%ebp),%eax
    1808:	8b 58 18             	mov    0x18(%eax),%ebx
    180b:	8b 45 08             	mov    0x8(%ebp),%eax
    180e:	8b 48 08             	mov    0x8(%eax),%ecx
    1811:	8b 45 08             	mov    0x8(%ebp),%eax
    1814:	8b 50 40             	mov    0x40(%eax),%edx
    1817:	8b 45 08             	mov    0x8(%ebp),%eax
    181a:	8b 40 3c             	mov    0x3c(%eax),%eax
    181d:	8b 7d 08             	mov    0x8(%ebp),%edi
    1820:	83 c7 3c             	add    $0x3c,%edi
    1823:	83 ec 04             	sub    $0x4,%esp
    1826:	56                   	push   %esi
    1827:	53                   	push   %ebx
    1828:	51                   	push   %ecx
    1829:	52                   	push   %edx
    182a:	50                   	push   %eax
    182b:	6a 00                	push   $0x0
    182d:	6a 00                	push   $0x0
    182f:	57                   	push   %edi
    1830:	6a 32                	push   $0x32
    1832:	6a 00                	push   $0x0
    1834:	ff 75 08             	pushl  0x8(%ebp)
    1837:	e8 78 ec ff ff       	call   4b4 <paintWindow>
    183c:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    183f:	90                   	nop
        default: break;
            
            
    }
    return False;
    1840:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1845:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1848:	5b                   	pop    %ebx
    1849:	5e                   	pop    %esi
    184a:	5f                   	pop    %edi
    184b:	5d                   	pop    %ebp
    184c:	c3                   	ret    

0000184d <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    184d:	55                   	push   %ebp
    184e:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1850:	8b 45 0c             	mov    0xc(%ebp),%eax
    1853:	8b 50 08             	mov    0x8(%eax),%edx
    1856:	8b 45 08             	mov    0x8(%ebp),%eax
    1859:	8b 00                	mov    (%eax),%eax
    185b:	39 c2                	cmp    %eax,%edx
    185d:	74 07                	je     1866 <APPreJudge+0x19>
        return False;
    185f:	b8 00 00 00 00       	mov    $0x0,%eax
    1864:	eb 05                	jmp    186b <APPreJudge+0x1e>
    return True;
    1866:	b8 01 00 00 00       	mov    $0x1,%eax
}
    186b:	5d                   	pop    %ebp
    186c:	c3                   	ret    

0000186d <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    186d:	55                   	push   %ebp
    186e:	89 e5                	mov    %esp,%ebp
    1870:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1873:	8b 45 08             	mov    0x8(%ebp),%eax
    1876:	8b 55 0c             	mov    0xc(%ebp),%edx
    1879:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    187f:	83 ec 0c             	sub    $0xc,%esp
    1882:	ff 75 08             	pushl  0x8(%ebp)
    1885:	e8 42 ec ff ff       	call   4cc <registWindow>
    188a:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    188d:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1894:	8b 45 08             	mov    0x8(%ebp),%eax
    1897:	8b 00                	mov    (%eax),%eax
    1899:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    189c:	ff 75 f4             	pushl  -0xc(%ebp)
    189f:	ff 75 f0             	pushl  -0x10(%ebp)
    18a2:	ff 75 ec             	pushl  -0x14(%ebp)
    18a5:	ff 75 08             	pushl  0x8(%ebp)
    18a8:	e8 80 fc ff ff       	call   152d <APSendMessage>
    18ad:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    18b0:	83 ec 0c             	sub    $0xc,%esp
    18b3:	ff 75 08             	pushl  0x8(%ebp)
    18b6:	e8 09 ec ff ff       	call   4c4 <getMessage>
    18bb:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    18be:	8b 45 08             	mov    0x8(%ebp),%eax
    18c1:	83 c0 74             	add    $0x74,%eax
    18c4:	83 ec 08             	sub    $0x8,%esp
    18c7:	50                   	push   %eax
    18c8:	ff 75 08             	pushl  0x8(%ebp)
    18cb:	e8 7d ff ff ff       	call   184d <APPreJudge>
    18d0:	83 c4 10             	add    $0x10,%esp
    18d3:	84 c0                	test   %al,%al
    18d5:	74 1b                	je     18f2 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    18d7:	8b 45 08             	mov    0x8(%ebp),%eax
    18da:	ff 70 7c             	pushl  0x7c(%eax)
    18dd:	ff 70 78             	pushl  0x78(%eax)
    18e0:	ff 70 74             	pushl  0x74(%eax)
    18e3:	ff 75 08             	pushl  0x8(%ebp)
    18e6:	8b 45 0c             	mov    0xc(%ebp),%eax
    18e9:	ff d0                	call   *%eax
    18eb:	83 c4 10             	add    $0x10,%esp
    18ee:	84 c0                	test   %al,%al
    18f0:	75 0c                	jne    18fe <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    18f2:	8b 45 08             	mov    0x8(%ebp),%eax
    18f5:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    18fc:	eb b2                	jmp    18b0 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    18fe:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    18ff:	90                   	nop
    1900:	c9                   	leave  
    1901:	c3                   	ret    

00001902 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1902:	55                   	push   %ebp
    1903:	89 e5                	mov    %esp,%ebp
    1905:	57                   	push   %edi
    1906:	56                   	push   %esi
    1907:	53                   	push   %ebx
    1908:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    190b:	a1 ec 2a 00 00       	mov    0x2aec,%eax
    1910:	85 c0                	test   %eax,%eax
    1912:	0f 85 2c 02 00 00    	jne    1b44 <APGridPaint+0x242>
    {
        iconReady = 1;
    1918:	c7 05 ec 2a 00 00 01 	movl   $0x1,0x2aec
    191f:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1922:	8d 45 98             	lea    -0x68(%ebp),%eax
    1925:	83 ec 08             	sub    $0x8,%esp
    1928:	68 67 24 00 00       	push   $0x2467
    192d:	50                   	push   %eax
    192e:	e8 16 f1 ff ff       	call   a49 <APLoadBitmap>
    1933:	83 c4 0c             	add    $0xc,%esp
    1936:	8b 45 98             	mov    -0x68(%ebp),%eax
    1939:	a3 20 2d 00 00       	mov    %eax,0x2d20
    193e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1941:	a3 24 2d 00 00       	mov    %eax,0x2d24
    1946:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1949:	a3 28 2d 00 00       	mov    %eax,0x2d28
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    194e:	83 ec 04             	sub    $0x4,%esp
    1951:	ff 35 28 2d 00 00    	pushl  0x2d28
    1957:	ff 35 24 2d 00 00    	pushl  0x2d24
    195d:	ff 35 20 2d 00 00    	pushl  0x2d20
    1963:	e8 1b f3 ff ff       	call   c83 <APCreateCompatibleDCFromBitmap>
    1968:	83 c4 10             	add    $0x10,%esp
    196b:	a3 2c 2d 00 00       	mov    %eax,0x2d2c
        grid_river = APLoadBitmap ("grid_river.bmp");
    1970:	8d 45 98             	lea    -0x68(%ebp),%eax
    1973:	83 ec 08             	sub    $0x8,%esp
    1976:	68 75 24 00 00       	push   $0x2475
    197b:	50                   	push   %eax
    197c:	e8 c8 f0 ff ff       	call   a49 <APLoadBitmap>
    1981:	83 c4 0c             	add    $0xc,%esp
    1984:	8b 45 98             	mov    -0x68(%ebp),%eax
    1987:	a3 5c 2d 00 00       	mov    %eax,0x2d5c
    198c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    198f:	a3 60 2d 00 00       	mov    %eax,0x2d60
    1994:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1997:	a3 64 2d 00 00       	mov    %eax,0x2d64
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    199c:	83 ec 04             	sub    $0x4,%esp
    199f:	ff 35 64 2d 00 00    	pushl  0x2d64
    19a5:	ff 35 60 2d 00 00    	pushl  0x2d60
    19ab:	ff 35 5c 2d 00 00    	pushl  0x2d5c
    19b1:	e8 cd f2 ff ff       	call   c83 <APCreateCompatibleDCFromBitmap>
    19b6:	83 c4 10             	add    $0x10,%esp
    19b9:	a3 4c 2d 00 00       	mov    %eax,0x2d4c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    19be:	8d 45 98             	lea    -0x68(%ebp),%eax
    19c1:	83 ec 08             	sub    $0x8,%esp
    19c4:	68 84 24 00 00       	push   $0x2484
    19c9:	50                   	push   %eax
    19ca:	e8 7a f0 ff ff       	call   a49 <APLoadBitmap>
    19cf:	83 c4 0c             	add    $0xc,%esp
    19d2:	8b 45 98             	mov    -0x68(%ebp),%eax
    19d5:	a3 50 2d 00 00       	mov    %eax,0x2d50
    19da:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19dd:	a3 54 2d 00 00       	mov    %eax,0x2d54
    19e2:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19e5:	a3 58 2d 00 00       	mov    %eax,0x2d58
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    19ea:	83 ec 04             	sub    $0x4,%esp
    19ed:	ff 35 58 2d 00 00    	pushl  0x2d58
    19f3:	ff 35 54 2d 00 00    	pushl  0x2d54
    19f9:	ff 35 50 2d 00 00    	pushl  0x2d50
    19ff:	e8 7f f2 ff ff       	call   c83 <APCreateCompatibleDCFromBitmap>
    1a04:	83 c4 10             	add    $0x10,%esp
    1a07:	a3 00 2d 00 00       	mov    %eax,0x2d00
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1a0c:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a0f:	83 ec 08             	sub    $0x8,%esp
    1a12:	68 93 24 00 00       	push   $0x2493
    1a17:	50                   	push   %eax
    1a18:	e8 2c f0 ff ff       	call   a49 <APLoadBitmap>
    1a1d:	83 c4 0c             	add    $0xc,%esp
    1a20:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a23:	a3 34 2d 00 00       	mov    %eax,0x2d34
    1a28:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a2b:	a3 38 2d 00 00       	mov    %eax,0x2d38
    1a30:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a33:	a3 3c 2d 00 00       	mov    %eax,0x2d3c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1a38:	83 ec 04             	sub    $0x4,%esp
    1a3b:	ff 35 3c 2d 00 00    	pushl  0x2d3c
    1a41:	ff 35 38 2d 00 00    	pushl  0x2d38
    1a47:	ff 35 34 2d 00 00    	pushl  0x2d34
    1a4d:	e8 31 f2 ff ff       	call   c83 <APCreateCompatibleDCFromBitmap>
    1a52:	83 c4 10             	add    $0x10,%esp
    1a55:	a3 68 2d 00 00       	mov    %eax,0x2d68
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1a5a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a5d:	83 ec 08             	sub    $0x8,%esp
    1a60:	68 a1 24 00 00       	push   $0x24a1
    1a65:	50                   	push   %eax
    1a66:	e8 de ef ff ff       	call   a49 <APLoadBitmap>
    1a6b:	83 c4 0c             	add    $0xc,%esp
    1a6e:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a71:	a3 10 2d 00 00       	mov    %eax,0x2d10
    1a76:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a79:	a3 14 2d 00 00       	mov    %eax,0x2d14
    1a7e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a81:	a3 18 2d 00 00       	mov    %eax,0x2d18
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1a86:	83 ec 04             	sub    $0x4,%esp
    1a89:	ff 35 18 2d 00 00    	pushl  0x2d18
    1a8f:	ff 35 14 2d 00 00    	pushl  0x2d14
    1a95:	ff 35 10 2d 00 00    	pushl  0x2d10
    1a9b:	e8 e3 f1 ff ff       	call   c83 <APCreateCompatibleDCFromBitmap>
    1aa0:	83 c4 10             	add    $0x10,%esp
    1aa3:	a3 30 2d 00 00       	mov    %eax,0x2d30
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1aa8:	8d 45 98             	lea    -0x68(%ebp),%eax
    1aab:	83 ec 08             	sub    $0x8,%esp
    1aae:	68 b1 24 00 00       	push   $0x24b1
    1ab3:	50                   	push   %eax
    1ab4:	e8 90 ef ff ff       	call   a49 <APLoadBitmap>
    1ab9:	83 c4 0c             	add    $0xc,%esp
    1abc:	8b 45 98             	mov    -0x68(%ebp),%eax
    1abf:	a3 04 2d 00 00       	mov    %eax,0x2d04
    1ac4:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1ac7:	a3 08 2d 00 00       	mov    %eax,0x2d08
    1acc:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1acf:	a3 0c 2d 00 00       	mov    %eax,0x2d0c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1ad4:	83 ec 04             	sub    $0x4,%esp
    1ad7:	ff 35 0c 2d 00 00    	pushl  0x2d0c
    1add:	ff 35 08 2d 00 00    	pushl  0x2d08
    1ae3:	ff 35 04 2d 00 00    	pushl  0x2d04
    1ae9:	e8 95 f1 ff ff       	call   c83 <APCreateCompatibleDCFromBitmap>
    1aee:	83 c4 10             	add    $0x10,%esp
    1af1:	a3 1c 2d 00 00       	mov    %eax,0x2d1c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1af6:	8d 45 98             	lea    -0x68(%ebp),%eax
    1af9:	83 ec 08             	sub    $0x8,%esp
    1afc:	68 c3 24 00 00       	push   $0x24c3
    1b01:	50                   	push   %eax
    1b02:	e8 42 ef ff ff       	call   a49 <APLoadBitmap>
    1b07:	83 c4 0c             	add    $0xc,%esp
    1b0a:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b0d:	a3 40 2d 00 00       	mov    %eax,0x2d40
    1b12:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b15:	a3 44 2d 00 00       	mov    %eax,0x2d44
    1b1a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b1d:	a3 48 2d 00 00       	mov    %eax,0x2d48
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1b22:	83 ec 04             	sub    $0x4,%esp
    1b25:	ff 35 48 2d 00 00    	pushl  0x2d48
    1b2b:	ff 35 44 2d 00 00    	pushl  0x2d44
    1b31:	ff 35 40 2d 00 00    	pushl  0x2d40
    1b37:	e8 47 f1 ff ff       	call   c83 <APCreateCompatibleDCFromBitmap>
    1b3c:	83 c4 10             	add    $0x10,%esp
    1b3f:	a3 6c 2d 00 00       	mov    %eax,0x2d6c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1b44:	8b 45 08             	mov    0x8(%ebp),%eax
    1b47:	8b 40 08             	mov    0x8(%eax),%eax
    1b4a:	85 c0                	test   %eax,%eax
    1b4c:	75 17                	jne    1b65 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1b4e:	83 ec 08             	sub    $0x8,%esp
    1b51:	68 d4 24 00 00       	push   $0x24d4
    1b56:	6a 01                	push   $0x1
    1b58:	e8 66 ea ff ff       	call   5c3 <printf>
    1b5d:	83 c4 10             	add    $0x10,%esp
        return;
    1b60:	e9 a0 04 00 00       	jmp    2005 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1b65:	8b 45 08             	mov    0x8(%ebp),%eax
    1b68:	8b 40 10             	mov    0x10(%eax),%eax
    1b6b:	85 c0                	test   %eax,%eax
    1b6d:	7e 10                	jle    1b7f <APGridPaint+0x27d>
    1b6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b72:	8b 50 14             	mov    0x14(%eax),%edx
    1b75:	8b 45 08             	mov    0x8(%ebp),%eax
    1b78:	8b 40 10             	mov    0x10(%eax),%eax
    1b7b:	39 c2                	cmp    %eax,%edx
    1b7d:	7c 17                	jl     1b96 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1b7f:	83 ec 08             	sub    $0x8,%esp
    1b82:	68 fa 24 00 00       	push   $0x24fa
    1b87:	6a 01                	push   $0x1
    1b89:	e8 35 ea ff ff       	call   5c3 <printf>
    1b8e:	83 c4 10             	add    $0x10,%esp
        return;
    1b91:	e9 6f 04 00 00       	jmp    2005 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1b96:	8b 45 08             	mov    0x8(%ebp),%eax
    1b99:	8b 40 14             	mov    0x14(%eax),%eax
    1b9c:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1ba2:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1ba5:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1ba8:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1bab:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1bb2:	e9 96 03 00 00       	jmp    1f4d <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1bb7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1bbe:	e9 7c 03 00 00       	jmp    1f3f <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1bc3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bc6:	c1 e0 04             	shl    $0x4,%eax
    1bc9:	89 c2                	mov    %eax,%edx
    1bcb:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1bce:	01 c2                	add    %eax,%edx
    1bd0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bd3:	01 d0                	add    %edx,%eax
    1bd5:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1bd8:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdb:	8b 40 0c             	mov    0xc(%eax),%eax
    1bde:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1be1:	c1 e2 02             	shl    $0x2,%edx
    1be4:	01 d0                	add    %edx,%eax
    1be6:	8b 00                	mov    (%eax),%eax
    1be8:	83 f8 07             	cmp    $0x7,%eax
    1beb:	0f 87 49 03 00 00    	ja     1f3a <APGridPaint+0x638>
    1bf1:	8b 04 85 10 25 00 00 	mov    0x2510(,%eax,4),%eax
    1bf8:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bfa:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1bfd:	6a 0c                	push   $0xc
    1bff:	6a 0c                	push   $0xc
    1c01:	6a 0c                	push   $0xc
    1c03:	50                   	push   %eax
    1c04:	e8 df f8 ff ff       	call   14e8 <RGB>
    1c09:	83 c4 0c             	add    $0xc,%esp
    1c0c:	8b 1d 2c 2d 00 00    	mov    0x2d2c,%ebx
    1c12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c15:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c18:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c1b:	6b c0 32             	imul   $0x32,%eax,%eax
    1c1e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c21:	8b 45 08             	mov    0x8(%ebp),%eax
    1c24:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c27:	83 ec 0c             	sub    $0xc,%esp
    1c2a:	83 ec 04             	sub    $0x4,%esp
    1c2d:	89 e0                	mov    %esp,%eax
    1c2f:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1c33:	66 89 30             	mov    %si,(%eax)
    1c36:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1c3a:	88 50 02             	mov    %dl,0x2(%eax)
    1c3d:	6a 32                	push   $0x32
    1c3f:	6a 32                	push   $0x32
    1c41:	6a 00                	push   $0x0
    1c43:	6a 00                	push   $0x0
    1c45:	53                   	push   %ebx
    1c46:	51                   	push   %ecx
    1c47:	ff 75 94             	pushl  -0x6c(%ebp)
    1c4a:	57                   	push   %edi
    1c4b:	e8 f4 f6 ff ff       	call   1344 <APDcCopy>
    1c50:	83 c4 30             	add    $0x30,%esp
                    break;
    1c53:	e9 e3 02 00 00       	jmp    1f3b <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1c58:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c5b:	6a 69                	push   $0x69
    1c5d:	6a 69                	push   $0x69
    1c5f:	6a 69                	push   $0x69
    1c61:	50                   	push   %eax
    1c62:	e8 81 f8 ff ff       	call   14e8 <RGB>
    1c67:	83 c4 0c             	add    $0xc,%esp
    1c6a:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1c6e:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1c72:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1c76:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1c79:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1c80:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c83:	6a 69                	push   $0x69
    1c85:	6a 69                	push   $0x69
    1c87:	6a 69                	push   $0x69
    1c89:	50                   	push   %eax
    1c8a:	e8 59 f8 ff ff       	call   14e8 <RGB>
    1c8f:	83 c4 0c             	add    $0xc,%esp
    1c92:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1c96:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1c9a:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1c9e:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1ca1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca4:	8d 50 3c             	lea    0x3c(%eax),%edx
    1ca7:	8d 45 98             	lea    -0x68(%ebp),%eax
    1caa:	ff 75 b0             	pushl  -0x50(%ebp)
    1cad:	ff 75 ac             	pushl  -0x54(%ebp)
    1cb0:	52                   	push   %edx
    1cb1:	50                   	push   %eax
    1cb2:	e8 61 f0 ff ff       	call   d18 <APSetPen>
    1cb7:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1cba:	8b 45 08             	mov    0x8(%ebp),%eax
    1cbd:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1cc0:	8d 55 98             	lea    -0x68(%ebp),%edx
    1cc3:	83 ec 04             	sub    $0x4,%esp
    1cc6:	83 ec 04             	sub    $0x4,%esp
    1cc9:	89 e0                	mov    %esp,%eax
    1ccb:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1ccf:	66 89 08             	mov    %cx,(%eax)
    1cd2:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1cd6:	88 48 02             	mov    %cl,0x2(%eax)
    1cd9:	53                   	push   %ebx
    1cda:	52                   	push   %edx
    1cdb:	e8 71 f0 ff ff       	call   d51 <APSetBrush>
    1ce0:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1ce3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ce6:	6b d0 32             	imul   $0x32,%eax,%edx
    1ce9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cec:	6b c0 32             	imul   $0x32,%eax,%eax
    1cef:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1cf2:	83 c1 3c             	add    $0x3c,%ecx
    1cf5:	83 ec 0c             	sub    $0xc,%esp
    1cf8:	6a 32                	push   $0x32
    1cfa:	6a 32                	push   $0x32
    1cfc:	52                   	push   %edx
    1cfd:	50                   	push   %eax
    1cfe:	51                   	push   %ecx
    1cff:	e8 35 f4 ff ff       	call   1139 <APDrawRect>
    1d04:	83 c4 20             	add    $0x20,%esp
                    break;
    1d07:	e9 2f 02 00 00       	jmp    1f3b <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d0c:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1d0f:	6a 0c                	push   $0xc
    1d11:	6a 0c                	push   $0xc
    1d13:	6a 0c                	push   $0xc
    1d15:	50                   	push   %eax
    1d16:	e8 cd f7 ff ff       	call   14e8 <RGB>
    1d1b:	83 c4 0c             	add    $0xc,%esp
    1d1e:	8b 1d 6c 2d 00 00    	mov    0x2d6c,%ebx
    1d24:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d27:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d2a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d2d:	6b c0 32             	imul   $0x32,%eax,%eax
    1d30:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d33:	8b 45 08             	mov    0x8(%ebp),%eax
    1d36:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d39:	83 ec 0c             	sub    $0xc,%esp
    1d3c:	83 ec 04             	sub    $0x4,%esp
    1d3f:	89 e0                	mov    %esp,%eax
    1d41:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1d45:	66 89 30             	mov    %si,(%eax)
    1d48:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1d4c:	88 50 02             	mov    %dl,0x2(%eax)
    1d4f:	6a 32                	push   $0x32
    1d51:	6a 32                	push   $0x32
    1d53:	6a 00                	push   $0x0
    1d55:	6a 00                	push   $0x0
    1d57:	53                   	push   %ebx
    1d58:	51                   	push   %ecx
    1d59:	ff 75 94             	pushl  -0x6c(%ebp)
    1d5c:	57                   	push   %edi
    1d5d:	e8 e2 f5 ff ff       	call   1344 <APDcCopy>
    1d62:	83 c4 30             	add    $0x30,%esp
                    break;
    1d65:	e9 d1 01 00 00       	jmp    1f3b <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d6a:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1d6d:	6a 0c                	push   $0xc
    1d6f:	6a 0c                	push   $0xc
    1d71:	6a 0c                	push   $0xc
    1d73:	50                   	push   %eax
    1d74:	e8 6f f7 ff ff       	call   14e8 <RGB>
    1d79:	83 c4 0c             	add    $0xc,%esp
    1d7c:	8b 1d 4c 2d 00 00    	mov    0x2d4c,%ebx
    1d82:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d85:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d88:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d8b:	6b c0 32             	imul   $0x32,%eax,%eax
    1d8e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d91:	8b 45 08             	mov    0x8(%ebp),%eax
    1d94:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d97:	83 ec 0c             	sub    $0xc,%esp
    1d9a:	83 ec 04             	sub    $0x4,%esp
    1d9d:	89 e0                	mov    %esp,%eax
    1d9f:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1da3:	66 89 30             	mov    %si,(%eax)
    1da6:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1daa:	88 50 02             	mov    %dl,0x2(%eax)
    1dad:	6a 32                	push   $0x32
    1daf:	6a 32                	push   $0x32
    1db1:	6a 00                	push   $0x0
    1db3:	6a 00                	push   $0x0
    1db5:	53                   	push   %ebx
    1db6:	51                   	push   %ecx
    1db7:	ff 75 94             	pushl  -0x6c(%ebp)
    1dba:	57                   	push   %edi
    1dbb:	e8 84 f5 ff ff       	call   1344 <APDcCopy>
    1dc0:	83 c4 30             	add    $0x30,%esp
                    break;
    1dc3:	e9 73 01 00 00       	jmp    1f3b <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dc8:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1dcb:	6a 0c                	push   $0xc
    1dcd:	6a 0c                	push   $0xc
    1dcf:	6a 0c                	push   $0xc
    1dd1:	50                   	push   %eax
    1dd2:	e8 11 f7 ff ff       	call   14e8 <RGB>
    1dd7:	83 c4 0c             	add    $0xc,%esp
    1dda:	8b 1d 30 2d 00 00    	mov    0x2d30,%ebx
    1de0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1de3:	6b c8 32             	imul   $0x32,%eax,%ecx
    1de6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1de9:	6b c0 32             	imul   $0x32,%eax,%eax
    1dec:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1def:	8b 45 08             	mov    0x8(%ebp),%eax
    1df2:	8d 78 3c             	lea    0x3c(%eax),%edi
    1df5:	83 ec 0c             	sub    $0xc,%esp
    1df8:	83 ec 04             	sub    $0x4,%esp
    1dfb:	89 e0                	mov    %esp,%eax
    1dfd:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1e01:	66 89 30             	mov    %si,(%eax)
    1e04:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1e08:	88 50 02             	mov    %dl,0x2(%eax)
    1e0b:	6a 32                	push   $0x32
    1e0d:	6a 32                	push   $0x32
    1e0f:	6a 00                	push   $0x0
    1e11:	6a 00                	push   $0x0
    1e13:	53                   	push   %ebx
    1e14:	51                   	push   %ecx
    1e15:	ff 75 94             	pushl  -0x6c(%ebp)
    1e18:	57                   	push   %edi
    1e19:	e8 26 f5 ff ff       	call   1344 <APDcCopy>
    1e1e:	83 c4 30             	add    $0x30,%esp
                    break;
    1e21:	e9 15 01 00 00       	jmp    1f3b <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e26:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1e29:	6a 0c                	push   $0xc
    1e2b:	6a 0c                	push   $0xc
    1e2d:	6a 0c                	push   $0xc
    1e2f:	50                   	push   %eax
    1e30:	e8 b3 f6 ff ff       	call   14e8 <RGB>
    1e35:	83 c4 0c             	add    $0xc,%esp
    1e38:	8b 1d 68 2d 00 00    	mov    0x2d68,%ebx
    1e3e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e41:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e44:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e47:	6b c0 32             	imul   $0x32,%eax,%eax
    1e4a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e4d:	8b 45 08             	mov    0x8(%ebp),%eax
    1e50:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e53:	83 ec 0c             	sub    $0xc,%esp
    1e56:	83 ec 04             	sub    $0x4,%esp
    1e59:	89 e0                	mov    %esp,%eax
    1e5b:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1e5f:	66 89 30             	mov    %si,(%eax)
    1e62:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1e66:	88 50 02             	mov    %dl,0x2(%eax)
    1e69:	6a 32                	push   $0x32
    1e6b:	6a 32                	push   $0x32
    1e6d:	6a 00                	push   $0x0
    1e6f:	6a 00                	push   $0x0
    1e71:	53                   	push   %ebx
    1e72:	51                   	push   %ecx
    1e73:	ff 75 94             	pushl  -0x6c(%ebp)
    1e76:	57                   	push   %edi
    1e77:	e8 c8 f4 ff ff       	call   1344 <APDcCopy>
    1e7c:	83 c4 30             	add    $0x30,%esp
                    break;
    1e7f:	e9 b7 00 00 00       	jmp    1f3b <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e84:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1e87:	6a 0c                	push   $0xc
    1e89:	6a 0c                	push   $0xc
    1e8b:	6a 0c                	push   $0xc
    1e8d:	50                   	push   %eax
    1e8e:	e8 55 f6 ff ff       	call   14e8 <RGB>
    1e93:	83 c4 0c             	add    $0xc,%esp
    1e96:	8b 1d 00 2d 00 00    	mov    0x2d00,%ebx
    1e9c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e9f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ea2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ea5:	6b c0 32             	imul   $0x32,%eax,%eax
    1ea8:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1eab:	8b 45 08             	mov    0x8(%ebp),%eax
    1eae:	8d 78 3c             	lea    0x3c(%eax),%edi
    1eb1:	83 ec 0c             	sub    $0xc,%esp
    1eb4:	83 ec 04             	sub    $0x4,%esp
    1eb7:	89 e0                	mov    %esp,%eax
    1eb9:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1ebd:	66 89 30             	mov    %si,(%eax)
    1ec0:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1ec4:	88 50 02             	mov    %dl,0x2(%eax)
    1ec7:	6a 32                	push   $0x32
    1ec9:	6a 32                	push   $0x32
    1ecb:	6a 00                	push   $0x0
    1ecd:	6a 00                	push   $0x0
    1ecf:	53                   	push   %ebx
    1ed0:	51                   	push   %ecx
    1ed1:	ff 75 94             	pushl  -0x6c(%ebp)
    1ed4:	57                   	push   %edi
    1ed5:	e8 6a f4 ff ff       	call   1344 <APDcCopy>
    1eda:	83 c4 30             	add    $0x30,%esp
                    break;
    1edd:	eb 5c                	jmp    1f3b <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1edf:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1ee2:	6a 0c                	push   $0xc
    1ee4:	6a 0c                	push   $0xc
    1ee6:	6a 0c                	push   $0xc
    1ee8:	50                   	push   %eax
    1ee9:	e8 fa f5 ff ff       	call   14e8 <RGB>
    1eee:	83 c4 0c             	add    $0xc,%esp
    1ef1:	8b 1d 1c 2d 00 00    	mov    0x2d1c,%ebx
    1ef7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1efa:	6b c8 32             	imul   $0x32,%eax,%ecx
    1efd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f00:	6b c0 32             	imul   $0x32,%eax,%eax
    1f03:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f06:	8b 45 08             	mov    0x8(%ebp),%eax
    1f09:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f0c:	83 ec 0c             	sub    $0xc,%esp
    1f0f:	83 ec 04             	sub    $0x4,%esp
    1f12:	89 e0                	mov    %esp,%eax
    1f14:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1f18:	66 89 30             	mov    %si,(%eax)
    1f1b:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1f1f:	88 50 02             	mov    %dl,0x2(%eax)
    1f22:	6a 32                	push   $0x32
    1f24:	6a 32                	push   $0x32
    1f26:	6a 00                	push   $0x0
    1f28:	6a 00                	push   $0x0
    1f2a:	53                   	push   %ebx
    1f2b:	51                   	push   %ecx
    1f2c:	ff 75 94             	pushl  -0x6c(%ebp)
    1f2f:	57                   	push   %edi
    1f30:	e8 0f f4 ff ff       	call   1344 <APDcCopy>
    1f35:	83 c4 30             	add    $0x30,%esp
                    break;
    1f38:	eb 01                	jmp    1f3b <APGridPaint+0x639>
                default: break;
    1f3a:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1f3b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1f3f:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1f43:	0f 8e 7a fc ff ff    	jle    1bc3 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1f49:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1f4d:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1f51:	0f 8e 60 fc ff ff    	jle    1bb7 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1f57:	8d 45 98             	lea    -0x68(%ebp),%eax
    1f5a:	68 cd 00 00 00       	push   $0xcd
    1f5f:	6a 74                	push   $0x74
    1f61:	6a 18                	push   $0x18
    1f63:	50                   	push   %eax
    1f64:	e8 7f f5 ff ff       	call   14e8 <RGB>
    1f69:	83 c4 0c             	add    $0xc,%esp
    1f6c:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1f70:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1f74:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1f78:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1f7b:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1f82:	8d 45 98             	lea    -0x68(%ebp),%eax
    1f85:	68 cd 00 00 00       	push   $0xcd
    1f8a:	6a 74                	push   $0x74
    1f8c:	6a 18                	push   $0x18
    1f8e:	50                   	push   %eax
    1f8f:	e8 54 f5 ff ff       	call   14e8 <RGB>
    1f94:	83 c4 0c             	add    $0xc,%esp
    1f97:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1f9b:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1f9f:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1fa3:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1fa6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fa9:	8d 50 58             	lea    0x58(%eax),%edx
    1fac:	8d 45 98             	lea    -0x68(%ebp),%eax
    1faf:	ff 75 bc             	pushl  -0x44(%ebp)
    1fb2:	ff 75 b8             	pushl  -0x48(%ebp)
    1fb5:	52                   	push   %edx
    1fb6:	50                   	push   %eax
    1fb7:	e8 5c ed ff ff       	call   d18 <APSetPen>
    1fbc:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1fbf:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc2:	8d 58 58             	lea    0x58(%eax),%ebx
    1fc5:	8d 55 98             	lea    -0x68(%ebp),%edx
    1fc8:	83 ec 04             	sub    $0x4,%esp
    1fcb:	83 ec 04             	sub    $0x4,%esp
    1fce:	89 e0                	mov    %esp,%eax
    1fd0:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1fd4:	66 89 08             	mov    %cx,(%eax)
    1fd7:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1fdb:	88 48 02             	mov    %cl,0x2(%eax)
    1fde:	53                   	push   %ebx
    1fdf:	52                   	push   %edx
    1fe0:	e8 6c ed ff ff       	call   d51 <APSetBrush>
    1fe5:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1fe8:	8b 45 08             	mov    0x8(%ebp),%eax
    1feb:	83 c0 58             	add    $0x58,%eax
    1fee:	83 ec 0c             	sub    $0xc,%esp
    1ff1:	6a 32                	push   $0x32
    1ff3:	68 20 03 00 00       	push   $0x320
    1ff8:	6a 00                	push   $0x0
    1ffa:	6a 00                	push   $0x0
    1ffc:	50                   	push   %eax
    1ffd:	e8 37 f1 ff ff       	call   1139 <APDrawRect>
    2002:	83 c4 20             	add    $0x20,%esp
}
    2005:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2008:	5b                   	pop    %ebx
    2009:	5e                   	pop    %esi
    200a:	5f                   	pop    %edi
    200b:	5d                   	pop    %ebp
    200c:	c3                   	ret    

0000200d <random>:
//

#include "APLib.h"

int random(int seed)
{
    200d:	55                   	push   %ebp
    200e:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2010:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2014:	7e 08                	jle    201e <random+0x11>
{
rand_num = seed;
    2016:	8b 45 08             	mov    0x8(%ebp),%eax
    2019:	a3 c4 2a 00 00       	mov    %eax,0x2ac4
}
rand_num *= 3;
    201e:	8b 15 c4 2a 00 00    	mov    0x2ac4,%edx
    2024:	89 d0                	mov    %edx,%eax
    2026:	01 c0                	add    %eax,%eax
    2028:	01 d0                	add    %edx,%eax
    202a:	a3 c4 2a 00 00       	mov    %eax,0x2ac4
if (rand_num < 0)
    202f:	a1 c4 2a 00 00       	mov    0x2ac4,%eax
    2034:	85 c0                	test   %eax,%eax
    2036:	79 0c                	jns    2044 <random+0x37>
{
rand_num *= (-1);
    2038:	a1 c4 2a 00 00       	mov    0x2ac4,%eax
    203d:	f7 d8                	neg    %eax
    203f:	a3 c4 2a 00 00       	mov    %eax,0x2ac4
}
return rand_num % 997;
    2044:	8b 0d c4 2a 00 00    	mov    0x2ac4,%ecx
    204a:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    204f:	89 c8                	mov    %ecx,%eax
    2051:	f7 ea                	imul   %edx
    2053:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2056:	c1 f8 09             	sar    $0x9,%eax
    2059:	89 c2                	mov    %eax,%edx
    205b:	89 c8                	mov    %ecx,%eax
    205d:	c1 f8 1f             	sar    $0x1f,%eax
    2060:	29 c2                	sub    %eax,%edx
    2062:	89 d0                	mov    %edx,%eax
    2064:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    206a:	29 c1                	sub    %eax,%ecx
    206c:	89 c8                	mov    %ecx,%eax
}
    206e:	5d                   	pop    %ebp
    206f:	c3                   	ret    

00002070 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2070:	55                   	push   %ebp
    2071:	89 e5                	mov    %esp,%ebp
    2073:	53                   	push   %ebx
    2074:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2077:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    207e:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2082:	74 17                	je     209b <sprintint+0x2b>
    2084:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2088:	79 11                	jns    209b <sprintint+0x2b>
        neg = 1;
    208a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2091:	8b 45 10             	mov    0x10(%ebp),%eax
    2094:	f7 d8                	neg    %eax
    2096:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2099:	eb 06                	jmp    20a1 <sprintint+0x31>
    } else {
        x = xx;
    209b:	8b 45 10             	mov    0x10(%ebp),%eax
    209e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    20a1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    20a8:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    20ab:	8d 41 01             	lea    0x1(%ecx),%eax
    20ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
    20b1:	8b 5d 14             	mov    0x14(%ebp),%ebx
    20b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20b7:	ba 00 00 00 00       	mov    $0x0,%edx
    20bc:	f7 f3                	div    %ebx
    20be:	89 d0                	mov    %edx,%eax
    20c0:	0f b6 80 c8 2a 00 00 	movzbl 0x2ac8(%eax),%eax
    20c7:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    20cb:	8b 5d 14             	mov    0x14(%ebp),%ebx
    20ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20d1:	ba 00 00 00 00       	mov    $0x0,%edx
    20d6:	f7 f3                	div    %ebx
    20d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    20db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    20df:	75 c7                	jne    20a8 <sprintint+0x38>
    if(neg)
    20e1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    20e5:	74 0e                	je     20f5 <sprintint+0x85>
        buf[i++] = '-';
    20e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20ea:	8d 50 01             	lea    0x1(%eax),%edx
    20ed:	89 55 f8             	mov    %edx,-0x8(%ebp)
    20f0:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    20f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20f8:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    20fb:	eb 1b                	jmp    2118 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    20fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    2100:	8b 00                	mov    (%eax),%eax
    2102:	8d 48 01             	lea    0x1(%eax),%ecx
    2105:	8b 55 0c             	mov    0xc(%ebp),%edx
    2108:	89 0a                	mov    %ecx,(%edx)
    210a:	89 c2                	mov    %eax,%edx
    210c:	8b 45 08             	mov    0x8(%ebp),%eax
    210f:	01 d0                	add    %edx,%eax
    2111:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2114:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2118:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    211c:	7f df                	jg     20fd <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    211e:	eb 21                	jmp    2141 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2120:	8b 45 0c             	mov    0xc(%ebp),%eax
    2123:	8b 00                	mov    (%eax),%eax
    2125:	8d 48 01             	lea    0x1(%eax),%ecx
    2128:	8b 55 0c             	mov    0xc(%ebp),%edx
    212b:	89 0a                	mov    %ecx,(%edx)
    212d:	89 c2                	mov    %eax,%edx
    212f:	8b 45 08             	mov    0x8(%ebp),%eax
    2132:	01 c2                	add    %eax,%edx
    2134:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2137:	8b 45 f8             	mov    -0x8(%ebp),%eax
    213a:	01 c8                	add    %ecx,%eax
    213c:	0f b6 00             	movzbl (%eax),%eax
    213f:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2141:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2145:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2149:	79 d5                	jns    2120 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    214b:	90                   	nop
    214c:	83 c4 20             	add    $0x20,%esp
    214f:	5b                   	pop    %ebx
    2150:	5d                   	pop    %ebp
    2151:	c3                   	ret    

00002152 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2152:	55                   	push   %ebp
    2153:	89 e5                	mov    %esp,%ebp
    2155:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2158:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    215f:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2166:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    216d:	8d 45 0c             	lea    0xc(%ebp),%eax
    2170:	83 c0 04             	add    $0x4,%eax
    2173:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2176:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    217d:	e9 d9 01 00 00       	jmp    235b <sprintf+0x209>
        c = fmt[i] & 0xff;
    2182:	8b 55 0c             	mov    0xc(%ebp),%edx
    2185:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2188:	01 d0                	add    %edx,%eax
    218a:	0f b6 00             	movzbl (%eax),%eax
    218d:	0f be c0             	movsbl %al,%eax
    2190:	25 ff 00 00 00       	and    $0xff,%eax
    2195:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2198:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    219c:	75 2c                	jne    21ca <sprintf+0x78>
            if(c == '%'){
    219e:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    21a2:	75 0c                	jne    21b0 <sprintf+0x5e>
                state = '%';
    21a4:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    21ab:	e9 a7 01 00 00       	jmp    2357 <sprintf+0x205>
            } else {
                dst[j++] = c;
    21b0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21b3:	8d 50 01             	lea    0x1(%eax),%edx
    21b6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21b9:	89 c2                	mov    %eax,%edx
    21bb:	8b 45 08             	mov    0x8(%ebp),%eax
    21be:	01 d0                	add    %edx,%eax
    21c0:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21c3:	88 10                	mov    %dl,(%eax)
    21c5:	e9 8d 01 00 00       	jmp    2357 <sprintf+0x205>
            }
        } else if(state == '%'){
    21ca:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    21ce:	0f 85 83 01 00 00    	jne    2357 <sprintf+0x205>
            if(c == 'd'){
    21d4:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    21d8:	75 4c                	jne    2226 <sprintf+0xd4>
                buf[bi] = '\0';
    21da:	8d 55 ce             	lea    -0x32(%ebp),%edx
    21dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21e0:	01 d0                	add    %edx,%eax
    21e2:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    21e5:	83 ec 0c             	sub    $0xc,%esp
    21e8:	8d 45 ce             	lea    -0x32(%ebp),%eax
    21eb:	50                   	push   %eax
    21ec:	e8 91 e1 ff ff       	call   382 <atoi>
    21f1:	83 c4 10             	add    $0x10,%esp
    21f4:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    21f7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    21fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2201:	8b 00                	mov    (%eax),%eax
    2203:	83 ec 08             	sub    $0x8,%esp
    2206:	ff 75 d8             	pushl  -0x28(%ebp)
    2209:	6a 01                	push   $0x1
    220b:	6a 0a                	push   $0xa
    220d:	50                   	push   %eax
    220e:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2211:	50                   	push   %eax
    2212:	ff 75 08             	pushl  0x8(%ebp)
    2215:	e8 56 fe ff ff       	call   2070 <sprintint>
    221a:	83 c4 20             	add    $0x20,%esp
                ap++;
    221d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2221:	e9 2a 01 00 00       	jmp    2350 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2226:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    222a:	74 06                	je     2232 <sprintf+0xe0>
    222c:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2230:	75 4c                	jne    227e <sprintf+0x12c>
                buf[bi] = '\0';
    2232:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2235:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2238:	01 d0                	add    %edx,%eax
    223a:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    223d:	83 ec 0c             	sub    $0xc,%esp
    2240:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2243:	50                   	push   %eax
    2244:	e8 39 e1 ff ff       	call   382 <atoi>
    2249:	83 c4 10             	add    $0x10,%esp
    224c:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    224f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2256:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2259:	8b 00                	mov    (%eax),%eax
    225b:	83 ec 08             	sub    $0x8,%esp
    225e:	ff 75 dc             	pushl  -0x24(%ebp)
    2261:	6a 00                	push   $0x0
    2263:	6a 10                	push   $0x10
    2265:	50                   	push   %eax
    2266:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2269:	50                   	push   %eax
    226a:	ff 75 08             	pushl  0x8(%ebp)
    226d:	e8 fe fd ff ff       	call   2070 <sprintint>
    2272:	83 c4 20             	add    $0x20,%esp
                ap++;
    2275:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2279:	e9 d2 00 00 00       	jmp    2350 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    227e:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2282:	75 46                	jne    22ca <sprintf+0x178>
                s = (char*)*ap;
    2284:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2287:	8b 00                	mov    (%eax),%eax
    2289:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    228c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2290:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2294:	75 25                	jne    22bb <sprintf+0x169>
                    s = "(null)";
    2296:	c7 45 f4 30 25 00 00 	movl   $0x2530,-0xc(%ebp)
                while(*s != 0){
    229d:	eb 1c                	jmp    22bb <sprintf+0x169>
                    dst[j++] = *s;
    229f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22a2:	8d 50 01             	lea    0x1(%eax),%edx
    22a5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22a8:	89 c2                	mov    %eax,%edx
    22aa:	8b 45 08             	mov    0x8(%ebp),%eax
    22ad:	01 c2                	add    %eax,%edx
    22af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22b2:	0f b6 00             	movzbl (%eax),%eax
    22b5:	88 02                	mov    %al,(%edx)
                    s++;
    22b7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    22bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22be:	0f b6 00             	movzbl (%eax),%eax
    22c1:	84 c0                	test   %al,%al
    22c3:	75 da                	jne    229f <sprintf+0x14d>
    22c5:	e9 86 00 00 00       	jmp    2350 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    22ca:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    22ce:	75 1d                	jne    22ed <sprintf+0x19b>
                dst[j++] = *ap;
    22d0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22d3:	8d 50 01             	lea    0x1(%eax),%edx
    22d6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22d9:	89 c2                	mov    %eax,%edx
    22db:	8b 45 08             	mov    0x8(%ebp),%eax
    22de:	01 c2                	add    %eax,%edx
    22e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22e3:	8b 00                	mov    (%eax),%eax
    22e5:	88 02                	mov    %al,(%edx)
                ap++;
    22e7:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    22eb:	eb 63                	jmp    2350 <sprintf+0x1fe>
            } else if(c == '%'){
    22ed:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    22f1:	75 17                	jne    230a <sprintf+0x1b8>
                dst[j++] = c;
    22f3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22f6:	8d 50 01             	lea    0x1(%eax),%edx
    22f9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22fc:	89 c2                	mov    %eax,%edx
    22fe:	8b 45 08             	mov    0x8(%ebp),%eax
    2301:	01 d0                	add    %edx,%eax
    2303:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2306:	88 10                	mov    %dl,(%eax)
    2308:	eb 46                	jmp    2350 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    230a:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    230e:	7e 18                	jle    2328 <sprintf+0x1d6>
    2310:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2314:	7f 12                	jg     2328 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2316:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2319:	8d 50 01             	lea    0x1(%eax),%edx
    231c:	89 55 f0             	mov    %edx,-0x10(%ebp)
    231f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2322:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2326:	eb 2f                	jmp    2357 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2328:	8b 45 c8             	mov    -0x38(%ebp),%eax
    232b:	8d 50 01             	lea    0x1(%eax),%edx
    232e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2331:	89 c2                	mov    %eax,%edx
    2333:	8b 45 08             	mov    0x8(%ebp),%eax
    2336:	01 d0                	add    %edx,%eax
    2338:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    233b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    233e:	8d 50 01             	lea    0x1(%eax),%edx
    2341:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2344:	89 c2                	mov    %eax,%edx
    2346:	8b 45 08             	mov    0x8(%ebp),%eax
    2349:	01 d0                	add    %edx,%eax
    234b:	8b 55 e0             	mov    -0x20(%ebp),%edx
    234e:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2350:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2357:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    235b:	8b 55 0c             	mov    0xc(%ebp),%edx
    235e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2361:	01 d0                	add    %edx,%eax
    2363:	0f b6 00             	movzbl (%eax),%eax
    2366:	84 c0                	test   %al,%al
    2368:	0f 85 14 fe ff ff    	jne    2182 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    236e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2371:	8d 50 01             	lea    0x1(%eax),%edx
    2374:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2377:	89 c2                	mov    %eax,%edx
    2379:	8b 45 08             	mov    0x8(%ebp),%eax
    237c:	01 d0                	add    %edx,%eax
    237e:	c6 00 00             	movb   $0x0,(%eax)
}
    2381:	90                   	nop
    2382:	c9                   	leave  
    2383:	c3                   	ret    
