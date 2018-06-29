
_kill：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	53                   	push   %ebx
       e:	51                   	push   %ecx
       f:	83 ec 10             	sub    $0x10,%esp
      12:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 1){
      14:	83 3b 00             	cmpl   $0x0,(%ebx)
      17:	7f 17                	jg     30 <main+0x30>
    printf(2, "usage: kill pid...\n");
      19:	83 ec 08             	sub    $0x8,%esp
      1c:	68 10 25 00 00       	push   $0x2510
      21:	6a 02                	push   $0x2
      23:	e8 60 04 00 00       	call   488 <printf>
      28:	83 c4 10             	add    $0x10,%esp
    exit();
      2b:	e8 99 02 00 00       	call   2c9 <exit>
  }
  for(i=1; i<argc; i++)
      30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      37:	eb 2d                	jmp    66 <main+0x66>
    kill(atoi(argv[i]));
      39:	8b 45 f4             	mov    -0xc(%ebp),%eax
      3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      43:	8b 43 04             	mov    0x4(%ebx),%eax
      46:	01 d0                	add    %edx,%eax
      48:	8b 00                	mov    (%eax),%eax
      4a:	83 ec 0c             	sub    $0xc,%esp
      4d:	50                   	push   %eax
      4e:	e8 e4 01 00 00       	call   237 <atoi>
      53:	83 c4 10             	add    $0x10,%esp
      56:	83 ec 0c             	sub    $0xc,%esp
      59:	50                   	push   %eax
      5a:	e8 9a 02 00 00       	call   2f9 <kill>
      5f:	83 c4 10             	add    $0x10,%esp

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
      62:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      66:	8b 45 f4             	mov    -0xc(%ebp),%eax
      69:	3b 03                	cmp    (%ebx),%eax
      6b:	7c cc                	jl     39 <main+0x39>
    kill(atoi(argv[i]));
  exit();
      6d:	e8 57 02 00 00       	call   2c9 <exit>

00000072 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
      72:	55                   	push   %ebp
      73:	89 e5                	mov    %esp,%ebp
      75:	57                   	push   %edi
      76:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      77:	8b 4d 08             	mov    0x8(%ebp),%ecx
      7a:	8b 55 10             	mov    0x10(%ebp),%edx
      7d:	8b 45 0c             	mov    0xc(%ebp),%eax
      80:	89 cb                	mov    %ecx,%ebx
      82:	89 df                	mov    %ebx,%edi
      84:	89 d1                	mov    %edx,%ecx
      86:	fc                   	cld    
      87:	f3 aa                	rep stos %al,%es:(%edi)
      89:	89 ca                	mov    %ecx,%edx
      8b:	89 fb                	mov    %edi,%ebx
      8d:	89 5d 08             	mov    %ebx,0x8(%ebp)
      90:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      93:	90                   	nop
      94:	5b                   	pop    %ebx
      95:	5f                   	pop    %edi
      96:	5d                   	pop    %ebp
      97:	c3                   	ret    

00000098 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      98:	55                   	push   %ebp
      99:	89 e5                	mov    %esp,%ebp
      9b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      9e:	8b 45 08             	mov    0x8(%ebp),%eax
      a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      a4:	90                   	nop
      a5:	8b 45 08             	mov    0x8(%ebp),%eax
      a8:	8d 50 01             	lea    0x1(%eax),%edx
      ab:	89 55 08             	mov    %edx,0x8(%ebp)
      ae:	8b 55 0c             	mov    0xc(%ebp),%edx
      b1:	8d 4a 01             	lea    0x1(%edx),%ecx
      b4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
      b7:	0f b6 12             	movzbl (%edx),%edx
      ba:	88 10                	mov    %dl,(%eax)
      bc:	0f b6 00             	movzbl (%eax),%eax
      bf:	84 c0                	test   %al,%al
      c1:	75 e2                	jne    a5 <strcpy+0xd>
    ;
  return os;
      c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      c6:	c9                   	leave  
      c7:	c3                   	ret    

000000c8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      c8:	55                   	push   %ebp
      c9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      cb:	eb 08                	jmp    d5 <strcmp+0xd>
    p++, q++;
      cd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      d1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
      d5:	8b 45 08             	mov    0x8(%ebp),%eax
      d8:	0f b6 00             	movzbl (%eax),%eax
      db:	84 c0                	test   %al,%al
      dd:	74 10                	je     ef <strcmp+0x27>
      df:	8b 45 08             	mov    0x8(%ebp),%eax
      e2:	0f b6 10             	movzbl (%eax),%edx
      e5:	8b 45 0c             	mov    0xc(%ebp),%eax
      e8:	0f b6 00             	movzbl (%eax),%eax
      eb:	38 c2                	cmp    %al,%dl
      ed:	74 de                	je     cd <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
      ef:	8b 45 08             	mov    0x8(%ebp),%eax
      f2:	0f b6 00             	movzbl (%eax),%eax
      f5:	0f b6 d0             	movzbl %al,%edx
      f8:	8b 45 0c             	mov    0xc(%ebp),%eax
      fb:	0f b6 00             	movzbl (%eax),%eax
      fe:	0f b6 c0             	movzbl %al,%eax
     101:	29 c2                	sub    %eax,%edx
     103:	89 d0                	mov    %edx,%eax
}
     105:	5d                   	pop    %ebp
     106:	c3                   	ret    

00000107 <strlen>:

uint
strlen(char *s)
{
     107:	55                   	push   %ebp
     108:	89 e5                	mov    %esp,%ebp
     10a:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     10d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     114:	eb 04                	jmp    11a <strlen+0x13>
     116:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     11a:	8b 55 fc             	mov    -0x4(%ebp),%edx
     11d:	8b 45 08             	mov    0x8(%ebp),%eax
     120:	01 d0                	add    %edx,%eax
     122:	0f b6 00             	movzbl (%eax),%eax
     125:	84 c0                	test   %al,%al
     127:	75 ed                	jne    116 <strlen+0xf>
    ;
  return n;
     129:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     12c:	c9                   	leave  
     12d:	c3                   	ret    

0000012e <memset>:

void*
memset(void *dst, int c, uint n)
{
     12e:	55                   	push   %ebp
     12f:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     131:	8b 45 10             	mov    0x10(%ebp),%eax
     134:	50                   	push   %eax
     135:	ff 75 0c             	pushl  0xc(%ebp)
     138:	ff 75 08             	pushl  0x8(%ebp)
     13b:	e8 32 ff ff ff       	call   72 <stosb>
     140:	83 c4 0c             	add    $0xc,%esp
  return dst;
     143:	8b 45 08             	mov    0x8(%ebp),%eax
}
     146:	c9                   	leave  
     147:	c3                   	ret    

00000148 <strchr>:

char*
strchr(const char *s, char c)
{
     148:	55                   	push   %ebp
     149:	89 e5                	mov    %esp,%ebp
     14b:	83 ec 04             	sub    $0x4,%esp
     14e:	8b 45 0c             	mov    0xc(%ebp),%eax
     151:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     154:	eb 14                	jmp    16a <strchr+0x22>
    if(*s == c)
     156:	8b 45 08             	mov    0x8(%ebp),%eax
     159:	0f b6 00             	movzbl (%eax),%eax
     15c:	3a 45 fc             	cmp    -0x4(%ebp),%al
     15f:	75 05                	jne    166 <strchr+0x1e>
      return (char*)s;
     161:	8b 45 08             	mov    0x8(%ebp),%eax
     164:	eb 13                	jmp    179 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     166:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     16a:	8b 45 08             	mov    0x8(%ebp),%eax
     16d:	0f b6 00             	movzbl (%eax),%eax
     170:	84 c0                	test   %al,%al
     172:	75 e2                	jne    156 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     174:	b8 00 00 00 00       	mov    $0x0,%eax
}
     179:	c9                   	leave  
     17a:	c3                   	ret    

0000017b <gets>:

char*
gets(char *buf, int max)
{
     17b:	55                   	push   %ebp
     17c:	89 e5                	mov    %esp,%ebp
     17e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     181:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     188:	eb 42                	jmp    1cc <gets+0x51>
    cc = read(0, &c, 1);
     18a:	83 ec 04             	sub    $0x4,%esp
     18d:	6a 01                	push   $0x1
     18f:	8d 45 ef             	lea    -0x11(%ebp),%eax
     192:	50                   	push   %eax
     193:	6a 00                	push   $0x0
     195:	e8 47 01 00 00       	call   2e1 <read>
     19a:	83 c4 10             	add    $0x10,%esp
     19d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     1a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1a4:	7e 33                	jle    1d9 <gets+0x5e>
      break;
    buf[i++] = c;
     1a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1a9:	8d 50 01             	lea    0x1(%eax),%edx
     1ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1af:	89 c2                	mov    %eax,%edx
     1b1:	8b 45 08             	mov    0x8(%ebp),%eax
     1b4:	01 c2                	add    %eax,%edx
     1b6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1ba:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1bc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1c0:	3c 0a                	cmp    $0xa,%al
     1c2:	74 16                	je     1da <gets+0x5f>
     1c4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1c8:	3c 0d                	cmp    $0xd,%al
     1ca:	74 0e                	je     1da <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1cf:	83 c0 01             	add    $0x1,%eax
     1d2:	3b 45 0c             	cmp    0xc(%ebp),%eax
     1d5:	7c b3                	jl     18a <gets+0xf>
     1d7:	eb 01                	jmp    1da <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     1d9:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     1da:	8b 55 f4             	mov    -0xc(%ebp),%edx
     1dd:	8b 45 08             	mov    0x8(%ebp),%eax
     1e0:	01 d0                	add    %edx,%eax
     1e2:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     1e5:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1e8:	c9                   	leave  
     1e9:	c3                   	ret    

000001ea <stat>:

int
stat(char *n, struct stat *st)
{
     1ea:	55                   	push   %ebp
     1eb:	89 e5                	mov    %esp,%ebp
     1ed:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     1f0:	83 ec 08             	sub    $0x8,%esp
     1f3:	6a 00                	push   $0x0
     1f5:	ff 75 08             	pushl  0x8(%ebp)
     1f8:	e8 0c 01 00 00       	call   309 <open>
     1fd:	83 c4 10             	add    $0x10,%esp
     200:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     203:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     207:	79 07                	jns    210 <stat+0x26>
    return -1;
     209:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     20e:	eb 25                	jmp    235 <stat+0x4b>
  r = fstat(fd, st);
     210:	83 ec 08             	sub    $0x8,%esp
     213:	ff 75 0c             	pushl  0xc(%ebp)
     216:	ff 75 f4             	pushl  -0xc(%ebp)
     219:	e8 03 01 00 00       	call   321 <fstat>
     21e:	83 c4 10             	add    $0x10,%esp
     221:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     224:	83 ec 0c             	sub    $0xc,%esp
     227:	ff 75 f4             	pushl  -0xc(%ebp)
     22a:	e8 c2 00 00 00       	call   2f1 <close>
     22f:	83 c4 10             	add    $0x10,%esp
  return r;
     232:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     235:	c9                   	leave  
     236:	c3                   	ret    

00000237 <atoi>:

int
atoi(const char *s)
{
     237:	55                   	push   %ebp
     238:	89 e5                	mov    %esp,%ebp
     23a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     23d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     244:	eb 25                	jmp    26b <atoi+0x34>
    n = n*10 + *s++ - '0';
     246:	8b 55 fc             	mov    -0x4(%ebp),%edx
     249:	89 d0                	mov    %edx,%eax
     24b:	c1 e0 02             	shl    $0x2,%eax
     24e:	01 d0                	add    %edx,%eax
     250:	01 c0                	add    %eax,%eax
     252:	89 c1                	mov    %eax,%ecx
     254:	8b 45 08             	mov    0x8(%ebp),%eax
     257:	8d 50 01             	lea    0x1(%eax),%edx
     25a:	89 55 08             	mov    %edx,0x8(%ebp)
     25d:	0f b6 00             	movzbl (%eax),%eax
     260:	0f be c0             	movsbl %al,%eax
     263:	01 c8                	add    %ecx,%eax
     265:	83 e8 30             	sub    $0x30,%eax
     268:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     26b:	8b 45 08             	mov    0x8(%ebp),%eax
     26e:	0f b6 00             	movzbl (%eax),%eax
     271:	3c 2f                	cmp    $0x2f,%al
     273:	7e 0a                	jle    27f <atoi+0x48>
     275:	8b 45 08             	mov    0x8(%ebp),%eax
     278:	0f b6 00             	movzbl (%eax),%eax
     27b:	3c 39                	cmp    $0x39,%al
     27d:	7e c7                	jle    246 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     27f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     282:	c9                   	leave  
     283:	c3                   	ret    

00000284 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     284:	55                   	push   %ebp
     285:	89 e5                	mov    %esp,%ebp
     287:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     28a:	8b 45 08             	mov    0x8(%ebp),%eax
     28d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     290:	8b 45 0c             	mov    0xc(%ebp),%eax
     293:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     296:	eb 17                	jmp    2af <memmove+0x2b>
    *dst++ = *src++;
     298:	8b 45 fc             	mov    -0x4(%ebp),%eax
     29b:	8d 50 01             	lea    0x1(%eax),%edx
     29e:	89 55 fc             	mov    %edx,-0x4(%ebp)
     2a1:	8b 55 f8             	mov    -0x8(%ebp),%edx
     2a4:	8d 4a 01             	lea    0x1(%edx),%ecx
     2a7:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     2aa:	0f b6 12             	movzbl (%edx),%edx
     2ad:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     2af:	8b 45 10             	mov    0x10(%ebp),%eax
     2b2:	8d 50 ff             	lea    -0x1(%eax),%edx
     2b5:	89 55 10             	mov    %edx,0x10(%ebp)
     2b8:	85 c0                	test   %eax,%eax
     2ba:	7f dc                	jg     298 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     2bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2bf:	c9                   	leave  
     2c0:	c3                   	ret    

000002c1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2c1:	b8 01 00 00 00       	mov    $0x1,%eax
     2c6:	cd 40                	int    $0x40
     2c8:	c3                   	ret    

000002c9 <exit>:
SYSCALL(exit)
     2c9:	b8 02 00 00 00       	mov    $0x2,%eax
     2ce:	cd 40                	int    $0x40
     2d0:	c3                   	ret    

000002d1 <wait>:
SYSCALL(wait)
     2d1:	b8 03 00 00 00       	mov    $0x3,%eax
     2d6:	cd 40                	int    $0x40
     2d8:	c3                   	ret    

000002d9 <pipe>:
SYSCALL(pipe)
     2d9:	b8 04 00 00 00       	mov    $0x4,%eax
     2de:	cd 40                	int    $0x40
     2e0:	c3                   	ret    

000002e1 <read>:
SYSCALL(read)
     2e1:	b8 05 00 00 00       	mov    $0x5,%eax
     2e6:	cd 40                	int    $0x40
     2e8:	c3                   	ret    

000002e9 <write>:
SYSCALL(write)
     2e9:	b8 10 00 00 00       	mov    $0x10,%eax
     2ee:	cd 40                	int    $0x40
     2f0:	c3                   	ret    

000002f1 <close>:
SYSCALL(close)
     2f1:	b8 15 00 00 00       	mov    $0x15,%eax
     2f6:	cd 40                	int    $0x40
     2f8:	c3                   	ret    

000002f9 <kill>:
SYSCALL(kill)
     2f9:	b8 06 00 00 00       	mov    $0x6,%eax
     2fe:	cd 40                	int    $0x40
     300:	c3                   	ret    

00000301 <exec>:
SYSCALL(exec)
     301:	b8 07 00 00 00       	mov    $0x7,%eax
     306:	cd 40                	int    $0x40
     308:	c3                   	ret    

00000309 <open>:
SYSCALL(open)
     309:	b8 0f 00 00 00       	mov    $0xf,%eax
     30e:	cd 40                	int    $0x40
     310:	c3                   	ret    

00000311 <mknod>:
SYSCALL(mknod)
     311:	b8 11 00 00 00       	mov    $0x11,%eax
     316:	cd 40                	int    $0x40
     318:	c3                   	ret    

00000319 <unlink>:
SYSCALL(unlink)
     319:	b8 12 00 00 00       	mov    $0x12,%eax
     31e:	cd 40                	int    $0x40
     320:	c3                   	ret    

00000321 <fstat>:
SYSCALL(fstat)
     321:	b8 08 00 00 00       	mov    $0x8,%eax
     326:	cd 40                	int    $0x40
     328:	c3                   	ret    

00000329 <link>:
SYSCALL(link)
     329:	b8 13 00 00 00       	mov    $0x13,%eax
     32e:	cd 40                	int    $0x40
     330:	c3                   	ret    

00000331 <mkdir>:
SYSCALL(mkdir)
     331:	b8 14 00 00 00       	mov    $0x14,%eax
     336:	cd 40                	int    $0x40
     338:	c3                   	ret    

00000339 <chdir>:
SYSCALL(chdir)
     339:	b8 09 00 00 00       	mov    $0x9,%eax
     33e:	cd 40                	int    $0x40
     340:	c3                   	ret    

00000341 <dup>:
SYSCALL(dup)
     341:	b8 0a 00 00 00       	mov    $0xa,%eax
     346:	cd 40                	int    $0x40
     348:	c3                   	ret    

00000349 <getpid>:
SYSCALL(getpid)
     349:	b8 0b 00 00 00       	mov    $0xb,%eax
     34e:	cd 40                	int    $0x40
     350:	c3                   	ret    

00000351 <sbrk>:
SYSCALL(sbrk)
     351:	b8 0c 00 00 00       	mov    $0xc,%eax
     356:	cd 40                	int    $0x40
     358:	c3                   	ret    

00000359 <sleep>:
SYSCALL(sleep)
     359:	b8 0d 00 00 00       	mov    $0xd,%eax
     35e:	cd 40                	int    $0x40
     360:	c3                   	ret    

00000361 <uptime>:
SYSCALL(uptime)
     361:	b8 0e 00 00 00       	mov    $0xe,%eax
     366:	cd 40                	int    $0x40
     368:	c3                   	ret    

00000369 <paintWindow>:

SYSCALL(paintWindow)
     369:	b8 16 00 00 00       	mov    $0x16,%eax
     36e:	cd 40                	int    $0x40
     370:	c3                   	ret    

00000371 <sendMessage>:
SYSCALL(sendMessage)
     371:	b8 17 00 00 00       	mov    $0x17,%eax
     376:	cd 40                	int    $0x40
     378:	c3                   	ret    

00000379 <getMessage>:
SYSCALL(getMessage)
     379:	b8 19 00 00 00       	mov    $0x19,%eax
     37e:	cd 40                	int    $0x40
     380:	c3                   	ret    

00000381 <registWindow>:
SYSCALL(registWindow)
     381:	b8 18 00 00 00       	mov    $0x18,%eax
     386:	cd 40                	int    $0x40
     388:	c3                   	ret    

00000389 <changePosition>:
SYSCALL(changePosition)
     389:	b8 1a 00 00 00       	mov    $0x1a,%eax
     38e:	cd 40                	int    $0x40
     390:	c3                   	ret    

00000391 <setupTimer>:
SYSCALL(setupTimer)
     391:	b8 1b 00 00 00       	mov    $0x1b,%eax
     396:	cd 40                	int    $0x40
     398:	c3                   	ret    

00000399 <deleteTimer>:
SYSCALL(deleteTimer)
     399:	b8 1c 00 00 00       	mov    $0x1c,%eax
     39e:	cd 40                	int    $0x40
     3a0:	c3                   	ret    

000003a1 <getCurrentTime>:
SYSCALL(getCurrentTime)
     3a1:	b8 1d 00 00 00       	mov    $0x1d,%eax
     3a6:	cd 40                	int    $0x40
     3a8:	c3                   	ret    

000003a9 <removeWindow>:
SYSCALL(removeWindow)
     3a9:	b8 1e 00 00 00       	mov    $0x1e,%eax
     3ae:	cd 40                	int    $0x40
     3b0:	c3                   	ret    

000003b1 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3b1:	55                   	push   %ebp
     3b2:	89 e5                	mov    %esp,%ebp
     3b4:	83 ec 18             	sub    $0x18,%esp
     3b7:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ba:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3bd:	83 ec 04             	sub    $0x4,%esp
     3c0:	6a 01                	push   $0x1
     3c2:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3c5:	50                   	push   %eax
     3c6:	ff 75 08             	pushl  0x8(%ebp)
     3c9:	e8 1b ff ff ff       	call   2e9 <write>
     3ce:	83 c4 10             	add    $0x10,%esp
}
     3d1:	90                   	nop
     3d2:	c9                   	leave  
     3d3:	c3                   	ret    

000003d4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3d4:	55                   	push   %ebp
     3d5:	89 e5                	mov    %esp,%ebp
     3d7:	53                   	push   %ebx
     3d8:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3db:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3e2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3e6:	74 17                	je     3ff <printint+0x2b>
     3e8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3ec:	79 11                	jns    3ff <printint+0x2b>
    neg = 1;
     3ee:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3f5:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f8:	f7 d8                	neg    %eax
     3fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3fd:	eb 06                	jmp    405 <printint+0x31>
  } else {
    x = xx;
     3ff:	8b 45 0c             	mov    0xc(%ebp),%eax
     402:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     405:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     40c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     40f:	8d 41 01             	lea    0x1(%ecx),%eax
     412:	89 45 f4             	mov    %eax,-0xc(%ebp)
     415:	8b 5d 10             	mov    0x10(%ebp),%ebx
     418:	8b 45 ec             	mov    -0x14(%ebp),%eax
     41b:	ba 00 00 00 00       	mov    $0x0,%edx
     420:	f7 f3                	div    %ebx
     422:	89 d0                	mov    %edx,%eax
     424:	0f b6 80 60 2c 00 00 	movzbl 0x2c60(%eax),%eax
     42b:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     42f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     432:	8b 45 ec             	mov    -0x14(%ebp),%eax
     435:	ba 00 00 00 00       	mov    $0x0,%edx
     43a:	f7 f3                	div    %ebx
     43c:	89 45 ec             	mov    %eax,-0x14(%ebp)
     43f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     443:	75 c7                	jne    40c <printint+0x38>
  if(neg)
     445:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     449:	74 2d                	je     478 <printint+0xa4>
    buf[i++] = '-';
     44b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     44e:	8d 50 01             	lea    0x1(%eax),%edx
     451:	89 55 f4             	mov    %edx,-0xc(%ebp)
     454:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     459:	eb 1d                	jmp    478 <printint+0xa4>
    putc(fd, buf[i]);
     45b:	8d 55 dc             	lea    -0x24(%ebp),%edx
     45e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     461:	01 d0                	add    %edx,%eax
     463:	0f b6 00             	movzbl (%eax),%eax
     466:	0f be c0             	movsbl %al,%eax
     469:	83 ec 08             	sub    $0x8,%esp
     46c:	50                   	push   %eax
     46d:	ff 75 08             	pushl  0x8(%ebp)
     470:	e8 3c ff ff ff       	call   3b1 <putc>
     475:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     478:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     47c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     480:	79 d9                	jns    45b <printint+0x87>
    putc(fd, buf[i]);
}
     482:	90                   	nop
     483:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     486:	c9                   	leave  
     487:	c3                   	ret    

00000488 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     488:	55                   	push   %ebp
     489:	89 e5                	mov    %esp,%ebp
     48b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     48e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     495:	8d 45 0c             	lea    0xc(%ebp),%eax
     498:	83 c0 04             	add    $0x4,%eax
     49b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     49e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4a5:	e9 59 01 00 00       	jmp    603 <printf+0x17b>
    c = fmt[i] & 0xff;
     4aa:	8b 55 0c             	mov    0xc(%ebp),%edx
     4ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4b0:	01 d0                	add    %edx,%eax
     4b2:	0f b6 00             	movzbl (%eax),%eax
     4b5:	0f be c0             	movsbl %al,%eax
     4b8:	25 ff 00 00 00       	and    $0xff,%eax
     4bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4c0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4c4:	75 2c                	jne    4f2 <printf+0x6a>
      if(c == '%'){
     4c6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4ca:	75 0c                	jne    4d8 <printf+0x50>
        state = '%';
     4cc:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4d3:	e9 27 01 00 00       	jmp    5ff <printf+0x177>
      } else {
        putc(fd, c);
     4d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4db:	0f be c0             	movsbl %al,%eax
     4de:	83 ec 08             	sub    $0x8,%esp
     4e1:	50                   	push   %eax
     4e2:	ff 75 08             	pushl  0x8(%ebp)
     4e5:	e8 c7 fe ff ff       	call   3b1 <putc>
     4ea:	83 c4 10             	add    $0x10,%esp
     4ed:	e9 0d 01 00 00       	jmp    5ff <printf+0x177>
      }
    } else if(state == '%'){
     4f2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4f6:	0f 85 03 01 00 00    	jne    5ff <printf+0x177>
      if(c == 'd'){
     4fc:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     500:	75 1e                	jne    520 <printf+0x98>
        printint(fd, *ap, 10, 1);
     502:	8b 45 e8             	mov    -0x18(%ebp),%eax
     505:	8b 00                	mov    (%eax),%eax
     507:	6a 01                	push   $0x1
     509:	6a 0a                	push   $0xa
     50b:	50                   	push   %eax
     50c:	ff 75 08             	pushl  0x8(%ebp)
     50f:	e8 c0 fe ff ff       	call   3d4 <printint>
     514:	83 c4 10             	add    $0x10,%esp
        ap++;
     517:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     51b:	e9 d8 00 00 00       	jmp    5f8 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     520:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     524:	74 06                	je     52c <printf+0xa4>
     526:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     52a:	75 1e                	jne    54a <printf+0xc2>
        printint(fd, *ap, 16, 0);
     52c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     52f:	8b 00                	mov    (%eax),%eax
     531:	6a 00                	push   $0x0
     533:	6a 10                	push   $0x10
     535:	50                   	push   %eax
     536:	ff 75 08             	pushl  0x8(%ebp)
     539:	e8 96 fe ff ff       	call   3d4 <printint>
     53e:	83 c4 10             	add    $0x10,%esp
        ap++;
     541:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     545:	e9 ae 00 00 00       	jmp    5f8 <printf+0x170>
      } else if(c == 's'){
     54a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     54e:	75 43                	jne    593 <printf+0x10b>
        s = (char*)*ap;
     550:	8b 45 e8             	mov    -0x18(%ebp),%eax
     553:	8b 00                	mov    (%eax),%eax
     555:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     558:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     55c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     560:	75 25                	jne    587 <printf+0xff>
          s = "(null)";
     562:	c7 45 f4 24 25 00 00 	movl   $0x2524,-0xc(%ebp)
        while(*s != 0){
     569:	eb 1c                	jmp    587 <printf+0xff>
          putc(fd, *s);
     56b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     56e:	0f b6 00             	movzbl (%eax),%eax
     571:	0f be c0             	movsbl %al,%eax
     574:	83 ec 08             	sub    $0x8,%esp
     577:	50                   	push   %eax
     578:	ff 75 08             	pushl  0x8(%ebp)
     57b:	e8 31 fe ff ff       	call   3b1 <putc>
     580:	83 c4 10             	add    $0x10,%esp
          s++;
     583:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     587:	8b 45 f4             	mov    -0xc(%ebp),%eax
     58a:	0f b6 00             	movzbl (%eax),%eax
     58d:	84 c0                	test   %al,%al
     58f:	75 da                	jne    56b <printf+0xe3>
     591:	eb 65                	jmp    5f8 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     593:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     597:	75 1d                	jne    5b6 <printf+0x12e>
        putc(fd, *ap);
     599:	8b 45 e8             	mov    -0x18(%ebp),%eax
     59c:	8b 00                	mov    (%eax),%eax
     59e:	0f be c0             	movsbl %al,%eax
     5a1:	83 ec 08             	sub    $0x8,%esp
     5a4:	50                   	push   %eax
     5a5:	ff 75 08             	pushl  0x8(%ebp)
     5a8:	e8 04 fe ff ff       	call   3b1 <putc>
     5ad:	83 c4 10             	add    $0x10,%esp
        ap++;
     5b0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5b4:	eb 42                	jmp    5f8 <printf+0x170>
      } else if(c == '%'){
     5b6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5ba:	75 17                	jne    5d3 <printf+0x14b>
        putc(fd, c);
     5bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5bf:	0f be c0             	movsbl %al,%eax
     5c2:	83 ec 08             	sub    $0x8,%esp
     5c5:	50                   	push   %eax
     5c6:	ff 75 08             	pushl  0x8(%ebp)
     5c9:	e8 e3 fd ff ff       	call   3b1 <putc>
     5ce:	83 c4 10             	add    $0x10,%esp
     5d1:	eb 25                	jmp    5f8 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5d3:	83 ec 08             	sub    $0x8,%esp
     5d6:	6a 25                	push   $0x25
     5d8:	ff 75 08             	pushl  0x8(%ebp)
     5db:	e8 d1 fd ff ff       	call   3b1 <putc>
     5e0:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5e6:	0f be c0             	movsbl %al,%eax
     5e9:	83 ec 08             	sub    $0x8,%esp
     5ec:	50                   	push   %eax
     5ed:	ff 75 08             	pushl  0x8(%ebp)
     5f0:	e8 bc fd ff ff       	call   3b1 <putc>
     5f5:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5f8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5ff:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     603:	8b 55 0c             	mov    0xc(%ebp),%edx
     606:	8b 45 f0             	mov    -0x10(%ebp),%eax
     609:	01 d0                	add    %edx,%eax
     60b:	0f b6 00             	movzbl (%eax),%eax
     60e:	84 c0                	test   %al,%al
     610:	0f 85 94 fe ff ff    	jne    4aa <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     616:	90                   	nop
     617:	c9                   	leave  
     618:	c3                   	ret    

00000619 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     619:	55                   	push   %ebp
     61a:	89 e5                	mov    %esp,%ebp
     61c:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     61f:	8b 45 08             	mov    0x8(%ebp),%eax
     622:	83 e8 08             	sub    $0x8,%eax
     625:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     628:	a1 c0 68 00 00       	mov    0x68c0,%eax
     62d:	89 45 fc             	mov    %eax,-0x4(%ebp)
     630:	eb 24                	jmp    656 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     632:	8b 45 fc             	mov    -0x4(%ebp),%eax
     635:	8b 00                	mov    (%eax),%eax
     637:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     63a:	77 12                	ja     64e <free+0x35>
     63c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     63f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     642:	77 24                	ja     668 <free+0x4f>
     644:	8b 45 fc             	mov    -0x4(%ebp),%eax
     647:	8b 00                	mov    (%eax),%eax
     649:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     64c:	77 1a                	ja     668 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     64e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     651:	8b 00                	mov    (%eax),%eax
     653:	89 45 fc             	mov    %eax,-0x4(%ebp)
     656:	8b 45 f8             	mov    -0x8(%ebp),%eax
     659:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     65c:	76 d4                	jbe    632 <free+0x19>
     65e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     661:	8b 00                	mov    (%eax),%eax
     663:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     666:	76 ca                	jbe    632 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     668:	8b 45 f8             	mov    -0x8(%ebp),%eax
     66b:	8b 40 04             	mov    0x4(%eax),%eax
     66e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     675:	8b 45 f8             	mov    -0x8(%ebp),%eax
     678:	01 c2                	add    %eax,%edx
     67a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67d:	8b 00                	mov    (%eax),%eax
     67f:	39 c2                	cmp    %eax,%edx
     681:	75 24                	jne    6a7 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     683:	8b 45 f8             	mov    -0x8(%ebp),%eax
     686:	8b 50 04             	mov    0x4(%eax),%edx
     689:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68c:	8b 00                	mov    (%eax),%eax
     68e:	8b 40 04             	mov    0x4(%eax),%eax
     691:	01 c2                	add    %eax,%edx
     693:	8b 45 f8             	mov    -0x8(%ebp),%eax
     696:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     699:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69c:	8b 00                	mov    (%eax),%eax
     69e:	8b 10                	mov    (%eax),%edx
     6a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a3:	89 10                	mov    %edx,(%eax)
     6a5:	eb 0a                	jmp    6b1 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     6a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6aa:	8b 10                	mov    (%eax),%edx
     6ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6af:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b4:	8b 40 04             	mov    0x4(%eax),%eax
     6b7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6be:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c1:	01 d0                	add    %edx,%eax
     6c3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6c6:	75 20                	jne    6e8 <free+0xcf>
    p->s.size += bp->s.size;
     6c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cb:	8b 50 04             	mov    0x4(%eax),%edx
     6ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6d1:	8b 40 04             	mov    0x4(%eax),%eax
     6d4:	01 c2                	add    %eax,%edx
     6d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d9:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6df:	8b 10                	mov    (%eax),%edx
     6e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e4:	89 10                	mov    %edx,(%eax)
     6e6:	eb 08                	jmp    6f0 <free+0xd7>
  } else
    p->s.ptr = bp;
     6e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6eb:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6ee:	89 10                	mov    %edx,(%eax)
  freep = p;
     6f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f3:	a3 c0 68 00 00       	mov    %eax,0x68c0
}
     6f8:	90                   	nop
     6f9:	c9                   	leave  
     6fa:	c3                   	ret    

000006fb <morecore>:

static Header*
morecore(uint nu)
{
     6fb:	55                   	push   %ebp
     6fc:	89 e5                	mov    %esp,%ebp
     6fe:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     701:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     708:	77 07                	ja     711 <morecore+0x16>
    nu = 4096;
     70a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     711:	8b 45 08             	mov    0x8(%ebp),%eax
     714:	c1 e0 03             	shl    $0x3,%eax
     717:	83 ec 0c             	sub    $0xc,%esp
     71a:	50                   	push   %eax
     71b:	e8 31 fc ff ff       	call   351 <sbrk>
     720:	83 c4 10             	add    $0x10,%esp
     723:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     726:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     72a:	75 07                	jne    733 <morecore+0x38>
    return 0;
     72c:	b8 00 00 00 00       	mov    $0x0,%eax
     731:	eb 26                	jmp    759 <morecore+0x5e>
  hp = (Header*)p;
     733:	8b 45 f4             	mov    -0xc(%ebp),%eax
     736:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     739:	8b 45 f0             	mov    -0x10(%ebp),%eax
     73c:	8b 55 08             	mov    0x8(%ebp),%edx
     73f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     742:	8b 45 f0             	mov    -0x10(%ebp),%eax
     745:	83 c0 08             	add    $0x8,%eax
     748:	83 ec 0c             	sub    $0xc,%esp
     74b:	50                   	push   %eax
     74c:	e8 c8 fe ff ff       	call   619 <free>
     751:	83 c4 10             	add    $0x10,%esp
  return freep;
     754:	a1 c0 68 00 00       	mov    0x68c0,%eax
}
     759:	c9                   	leave  
     75a:	c3                   	ret    

0000075b <malloc>:

void*
malloc(uint nbytes)
{
     75b:	55                   	push   %ebp
     75c:	89 e5                	mov    %esp,%ebp
     75e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     761:	8b 45 08             	mov    0x8(%ebp),%eax
     764:	83 c0 07             	add    $0x7,%eax
     767:	c1 e8 03             	shr    $0x3,%eax
     76a:	83 c0 01             	add    $0x1,%eax
     76d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     770:	a1 c0 68 00 00       	mov    0x68c0,%eax
     775:	89 45 f0             	mov    %eax,-0x10(%ebp)
     778:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     77c:	75 23                	jne    7a1 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     77e:	c7 45 f0 b8 68 00 00 	movl   $0x68b8,-0x10(%ebp)
     785:	8b 45 f0             	mov    -0x10(%ebp),%eax
     788:	a3 c0 68 00 00       	mov    %eax,0x68c0
     78d:	a1 c0 68 00 00       	mov    0x68c0,%eax
     792:	a3 b8 68 00 00       	mov    %eax,0x68b8
    base.s.size = 0;
     797:	c7 05 bc 68 00 00 00 	movl   $0x0,0x68bc
     79e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7a4:	8b 00                	mov    (%eax),%eax
     7a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ac:	8b 40 04             	mov    0x4(%eax),%eax
     7af:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7b2:	72 4d                	jb     801 <malloc+0xa6>
      if(p->s.size == nunits)
     7b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b7:	8b 40 04             	mov    0x4(%eax),%eax
     7ba:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7bd:	75 0c                	jne    7cb <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c2:	8b 10                	mov    (%eax),%edx
     7c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7c7:	89 10                	mov    %edx,(%eax)
     7c9:	eb 26                	jmp    7f1 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ce:	8b 40 04             	mov    0x4(%eax),%eax
     7d1:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7d4:	89 c2                	mov    %eax,%edx
     7d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7df:	8b 40 04             	mov    0x4(%eax),%eax
     7e2:	c1 e0 03             	shl    $0x3,%eax
     7e5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7eb:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7ee:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7f4:	a3 c0 68 00 00       	mov    %eax,0x68c0
      return (void*)(p + 1);
     7f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7fc:	83 c0 08             	add    $0x8,%eax
     7ff:	eb 3b                	jmp    83c <malloc+0xe1>
    }
    if(p == freep)
     801:	a1 c0 68 00 00       	mov    0x68c0,%eax
     806:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     809:	75 1e                	jne    829 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     80b:	83 ec 0c             	sub    $0xc,%esp
     80e:	ff 75 ec             	pushl  -0x14(%ebp)
     811:	e8 e5 fe ff ff       	call   6fb <morecore>
     816:	83 c4 10             	add    $0x10,%esp
     819:	89 45 f4             	mov    %eax,-0xc(%ebp)
     81c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     820:	75 07                	jne    829 <malloc+0xce>
        return 0;
     822:	b8 00 00 00 00       	mov    $0x0,%eax
     827:	eb 13                	jmp    83c <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     829:	8b 45 f4             	mov    -0xc(%ebp),%eax
     82c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     82f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     832:	8b 00                	mov    (%eax),%eax
     834:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     837:	e9 6d ff ff ff       	jmp    7a9 <malloc+0x4e>
}
     83c:	c9                   	leave  
     83d:	c3                   	ret    

0000083e <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     83e:	55                   	push   %ebp
     83f:	89 e5                	mov    %esp,%ebp
     841:	83 ec 1c             	sub    $0x1c,%esp
     844:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     847:	8b 55 10             	mov    0x10(%ebp),%edx
     84a:	8b 45 14             	mov    0x14(%ebp),%eax
     84d:	88 4d ec             	mov    %cl,-0x14(%ebp)
     850:	88 55 e8             	mov    %dl,-0x18(%ebp)
     853:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     856:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     85a:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     85d:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     861:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     864:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     868:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     86b:	8b 45 08             	mov    0x8(%ebp),%eax
     86e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     872:	66 89 10             	mov    %dx,(%eax)
     875:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     879:	88 50 02             	mov    %dl,0x2(%eax)
}
     87c:	8b 45 08             	mov    0x8(%ebp),%eax
     87f:	c9                   	leave  
     880:	c2 04 00             	ret    $0x4

00000883 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     883:	55                   	push   %ebp
     884:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     886:	8b 45 08             	mov    0x8(%ebp),%eax
     889:	2b 45 10             	sub    0x10(%ebp),%eax
     88c:	89 c2                	mov    %eax,%edx
     88e:	8b 45 08             	mov    0x8(%ebp),%eax
     891:	2b 45 10             	sub    0x10(%ebp),%eax
     894:	0f af d0             	imul   %eax,%edx
     897:	8b 45 0c             	mov    0xc(%ebp),%eax
     89a:	2b 45 14             	sub    0x14(%ebp),%eax
     89d:	89 c1                	mov    %eax,%ecx
     89f:	8b 45 0c             	mov    0xc(%ebp),%eax
     8a2:	2b 45 14             	sub    0x14(%ebp),%eax
     8a5:	0f af c1             	imul   %ecx,%eax
     8a8:	01 d0                	add    %edx,%eax
}
     8aa:	5d                   	pop    %ebp
     8ab:	c3                   	ret    

000008ac <abs_int>:

static inline int abs_int(int x)
{
     8ac:	55                   	push   %ebp
     8ad:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     8af:	8b 45 08             	mov    0x8(%ebp),%eax
     8b2:	99                   	cltd   
     8b3:	89 d0                	mov    %edx,%eax
     8b5:	33 45 08             	xor    0x8(%ebp),%eax
     8b8:	29 d0                	sub    %edx,%eax
}
     8ba:	5d                   	pop    %ebp
     8bb:	c3                   	ret    

000008bc <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     8bc:	55                   	push   %ebp
     8bd:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     8bf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8c3:	79 07                	jns    8cc <APGetIndex+0x10>
        return X_SMALLER;
     8c5:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8ca:	eb 40                	jmp    90c <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8cc:	8b 45 08             	mov    0x8(%ebp),%eax
     8cf:	8b 00                	mov    (%eax),%eax
     8d1:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8d4:	7f 07                	jg     8dd <APGetIndex+0x21>
        return X_BIGGER;
     8d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8db:	eb 2f                	jmp    90c <APGetIndex+0x50>
    if (y < 0)
     8dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8e1:	79 07                	jns    8ea <APGetIndex+0x2e>
        return Y_SMALLER;
     8e3:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8e8:	eb 22                	jmp    90c <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8ea:	8b 45 08             	mov    0x8(%ebp),%eax
     8ed:	8b 40 04             	mov    0x4(%eax),%eax
     8f0:	3b 45 10             	cmp    0x10(%ebp),%eax
     8f3:	7f 07                	jg     8fc <APGetIndex+0x40>
        return Y_BIGGER;
     8f5:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8fa:	eb 10                	jmp    90c <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8fc:	8b 45 08             	mov    0x8(%ebp),%eax
     8ff:	8b 00                	mov    (%eax),%eax
     901:	0f af 45 10          	imul   0x10(%ebp),%eax
     905:	89 c2                	mov    %eax,%edx
     907:	8b 45 0c             	mov    0xc(%ebp),%eax
     90a:	01 d0                	add    %edx,%eax
}
     90c:	5d                   	pop    %ebp
     90d:	c3                   	ret    

0000090e <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     90e:	55                   	push   %ebp
     90f:	89 e5                	mov    %esp,%ebp
     911:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     914:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     91b:	8b 45 cc             	mov    -0x34(%ebp),%eax
     91e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     921:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     928:	83 ec 08             	sub    $0x8,%esp
     92b:	6a 00                	push   $0x0
     92d:	ff 75 0c             	pushl  0xc(%ebp)
     930:	e8 d4 f9 ff ff       	call   309 <open>
     935:	83 c4 10             	add    $0x10,%esp
     938:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     93b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     93f:	79 2e                	jns    96f <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     941:	83 ec 04             	sub    $0x4,%esp
     944:	ff 75 0c             	pushl  0xc(%ebp)
     947:	68 2b 25 00 00       	push   $0x252b
     94c:	6a 01                	push   $0x1
     94e:	e8 35 fb ff ff       	call   488 <printf>
     953:	83 c4 10             	add    $0x10,%esp
        return bmp;
     956:	8b 45 08             	mov    0x8(%ebp),%eax
     959:	8b 55 c8             	mov    -0x38(%ebp),%edx
     95c:	89 10                	mov    %edx,(%eax)
     95e:	8b 55 cc             	mov    -0x34(%ebp),%edx
     961:	89 50 04             	mov    %edx,0x4(%eax)
     964:	8b 55 d0             	mov    -0x30(%ebp),%edx
     967:	89 50 08             	mov    %edx,0x8(%eax)
     96a:	e9 d2 01 00 00       	jmp    b41 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     96f:	83 ec 04             	sub    $0x4,%esp
     972:	6a 0e                	push   $0xe
     974:	8d 45 ba             	lea    -0x46(%ebp),%eax
     977:	50                   	push   %eax
     978:	ff 75 ec             	pushl  -0x14(%ebp)
     97b:	e8 61 f9 ff ff       	call   2e1 <read>
     980:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     983:	83 ec 04             	sub    $0x4,%esp
     986:	6a 28                	push   $0x28
     988:	8d 45 92             	lea    -0x6e(%ebp),%eax
     98b:	50                   	push   %eax
     98c:	ff 75 ec             	pushl  -0x14(%ebp)
     98f:	e8 4d f9 ff ff       	call   2e1 <read>
     994:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     997:	8b 45 96             	mov    -0x6a(%ebp),%eax
     99a:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     99d:	8b 45 9a             	mov    -0x66(%ebp),%eax
     9a0:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     9a3:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9a6:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9a9:	0f af d0             	imul   %eax,%edx
     9ac:	89 d0                	mov    %edx,%eax
     9ae:	01 c0                	add    %eax,%eax
     9b0:	01 d0                	add    %edx,%eax
     9b2:	83 ec 0c             	sub    $0xc,%esp
     9b5:	50                   	push   %eax
     9b6:	e8 a0 fd ff ff       	call   75b <malloc>
     9bb:	83 c4 10             	add    $0x10,%esp
     9be:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9c1:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9c5:	0f b7 c0             	movzwl %ax,%eax
     9c8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9cb:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9d1:	0f af c2             	imul   %edx,%eax
     9d4:	83 c0 1f             	add    $0x1f,%eax
     9d7:	c1 e8 05             	shr    $0x5,%eax
     9da:	c1 e0 02             	shl    $0x2,%eax
     9dd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9e0:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9e6:	0f af c2             	imul   %edx,%eax
     9e9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9ef:	83 ec 0c             	sub    $0xc,%esp
     9f2:	50                   	push   %eax
     9f3:	e8 63 fd ff ff       	call   75b <malloc>
     9f8:	83 c4 10             	add    $0x10,%esp
     9fb:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9fe:	83 ec 04             	sub    $0x4,%esp
     a01:	ff 75 e0             	pushl  -0x20(%ebp)
     a04:	ff 75 dc             	pushl  -0x24(%ebp)
     a07:	ff 75 ec             	pushl  -0x14(%ebp)
     a0a:	e8 d2 f8 ff ff       	call   2e1 <read>
     a0f:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a12:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a16:	66 c1 e8 03          	shr    $0x3,%ax
     a1a:	0f b7 c0             	movzwl %ax,%eax
     a1d:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a20:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a27:	e9 e5 00 00 00       	jmp    b11 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a2c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a32:	29 c2                	sub    %eax,%edx
     a34:	89 d0                	mov    %edx,%eax
     a36:	8d 50 ff             	lea    -0x1(%eax),%edx
     a39:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a3c:	0f af c2             	imul   %edx,%eax
     a3f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a42:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a49:	e9 b1 00 00 00       	jmp    aff <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a4e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a51:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a54:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a57:	01 c8                	add    %ecx,%eax
     a59:	89 c1                	mov    %eax,%ecx
     a5b:	89 c8                	mov    %ecx,%eax
     a5d:	01 c0                	add    %eax,%eax
     a5f:	01 c8                	add    %ecx,%eax
     a61:	01 c2                	add    %eax,%edx
     a63:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a66:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a6a:	89 c1                	mov    %eax,%ecx
     a6c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a6f:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a73:	01 c1                	add    %eax,%ecx
     a75:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a78:	01 c8                	add    %ecx,%eax
     a7a:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a7d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a80:	01 c8                	add    %ecx,%eax
     a82:	0f b6 00             	movzbl (%eax),%eax
     a85:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a88:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a8b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a91:	01 c8                	add    %ecx,%eax
     a93:	89 c1                	mov    %eax,%ecx
     a95:	89 c8                	mov    %ecx,%eax
     a97:	01 c0                	add    %eax,%eax
     a99:	01 c8                	add    %ecx,%eax
     a9b:	01 c2                	add    %eax,%edx
     a9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa0:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     aa4:	89 c1                	mov    %eax,%ecx
     aa6:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aa9:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     aad:	01 c1                	add    %eax,%ecx
     aaf:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ab2:	01 c8                	add    %ecx,%eax
     ab4:	8d 48 fe             	lea    -0x2(%eax),%ecx
     ab7:	8b 45 dc             	mov    -0x24(%ebp),%eax
     aba:	01 c8                	add    %ecx,%eax
     abc:	0f b6 00             	movzbl (%eax),%eax
     abf:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     ac2:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ac5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ac8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     acb:	01 c8                	add    %ecx,%eax
     acd:	89 c1                	mov    %eax,%ecx
     acf:	89 c8                	mov    %ecx,%eax
     ad1:	01 c0                	add    %eax,%eax
     ad3:	01 c8                	add    %ecx,%eax
     ad5:	01 c2                	add    %eax,%edx
     ad7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ada:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ade:	89 c1                	mov    %eax,%ecx
     ae0:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ae3:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ae7:	01 c1                	add    %eax,%ecx
     ae9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aec:	01 c8                	add    %ecx,%eax
     aee:	8d 48 fd             	lea    -0x3(%eax),%ecx
     af1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     af4:	01 c8                	add    %ecx,%eax
     af6:	0f b6 00             	movzbl (%eax),%eax
     af9:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     afb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     aff:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b02:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b05:	39 c2                	cmp    %eax,%edx
     b07:	0f 87 41 ff ff ff    	ja     a4e <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b0d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b11:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b14:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b17:	39 c2                	cmp    %eax,%edx
     b19:	0f 87 0d ff ff ff    	ja     a2c <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b1f:	83 ec 0c             	sub    $0xc,%esp
     b22:	ff 75 ec             	pushl  -0x14(%ebp)
     b25:	e8 c7 f7 ff ff       	call   2f1 <close>
     b2a:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b2d:	8b 45 08             	mov    0x8(%ebp),%eax
     b30:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b33:	89 10                	mov    %edx,(%eax)
     b35:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b38:	89 50 04             	mov    %edx,0x4(%eax)
     b3b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b3e:	89 50 08             	mov    %edx,0x8(%eax)
}
     b41:	8b 45 08             	mov    0x8(%ebp),%eax
     b44:	c9                   	leave  
     b45:	c2 04 00             	ret    $0x4

00000b48 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b48:	55                   	push   %ebp
     b49:	89 e5                	mov    %esp,%ebp
     b4b:	53                   	push   %ebx
     b4c:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b4f:	83 ec 0c             	sub    $0xc,%esp
     b52:	6a 1c                	push   $0x1c
     b54:	e8 02 fc ff ff       	call   75b <malloc>
     b59:	83 c4 10             	add    $0x10,%esp
     b5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b62:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b69:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b6c:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b6f:	6a 0c                	push   $0xc
     b71:	6a 0c                	push   $0xc
     b73:	6a 0c                	push   $0xc
     b75:	50                   	push   %eax
     b76:	e8 c3 fc ff ff       	call   83e <RGB>
     b7b:	83 c4 0c             	add    $0xc,%esp
     b7e:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b82:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b86:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b8a:	88 43 15             	mov    %al,0x15(%ebx)
     b8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b90:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b93:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b97:	66 89 48 10          	mov    %cx,0x10(%eax)
     b9b:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b9f:	88 50 12             	mov    %dl,0x12(%eax)
     ba2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ba8:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     bac:	66 89 48 08          	mov    %cx,0x8(%eax)
     bb0:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     bb4:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     bb7:	8b 45 08             	mov    0x8(%ebp),%eax
     bba:	89 c2                	mov    %eax,%edx
     bbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bbf:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     bc1:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc4:	89 c2                	mov    %eax,%edx
     bc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc9:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bcc:	8b 55 10             	mov    0x10(%ebp),%edx
     bcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd2:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     bd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bd8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bdb:	c9                   	leave  
     bdc:	c3                   	ret    

00000bdd <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     bdd:	55                   	push   %ebp
     bde:	89 e5                	mov    %esp,%ebp
     be0:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     be3:	8b 45 0c             	mov    0xc(%ebp),%eax
     be6:	8b 50 08             	mov    0x8(%eax),%edx
     be9:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bec:	8b 40 0c             	mov    0xc(%eax),%eax
     bef:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     bf2:	8b 45 0c             	mov    0xc(%ebp),%eax
     bf5:	8b 55 10             	mov    0x10(%ebp),%edx
     bf8:	89 50 08             	mov    %edx,0x8(%eax)
     bfb:	8b 55 14             	mov    0x14(%ebp),%edx
     bfe:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c01:	8b 45 08             	mov    0x8(%ebp),%eax
     c04:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c07:	89 10                	mov    %edx,(%eax)
     c09:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c0c:	89 50 04             	mov    %edx,0x4(%eax)
}
     c0f:	8b 45 08             	mov    0x8(%ebp),%eax
     c12:	c9                   	leave  
     c13:	c2 04 00             	ret    $0x4

00000c16 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c16:	55                   	push   %ebp
     c17:	89 e5                	mov    %esp,%ebp
     c19:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c1c:	8b 45 0c             	mov    0xc(%ebp),%eax
     c1f:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c23:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c27:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c2b:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c2e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c31:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c35:	66 89 50 10          	mov    %dx,0x10(%eax)
     c39:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c3d:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c40:	8b 45 08             	mov    0x8(%ebp),%eax
     c43:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c47:	66 89 10             	mov    %dx,(%eax)
     c4a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c4e:	88 50 02             	mov    %dl,0x2(%eax)
}
     c51:	8b 45 08             	mov    0x8(%ebp),%eax
     c54:	c9                   	leave  
     c55:	c2 04 00             	ret    $0x4

00000c58 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     c58:	55                   	push   %ebp
     c59:	89 e5                	mov    %esp,%ebp
     c5b:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     c5e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c61:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     c65:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c69:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     c6d:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     c70:	8b 45 0c             	mov    0xc(%ebp),%eax
     c73:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c77:	66 89 50 13          	mov    %dx,0x13(%eax)
     c7b:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c7f:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     c82:	8b 45 08             	mov    0x8(%ebp),%eax
     c85:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c89:	66 89 10             	mov    %dx,(%eax)
     c8c:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c90:	88 50 02             	mov    %dl,0x2(%eax)
}
     c93:	8b 45 08             	mov    0x8(%ebp),%eax
     c96:	c9                   	leave  
     c97:	c2 04 00             	ret    $0x4

00000c9a <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c9a:	55                   	push   %ebp
     c9b:	89 e5                	mov    %esp,%ebp
     c9d:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     ca0:	8b 45 08             	mov    0x8(%ebp),%eax
     ca3:	8b 40 0c             	mov    0xc(%eax),%eax
     ca6:	89 c2                	mov    %eax,%edx
     ca8:	c1 ea 1f             	shr    $0x1f,%edx
     cab:	01 d0                	add    %edx,%eax
     cad:	d1 f8                	sar    %eax
     caf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     cb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cb5:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     cb9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     cbc:	8b 45 10             	mov    0x10(%ebp),%eax
     cbf:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cc2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     cc5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     cc9:	0f 89 98 00 00 00    	jns    d67 <APDrawPoint+0xcd>
        i = 0;
     ccf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     cd6:	e9 8c 00 00 00       	jmp    d67 <APDrawPoint+0xcd>
    {
        j = x - off;
     cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
     cde:	2b 45 f4             	sub    -0xc(%ebp),%eax
     ce1:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     ce4:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     ce8:	79 69                	jns    d53 <APDrawPoint+0xb9>
            j = 0;
     cea:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     cf1:	eb 60                	jmp    d53 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     cf3:	ff 75 fc             	pushl  -0x4(%ebp)
     cf6:	ff 75 f8             	pushl  -0x8(%ebp)
     cf9:	ff 75 08             	pushl  0x8(%ebp)
     cfc:	e8 bb fb ff ff       	call   8bc <APGetIndex>
     d01:	83 c4 0c             	add    $0xc,%esp
     d04:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d07:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d0b:	74 55                	je     d62 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d0d:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d11:	74 67                	je     d7a <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d13:	ff 75 10             	pushl  0x10(%ebp)
     d16:	ff 75 0c             	pushl  0xc(%ebp)
     d19:	ff 75 fc             	pushl  -0x4(%ebp)
     d1c:	ff 75 f8             	pushl  -0x8(%ebp)
     d1f:	e8 5f fb ff ff       	call   883 <distance_2>
     d24:	83 c4 10             	add    $0x10,%esp
     d27:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d2a:	7f 23                	jg     d4f <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d2c:	8b 45 08             	mov    0x8(%ebp),%eax
     d2f:	8b 48 18             	mov    0x18(%eax),%ecx
     d32:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d35:	89 d0                	mov    %edx,%eax
     d37:	01 c0                	add    %eax,%eax
     d39:	01 d0                	add    %edx,%eax
     d3b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d3e:	8b 45 08             	mov    0x8(%ebp),%eax
     d41:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d45:	66 89 0a             	mov    %cx,(%edx)
     d48:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d4c:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d4f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d53:	8b 55 0c             	mov    0xc(%ebp),%edx
     d56:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d59:	01 d0                	add    %edx,%eax
     d5b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d5e:	7d 93                	jge    cf3 <APDrawPoint+0x59>
     d60:	eb 01                	jmp    d63 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d62:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d63:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d67:	8b 55 10             	mov    0x10(%ebp),%edx
     d6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d6d:	01 d0                	add    %edx,%eax
     d6f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d72:	0f 8d 63 ff ff ff    	jge    cdb <APDrawPoint+0x41>
     d78:	eb 01                	jmp    d7b <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d7a:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d7b:	c9                   	leave  
     d7c:	c3                   	ret    

00000d7d <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d7d:	55                   	push   %ebp
     d7e:	89 e5                	mov    %esp,%ebp
     d80:	53                   	push   %ebx
     d81:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d84:	8b 45 0c             	mov    0xc(%ebp),%eax
     d87:	3b 45 14             	cmp    0x14(%ebp),%eax
     d8a:	0f 85 80 00 00 00    	jne    e10 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d90:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d94:	0f 88 9d 02 00 00    	js     1037 <APDrawLine+0x2ba>
     d9a:	8b 45 08             	mov    0x8(%ebp),%eax
     d9d:	8b 00                	mov    (%eax),%eax
     d9f:	3b 45 0c             	cmp    0xc(%ebp),%eax
     da2:	0f 8e 8f 02 00 00    	jle    1037 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     da8:	8b 45 10             	mov    0x10(%ebp),%eax
     dab:	3b 45 18             	cmp    0x18(%ebp),%eax
     dae:	7e 12                	jle    dc2 <APDrawLine+0x45>
        {
            int tmp = y2;
     db0:	8b 45 18             	mov    0x18(%ebp),%eax
     db3:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     db6:	8b 45 10             	mov    0x10(%ebp),%eax
     db9:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     dbc:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dbf:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     dc2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dc6:	79 07                	jns    dcf <APDrawLine+0x52>
     dc8:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     dcf:	8b 45 08             	mov    0x8(%ebp),%eax
     dd2:	8b 40 04             	mov    0x4(%eax),%eax
     dd5:	3b 45 18             	cmp    0x18(%ebp),%eax
     dd8:	7d 0c                	jge    de6 <APDrawLine+0x69>
     dda:	8b 45 08             	mov    0x8(%ebp),%eax
     ddd:	8b 40 04             	mov    0x4(%eax),%eax
     de0:	83 e8 01             	sub    $0x1,%eax
     de3:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     de6:	8b 45 10             	mov    0x10(%ebp),%eax
     de9:	89 45 f4             	mov    %eax,-0xc(%ebp)
     dec:	eb 15                	jmp    e03 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     dee:	ff 75 f4             	pushl  -0xc(%ebp)
     df1:	ff 75 0c             	pushl  0xc(%ebp)
     df4:	ff 75 08             	pushl  0x8(%ebp)
     df7:	e8 9e fe ff ff       	call   c9a <APDrawPoint>
     dfc:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     dff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e03:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e06:	3b 45 18             	cmp    0x18(%ebp),%eax
     e09:	7e e3                	jle    dee <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e0b:	e9 2b 02 00 00       	jmp    103b <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e10:	8b 45 10             	mov    0x10(%ebp),%eax
     e13:	3b 45 18             	cmp    0x18(%ebp),%eax
     e16:	75 7f                	jne    e97 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e18:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e1c:	0f 88 18 02 00 00    	js     103a <APDrawLine+0x2bd>
     e22:	8b 45 08             	mov    0x8(%ebp),%eax
     e25:	8b 40 04             	mov    0x4(%eax),%eax
     e28:	3b 45 10             	cmp    0x10(%ebp),%eax
     e2b:	0f 8e 09 02 00 00    	jle    103a <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e31:	8b 45 0c             	mov    0xc(%ebp),%eax
     e34:	3b 45 14             	cmp    0x14(%ebp),%eax
     e37:	7e 12                	jle    e4b <APDrawLine+0xce>
        {
            int tmp = x2;
     e39:	8b 45 14             	mov    0x14(%ebp),%eax
     e3c:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e3f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e42:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e45:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e48:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e4b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e4f:	79 07                	jns    e58 <APDrawLine+0xdb>
     e51:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e58:	8b 45 08             	mov    0x8(%ebp),%eax
     e5b:	8b 00                	mov    (%eax),%eax
     e5d:	3b 45 14             	cmp    0x14(%ebp),%eax
     e60:	7d 0b                	jge    e6d <APDrawLine+0xf0>
     e62:	8b 45 08             	mov    0x8(%ebp),%eax
     e65:	8b 00                	mov    (%eax),%eax
     e67:	83 e8 01             	sub    $0x1,%eax
     e6a:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e6d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e70:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e73:	eb 15                	jmp    e8a <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e75:	ff 75 10             	pushl  0x10(%ebp)
     e78:	ff 75 f0             	pushl  -0x10(%ebp)
     e7b:	ff 75 08             	pushl  0x8(%ebp)
     e7e:	e8 17 fe ff ff       	call   c9a <APDrawPoint>
     e83:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e86:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e8d:	3b 45 14             	cmp    0x14(%ebp),%eax
     e90:	7e e3                	jle    e75 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e92:	e9 a4 01 00 00       	jmp    103b <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e97:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e9e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     ea5:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea8:	2b 45 14             	sub    0x14(%ebp),%eax
     eab:	50                   	push   %eax
     eac:	e8 fb f9 ff ff       	call   8ac <abs_int>
     eb1:	83 c4 04             	add    $0x4,%esp
     eb4:	89 c3                	mov    %eax,%ebx
     eb6:	8b 45 10             	mov    0x10(%ebp),%eax
     eb9:	2b 45 18             	sub    0x18(%ebp),%eax
     ebc:	50                   	push   %eax
     ebd:	e8 ea f9 ff ff       	call   8ac <abs_int>
     ec2:	83 c4 04             	add    $0x4,%esp
     ec5:	39 c3                	cmp    %eax,%ebx
     ec7:	0f 8e b5 00 00 00    	jle    f82 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     ecd:	8b 45 10             	mov    0x10(%ebp),%eax
     ed0:	2b 45 18             	sub    0x18(%ebp),%eax
     ed3:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ed6:	db 45 b0             	fildl  -0x50(%ebp)
     ed9:	8b 45 0c             	mov    0xc(%ebp),%eax
     edc:	2b 45 14             	sub    0x14(%ebp),%eax
     edf:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ee2:	db 45 b0             	fildl  -0x50(%ebp)
     ee5:	de f9                	fdivrp %st,%st(1)
     ee7:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     eea:	8b 45 14             	mov    0x14(%ebp),%eax
     eed:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ef0:	7e 0e                	jle    f00 <APDrawLine+0x183>
        {
            s = x1;
     ef2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef5:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     ef8:	8b 45 14             	mov    0x14(%ebp),%eax
     efb:	89 45 e8             	mov    %eax,-0x18(%ebp)
     efe:	eb 0c                	jmp    f0c <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f00:	8b 45 14             	mov    0x14(%ebp),%eax
     f03:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f06:	8b 45 0c             	mov    0xc(%ebp),%eax
     f09:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f0c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f10:	79 07                	jns    f19 <APDrawLine+0x19c>
     f12:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f19:	8b 45 08             	mov    0x8(%ebp),%eax
     f1c:	8b 00                	mov    (%eax),%eax
     f1e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f21:	7f 0b                	jg     f2e <APDrawLine+0x1b1>
     f23:	8b 45 08             	mov    0x8(%ebp),%eax
     f26:	8b 00                	mov    (%eax),%eax
     f28:	83 e8 01             	sub    $0x1,%eax
     f2b:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f2e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f31:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f34:	eb 3f                	jmp    f75 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f39:	2b 45 0c             	sub    0xc(%ebp),%eax
     f3c:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f3f:	db 45 b0             	fildl  -0x50(%ebp)
     f42:	dc 4d d0             	fmull  -0x30(%ebp)
     f45:	db 45 10             	fildl  0x10(%ebp)
     f48:	de c1                	faddp  %st,%st(1)
     f4a:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f4d:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f51:	b4 0c                	mov    $0xc,%ah
     f53:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f57:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f5a:	db 5d cc             	fistpl -0x34(%ebp)
     f5d:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f60:	ff 75 cc             	pushl  -0x34(%ebp)
     f63:	ff 75 e4             	pushl  -0x1c(%ebp)
     f66:	ff 75 08             	pushl  0x8(%ebp)
     f69:	e8 2c fd ff ff       	call   c9a <APDrawPoint>
     f6e:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f71:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f75:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f78:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f7b:	7e b9                	jle    f36 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f7d:	e9 b9 00 00 00       	jmp    103b <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f82:	8b 45 0c             	mov    0xc(%ebp),%eax
     f85:	2b 45 14             	sub    0x14(%ebp),%eax
     f88:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f8b:	db 45 b0             	fildl  -0x50(%ebp)
     f8e:	8b 45 10             	mov    0x10(%ebp),%eax
     f91:	2b 45 18             	sub    0x18(%ebp),%eax
     f94:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f97:	db 45 b0             	fildl  -0x50(%ebp)
     f9a:	de f9                	fdivrp %st,%st(1)
     f9c:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f9f:	8b 45 10             	mov    0x10(%ebp),%eax
     fa2:	3b 45 18             	cmp    0x18(%ebp),%eax
     fa5:	7e 0e                	jle    fb5 <APDrawLine+0x238>
    {
        s = y2;
     fa7:	8b 45 18             	mov    0x18(%ebp),%eax
     faa:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     fad:	8b 45 10             	mov    0x10(%ebp),%eax
     fb0:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fb3:	eb 0c                	jmp    fc1 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     fb5:	8b 45 10             	mov    0x10(%ebp),%eax
     fb8:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     fbb:	8b 45 18             	mov    0x18(%ebp),%eax
     fbe:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     fc1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fc5:	79 07                	jns    fce <APDrawLine+0x251>
     fc7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     fce:	8b 45 08             	mov    0x8(%ebp),%eax
     fd1:	8b 40 04             	mov    0x4(%eax),%eax
     fd4:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fd7:	7f 0c                	jg     fe5 <APDrawLine+0x268>
     fd9:	8b 45 08             	mov    0x8(%ebp),%eax
     fdc:	8b 40 04             	mov    0x4(%eax),%eax
     fdf:	83 e8 01             	sub    $0x1,%eax
     fe2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     fe5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fe8:	89 45 e0             	mov    %eax,-0x20(%ebp)
     feb:	eb 3f                	jmp    102c <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     fed:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ff0:	2b 45 10             	sub    0x10(%ebp),%eax
     ff3:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ff6:	db 45 b0             	fildl  -0x50(%ebp)
     ff9:	dc 4d c0             	fmull  -0x40(%ebp)
     ffc:	db 45 0c             	fildl  0xc(%ebp)
     fff:	de c1                	faddp  %st,%st(1)
    1001:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1004:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1008:	b4 0c                	mov    $0xc,%ah
    100a:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    100e:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1011:	db 5d bc             	fistpl -0x44(%ebp)
    1014:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1017:	ff 75 e0             	pushl  -0x20(%ebp)
    101a:	ff 75 bc             	pushl  -0x44(%ebp)
    101d:	ff 75 08             	pushl  0x8(%ebp)
    1020:	e8 75 fc ff ff       	call   c9a <APDrawPoint>
    1025:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1028:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    102c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    102f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1032:	7e b9                	jle    fed <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1034:	90                   	nop
    1035:	eb 04                	jmp    103b <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1037:	90                   	nop
    1038:	eb 01                	jmp    103b <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    103a:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    103b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    103e:	c9                   	leave  
    103f:	c3                   	ret    

00001040 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1040:	55                   	push   %ebp
    1041:	89 e5                	mov    %esp,%ebp
    1043:	53                   	push   %ebx
    1044:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1047:	8b 55 10             	mov    0x10(%ebp),%edx
    104a:	8b 45 18             	mov    0x18(%ebp),%eax
    104d:	01 d0                	add    %edx,%eax
    104f:	83 e8 01             	sub    $0x1,%eax
    1052:	83 ec 04             	sub    $0x4,%esp
    1055:	50                   	push   %eax
    1056:	ff 75 0c             	pushl  0xc(%ebp)
    1059:	ff 75 10             	pushl  0x10(%ebp)
    105c:	ff 75 0c             	pushl  0xc(%ebp)
    105f:	ff 75 08             	pushl  0x8(%ebp)
    1062:	e8 16 fd ff ff       	call   d7d <APDrawLine>
    1067:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    106a:	8b 55 0c             	mov    0xc(%ebp),%edx
    106d:	8b 45 14             	mov    0x14(%ebp),%eax
    1070:	01 d0                	add    %edx,%eax
    1072:	83 e8 01             	sub    $0x1,%eax
    1075:	83 ec 04             	sub    $0x4,%esp
    1078:	ff 75 10             	pushl  0x10(%ebp)
    107b:	50                   	push   %eax
    107c:	ff 75 10             	pushl  0x10(%ebp)
    107f:	ff 75 0c             	pushl  0xc(%ebp)
    1082:	ff 75 08             	pushl  0x8(%ebp)
    1085:	e8 f3 fc ff ff       	call   d7d <APDrawLine>
    108a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    108d:	8b 55 10             	mov    0x10(%ebp),%edx
    1090:	8b 45 18             	mov    0x18(%ebp),%eax
    1093:	01 d0                	add    %edx,%eax
    1095:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1098:	8b 55 0c             	mov    0xc(%ebp),%edx
    109b:	8b 45 14             	mov    0x14(%ebp),%eax
    109e:	01 d0                	add    %edx,%eax
    10a0:	8d 50 ff             	lea    -0x1(%eax),%edx
    10a3:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10a6:	8b 45 14             	mov    0x14(%ebp),%eax
    10a9:	01 d8                	add    %ebx,%eax
    10ab:	83 e8 01             	sub    $0x1,%eax
    10ae:	83 ec 04             	sub    $0x4,%esp
    10b1:	51                   	push   %ecx
    10b2:	52                   	push   %edx
    10b3:	ff 75 10             	pushl  0x10(%ebp)
    10b6:	50                   	push   %eax
    10b7:	ff 75 08             	pushl  0x8(%ebp)
    10ba:	e8 be fc ff ff       	call   d7d <APDrawLine>
    10bf:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10c2:	8b 55 10             	mov    0x10(%ebp),%edx
    10c5:	8b 45 18             	mov    0x18(%ebp),%eax
    10c8:	01 d0                	add    %edx,%eax
    10ca:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10cd:	8b 55 0c             	mov    0xc(%ebp),%edx
    10d0:	8b 45 14             	mov    0x14(%ebp),%eax
    10d3:	01 d0                	add    %edx,%eax
    10d5:	8d 50 ff             	lea    -0x1(%eax),%edx
    10d8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    10db:	8b 45 18             	mov    0x18(%ebp),%eax
    10de:	01 d8                	add    %ebx,%eax
    10e0:	83 e8 01             	sub    $0x1,%eax
    10e3:	83 ec 04             	sub    $0x4,%esp
    10e6:	51                   	push   %ecx
    10e7:	52                   	push   %edx
    10e8:	50                   	push   %eax
    10e9:	ff 75 0c             	pushl  0xc(%ebp)
    10ec:	ff 75 08             	pushl  0x8(%ebp)
    10ef:	e8 89 fc ff ff       	call   d7d <APDrawLine>
    10f4:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10f7:	8b 55 0c             	mov    0xc(%ebp),%edx
    10fa:	8b 45 14             	mov    0x14(%ebp),%eax
    10fd:	01 d0                	add    %edx,%eax
    10ff:	8d 50 ff             	lea    -0x1(%eax),%edx
    1102:	8b 45 08             	mov    0x8(%ebp),%eax
    1105:	8b 40 0c             	mov    0xc(%eax),%eax
    1108:	89 c1                	mov    %eax,%ecx
    110a:	c1 e9 1f             	shr    $0x1f,%ecx
    110d:	01 c8                	add    %ecx,%eax
    110f:	d1 f8                	sar    %eax
    1111:	29 c2                	sub    %eax,%edx
    1113:	89 d0                	mov    %edx,%eax
    1115:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1118:	8b 55 10             	mov    0x10(%ebp),%edx
    111b:	8b 45 18             	mov    0x18(%ebp),%eax
    111e:	01 d0                	add    %edx,%eax
    1120:	8d 50 ff             	lea    -0x1(%eax),%edx
    1123:	8b 45 08             	mov    0x8(%ebp),%eax
    1126:	8b 40 0c             	mov    0xc(%eax),%eax
    1129:	89 c1                	mov    %eax,%ecx
    112b:	c1 e9 1f             	shr    $0x1f,%ecx
    112e:	01 c8                	add    %ecx,%eax
    1130:	d1 f8                	sar    %eax
    1132:	29 c2                	sub    %eax,%edx
    1134:	89 d0                	mov    %edx,%eax
    1136:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1139:	8b 45 08             	mov    0x8(%ebp),%eax
    113c:	8b 40 0c             	mov    0xc(%eax),%eax
    113f:	89 c2                	mov    %eax,%edx
    1141:	c1 ea 1f             	shr    $0x1f,%edx
    1144:	01 d0                	add    %edx,%eax
    1146:	d1 f8                	sar    %eax
    1148:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    114b:	8b 45 08             	mov    0x8(%ebp),%eax
    114e:	8b 40 0c             	mov    0xc(%eax),%eax
    1151:	89 c2                	mov    %eax,%edx
    1153:	c1 ea 1f             	shr    $0x1f,%edx
    1156:	01 d0                	add    %edx,%eax
    1158:	d1 f8                	sar    %eax
    115a:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    115d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1161:	0f 88 d8 00 00 00    	js     123f <APDrawRect+0x1ff>
    1167:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    116b:	0f 88 ce 00 00 00    	js     123f <APDrawRect+0x1ff>
    1171:	8b 45 08             	mov    0x8(%ebp),%eax
    1174:	8b 00                	mov    (%eax),%eax
    1176:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1179:	0f 8e c0 00 00 00    	jle    123f <APDrawRect+0x1ff>
    117f:	8b 45 08             	mov    0x8(%ebp),%eax
    1182:	8b 40 04             	mov    0x4(%eax),%eax
    1185:	3b 45 10             	cmp    0x10(%ebp),%eax
    1188:	0f 8e b1 00 00 00    	jle    123f <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    118e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1192:	79 07                	jns    119b <APDrawRect+0x15b>
    1194:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    119b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    119f:	79 07                	jns    11a8 <APDrawRect+0x168>
    11a1:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    11a8:	8b 45 08             	mov    0x8(%ebp),%eax
    11ab:	8b 00                	mov    (%eax),%eax
    11ad:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11b0:	7f 0b                	jg     11bd <APDrawRect+0x17d>
    11b2:	8b 45 08             	mov    0x8(%ebp),%eax
    11b5:	8b 00                	mov    (%eax),%eax
    11b7:	83 e8 01             	sub    $0x1,%eax
    11ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    11bd:	8b 45 08             	mov    0x8(%ebp),%eax
    11c0:	8b 40 04             	mov    0x4(%eax),%eax
    11c3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11c6:	7f 0c                	jg     11d4 <APDrawRect+0x194>
    11c8:	8b 45 08             	mov    0x8(%ebp),%eax
    11cb:	8b 40 04             	mov    0x4(%eax),%eax
    11ce:	83 e8 01             	sub    $0x1,%eax
    11d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    11d4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11db:	8b 45 0c             	mov    0xc(%ebp),%eax
    11de:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11e1:	eb 52                	jmp    1235 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    11e3:	8b 45 10             	mov    0x10(%ebp),%eax
    11e6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11e9:	eb 3e                	jmp    1229 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    11eb:	83 ec 04             	sub    $0x4,%esp
    11ee:	ff 75 e8             	pushl  -0x18(%ebp)
    11f1:	ff 75 ec             	pushl  -0x14(%ebp)
    11f4:	ff 75 08             	pushl  0x8(%ebp)
    11f7:	e8 c0 f6 ff ff       	call   8bc <APGetIndex>
    11fc:	83 c4 10             	add    $0x10,%esp
    11ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1202:	8b 45 08             	mov    0x8(%ebp),%eax
    1205:	8b 48 18             	mov    0x18(%eax),%ecx
    1208:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    120b:	89 d0                	mov    %edx,%eax
    120d:	01 c0                	add    %eax,%eax
    120f:	01 d0                	add    %edx,%eax
    1211:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1214:	8b 45 08             	mov    0x8(%ebp),%eax
    1217:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    121b:	66 89 0a             	mov    %cx,(%edx)
    121e:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1222:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1225:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1229:	8b 45 e8             	mov    -0x18(%ebp),%eax
    122c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    122f:	7e ba                	jle    11eb <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1231:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1235:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1238:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    123b:	7e a6                	jle    11e3 <APDrawRect+0x1a3>
    123d:	eb 01                	jmp    1240 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    123f:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1240:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1243:	c9                   	leave  
    1244:	c3                   	ret    

00001245 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1245:	55                   	push   %ebp
    1246:	89 e5                	mov    %esp,%ebp
    1248:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    124b:	83 ec 0c             	sub    $0xc,%esp
    124e:	ff 75 0c             	pushl  0xc(%ebp)
    1251:	e8 b1 ee ff ff       	call   107 <strlen>
    1256:	83 c4 10             	add    $0x10,%esp
    1259:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    125c:	8b 45 08             	mov    0x8(%ebp),%eax
    125f:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1263:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1267:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    126b:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    126e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1275:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    127c:	e9 bc 00 00 00       	jmp    133d <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1281:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1284:	8b 45 0c             	mov    0xc(%ebp),%eax
    1287:	01 d0                	add    %edx,%eax
    1289:	0f b6 00             	movzbl (%eax),%eax
    128c:	0f be c0             	movsbl %al,%eax
    128f:	83 e8 20             	sub    $0x20,%eax
    1292:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1295:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1299:	0f 87 9a 00 00 00    	ja     1339 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    129f:	8b 45 08             	mov    0x8(%ebp),%eax
    12a2:	8b 00                	mov    (%eax),%eax
    12a4:	0f af 45 14          	imul   0x14(%ebp),%eax
    12a8:	89 c2                	mov    %eax,%edx
    12aa:	8b 45 10             	mov    0x10(%ebp),%eax
    12ad:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    12b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12b3:	89 d0                	mov    %edx,%eax
    12b5:	c1 e0 03             	shl    $0x3,%eax
    12b8:	01 d0                	add    %edx,%eax
    12ba:	01 c8                	add    %ecx,%eax
    12bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    12bf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    12c6:	eb 6b                	jmp    1333 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    12c8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    12cf:	eb 50                	jmp    1321 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    12d1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    12d4:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12d7:	89 d0                	mov    %edx,%eax
    12d9:	c1 e0 03             	shl    $0x3,%eax
    12dc:	01 d0                	add    %edx,%eax
    12de:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    12e4:	01 c2                	add    %eax,%edx
    12e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12e9:	01 d0                	add    %edx,%eax
    12eb:	05 80 2c 00 00       	add    $0x2c80,%eax
    12f0:	0f b6 00             	movzbl (%eax),%eax
    12f3:	84 c0                	test   %al,%al
    12f5:	74 26                	je     131d <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    12f7:	8b 45 08             	mov    0x8(%ebp),%eax
    12fa:	8b 50 18             	mov    0x18(%eax),%edx
    12fd:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1300:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1303:	01 c8                	add    %ecx,%eax
    1305:	89 c1                	mov    %eax,%ecx
    1307:	89 c8                	mov    %ecx,%eax
    1309:	01 c0                	add    %eax,%eax
    130b:	01 c8                	add    %ecx,%eax
    130d:	01 d0                	add    %edx,%eax
    130f:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1313:	66 89 10             	mov    %dx,(%eax)
    1316:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    131a:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    131d:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1321:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1325:	7e aa                	jle    12d1 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1327:	8b 45 08             	mov    0x8(%ebp),%eax
    132a:	8b 00                	mov    (%eax),%eax
    132c:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    132f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1333:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1337:	7e 8f                	jle    12c8 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    1339:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    133d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1340:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1343:	0f 82 38 ff ff ff    	jb     1281 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1349:	90                   	nop
    134a:	c9                   	leave  
    134b:	c3                   	ret    

0000134c <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    134c:	55                   	push   %ebp
    134d:	89 e5                	mov    %esp,%ebp
    134f:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1352:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1356:	0f 88 8e 01 00 00    	js     14ea <APDcCopy+0x19e>
    135c:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1360:	0f 88 84 01 00 00    	js     14ea <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1366:	8b 55 0c             	mov    0xc(%ebp),%edx
    1369:	8b 45 20             	mov    0x20(%ebp),%eax
    136c:	01 d0                	add    %edx,%eax
    136e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1371:	8b 55 10             	mov    0x10(%ebp),%edx
    1374:	8b 45 24             	mov    0x24(%ebp),%eax
    1377:	01 d0                	add    %edx,%eax
    1379:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    137c:	8b 55 18             	mov    0x18(%ebp),%edx
    137f:	8b 45 20             	mov    0x20(%ebp),%eax
    1382:	01 d0                	add    %edx,%eax
    1384:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1387:	8b 55 1c             	mov    0x1c(%ebp),%edx
    138a:	8b 45 24             	mov    0x24(%ebp),%eax
    138d:	01 d0                	add    %edx,%eax
    138f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1392:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1396:	0f 88 51 01 00 00    	js     14ed <APDcCopy+0x1a1>
    139c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    13a0:	0f 88 47 01 00 00    	js     14ed <APDcCopy+0x1a1>
    13a6:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    13aa:	0f 88 3d 01 00 00    	js     14ed <APDcCopy+0x1a1>
    13b0:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    13b4:	0f 88 33 01 00 00    	js     14ed <APDcCopy+0x1a1>
    13ba:	8b 45 14             	mov    0x14(%ebp),%eax
    13bd:	8b 00                	mov    (%eax),%eax
    13bf:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13c2:	0f 8c 25 01 00 00    	jl     14ed <APDcCopy+0x1a1>
    13c8:	8b 45 14             	mov    0x14(%ebp),%eax
    13cb:	8b 40 04             	mov    0x4(%eax),%eax
    13ce:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    13d1:	0f 8c 16 01 00 00    	jl     14ed <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    13d7:	8b 45 08             	mov    0x8(%ebp),%eax
    13da:	8b 00                	mov    (%eax),%eax
    13dc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    13df:	7f 0b                	jg     13ec <APDcCopy+0xa0>
    13e1:	8b 45 08             	mov    0x8(%ebp),%eax
    13e4:	8b 00                	mov    (%eax),%eax
    13e6:	83 e8 01             	sub    $0x1,%eax
    13e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    13ec:	8b 45 08             	mov    0x8(%ebp),%eax
    13ef:	8b 40 04             	mov    0x4(%eax),%eax
    13f2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13f5:	7f 0c                	jg     1403 <APDcCopy+0xb7>
    13f7:	8b 45 08             	mov    0x8(%ebp),%eax
    13fa:	8b 40 04             	mov    0x4(%eax),%eax
    13fd:	83 e8 01             	sub    $0x1,%eax
    1400:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1403:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    140a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1411:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1418:	e9 bc 00 00 00       	jmp    14d9 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    141d:	8b 45 08             	mov    0x8(%ebp),%eax
    1420:	8b 00                	mov    (%eax),%eax
    1422:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1425:	8b 55 10             	mov    0x10(%ebp),%edx
    1428:	01 ca                	add    %ecx,%edx
    142a:	0f af d0             	imul   %eax,%edx
    142d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1430:	01 d0                	add    %edx,%eax
    1432:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1435:	8b 45 14             	mov    0x14(%ebp),%eax
    1438:	8b 00                	mov    (%eax),%eax
    143a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    143d:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1440:	01 ca                	add    %ecx,%edx
    1442:	0f af d0             	imul   %eax,%edx
    1445:	8b 45 18             	mov    0x18(%ebp),%eax
    1448:	01 d0                	add    %edx,%eax
    144a:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    144d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1454:	eb 74                	jmp    14ca <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1456:	8b 45 14             	mov    0x14(%ebp),%eax
    1459:	8b 50 18             	mov    0x18(%eax),%edx
    145c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    145f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1462:	01 c8                	add    %ecx,%eax
    1464:	89 c1                	mov    %eax,%ecx
    1466:	89 c8                	mov    %ecx,%eax
    1468:	01 c0                	add    %eax,%eax
    146a:	01 c8                	add    %ecx,%eax
    146c:	01 d0                	add    %edx,%eax
    146e:	0f b7 10             	movzwl (%eax),%edx
    1471:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1475:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1479:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    147c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1480:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1484:	38 c2                	cmp    %al,%dl
    1486:	75 18                	jne    14a0 <APDcCopy+0x154>
    1488:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    148c:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1490:	38 c2                	cmp    %al,%dl
    1492:	75 0c                	jne    14a0 <APDcCopy+0x154>
    1494:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1498:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    149c:	38 c2                	cmp    %al,%dl
    149e:	74 26                	je     14c6 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    14a0:	8b 45 08             	mov    0x8(%ebp),%eax
    14a3:	8b 50 18             	mov    0x18(%eax),%edx
    14a6:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    14a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14ac:	01 c8                	add    %ecx,%eax
    14ae:	89 c1                	mov    %eax,%ecx
    14b0:	89 c8                	mov    %ecx,%eax
    14b2:	01 c0                	add    %eax,%eax
    14b4:	01 c8                	add    %ecx,%eax
    14b6:	01 d0                	add    %edx,%eax
    14b8:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    14bc:	66 89 10             	mov    %dx,(%eax)
    14bf:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    14c3:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    14c6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14cd:	2b 45 0c             	sub    0xc(%ebp),%eax
    14d0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14d3:	7d 81                	jge    1456 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    14d5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14dc:	2b 45 10             	sub    0x10(%ebp),%eax
    14df:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14e2:	0f 8d 35 ff ff ff    	jge    141d <APDcCopy+0xd1>
    14e8:	eb 04                	jmp    14ee <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    14ea:	90                   	nop
    14eb:	eb 01                	jmp    14ee <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    14ed:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    14ee:	c9                   	leave  
    14ef:	c3                   	ret    

000014f0 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    14f0:	55                   	push   %ebp
    14f1:	89 e5                	mov    %esp,%ebp
    14f3:	83 ec 1c             	sub    $0x1c,%esp
    14f6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    14f9:	8b 55 10             	mov    0x10(%ebp),%edx
    14fc:	8b 45 14             	mov    0x14(%ebp),%eax
    14ff:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1502:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1505:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1508:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    150c:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    150f:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1513:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1516:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    151a:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    151d:	8b 45 08             	mov    0x8(%ebp),%eax
    1520:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1524:	66 89 10             	mov    %dx,(%eax)
    1527:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    152b:	88 50 02             	mov    %dl,0x2(%eax)
}
    152e:	8b 45 08             	mov    0x8(%ebp),%eax
    1531:	c9                   	leave  
    1532:	c2 04 00             	ret    $0x4

00001535 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1535:	55                   	push   %ebp
    1536:	89 e5                	mov    %esp,%ebp
    1538:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    153b:	8b 45 08             	mov    0x8(%ebp),%eax
    153e:	8b 00                	mov    (%eax),%eax
    1540:	83 ec 08             	sub    $0x8,%esp
    1543:	8d 55 0c             	lea    0xc(%ebp),%edx
    1546:	52                   	push   %edx
    1547:	50                   	push   %eax
    1548:	e8 24 ee ff ff       	call   371 <sendMessage>
    154d:	83 c4 10             	add    $0x10,%esp
}
    1550:	90                   	nop
    1551:	c9                   	leave  
    1552:	c3                   	ret    

00001553 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1553:	55                   	push   %ebp
    1554:	89 e5                	mov    %esp,%ebp
    1556:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1559:	83 ec 0c             	sub    $0xc,%esp
    155c:	68 9c 00 00 00       	push   $0x9c
    1561:	e8 f5 f1 ff ff       	call   75b <malloc>
    1566:	83 c4 10             	add    $0x10,%esp
    1569:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    156c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1570:	75 15                	jne    1587 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1572:	83 ec 04             	sub    $0x4,%esp
    1575:	ff 75 08             	pushl  0x8(%ebp)
    1578:	68 3c 25 00 00       	push   $0x253c
    157d:	6a 01                	push   $0x1
    157f:	e8 04 ef ff ff       	call   488 <printf>
    1584:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1587:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158a:	05 88 00 00 00       	add    $0x88,%eax
    158f:	83 ec 08             	sub    $0x8,%esp
    1592:	ff 75 08             	pushl  0x8(%ebp)
    1595:	50                   	push   %eax
    1596:	e8 fd ea ff ff       	call   98 <strcpy>
    159b:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    159e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a1:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    15a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ab:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b5:	8b 40 3c             	mov    0x3c(%eax),%eax
    15b8:	89 c2                	mov    %eax,%edx
    15ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bd:	8b 40 40             	mov    0x40(%eax),%eax
    15c0:	0f af d0             	imul   %eax,%edx
    15c3:	89 d0                	mov    %edx,%eax
    15c5:	01 c0                	add    %eax,%eax
    15c7:	01 d0                	add    %edx,%eax
    15c9:	83 ec 0c             	sub    $0xc,%esp
    15cc:	50                   	push   %eax
    15cd:	e8 89 f1 ff ff       	call   75b <malloc>
    15d2:	83 c4 10             	add    $0x10,%esp
    15d5:	89 c2                	mov    %eax,%edx
    15d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15da:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    15dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e0:	8b 40 54             	mov    0x54(%eax),%eax
    15e3:	85 c0                	test   %eax,%eax
    15e5:	75 15                	jne    15fc <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    15e7:	83 ec 04             	sub    $0x4,%esp
    15ea:	ff 75 08             	pushl  0x8(%ebp)
    15ed:	68 5c 25 00 00       	push   $0x255c
    15f2:	6a 01                	push   $0x1
    15f4:	e8 8f ee ff ff       	call   488 <printf>
    15f9:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ff:	8b 40 3c             	mov    0x3c(%eax),%eax
    1602:	89 c2                	mov    %eax,%edx
    1604:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1607:	8b 40 40             	mov    0x40(%eax),%eax
    160a:	0f af d0             	imul   %eax,%edx
    160d:	89 d0                	mov    %edx,%eax
    160f:	01 c0                	add    %eax,%eax
    1611:	01 c2                	add    %eax,%edx
    1613:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1616:	8b 40 54             	mov    0x54(%eax),%eax
    1619:	83 ec 04             	sub    $0x4,%esp
    161c:	52                   	push   %edx
    161d:	68 ff ff ff 00       	push   $0xffffff
    1622:	50                   	push   %eax
    1623:	e8 06 eb ff ff       	call   12e <memset>
    1628:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    162b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162e:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1635:	e8 0f ed ff ff       	call   349 <getpid>
    163a:	89 c2                	mov    %eax,%edx
    163c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163f:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1642:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1645:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    164c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164f:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1656:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1659:	8b 40 58             	mov    0x58(%eax),%eax
    165c:	89 c2                	mov    %eax,%edx
    165e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1661:	8b 40 5c             	mov    0x5c(%eax),%eax
    1664:	0f af d0             	imul   %eax,%edx
    1667:	89 d0                	mov    %edx,%eax
    1669:	01 c0                	add    %eax,%eax
    166b:	01 d0                	add    %edx,%eax
    166d:	83 ec 0c             	sub    $0xc,%esp
    1670:	50                   	push   %eax
    1671:	e8 e5 f0 ff ff       	call   75b <malloc>
    1676:	83 c4 10             	add    $0x10,%esp
    1679:	89 c2                	mov    %eax,%edx
    167b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167e:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1681:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1684:	8b 40 70             	mov    0x70(%eax),%eax
    1687:	85 c0                	test   %eax,%eax
    1689:	75 15                	jne    16a0 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    168b:	83 ec 04             	sub    $0x4,%esp
    168e:	ff 75 08             	pushl  0x8(%ebp)
    1691:	68 80 25 00 00       	push   $0x2580
    1696:	6a 01                	push   $0x1
    1698:	e8 eb ed ff ff       	call   488 <printf>
    169d:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    16a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a3:	8b 40 3c             	mov    0x3c(%eax),%eax
    16a6:	89 c2                	mov    %eax,%edx
    16a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ab:	8b 40 40             	mov    0x40(%eax),%eax
    16ae:	0f af d0             	imul   %eax,%edx
    16b1:	89 d0                	mov    %edx,%eax
    16b3:	01 c0                	add    %eax,%eax
    16b5:	01 c2                	add    %eax,%edx
    16b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ba:	8b 40 54             	mov    0x54(%eax),%eax
    16bd:	83 ec 04             	sub    $0x4,%esp
    16c0:	52                   	push   %edx
    16c1:	68 ff 00 00 00       	push   $0xff
    16c6:	50                   	push   %eax
    16c7:	e8 62 ea ff ff       	call   12e <memset>
    16cc:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    16cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d2:	8b 55 0c             	mov    0xc(%ebp),%edx
    16d5:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    16d8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16dc:	74 49                	je     1727 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    16de:	8b 45 10             	mov    0x10(%ebp),%eax
    16e1:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    16e7:	83 ec 0c             	sub    $0xc,%esp
    16ea:	50                   	push   %eax
    16eb:	e8 6b f0 ff ff       	call   75b <malloc>
    16f0:	83 c4 10             	add    $0x10,%esp
    16f3:	89 c2                	mov    %eax,%edx
    16f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f8:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    16fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fe:	8b 55 10             	mov    0x10(%ebp),%edx
    1701:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1704:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1707:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    170e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1711:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1718:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171b:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1722:	e9 8d 00 00 00       	jmp    17b4 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1727:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172a:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1731:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1734:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    173b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    173e:	8b 40 20             	mov    0x20(%eax),%eax
    1741:	89 c2                	mov    %eax,%edx
    1743:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1746:	8b 40 24             	mov    0x24(%eax),%eax
    1749:	0f af d0             	imul   %eax,%edx
    174c:	89 d0                	mov    %edx,%eax
    174e:	01 c0                	add    %eax,%eax
    1750:	01 d0                	add    %edx,%eax
    1752:	83 ec 0c             	sub    $0xc,%esp
    1755:	50                   	push   %eax
    1756:	e8 00 f0 ff ff       	call   75b <malloc>
    175b:	83 c4 10             	add    $0x10,%esp
    175e:	89 c2                	mov    %eax,%edx
    1760:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1763:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1766:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1769:	8b 40 38             	mov    0x38(%eax),%eax
    176c:	85 c0                	test   %eax,%eax
    176e:	75 15                	jne    1785 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1770:	83 ec 04             	sub    $0x4,%esp
    1773:	ff 75 08             	pushl  0x8(%ebp)
    1776:	68 a8 25 00 00       	push   $0x25a8
    177b:	6a 01                	push   $0x1
    177d:	e8 06 ed ff ff       	call   488 <printf>
    1782:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1785:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1788:	8b 40 20             	mov    0x20(%eax),%eax
    178b:	89 c2                	mov    %eax,%edx
    178d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1790:	8b 40 24             	mov    0x24(%eax),%eax
    1793:	0f af d0             	imul   %eax,%edx
    1796:	89 d0                	mov    %edx,%eax
    1798:	01 c0                	add    %eax,%eax
    179a:	01 c2                	add    %eax,%edx
    179c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179f:	8b 40 38             	mov    0x38(%eax),%eax
    17a2:	83 ec 04             	sub    $0x4,%esp
    17a5:	52                   	push   %edx
    17a6:	68 ff ff ff 00       	push   $0xffffff
    17ab:	50                   	push   %eax
    17ac:	e8 7d e9 ff ff       	call   12e <memset>
    17b1:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    17b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    17b7:	c9                   	leave  
    17b8:	c3                   	ret    

000017b9 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    17b9:	55                   	push   %ebp
    17ba:	89 e5                	mov    %esp,%ebp
    17bc:	57                   	push   %edi
    17bd:	56                   	push   %esi
    17be:	53                   	push   %ebx
    17bf:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    17c2:	8b 45 0c             	mov    0xc(%ebp),%eax
    17c5:	83 f8 03             	cmp    $0x3,%eax
    17c8:	74 0e                	je     17d8 <APWndProc+0x1f>
    17ca:	83 f8 0a             	cmp    $0xa,%eax
    17cd:	0f 84 82 00 00 00    	je     1855 <APWndProc+0x9c>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            break;
        default: break;
    17d3:	e9 cb 00 00 00       	jmp    18a3 <APWndProc+0xea>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    17d8:	8b 45 08             	mov    0x8(%ebp),%eax
    17db:	8b 58 1c             	mov    0x1c(%eax),%ebx
    17de:	8b 45 08             	mov    0x8(%ebp),%eax
    17e1:	8b 48 18             	mov    0x18(%eax),%ecx
    17e4:	8b 45 08             	mov    0x8(%ebp),%eax
    17e7:	8b 50 5c             	mov    0x5c(%eax),%edx
    17ea:	8b 45 08             	mov    0x8(%ebp),%eax
    17ed:	8b 40 58             	mov    0x58(%eax),%eax
    17f0:	8b 75 08             	mov    0x8(%ebp),%esi
    17f3:	83 c6 58             	add    $0x58,%esi
    17f6:	83 ec 04             	sub    $0x4,%esp
    17f9:	53                   	push   %ebx
    17fa:	51                   	push   %ecx
    17fb:	6a 00                	push   $0x0
    17fd:	52                   	push   %edx
    17fe:	50                   	push   %eax
    17ff:	6a 00                	push   $0x0
    1801:	6a 00                	push   $0x0
    1803:	56                   	push   %esi
    1804:	6a 00                	push   $0x0
    1806:	6a 00                	push   $0x0
    1808:	ff 75 08             	pushl  0x8(%ebp)
    180b:	e8 59 eb ff ff       	call   369 <paintWindow>
    1810:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1813:	8b 45 08             	mov    0x8(%ebp),%eax
    1816:	8b 70 1c             	mov    0x1c(%eax),%esi
    1819:	8b 45 08             	mov    0x8(%ebp),%eax
    181c:	8b 58 18             	mov    0x18(%eax),%ebx
    181f:	8b 45 08             	mov    0x8(%ebp),%eax
    1822:	8b 48 08             	mov    0x8(%eax),%ecx
    1825:	8b 45 08             	mov    0x8(%ebp),%eax
    1828:	8b 50 40             	mov    0x40(%eax),%edx
    182b:	8b 45 08             	mov    0x8(%ebp),%eax
    182e:	8b 40 3c             	mov    0x3c(%eax),%eax
    1831:	8b 7d 08             	mov    0x8(%ebp),%edi
    1834:	83 c7 3c             	add    $0x3c,%edi
    1837:	83 ec 04             	sub    $0x4,%esp
    183a:	56                   	push   %esi
    183b:	53                   	push   %ebx
    183c:	51                   	push   %ecx
    183d:	52                   	push   %edx
    183e:	50                   	push   %eax
    183f:	6a 00                	push   $0x0
    1841:	6a 00                	push   $0x0
    1843:	57                   	push   %edi
    1844:	6a 32                	push   $0x32
    1846:	6a 00                	push   $0x0
    1848:	ff 75 08             	pushl  0x8(%ebp)
    184b:	e8 19 eb ff ff       	call   369 <paintWindow>
    1850:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1853:	eb 4e                	jmp    18a3 <APWndProc+0xea>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
    1855:	8b 45 18             	mov    0x18(%ebp),%eax
    1858:	83 ec 08             	sub    $0x8,%esp
    185b:	50                   	push   %eax
    185c:	ff 75 08             	pushl  0x8(%ebp)
    185f:	e8 19 08 00 00       	call   207d <updateword>
    1864:	83 c4 10             	add    $0x10,%esp
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1867:	8b 45 08             	mov    0x8(%ebp),%eax
    186a:	8b 58 1c             	mov    0x1c(%eax),%ebx
    186d:	8b 45 08             	mov    0x8(%ebp),%eax
    1870:	8b 48 18             	mov    0x18(%eax),%ecx
    1873:	8b 45 08             	mov    0x8(%ebp),%eax
    1876:	8b 50 5c             	mov    0x5c(%eax),%edx
    1879:	8b 45 08             	mov    0x8(%ebp),%eax
    187c:	8b 40 58             	mov    0x58(%eax),%eax
    187f:	8b 75 08             	mov    0x8(%ebp),%esi
    1882:	83 c6 58             	add    $0x58,%esi
    1885:	83 ec 04             	sub    $0x4,%esp
    1888:	53                   	push   %ebx
    1889:	51                   	push   %ecx
    188a:	6a 00                	push   $0x0
    188c:	52                   	push   %edx
    188d:	50                   	push   %eax
    188e:	6a 00                	push   $0x0
    1890:	6a 00                	push   $0x0
    1892:	56                   	push   %esi
    1893:	6a 00                	push   $0x0
    1895:	6a 00                	push   $0x0
    1897:	ff 75 08             	pushl  0x8(%ebp)
    189a:	e8 ca ea ff ff       	call   369 <paintWindow>
    189f:	83 c4 30             	add    $0x30,%esp
            break;
    18a2:	90                   	nop
        default: break;
            
            
    }
    return False;
    18a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
    18a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    18ab:	5b                   	pop    %ebx
    18ac:	5e                   	pop    %esi
    18ad:	5f                   	pop    %edi
    18ae:	5d                   	pop    %ebp
    18af:	c3                   	ret    

000018b0 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    18b0:	55                   	push   %ebp
    18b1:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    18b3:	8b 45 0c             	mov    0xc(%ebp),%eax
    18b6:	8b 50 08             	mov    0x8(%eax),%edx
    18b9:	8b 45 08             	mov    0x8(%ebp),%eax
    18bc:	8b 00                	mov    (%eax),%eax
    18be:	39 c2                	cmp    %eax,%edx
    18c0:	74 07                	je     18c9 <APPreJudge+0x19>
        return False;
    18c2:	b8 00 00 00 00       	mov    $0x0,%eax
    18c7:	eb 05                	jmp    18ce <APPreJudge+0x1e>
    return True;
    18c9:	b8 01 00 00 00       	mov    $0x1,%eax
}
    18ce:	5d                   	pop    %ebp
    18cf:	c3                   	ret    

000018d0 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    18d0:	55                   	push   %ebp
    18d1:	89 e5                	mov    %esp,%ebp
    18d3:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    18d6:	8b 45 08             	mov    0x8(%ebp),%eax
    18d9:	8b 55 0c             	mov    0xc(%ebp),%edx
    18dc:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
    //--------add window to list
    registWindow(hwnd);
    18e2:	83 ec 0c             	sub    $0xc,%esp
    18e5:	ff 75 08             	pushl  0x8(%ebp)
    18e8:	e8 94 ea ff ff       	call   381 <registWindow>
    18ed:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    18f0:	c7 45 e8 02 00 00 00 	movl   $0x2,-0x18(%ebp)
    msg.wndID = hwnd->id;
    18f7:	8b 45 08             	mov    0x8(%ebp),%eax
    18fa:	8b 00                	mov    (%eax),%eax
    18fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    APSendMessage(hwnd,msg);
    18ff:	83 ec 0c             	sub    $0xc,%esp
    1902:	ff 75 f4             	pushl  -0xc(%ebp)
    1905:	ff 75 f0             	pushl  -0x10(%ebp)
    1908:	ff 75 ec             	pushl  -0x14(%ebp)
    190b:	ff 75 e8             	pushl  -0x18(%ebp)
    190e:	ff 75 08             	pushl  0x8(%ebp)
    1911:	e8 1f fc ff ff       	call   1535 <APSendMessage>
    1916:	83 c4 20             	add    $0x20,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1919:	83 ec 0c             	sub    $0xc,%esp
    191c:	ff 75 08             	pushl  0x8(%ebp)
    191f:	e8 55 ea ff ff       	call   379 <getMessage>
    1924:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1927:	8b 45 08             	mov    0x8(%ebp),%eax
    192a:	83 c0 74             	add    $0x74,%eax
    192d:	83 ec 08             	sub    $0x8,%esp
    1930:	50                   	push   %eax
    1931:	ff 75 08             	pushl  0x8(%ebp)
    1934:	e8 77 ff ff ff       	call   18b0 <APPreJudge>
    1939:	83 c4 10             	add    $0x10,%esp
    193c:	84 c0                	test   %al,%al
    193e:	74 24                	je     1964 <APWndExec+0x94>
            if (wndProc(hwnd, hwnd->msg))
    1940:	83 ec 0c             	sub    $0xc,%esp
    1943:	8b 45 08             	mov    0x8(%ebp),%eax
    1946:	ff b0 80 00 00 00    	pushl  0x80(%eax)
    194c:	ff 70 7c             	pushl  0x7c(%eax)
    194f:	ff 70 78             	pushl  0x78(%eax)
    1952:	ff 70 74             	pushl  0x74(%eax)
    1955:	ff 75 08             	pushl  0x8(%ebp)
    1958:	8b 45 0c             	mov    0xc(%ebp),%eax
    195b:	ff d0                	call   *%eax
    195d:	83 c4 20             	add    $0x20,%esp
    1960:	84 c0                	test   %al,%al
    1962:	75 0c                	jne    1970 <APWndExec+0xa0>
                break;
        hwnd->msg.type = MSG_NULL;
    1964:	8b 45 08             	mov    0x8(%ebp),%eax
    1967:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    196e:	eb a9                	jmp    1919 <APWndExec+0x49>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1970:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1971:	90                   	nop
    1972:	c9                   	leave  
    1973:	c3                   	ret    

00001974 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1974:	55                   	push   %ebp
    1975:	89 e5                	mov    %esp,%ebp
    1977:	57                   	push   %edi
    1978:	56                   	push   %esi
    1979:	53                   	push   %ebx
    197a:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    197d:	a1 c4 68 00 00       	mov    0x68c4,%eax
    1982:	85 c0                	test   %eax,%eax
    1984:	0f 85 7a 02 00 00    	jne    1c04 <APGridPaint+0x290>
    {
        iconReady = 1;
    198a:	c7 05 c4 68 00 00 01 	movl   $0x1,0x68c4
    1991:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1994:	8d 45 98             	lea    -0x68(%ebp),%eax
    1997:	83 ec 08             	sub    $0x8,%esp
    199a:	68 cf 25 00 00       	push   $0x25cf
    199f:	50                   	push   %eax
    19a0:	e8 69 ef ff ff       	call   90e <APLoadBitmap>
    19a5:	83 c4 0c             	add    $0xc,%esp
    19a8:	8b 45 98             	mov    -0x68(%ebp),%eax
    19ab:	a3 e8 68 00 00       	mov    %eax,0x68e8
    19b0:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19b3:	a3 ec 68 00 00       	mov    %eax,0x68ec
    19b8:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19bb:	a3 f0 68 00 00       	mov    %eax,0x68f0
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    19c0:	83 ec 04             	sub    $0x4,%esp
    19c3:	ff 35 f0 68 00 00    	pushl  0x68f0
    19c9:	ff 35 ec 68 00 00    	pushl  0x68ec
    19cf:	ff 35 e8 68 00 00    	pushl  0x68e8
    19d5:	e8 6e f1 ff ff       	call   b48 <APCreateCompatibleDCFromBitmap>
    19da:	83 c4 10             	add    $0x10,%esp
    19dd:	a3 f4 68 00 00       	mov    %eax,0x68f4
        grid_river = APLoadBitmap ("grid_river.bmp");
    19e2:	8d 45 98             	lea    -0x68(%ebp),%eax
    19e5:	83 ec 08             	sub    $0x8,%esp
    19e8:	68 dd 25 00 00       	push   $0x25dd
    19ed:	50                   	push   %eax
    19ee:	e8 1b ef ff ff       	call   90e <APLoadBitmap>
    19f3:	83 c4 0c             	add    $0xc,%esp
    19f6:	8b 45 98             	mov    -0x68(%ebp),%eax
    19f9:	a3 30 69 00 00       	mov    %eax,0x6930
    19fe:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a01:	a3 34 69 00 00       	mov    %eax,0x6934
    1a06:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a09:	a3 38 69 00 00       	mov    %eax,0x6938
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1a0e:	83 ec 04             	sub    $0x4,%esp
    1a11:	ff 35 38 69 00 00    	pushl  0x6938
    1a17:	ff 35 34 69 00 00    	pushl  0x6934
    1a1d:	ff 35 30 69 00 00    	pushl  0x6930
    1a23:	e8 20 f1 ff ff       	call   b48 <APCreateCompatibleDCFromBitmap>
    1a28:	83 c4 10             	add    $0x10,%esp
    1a2b:	a3 20 69 00 00       	mov    %eax,0x6920
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1a30:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a33:	83 ec 08             	sub    $0x8,%esp
    1a36:	68 ec 25 00 00       	push   $0x25ec
    1a3b:	50                   	push   %eax
    1a3c:	e8 cd ee ff ff       	call   90e <APLoadBitmap>
    1a41:	83 c4 0c             	add    $0xc,%esp
    1a44:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a47:	a3 24 69 00 00       	mov    %eax,0x6924
    1a4c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a4f:	a3 28 69 00 00       	mov    %eax,0x6928
    1a54:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a57:	a3 2c 69 00 00       	mov    %eax,0x692c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1a5c:	83 ec 04             	sub    $0x4,%esp
    1a5f:	ff 35 2c 69 00 00    	pushl  0x692c
    1a65:	ff 35 28 69 00 00    	pushl  0x6928
    1a6b:	ff 35 24 69 00 00    	pushl  0x6924
    1a71:	e8 d2 f0 ff ff       	call   b48 <APCreateCompatibleDCFromBitmap>
    1a76:	83 c4 10             	add    $0x10,%esp
    1a79:	a3 c8 68 00 00       	mov    %eax,0x68c8
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1a7e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a81:	83 ec 08             	sub    $0x8,%esp
    1a84:	68 fb 25 00 00       	push   $0x25fb
    1a89:	50                   	push   %eax
    1a8a:	e8 7f ee ff ff       	call   90e <APLoadBitmap>
    1a8f:	83 c4 0c             	add    $0xc,%esp
    1a92:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a95:	a3 fc 68 00 00       	mov    %eax,0x68fc
    1a9a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a9d:	a3 00 69 00 00       	mov    %eax,0x6900
    1aa2:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1aa5:	a3 04 69 00 00       	mov    %eax,0x6904
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1aaa:	83 ec 04             	sub    $0x4,%esp
    1aad:	ff 35 04 69 00 00    	pushl  0x6904
    1ab3:	ff 35 00 69 00 00    	pushl  0x6900
    1ab9:	ff 35 fc 68 00 00    	pushl  0x68fc
    1abf:	e8 84 f0 ff ff       	call   b48 <APCreateCompatibleDCFromBitmap>
    1ac4:	83 c4 10             	add    $0x10,%esp
    1ac7:	a3 40 69 00 00       	mov    %eax,0x6940
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1acc:	8d 45 98             	lea    -0x68(%ebp),%eax
    1acf:	83 ec 08             	sub    $0x8,%esp
    1ad2:	68 09 26 00 00       	push   $0x2609
    1ad7:	50                   	push   %eax
    1ad8:	e8 31 ee ff ff       	call   90e <APLoadBitmap>
    1add:	83 c4 0c             	add    $0xc,%esp
    1ae0:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ae3:	a3 d8 68 00 00       	mov    %eax,0x68d8
    1ae8:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1aeb:	a3 dc 68 00 00       	mov    %eax,0x68dc
    1af0:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1af3:	a3 e0 68 00 00       	mov    %eax,0x68e0
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1af8:	83 ec 04             	sub    $0x4,%esp
    1afb:	ff 35 e0 68 00 00    	pushl  0x68e0
    1b01:	ff 35 dc 68 00 00    	pushl  0x68dc
    1b07:	ff 35 d8 68 00 00    	pushl  0x68d8
    1b0d:	e8 36 f0 ff ff       	call   b48 <APCreateCompatibleDCFromBitmap>
    1b12:	83 c4 10             	add    $0x10,%esp
    1b15:	a3 f8 68 00 00       	mov    %eax,0x68f8
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1b1a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b1d:	83 ec 08             	sub    $0x8,%esp
    1b20:	68 19 26 00 00       	push   $0x2619
    1b25:	50                   	push   %eax
    1b26:	e8 e3 ed ff ff       	call   90e <APLoadBitmap>
    1b2b:	83 c4 0c             	add    $0xc,%esp
    1b2e:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b31:	a3 cc 68 00 00       	mov    %eax,0x68cc
    1b36:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b39:	a3 d0 68 00 00       	mov    %eax,0x68d0
    1b3e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b41:	a3 d4 68 00 00       	mov    %eax,0x68d4
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1b46:	83 ec 04             	sub    $0x4,%esp
    1b49:	ff 35 d4 68 00 00    	pushl  0x68d4
    1b4f:	ff 35 d0 68 00 00    	pushl  0x68d0
    1b55:	ff 35 cc 68 00 00    	pushl  0x68cc
    1b5b:	e8 e8 ef ff ff       	call   b48 <APCreateCompatibleDCFromBitmap>
    1b60:	83 c4 10             	add    $0x10,%esp
    1b63:	a3 e4 68 00 00       	mov    %eax,0x68e4
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1b68:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b6b:	83 ec 08             	sub    $0x8,%esp
    1b6e:	68 2b 26 00 00       	push   $0x262b
    1b73:	50                   	push   %eax
    1b74:	e8 95 ed ff ff       	call   90e <APLoadBitmap>
    1b79:	83 c4 0c             	add    $0xc,%esp
    1b7c:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b7f:	a3 14 69 00 00       	mov    %eax,0x6914
    1b84:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b87:	a3 18 69 00 00       	mov    %eax,0x6918
    1b8c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b8f:	a3 1c 69 00 00       	mov    %eax,0x691c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1b94:	83 ec 04             	sub    $0x4,%esp
    1b97:	ff 35 1c 69 00 00    	pushl  0x691c
    1b9d:	ff 35 18 69 00 00    	pushl  0x6918
    1ba3:	ff 35 14 69 00 00    	pushl  0x6914
    1ba9:	e8 9a ef ff ff       	call   b48 <APCreateCompatibleDCFromBitmap>
    1bae:	83 c4 10             	add    $0x10,%esp
    1bb1:	a3 44 69 00 00       	mov    %eax,0x6944
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    1bb6:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bb9:	83 ec 08             	sub    $0x8,%esp
    1bbc:	68 3a 26 00 00       	push   $0x263a
    1bc1:	50                   	push   %eax
    1bc2:	e8 47 ed ff ff       	call   90e <APLoadBitmap>
    1bc7:	83 c4 0c             	add    $0xc,%esp
    1bca:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bcd:	a3 08 69 00 00       	mov    %eax,0x6908
    1bd2:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1bd5:	a3 0c 69 00 00       	mov    %eax,0x690c
    1bda:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bdd:	a3 10 69 00 00       	mov    %eax,0x6910
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    1be2:	83 ec 04             	sub    $0x4,%esp
    1be5:	ff 35 10 69 00 00    	pushl  0x6910
    1beb:	ff 35 0c 69 00 00    	pushl  0x690c
    1bf1:	ff 35 08 69 00 00    	pushl  0x6908
    1bf7:	e8 4c ef ff ff       	call   b48 <APCreateCompatibleDCFromBitmap>
    1bfc:	83 c4 10             	add    $0x10,%esp
    1bff:	a3 3c 69 00 00       	mov    %eax,0x693c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1c04:	8b 45 08             	mov    0x8(%ebp),%eax
    1c07:	8b 40 08             	mov    0x8(%eax),%eax
    1c0a:	85 c0                	test   %eax,%eax
    1c0c:	75 17                	jne    1c25 <APGridPaint+0x2b1>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1c0e:	83 ec 08             	sub    $0x8,%esp
    1c11:	68 4c 26 00 00       	push   $0x264c
    1c16:	6a 01                	push   $0x1
    1c18:	e8 6b e8 ff ff       	call   488 <printf>
    1c1d:	83 c4 10             	add    $0x10,%esp
        return;
    1c20:	e9 50 04 00 00       	jmp    2075 <APGridPaint+0x701>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1c25:	8b 45 08             	mov    0x8(%ebp),%eax
    1c28:	8b 40 10             	mov    0x10(%eax),%eax
    1c2b:	85 c0                	test   %eax,%eax
    1c2d:	7e 10                	jle    1c3f <APGridPaint+0x2cb>
    1c2f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c32:	8b 50 14             	mov    0x14(%eax),%edx
    1c35:	8b 45 08             	mov    0x8(%ebp),%eax
    1c38:	8b 40 10             	mov    0x10(%eax),%eax
    1c3b:	39 c2                	cmp    %eax,%edx
    1c3d:	7c 17                	jl     1c56 <APGridPaint+0x2e2>
    {
        printf(1,"Grid mode page error!");
    1c3f:	83 ec 08             	sub    $0x8,%esp
    1c42:	68 72 26 00 00       	push   $0x2672
    1c47:	6a 01                	push   $0x1
    1c49:	e8 3a e8 ff ff       	call   488 <printf>
    1c4e:	83 c4 10             	add    $0x10,%esp
        return;
    1c51:	e9 1f 04 00 00       	jmp    2075 <APGridPaint+0x701>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1c56:	8b 45 08             	mov    0x8(%ebp),%eax
    1c59:	8b 40 14             	mov    0x14(%eax),%eax
    1c5c:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1c62:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1c65:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1c68:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1c6b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1c72:	e9 f4 03 00 00       	jmp    206b <APGridPaint+0x6f7>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1c77:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1c7e:	e9 da 03 00 00       	jmp    205d <APGridPaint+0x6e9>
        {
            index = start + GRID_W_NUMBER * j + i;
    1c83:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c86:	c1 e0 04             	shl    $0x4,%eax
    1c89:	89 c2                	mov    %eax,%edx
    1c8b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1c8e:	01 c2                	add    %eax,%edx
    1c90:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c93:	01 d0                	add    %edx,%eax
    1c95:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1c98:	8b 45 08             	mov    0x8(%ebp),%eax
    1c9b:	8b 40 0c             	mov    0xc(%eax),%eax
    1c9e:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1ca1:	c1 e2 02             	shl    $0x2,%edx
    1ca4:	01 d0                	add    %edx,%eax
    1ca6:	8b 00                	mov    (%eax),%eax
    1ca8:	83 f8 0a             	cmp    $0xa,%eax
    1cab:	0f 87 a7 03 00 00    	ja     2058 <APGridPaint+0x6e4>
    1cb1:	8b 04 85 88 26 00 00 	mov    0x2688(,%eax,4),%eax
    1cb8:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cba:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1cbd:	6a 0c                	push   $0xc
    1cbf:	6a 0c                	push   $0xc
    1cc1:	6a 0c                	push   $0xc
    1cc3:	50                   	push   %eax
    1cc4:	e8 27 f8 ff ff       	call   14f0 <RGB>
    1cc9:	83 c4 0c             	add    $0xc,%esp
    1ccc:	8b 1d f4 68 00 00    	mov    0x68f4,%ebx
    1cd2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cd5:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cd8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cdb:	6b c0 32             	imul   $0x32,%eax,%eax
    1cde:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ce1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce4:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ce7:	83 ec 0c             	sub    $0xc,%esp
    1cea:	83 ec 04             	sub    $0x4,%esp
    1ced:	89 e0                	mov    %esp,%eax
    1cef:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    1cf3:	66 89 30             	mov    %si,(%eax)
    1cf6:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    1cfa:	88 50 02             	mov    %dl,0x2(%eax)
    1cfd:	6a 32                	push   $0x32
    1cff:	6a 32                	push   $0x32
    1d01:	6a 00                	push   $0x0
    1d03:	6a 00                	push   $0x0
    1d05:	53                   	push   %ebx
    1d06:	51                   	push   %ecx
    1d07:	ff 75 94             	pushl  -0x6c(%ebp)
    1d0a:	57                   	push   %edi
    1d0b:	e8 3c f6 ff ff       	call   134c <APDcCopy>
    1d10:	83 c4 30             	add    $0x30,%esp
                    break;
    1d13:	e9 41 03 00 00       	jmp    2059 <APGridPaint+0x6e5>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1d18:	8d 45 98             	lea    -0x68(%ebp),%eax
    1d1b:	6a 69                	push   $0x69
    1d1d:	6a 69                	push   $0x69
    1d1f:	6a 69                	push   $0x69
    1d21:	50                   	push   %eax
    1d22:	e8 c9 f7 ff ff       	call   14f0 <RGB>
    1d27:	83 c4 0c             	add    $0xc,%esp
    1d2a:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1d2e:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1d32:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1d36:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1d39:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1d40:	8d 45 98             	lea    -0x68(%ebp),%eax
    1d43:	6a 69                	push   $0x69
    1d45:	6a 69                	push   $0x69
    1d47:	6a 69                	push   $0x69
    1d49:	50                   	push   %eax
    1d4a:	e8 a1 f7 ff ff       	call   14f0 <RGB>
    1d4f:	83 c4 0c             	add    $0xc,%esp
    1d52:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1d56:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1d5a:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1d5e:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1d61:	8b 45 08             	mov    0x8(%ebp),%eax
    1d64:	8d 50 3c             	lea    0x3c(%eax),%edx
    1d67:	8d 45 98             	lea    -0x68(%ebp),%eax
    1d6a:	ff 75 bc             	pushl  -0x44(%ebp)
    1d6d:	ff 75 b8             	pushl  -0x48(%ebp)
    1d70:	52                   	push   %edx
    1d71:	50                   	push   %eax
    1d72:	e8 66 ee ff ff       	call   bdd <APSetPen>
    1d77:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1d7a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7d:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1d80:	8d 55 98             	lea    -0x68(%ebp),%edx
    1d83:	83 ec 04             	sub    $0x4,%esp
    1d86:	83 ec 04             	sub    $0x4,%esp
    1d89:	89 e0                	mov    %esp,%eax
    1d8b:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1d8f:	66 89 08             	mov    %cx,(%eax)
    1d92:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1d96:	88 48 02             	mov    %cl,0x2(%eax)
    1d99:	53                   	push   %ebx
    1d9a:	52                   	push   %edx
    1d9b:	e8 76 ee ff ff       	call   c16 <APSetBrush>
    1da0:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1da3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1da6:	6b d0 32             	imul   $0x32,%eax,%edx
    1da9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dac:	6b c0 32             	imul   $0x32,%eax,%eax
    1daf:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1db2:	83 c1 3c             	add    $0x3c,%ecx
    1db5:	83 ec 0c             	sub    $0xc,%esp
    1db8:	6a 32                	push   $0x32
    1dba:	6a 32                	push   $0x32
    1dbc:	52                   	push   %edx
    1dbd:	50                   	push   %eax
    1dbe:	51                   	push   %ecx
    1dbf:	e8 7c f2 ff ff       	call   1040 <APDrawRect>
    1dc4:	83 c4 20             	add    $0x20,%esp
                    break;
    1dc7:	e9 8d 02 00 00       	jmp    2059 <APGridPaint+0x6e5>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dcc:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1dcf:	6a 0c                	push   $0xc
    1dd1:	6a 0c                	push   $0xc
    1dd3:	6a 0c                	push   $0xc
    1dd5:	50                   	push   %eax
    1dd6:	e8 15 f7 ff ff       	call   14f0 <RGB>
    1ddb:	83 c4 0c             	add    $0xc,%esp
    1dde:	8b 1d 44 69 00 00    	mov    0x6944,%ebx
    1de4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1de7:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dea:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ded:	6b c0 32             	imul   $0x32,%eax,%eax
    1df0:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1df3:	8b 45 08             	mov    0x8(%ebp),%eax
    1df6:	8d 78 3c             	lea    0x3c(%eax),%edi
    1df9:	83 ec 0c             	sub    $0xc,%esp
    1dfc:	83 ec 04             	sub    $0x4,%esp
    1dff:	89 e0                	mov    %esp,%eax
    1e01:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1e05:	66 89 30             	mov    %si,(%eax)
    1e08:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1e0c:	88 50 02             	mov    %dl,0x2(%eax)
    1e0f:	6a 32                	push   $0x32
    1e11:	6a 32                	push   $0x32
    1e13:	6a 00                	push   $0x0
    1e15:	6a 00                	push   $0x0
    1e17:	53                   	push   %ebx
    1e18:	51                   	push   %ecx
    1e19:	ff 75 94             	pushl  -0x6c(%ebp)
    1e1c:	57                   	push   %edi
    1e1d:	e8 2a f5 ff ff       	call   134c <APDcCopy>
    1e22:	83 c4 30             	add    $0x30,%esp
                    break;
    1e25:	e9 2f 02 00 00       	jmp    2059 <APGridPaint+0x6e5>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e2a:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1e2d:	6a 0c                	push   $0xc
    1e2f:	6a 0c                	push   $0xc
    1e31:	6a 0c                	push   $0xc
    1e33:	50                   	push   %eax
    1e34:	e8 b7 f6 ff ff       	call   14f0 <RGB>
    1e39:	83 c4 0c             	add    $0xc,%esp
    1e3c:	8b 1d 20 69 00 00    	mov    0x6920,%ebx
    1e42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e45:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e48:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e4b:	6b c0 32             	imul   $0x32,%eax,%eax
    1e4e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e51:	8b 45 08             	mov    0x8(%ebp),%eax
    1e54:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e57:	83 ec 0c             	sub    $0xc,%esp
    1e5a:	83 ec 04             	sub    $0x4,%esp
    1e5d:	89 e0                	mov    %esp,%eax
    1e5f:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1e63:	66 89 30             	mov    %si,(%eax)
    1e66:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1e6a:	88 50 02             	mov    %dl,0x2(%eax)
    1e6d:	6a 32                	push   $0x32
    1e6f:	6a 32                	push   $0x32
    1e71:	6a 00                	push   $0x0
    1e73:	6a 00                	push   $0x0
    1e75:	53                   	push   %ebx
    1e76:	51                   	push   %ecx
    1e77:	ff 75 94             	pushl  -0x6c(%ebp)
    1e7a:	57                   	push   %edi
    1e7b:	e8 cc f4 ff ff       	call   134c <APDcCopy>
    1e80:	83 c4 30             	add    $0x30,%esp
                    break;
    1e83:	e9 d1 01 00 00       	jmp    2059 <APGridPaint+0x6e5>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e88:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1e8b:	6a 0c                	push   $0xc
    1e8d:	6a 0c                	push   $0xc
    1e8f:	6a 0c                	push   $0xc
    1e91:	50                   	push   %eax
    1e92:	e8 59 f6 ff ff       	call   14f0 <RGB>
    1e97:	83 c4 0c             	add    $0xc,%esp
    1e9a:	8b 1d f8 68 00 00    	mov    0x68f8,%ebx
    1ea0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ea3:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ea6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ea9:	6b c0 32             	imul   $0x32,%eax,%eax
    1eac:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1eaf:	8b 45 08             	mov    0x8(%ebp),%eax
    1eb2:	8d 78 3c             	lea    0x3c(%eax),%edi
    1eb5:	83 ec 0c             	sub    $0xc,%esp
    1eb8:	83 ec 04             	sub    $0x4,%esp
    1ebb:	89 e0                	mov    %esp,%eax
    1ebd:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1ec1:	66 89 30             	mov    %si,(%eax)
    1ec4:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1ec8:	88 50 02             	mov    %dl,0x2(%eax)
    1ecb:	6a 32                	push   $0x32
    1ecd:	6a 32                	push   $0x32
    1ecf:	6a 00                	push   $0x0
    1ed1:	6a 00                	push   $0x0
    1ed3:	53                   	push   %ebx
    1ed4:	51                   	push   %ecx
    1ed5:	ff 75 94             	pushl  -0x6c(%ebp)
    1ed8:	57                   	push   %edi
    1ed9:	e8 6e f4 ff ff       	call   134c <APDcCopy>
    1ede:	83 c4 30             	add    $0x30,%esp
                    break;
    1ee1:	e9 73 01 00 00       	jmp    2059 <APGridPaint+0x6e5>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ee6:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1ee9:	6a 0c                	push   $0xc
    1eeb:	6a 0c                	push   $0xc
    1eed:	6a 0c                	push   $0xc
    1eef:	50                   	push   %eax
    1ef0:	e8 fb f5 ff ff       	call   14f0 <RGB>
    1ef5:	83 c4 0c             	add    $0xc,%esp
    1ef8:	8b 1d 40 69 00 00    	mov    0x6940,%ebx
    1efe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f01:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f04:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f07:	6b c0 32             	imul   $0x32,%eax,%eax
    1f0a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f0d:	8b 45 08             	mov    0x8(%ebp),%eax
    1f10:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f13:	83 ec 0c             	sub    $0xc,%esp
    1f16:	83 ec 04             	sub    $0x4,%esp
    1f19:	89 e0                	mov    %esp,%eax
    1f1b:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1f1f:	66 89 30             	mov    %si,(%eax)
    1f22:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1f26:	88 50 02             	mov    %dl,0x2(%eax)
    1f29:	6a 32                	push   $0x32
    1f2b:	6a 32                	push   $0x32
    1f2d:	6a 00                	push   $0x0
    1f2f:	6a 00                	push   $0x0
    1f31:	53                   	push   %ebx
    1f32:	51                   	push   %ecx
    1f33:	ff 75 94             	pushl  -0x6c(%ebp)
    1f36:	57                   	push   %edi
    1f37:	e8 10 f4 ff ff       	call   134c <APDcCopy>
    1f3c:	83 c4 30             	add    $0x30,%esp
                    break;
    1f3f:	e9 15 01 00 00       	jmp    2059 <APGridPaint+0x6e5>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f44:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1f47:	6a 0c                	push   $0xc
    1f49:	6a 0c                	push   $0xc
    1f4b:	6a 0c                	push   $0xc
    1f4d:	50                   	push   %eax
    1f4e:	e8 9d f5 ff ff       	call   14f0 <RGB>
    1f53:	83 c4 0c             	add    $0xc,%esp
    1f56:	8b 1d c8 68 00 00    	mov    0x68c8,%ebx
    1f5c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f5f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f62:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f65:	6b c0 32             	imul   $0x32,%eax,%eax
    1f68:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f6e:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f71:	83 ec 0c             	sub    $0xc,%esp
    1f74:	83 ec 04             	sub    $0x4,%esp
    1f77:	89 e0                	mov    %esp,%eax
    1f79:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1f7d:	66 89 30             	mov    %si,(%eax)
    1f80:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1f84:	88 50 02             	mov    %dl,0x2(%eax)
    1f87:	6a 32                	push   $0x32
    1f89:	6a 32                	push   $0x32
    1f8b:	6a 00                	push   $0x0
    1f8d:	6a 00                	push   $0x0
    1f8f:	53                   	push   %ebx
    1f90:	51                   	push   %ecx
    1f91:	ff 75 94             	pushl  -0x6c(%ebp)
    1f94:	57                   	push   %edi
    1f95:	e8 b2 f3 ff ff       	call   134c <APDcCopy>
    1f9a:	83 c4 30             	add    $0x30,%esp
                    break;
    1f9d:	e9 b7 00 00 00       	jmp    2059 <APGridPaint+0x6e5>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fa2:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1fa5:	6a 0c                	push   $0xc
    1fa7:	6a 0c                	push   $0xc
    1fa9:	6a 0c                	push   $0xc
    1fab:	50                   	push   %eax
    1fac:	e8 3f f5 ff ff       	call   14f0 <RGB>
    1fb1:	83 c4 0c             	add    $0xc,%esp
    1fb4:	8b 1d e4 68 00 00    	mov    0x68e4,%ebx
    1fba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fbd:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fc0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fc3:	6b c0 32             	imul   $0x32,%eax,%eax
    1fc6:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1fc9:	8b 45 08             	mov    0x8(%ebp),%eax
    1fcc:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fcf:	83 ec 0c             	sub    $0xc,%esp
    1fd2:	83 ec 04             	sub    $0x4,%esp
    1fd5:	89 e0                	mov    %esp,%eax
    1fd7:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1fdb:	66 89 30             	mov    %si,(%eax)
    1fde:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1fe2:	88 50 02             	mov    %dl,0x2(%eax)
    1fe5:	6a 32                	push   $0x32
    1fe7:	6a 32                	push   $0x32
    1fe9:	6a 00                	push   $0x0
    1feb:	6a 00                	push   $0x0
    1fed:	53                   	push   %ebx
    1fee:	51                   	push   %ecx
    1fef:	ff 75 94             	pushl  -0x6c(%ebp)
    1ff2:	57                   	push   %edi
    1ff3:	e8 54 f3 ff ff       	call   134c <APDcCopy>
    1ff8:	83 c4 30             	add    $0x30,%esp
                    break;
    1ffb:	eb 5c                	jmp    2059 <APGridPaint+0x6e5>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ffd:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    2000:	6a 0c                	push   $0xc
    2002:	6a 0c                	push   $0xc
    2004:	6a 0c                	push   $0xc
    2006:	50                   	push   %eax
    2007:	e8 e4 f4 ff ff       	call   14f0 <RGB>
    200c:	83 c4 0c             	add    $0xc,%esp
    200f:	8b 1d 3c 69 00 00    	mov    0x693c,%ebx
    2015:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2018:	6b c8 32             	imul   $0x32,%eax,%ecx
    201b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    201e:	6b c0 32             	imul   $0x32,%eax,%eax
    2021:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2024:	8b 45 08             	mov    0x8(%ebp),%eax
    2027:	8d 78 3c             	lea    0x3c(%eax),%edi
    202a:	83 ec 0c             	sub    $0xc,%esp
    202d:	83 ec 04             	sub    $0x4,%esp
    2030:	89 e0                	mov    %esp,%eax
    2032:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2036:	66 89 30             	mov    %si,(%eax)
    2039:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    203d:	88 50 02             	mov    %dl,0x2(%eax)
    2040:	6a 32                	push   $0x32
    2042:	6a 32                	push   $0x32
    2044:	6a 00                	push   $0x0
    2046:	6a 00                	push   $0x0
    2048:	53                   	push   %ebx
    2049:	51                   	push   %ecx
    204a:	ff 75 94             	pushl  -0x6c(%ebp)
    204d:	57                   	push   %edi
    204e:	e8 f9 f2 ff ff       	call   134c <APDcCopy>
    2053:	83 c4 30             	add    $0x30,%esp
                    break;
    2056:	eb 01                	jmp    2059 <APGridPaint+0x6e5>
                default: break;
    2058:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2059:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    205d:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2061:	0f 8e 1c fc ff ff    	jle    1c83 <APGridPaint+0x30f>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2067:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    206b:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    206f:	0f 8e 02 fc ff ff    	jle    1c77 <APGridPaint+0x303>
                default: break;
            }
        }
    }
    
}
    2075:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2078:	5b                   	pop    %ebx
    2079:	5e                   	pop    %esi
    207a:	5f                   	pop    %edi
    207b:	5d                   	pop    %ebp
    207c:	c3                   	ret    

0000207d <updateword>:


void updateword(AHwnd hwnd,char* str)
{
    207d:	55                   	push   %ebp
    207e:	89 e5                	mov    %esp,%ebp
    2080:	53                   	push   %ebx
    2081:	83 ec 24             	sub    $0x24,%esp
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2084:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2087:	68 cd 00 00 00       	push   $0xcd
    208c:	6a 74                	push   $0x74
    208e:	6a 18                	push   $0x18
    2090:	50                   	push   %eax
    2091:	e8 5a f4 ff ff       	call   14f0 <RGB>
    2096:	83 c4 0c             	add    $0xc,%esp
    2099:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    209d:	66 89 45 f0          	mov    %ax,-0x10(%ebp)
    20a1:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    20a5:	88 45 f2             	mov    %al,-0xe(%ebp)
    pen.size = 1;
    20a8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    20af:	8d 45 d8             	lea    -0x28(%ebp),%eax
    20b2:	68 cd 00 00 00       	push   $0xcd
    20b7:	6a 74                	push   $0x74
    20b9:	6a 18                	push   $0x18
    20bb:	50                   	push   %eax
    20bc:	e8 2f f4 ff ff       	call   14f0 <RGB>
    20c1:	83 c4 0c             	add    $0xc,%esp
    20c4:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    20c8:	66 89 45 ed          	mov    %ax,-0x13(%ebp)
    20cc:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    20d0:	88 45 ef             	mov    %al,-0x11(%ebp)
    APSetPen(&hwnd->TitleDc,pen);
    20d3:	8b 45 08             	mov    0x8(%ebp),%eax
    20d6:	8d 50 58             	lea    0x58(%eax),%edx
    20d9:	8d 45 d8             	lea    -0x28(%ebp),%eax
    20dc:	ff 75 f4             	pushl  -0xc(%ebp)
    20df:	ff 75 f0             	pushl  -0x10(%ebp)
    20e2:	52                   	push   %edx
    20e3:	50                   	push   %eax
    20e4:	e8 f4 ea ff ff       	call   bdd <APSetPen>
    20e9:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&hwnd->TitleDc,brush);
    20ec:	8b 45 08             	mov    0x8(%ebp),%eax
    20ef:	8d 58 58             	lea    0x58(%eax),%ebx
    20f2:	8d 55 d8             	lea    -0x28(%ebp),%edx
    20f5:	83 ec 04             	sub    $0x4,%esp
    20f8:	83 ec 04             	sub    $0x4,%esp
    20fb:	89 e0                	mov    %esp,%eax
    20fd:	0f b7 4d ed          	movzwl -0x13(%ebp),%ecx
    2101:	66 89 08             	mov    %cx,(%eax)
    2104:	0f b6 4d ef          	movzbl -0x11(%ebp),%ecx
    2108:	88 48 02             	mov    %cl,0x2(%eax)
    210b:	53                   	push   %ebx
    210c:	52                   	push   %edx
    210d:	e8 04 eb ff ff       	call   c16 <APSetBrush>
    2112:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&hwnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2115:	8b 45 08             	mov    0x8(%ebp),%eax
    2118:	83 c0 58             	add    $0x58,%eax
    211b:	83 ec 0c             	sub    $0xc,%esp
    211e:	6a 32                	push   $0x32
    2120:	68 20 03 00 00       	push   $0x320
    2125:	6a 00                	push   $0x0
    2127:	6a 00                	push   $0x0
    2129:	50                   	push   %eax
    212a:	e8 11 ef ff ff       	call   1040 <APDrawRect>
    212f:	83 c4 20             	add    $0x20,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    2132:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2135:	6a 08                	push   $0x8
    2137:	6a 08                	push   $0x8
    2139:	6a 08                	push   $0x8
    213b:	50                   	push   %eax
    213c:	e8 af f3 ff ff       	call   14f0 <RGB>
    2141:	83 c4 0c             	add    $0xc,%esp
    2144:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2148:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    214c:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    2150:	88 45 ec             	mov    %al,-0x14(%ebp)
    APSetFont(&hwnd->TitleDc,font);
    2153:	8b 45 08             	mov    0x8(%ebp),%eax
    2156:	8d 58 58             	lea    0x58(%eax),%ebx
    2159:	8d 55 d8             	lea    -0x28(%ebp),%edx
    215c:	83 ec 04             	sub    $0x4,%esp
    215f:	83 ec 04             	sub    $0x4,%esp
    2162:	89 e0                	mov    %esp,%eax
    2164:	0f b7 4d ea          	movzwl -0x16(%ebp),%ecx
    2168:	66 89 08             	mov    %cx,(%eax)
    216b:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
    216f:	88 48 02             	mov    %cl,0x2(%eax)
    2172:	53                   	push   %ebx
    2173:	52                   	push   %edx
    2174:	e8 df ea ff ff       	call   c58 <APSetFont>
    2179:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&hwnd->TitleDc,str,10,20);
    217c:	8b 45 08             	mov    0x8(%ebp),%eax
    217f:	83 c0 58             	add    $0x58,%eax
    2182:	6a 14                	push   $0x14
    2184:	6a 0a                	push   $0xa
    2186:	ff 75 0c             	pushl  0xc(%ebp)
    2189:	50                   	push   %eax
    218a:	e8 b6 f0 ff ff       	call   1245 <APDrawText>
    218f:	83 c4 10             	add    $0x10,%esp
}
    2192:	90                   	nop
    2193:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2196:	c9                   	leave  
    2197:	c3                   	ret    

00002198 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2198:	55                   	push   %ebp
    2199:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    219b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    219f:	7e 08                	jle    21a9 <random+0x11>
{
rand_num = seed;
    21a1:	8b 45 08             	mov    0x8(%ebp),%eax
    21a4:	a3 a0 68 00 00       	mov    %eax,0x68a0
}
rand_num *= 3;
    21a9:	8b 15 a0 68 00 00    	mov    0x68a0,%edx
    21af:	89 d0                	mov    %edx,%eax
    21b1:	01 c0                	add    %eax,%eax
    21b3:	01 d0                	add    %edx,%eax
    21b5:	a3 a0 68 00 00       	mov    %eax,0x68a0
if (rand_num < 0)
    21ba:	a1 a0 68 00 00       	mov    0x68a0,%eax
    21bf:	85 c0                	test   %eax,%eax
    21c1:	79 0c                	jns    21cf <random+0x37>
{
rand_num *= (-1);
    21c3:	a1 a0 68 00 00       	mov    0x68a0,%eax
    21c8:	f7 d8                	neg    %eax
    21ca:	a3 a0 68 00 00       	mov    %eax,0x68a0
}
return rand_num % 997;
    21cf:	8b 0d a0 68 00 00    	mov    0x68a0,%ecx
    21d5:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    21da:	89 c8                	mov    %ecx,%eax
    21dc:	f7 ea                	imul   %edx
    21de:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    21e1:	c1 f8 09             	sar    $0x9,%eax
    21e4:	89 c2                	mov    %eax,%edx
    21e6:	89 c8                	mov    %ecx,%eax
    21e8:	c1 f8 1f             	sar    $0x1f,%eax
    21eb:	29 c2                	sub    %eax,%edx
    21ed:	89 d0                	mov    %edx,%eax
    21ef:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    21f5:	29 c1                	sub    %eax,%ecx
    21f7:	89 c8                	mov    %ecx,%eax
}
    21f9:	5d                   	pop    %ebp
    21fa:	c3                   	ret    

000021fb <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    21fb:	55                   	push   %ebp
    21fc:	89 e5                	mov    %esp,%ebp
    21fe:	53                   	push   %ebx
    21ff:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2202:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2209:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    220d:	74 17                	je     2226 <sprintint+0x2b>
    220f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2213:	79 11                	jns    2226 <sprintint+0x2b>
        neg = 1;
    2215:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    221c:	8b 45 10             	mov    0x10(%ebp),%eax
    221f:	f7 d8                	neg    %eax
    2221:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2224:	eb 06                	jmp    222c <sprintint+0x31>
    } else {
        x = xx;
    2226:	8b 45 10             	mov    0x10(%ebp),%eax
    2229:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    222c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2233:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2236:	8d 41 01             	lea    0x1(%ecx),%eax
    2239:	89 45 f8             	mov    %eax,-0x8(%ebp)
    223c:	8b 5d 14             	mov    0x14(%ebp),%ebx
    223f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2242:	ba 00 00 00 00       	mov    $0x0,%edx
    2247:	f7 f3                	div    %ebx
    2249:	89 d0                	mov    %edx,%eax
    224b:	0f b6 80 a4 68 00 00 	movzbl 0x68a4(%eax),%eax
    2252:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2256:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2259:	8b 45 f0             	mov    -0x10(%ebp),%eax
    225c:	ba 00 00 00 00       	mov    $0x0,%edx
    2261:	f7 f3                	div    %ebx
    2263:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2266:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    226a:	75 c7                	jne    2233 <sprintint+0x38>
    if(neg)
    226c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2270:	74 0e                	je     2280 <sprintint+0x85>
        buf[i++] = '-';
    2272:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2275:	8d 50 01             	lea    0x1(%eax),%edx
    2278:	89 55 f8             	mov    %edx,-0x8(%ebp)
    227b:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2280:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2283:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2286:	eb 1b                	jmp    22a3 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2288:	8b 45 0c             	mov    0xc(%ebp),%eax
    228b:	8b 00                	mov    (%eax),%eax
    228d:	8d 48 01             	lea    0x1(%eax),%ecx
    2290:	8b 55 0c             	mov    0xc(%ebp),%edx
    2293:	89 0a                	mov    %ecx,(%edx)
    2295:	89 c2                	mov    %eax,%edx
    2297:	8b 45 08             	mov    0x8(%ebp),%eax
    229a:	01 d0                	add    %edx,%eax
    229c:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    229f:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    22a3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    22a7:	7f df                	jg     2288 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    22a9:	eb 21                	jmp    22cc <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    22ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    22ae:	8b 00                	mov    (%eax),%eax
    22b0:	8d 48 01             	lea    0x1(%eax),%ecx
    22b3:	8b 55 0c             	mov    0xc(%ebp),%edx
    22b6:	89 0a                	mov    %ecx,(%edx)
    22b8:	89 c2                	mov    %eax,%edx
    22ba:	8b 45 08             	mov    0x8(%ebp),%eax
    22bd:	01 c2                	add    %eax,%edx
    22bf:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    22c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22c5:	01 c8                	add    %ecx,%eax
    22c7:	0f b6 00             	movzbl (%eax),%eax
    22ca:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    22cc:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    22d0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    22d4:	79 d5                	jns    22ab <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    22d6:	90                   	nop
    22d7:	83 c4 20             	add    $0x20,%esp
    22da:	5b                   	pop    %ebx
    22db:	5d                   	pop    %ebp
    22dc:	c3                   	ret    

000022dd <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    22dd:	55                   	push   %ebp
    22de:	89 e5                	mov    %esp,%ebp
    22e0:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    22e3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    22ea:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    22f1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    22f8:	8d 45 0c             	lea    0xc(%ebp),%eax
    22fb:	83 c0 04             	add    $0x4,%eax
    22fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2301:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2308:	e9 d9 01 00 00       	jmp    24e6 <sprintf+0x209>
        c = fmt[i] & 0xff;
    230d:	8b 55 0c             	mov    0xc(%ebp),%edx
    2310:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2313:	01 d0                	add    %edx,%eax
    2315:	0f b6 00             	movzbl (%eax),%eax
    2318:	0f be c0             	movsbl %al,%eax
    231b:	25 ff 00 00 00       	and    $0xff,%eax
    2320:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2323:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2327:	75 2c                	jne    2355 <sprintf+0x78>
            if(c == '%'){
    2329:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    232d:	75 0c                	jne    233b <sprintf+0x5e>
                state = '%';
    232f:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2336:	e9 a7 01 00 00       	jmp    24e2 <sprintf+0x205>
            } else {
                dst[j++] = c;
    233b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    233e:	8d 50 01             	lea    0x1(%eax),%edx
    2341:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2344:	89 c2                	mov    %eax,%edx
    2346:	8b 45 08             	mov    0x8(%ebp),%eax
    2349:	01 d0                	add    %edx,%eax
    234b:	8b 55 e0             	mov    -0x20(%ebp),%edx
    234e:	88 10                	mov    %dl,(%eax)
    2350:	e9 8d 01 00 00       	jmp    24e2 <sprintf+0x205>
            }
        } else if(state == '%'){
    2355:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2359:	0f 85 83 01 00 00    	jne    24e2 <sprintf+0x205>
            if(c == 'd'){
    235f:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2363:	75 4c                	jne    23b1 <sprintf+0xd4>
                buf[bi] = '\0';
    2365:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2368:	8b 45 f0             	mov    -0x10(%ebp),%eax
    236b:	01 d0                	add    %edx,%eax
    236d:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2370:	83 ec 0c             	sub    $0xc,%esp
    2373:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2376:	50                   	push   %eax
    2377:	e8 bb de ff ff       	call   237 <atoi>
    237c:	83 c4 10             	add    $0x10,%esp
    237f:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2382:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2389:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    238c:	8b 00                	mov    (%eax),%eax
    238e:	83 ec 08             	sub    $0x8,%esp
    2391:	ff 75 d8             	pushl  -0x28(%ebp)
    2394:	6a 01                	push   $0x1
    2396:	6a 0a                	push   $0xa
    2398:	50                   	push   %eax
    2399:	8d 45 c8             	lea    -0x38(%ebp),%eax
    239c:	50                   	push   %eax
    239d:	ff 75 08             	pushl  0x8(%ebp)
    23a0:	e8 56 fe ff ff       	call   21fb <sprintint>
    23a5:	83 c4 20             	add    $0x20,%esp
                ap++;
    23a8:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    23ac:	e9 2a 01 00 00       	jmp    24db <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    23b1:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    23b5:	74 06                	je     23bd <sprintf+0xe0>
    23b7:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    23bb:	75 4c                	jne    2409 <sprintf+0x12c>
                buf[bi] = '\0';
    23bd:	8d 55 ce             	lea    -0x32(%ebp),%edx
    23c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23c3:	01 d0                	add    %edx,%eax
    23c5:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    23c8:	83 ec 0c             	sub    $0xc,%esp
    23cb:	8d 45 ce             	lea    -0x32(%ebp),%eax
    23ce:	50                   	push   %eax
    23cf:	e8 63 de ff ff       	call   237 <atoi>
    23d4:	83 c4 10             	add    $0x10,%esp
    23d7:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    23da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    23e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23e4:	8b 00                	mov    (%eax),%eax
    23e6:	83 ec 08             	sub    $0x8,%esp
    23e9:	ff 75 dc             	pushl  -0x24(%ebp)
    23ec:	6a 00                	push   $0x0
    23ee:	6a 10                	push   $0x10
    23f0:	50                   	push   %eax
    23f1:	8d 45 c8             	lea    -0x38(%ebp),%eax
    23f4:	50                   	push   %eax
    23f5:	ff 75 08             	pushl  0x8(%ebp)
    23f8:	e8 fe fd ff ff       	call   21fb <sprintint>
    23fd:	83 c4 20             	add    $0x20,%esp
                ap++;
    2400:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2404:	e9 d2 00 00 00       	jmp    24db <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2409:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    240d:	75 46                	jne    2455 <sprintf+0x178>
                s = (char*)*ap;
    240f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2412:	8b 00                	mov    (%eax),%eax
    2414:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2417:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    241b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    241f:	75 25                	jne    2446 <sprintf+0x169>
                    s = "(null)";
    2421:	c7 45 f4 b4 26 00 00 	movl   $0x26b4,-0xc(%ebp)
                while(*s != 0){
    2428:	eb 1c                	jmp    2446 <sprintf+0x169>
                    dst[j++] = *s;
    242a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    242d:	8d 50 01             	lea    0x1(%eax),%edx
    2430:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2433:	89 c2                	mov    %eax,%edx
    2435:	8b 45 08             	mov    0x8(%ebp),%eax
    2438:	01 c2                	add    %eax,%edx
    243a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    243d:	0f b6 00             	movzbl (%eax),%eax
    2440:	88 02                	mov    %al,(%edx)
                    s++;
    2442:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2446:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2449:	0f b6 00             	movzbl (%eax),%eax
    244c:	84 c0                	test   %al,%al
    244e:	75 da                	jne    242a <sprintf+0x14d>
    2450:	e9 86 00 00 00       	jmp    24db <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2455:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2459:	75 1d                	jne    2478 <sprintf+0x19b>
                dst[j++] = *ap;
    245b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    245e:	8d 50 01             	lea    0x1(%eax),%edx
    2461:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2464:	89 c2                	mov    %eax,%edx
    2466:	8b 45 08             	mov    0x8(%ebp),%eax
    2469:	01 c2                	add    %eax,%edx
    246b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    246e:	8b 00                	mov    (%eax),%eax
    2470:	88 02                	mov    %al,(%edx)
                ap++;
    2472:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2476:	eb 63                	jmp    24db <sprintf+0x1fe>
            } else if(c == '%'){
    2478:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    247c:	75 17                	jne    2495 <sprintf+0x1b8>
                dst[j++] = c;
    247e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2481:	8d 50 01             	lea    0x1(%eax),%edx
    2484:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2487:	89 c2                	mov    %eax,%edx
    2489:	8b 45 08             	mov    0x8(%ebp),%eax
    248c:	01 d0                	add    %edx,%eax
    248e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2491:	88 10                	mov    %dl,(%eax)
    2493:	eb 46                	jmp    24db <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2495:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2499:	7e 18                	jle    24b3 <sprintf+0x1d6>
    249b:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    249f:	7f 12                	jg     24b3 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    24a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24a4:	8d 50 01             	lea    0x1(%eax),%edx
    24a7:	89 55 f0             	mov    %edx,-0x10(%ebp)
    24aa:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24ad:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    24b1:	eb 2f                	jmp    24e2 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    24b3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24b6:	8d 50 01             	lea    0x1(%eax),%edx
    24b9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24bc:	89 c2                	mov    %eax,%edx
    24be:	8b 45 08             	mov    0x8(%ebp),%eax
    24c1:	01 d0                	add    %edx,%eax
    24c3:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    24c6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24c9:	8d 50 01             	lea    0x1(%eax),%edx
    24cc:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24cf:	89 c2                	mov    %eax,%edx
    24d1:	8b 45 08             	mov    0x8(%ebp),%eax
    24d4:	01 d0                	add    %edx,%eax
    24d6:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24d9:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    24db:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    24e2:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    24e6:	8b 55 0c             	mov    0xc(%ebp),%edx
    24e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    24ec:	01 d0                	add    %edx,%eax
    24ee:	0f b6 00             	movzbl (%eax),%eax
    24f1:	84 c0                	test   %al,%al
    24f3:	0f 85 14 fe ff ff    	jne    230d <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    24f9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24fc:	8d 50 01             	lea    0x1(%eax),%edx
    24ff:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2502:	89 c2                	mov    %eax,%edx
    2504:	8b 45 08             	mov    0x8(%ebp),%eax
    2507:	01 d0                	add    %edx,%eax
    2509:	c6 00 00             	movb   $0x0,(%eax)
}
    250c:	90                   	nop
    250d:	c9                   	leave  
    250e:	c3                   	ret    
