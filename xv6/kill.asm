
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
      1c:	68 2c 22 00 00       	push   $0x222c
      21:	6a 02                	push   $0x2
      23:	e8 40 04 00 00       	call   468 <printf>
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

00000391 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     391:	55                   	push   %ebp
     392:	89 e5                	mov    %esp,%ebp
     394:	83 ec 18             	sub    $0x18,%esp
     397:	8b 45 0c             	mov    0xc(%ebp),%eax
     39a:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     39d:	83 ec 04             	sub    $0x4,%esp
     3a0:	6a 01                	push   $0x1
     3a2:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3a5:	50                   	push   %eax
     3a6:	ff 75 08             	pushl  0x8(%ebp)
     3a9:	e8 3b ff ff ff       	call   2e9 <write>
     3ae:	83 c4 10             	add    $0x10,%esp
}
     3b1:	90                   	nop
     3b2:	c9                   	leave  
     3b3:	c3                   	ret    

000003b4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3b4:	55                   	push   %ebp
     3b5:	89 e5                	mov    %esp,%ebp
     3b7:	53                   	push   %ebx
     3b8:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3bb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3c2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3c6:	74 17                	je     3df <printint+0x2b>
     3c8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3cc:	79 11                	jns    3df <printint+0x2b>
    neg = 1;
     3ce:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3d5:	8b 45 0c             	mov    0xc(%ebp),%eax
     3d8:	f7 d8                	neg    %eax
     3da:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3dd:	eb 06                	jmp    3e5 <printint+0x31>
  } else {
    x = xx;
     3df:	8b 45 0c             	mov    0xc(%ebp),%eax
     3e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3ec:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3ef:	8d 41 01             	lea    0x1(%ecx),%eax
     3f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3f5:	8b 5d 10             	mov    0x10(%ebp),%ebx
     3f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3fb:	ba 00 00 00 00       	mov    $0x0,%edx
     400:	f7 f3                	div    %ebx
     402:	89 d0                	mov    %edx,%eax
     404:	0f b6 80 14 29 00 00 	movzbl 0x2914(%eax),%eax
     40b:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     40f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     412:	8b 45 ec             	mov    -0x14(%ebp),%eax
     415:	ba 00 00 00 00       	mov    $0x0,%edx
     41a:	f7 f3                	div    %ebx
     41c:	89 45 ec             	mov    %eax,-0x14(%ebp)
     41f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     423:	75 c7                	jne    3ec <printint+0x38>
  if(neg)
     425:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     429:	74 2d                	je     458 <printint+0xa4>
    buf[i++] = '-';
     42b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     42e:	8d 50 01             	lea    0x1(%eax),%edx
     431:	89 55 f4             	mov    %edx,-0xc(%ebp)
     434:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     439:	eb 1d                	jmp    458 <printint+0xa4>
    putc(fd, buf[i]);
     43b:	8d 55 dc             	lea    -0x24(%ebp),%edx
     43e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     441:	01 d0                	add    %edx,%eax
     443:	0f b6 00             	movzbl (%eax),%eax
     446:	0f be c0             	movsbl %al,%eax
     449:	83 ec 08             	sub    $0x8,%esp
     44c:	50                   	push   %eax
     44d:	ff 75 08             	pushl  0x8(%ebp)
     450:	e8 3c ff ff ff       	call   391 <putc>
     455:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     458:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     45c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     460:	79 d9                	jns    43b <printint+0x87>
    putc(fd, buf[i]);
}
     462:	90                   	nop
     463:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     466:	c9                   	leave  
     467:	c3                   	ret    

00000468 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     468:	55                   	push   %ebp
     469:	89 e5                	mov    %esp,%ebp
     46b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     46e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     475:	8d 45 0c             	lea    0xc(%ebp),%eax
     478:	83 c0 04             	add    $0x4,%eax
     47b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     47e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     485:	e9 59 01 00 00       	jmp    5e3 <printf+0x17b>
    c = fmt[i] & 0xff;
     48a:	8b 55 0c             	mov    0xc(%ebp),%edx
     48d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     490:	01 d0                	add    %edx,%eax
     492:	0f b6 00             	movzbl (%eax),%eax
     495:	0f be c0             	movsbl %al,%eax
     498:	25 ff 00 00 00       	and    $0xff,%eax
     49d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4a4:	75 2c                	jne    4d2 <printf+0x6a>
      if(c == '%'){
     4a6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4aa:	75 0c                	jne    4b8 <printf+0x50>
        state = '%';
     4ac:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4b3:	e9 27 01 00 00       	jmp    5df <printf+0x177>
      } else {
        putc(fd, c);
     4b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4bb:	0f be c0             	movsbl %al,%eax
     4be:	83 ec 08             	sub    $0x8,%esp
     4c1:	50                   	push   %eax
     4c2:	ff 75 08             	pushl  0x8(%ebp)
     4c5:	e8 c7 fe ff ff       	call   391 <putc>
     4ca:	83 c4 10             	add    $0x10,%esp
     4cd:	e9 0d 01 00 00       	jmp    5df <printf+0x177>
      }
    } else if(state == '%'){
     4d2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4d6:	0f 85 03 01 00 00    	jne    5df <printf+0x177>
      if(c == 'd'){
     4dc:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4e0:	75 1e                	jne    500 <printf+0x98>
        printint(fd, *ap, 10, 1);
     4e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4e5:	8b 00                	mov    (%eax),%eax
     4e7:	6a 01                	push   $0x1
     4e9:	6a 0a                	push   $0xa
     4eb:	50                   	push   %eax
     4ec:	ff 75 08             	pushl  0x8(%ebp)
     4ef:	e8 c0 fe ff ff       	call   3b4 <printint>
     4f4:	83 c4 10             	add    $0x10,%esp
        ap++;
     4f7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4fb:	e9 d8 00 00 00       	jmp    5d8 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     500:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     504:	74 06                	je     50c <printf+0xa4>
     506:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     50a:	75 1e                	jne    52a <printf+0xc2>
        printint(fd, *ap, 16, 0);
     50c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     50f:	8b 00                	mov    (%eax),%eax
     511:	6a 00                	push   $0x0
     513:	6a 10                	push   $0x10
     515:	50                   	push   %eax
     516:	ff 75 08             	pushl  0x8(%ebp)
     519:	e8 96 fe ff ff       	call   3b4 <printint>
     51e:	83 c4 10             	add    $0x10,%esp
        ap++;
     521:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     525:	e9 ae 00 00 00       	jmp    5d8 <printf+0x170>
      } else if(c == 's'){
     52a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     52e:	75 43                	jne    573 <printf+0x10b>
        s = (char*)*ap;
     530:	8b 45 e8             	mov    -0x18(%ebp),%eax
     533:	8b 00                	mov    (%eax),%eax
     535:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     538:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     53c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     540:	75 25                	jne    567 <printf+0xff>
          s = "(null)";
     542:	c7 45 f4 40 22 00 00 	movl   $0x2240,-0xc(%ebp)
        while(*s != 0){
     549:	eb 1c                	jmp    567 <printf+0xff>
          putc(fd, *s);
     54b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     54e:	0f b6 00             	movzbl (%eax),%eax
     551:	0f be c0             	movsbl %al,%eax
     554:	83 ec 08             	sub    $0x8,%esp
     557:	50                   	push   %eax
     558:	ff 75 08             	pushl  0x8(%ebp)
     55b:	e8 31 fe ff ff       	call   391 <putc>
     560:	83 c4 10             	add    $0x10,%esp
          s++;
     563:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     567:	8b 45 f4             	mov    -0xc(%ebp),%eax
     56a:	0f b6 00             	movzbl (%eax),%eax
     56d:	84 c0                	test   %al,%al
     56f:	75 da                	jne    54b <printf+0xe3>
     571:	eb 65                	jmp    5d8 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     573:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     577:	75 1d                	jne    596 <printf+0x12e>
        putc(fd, *ap);
     579:	8b 45 e8             	mov    -0x18(%ebp),%eax
     57c:	8b 00                	mov    (%eax),%eax
     57e:	0f be c0             	movsbl %al,%eax
     581:	83 ec 08             	sub    $0x8,%esp
     584:	50                   	push   %eax
     585:	ff 75 08             	pushl  0x8(%ebp)
     588:	e8 04 fe ff ff       	call   391 <putc>
     58d:	83 c4 10             	add    $0x10,%esp
        ap++;
     590:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     594:	eb 42                	jmp    5d8 <printf+0x170>
      } else if(c == '%'){
     596:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     59a:	75 17                	jne    5b3 <printf+0x14b>
        putc(fd, c);
     59c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     59f:	0f be c0             	movsbl %al,%eax
     5a2:	83 ec 08             	sub    $0x8,%esp
     5a5:	50                   	push   %eax
     5a6:	ff 75 08             	pushl  0x8(%ebp)
     5a9:	e8 e3 fd ff ff       	call   391 <putc>
     5ae:	83 c4 10             	add    $0x10,%esp
     5b1:	eb 25                	jmp    5d8 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5b3:	83 ec 08             	sub    $0x8,%esp
     5b6:	6a 25                	push   $0x25
     5b8:	ff 75 08             	pushl  0x8(%ebp)
     5bb:	e8 d1 fd ff ff       	call   391 <putc>
     5c0:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5c6:	0f be c0             	movsbl %al,%eax
     5c9:	83 ec 08             	sub    $0x8,%esp
     5cc:	50                   	push   %eax
     5cd:	ff 75 08             	pushl  0x8(%ebp)
     5d0:	e8 bc fd ff ff       	call   391 <putc>
     5d5:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5d8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5df:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5e3:	8b 55 0c             	mov    0xc(%ebp),%edx
     5e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5e9:	01 d0                	add    %edx,%eax
     5eb:	0f b6 00             	movzbl (%eax),%eax
     5ee:	84 c0                	test   %al,%al
     5f0:	0f 85 94 fe ff ff    	jne    48a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     5f6:	90                   	nop
     5f7:	c9                   	leave  
     5f8:	c3                   	ret    

000005f9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     5f9:	55                   	push   %ebp
     5fa:	89 e5                	mov    %esp,%ebp
     5fc:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     5ff:	8b 45 08             	mov    0x8(%ebp),%eax
     602:	83 e8 08             	sub    $0x8,%eax
     605:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     608:	a1 48 29 00 00       	mov    0x2948,%eax
     60d:	89 45 fc             	mov    %eax,-0x4(%ebp)
     610:	eb 24                	jmp    636 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     612:	8b 45 fc             	mov    -0x4(%ebp),%eax
     615:	8b 00                	mov    (%eax),%eax
     617:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     61a:	77 12                	ja     62e <free+0x35>
     61c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     61f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     622:	77 24                	ja     648 <free+0x4f>
     624:	8b 45 fc             	mov    -0x4(%ebp),%eax
     627:	8b 00                	mov    (%eax),%eax
     629:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     62c:	77 1a                	ja     648 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     62e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     631:	8b 00                	mov    (%eax),%eax
     633:	89 45 fc             	mov    %eax,-0x4(%ebp)
     636:	8b 45 f8             	mov    -0x8(%ebp),%eax
     639:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     63c:	76 d4                	jbe    612 <free+0x19>
     63e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     641:	8b 00                	mov    (%eax),%eax
     643:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     646:	76 ca                	jbe    612 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     648:	8b 45 f8             	mov    -0x8(%ebp),%eax
     64b:	8b 40 04             	mov    0x4(%eax),%eax
     64e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     655:	8b 45 f8             	mov    -0x8(%ebp),%eax
     658:	01 c2                	add    %eax,%edx
     65a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     65d:	8b 00                	mov    (%eax),%eax
     65f:	39 c2                	cmp    %eax,%edx
     661:	75 24                	jne    687 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     663:	8b 45 f8             	mov    -0x8(%ebp),%eax
     666:	8b 50 04             	mov    0x4(%eax),%edx
     669:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66c:	8b 00                	mov    (%eax),%eax
     66e:	8b 40 04             	mov    0x4(%eax),%eax
     671:	01 c2                	add    %eax,%edx
     673:	8b 45 f8             	mov    -0x8(%ebp),%eax
     676:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     679:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67c:	8b 00                	mov    (%eax),%eax
     67e:	8b 10                	mov    (%eax),%edx
     680:	8b 45 f8             	mov    -0x8(%ebp),%eax
     683:	89 10                	mov    %edx,(%eax)
     685:	eb 0a                	jmp    691 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     687:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68a:	8b 10                	mov    (%eax),%edx
     68c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     68f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     691:	8b 45 fc             	mov    -0x4(%ebp),%eax
     694:	8b 40 04             	mov    0x4(%eax),%eax
     697:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     69e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a1:	01 d0                	add    %edx,%eax
     6a3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6a6:	75 20                	jne    6c8 <free+0xcf>
    p->s.size += bp->s.size;
     6a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ab:	8b 50 04             	mov    0x4(%eax),%edx
     6ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b1:	8b 40 04             	mov    0x4(%eax),%eax
     6b4:	01 c2                	add    %eax,%edx
     6b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b9:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6bf:	8b 10                	mov    (%eax),%edx
     6c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c4:	89 10                	mov    %edx,(%eax)
     6c6:	eb 08                	jmp    6d0 <free+0xd7>
  } else
    p->s.ptr = bp;
     6c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cb:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6ce:	89 10                	mov    %edx,(%eax)
  freep = p;
     6d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d3:	a3 48 29 00 00       	mov    %eax,0x2948
}
     6d8:	90                   	nop
     6d9:	c9                   	leave  
     6da:	c3                   	ret    

000006db <morecore>:

static Header*
morecore(uint nu)
{
     6db:	55                   	push   %ebp
     6dc:	89 e5                	mov    %esp,%ebp
     6de:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6e1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6e8:	77 07                	ja     6f1 <morecore+0x16>
    nu = 4096;
     6ea:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     6f1:	8b 45 08             	mov    0x8(%ebp),%eax
     6f4:	c1 e0 03             	shl    $0x3,%eax
     6f7:	83 ec 0c             	sub    $0xc,%esp
     6fa:	50                   	push   %eax
     6fb:	e8 51 fc ff ff       	call   351 <sbrk>
     700:	83 c4 10             	add    $0x10,%esp
     703:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     706:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     70a:	75 07                	jne    713 <morecore+0x38>
    return 0;
     70c:	b8 00 00 00 00       	mov    $0x0,%eax
     711:	eb 26                	jmp    739 <morecore+0x5e>
  hp = (Header*)p;
     713:	8b 45 f4             	mov    -0xc(%ebp),%eax
     716:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     719:	8b 45 f0             	mov    -0x10(%ebp),%eax
     71c:	8b 55 08             	mov    0x8(%ebp),%edx
     71f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     722:	8b 45 f0             	mov    -0x10(%ebp),%eax
     725:	83 c0 08             	add    $0x8,%eax
     728:	83 ec 0c             	sub    $0xc,%esp
     72b:	50                   	push   %eax
     72c:	e8 c8 fe ff ff       	call   5f9 <free>
     731:	83 c4 10             	add    $0x10,%esp
  return freep;
     734:	a1 48 29 00 00       	mov    0x2948,%eax
}
     739:	c9                   	leave  
     73a:	c3                   	ret    

0000073b <malloc>:

void*
malloc(uint nbytes)
{
     73b:	55                   	push   %ebp
     73c:	89 e5                	mov    %esp,%ebp
     73e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     741:	8b 45 08             	mov    0x8(%ebp),%eax
     744:	83 c0 07             	add    $0x7,%eax
     747:	c1 e8 03             	shr    $0x3,%eax
     74a:	83 c0 01             	add    $0x1,%eax
     74d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     750:	a1 48 29 00 00       	mov    0x2948,%eax
     755:	89 45 f0             	mov    %eax,-0x10(%ebp)
     758:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     75c:	75 23                	jne    781 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     75e:	c7 45 f0 40 29 00 00 	movl   $0x2940,-0x10(%ebp)
     765:	8b 45 f0             	mov    -0x10(%ebp),%eax
     768:	a3 48 29 00 00       	mov    %eax,0x2948
     76d:	a1 48 29 00 00       	mov    0x2948,%eax
     772:	a3 40 29 00 00       	mov    %eax,0x2940
    base.s.size = 0;
     777:	c7 05 44 29 00 00 00 	movl   $0x0,0x2944
     77e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     781:	8b 45 f0             	mov    -0x10(%ebp),%eax
     784:	8b 00                	mov    (%eax),%eax
     786:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     789:	8b 45 f4             	mov    -0xc(%ebp),%eax
     78c:	8b 40 04             	mov    0x4(%eax),%eax
     78f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     792:	72 4d                	jb     7e1 <malloc+0xa6>
      if(p->s.size == nunits)
     794:	8b 45 f4             	mov    -0xc(%ebp),%eax
     797:	8b 40 04             	mov    0x4(%eax),%eax
     79a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     79d:	75 0c                	jne    7ab <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     79f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a2:	8b 10                	mov    (%eax),%edx
     7a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7a7:	89 10                	mov    %edx,(%eax)
     7a9:	eb 26                	jmp    7d1 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ae:	8b 40 04             	mov    0x4(%eax),%eax
     7b1:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7b4:	89 c2                	mov    %eax,%edx
     7b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7bf:	8b 40 04             	mov    0x4(%eax),%eax
     7c2:	c1 e0 03             	shl    $0x3,%eax
     7c5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7cb:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7ce:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d4:	a3 48 29 00 00       	mov    %eax,0x2948
      return (void*)(p + 1);
     7d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7dc:	83 c0 08             	add    $0x8,%eax
     7df:	eb 3b                	jmp    81c <malloc+0xe1>
    }
    if(p == freep)
     7e1:	a1 48 29 00 00       	mov    0x2948,%eax
     7e6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7e9:	75 1e                	jne    809 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7eb:	83 ec 0c             	sub    $0xc,%esp
     7ee:	ff 75 ec             	pushl  -0x14(%ebp)
     7f1:	e8 e5 fe ff ff       	call   6db <morecore>
     7f6:	83 c4 10             	add    $0x10,%esp
     7f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
     7fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     800:	75 07                	jne    809 <malloc+0xce>
        return 0;
     802:	b8 00 00 00 00       	mov    $0x0,%eax
     807:	eb 13                	jmp    81c <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     809:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     80f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     812:	8b 00                	mov    (%eax),%eax
     814:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     817:	e9 6d ff ff ff       	jmp    789 <malloc+0x4e>
}
     81c:	c9                   	leave  
     81d:	c3                   	ret    

0000081e <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     81e:	55                   	push   %ebp
     81f:	89 e5                	mov    %esp,%ebp
     821:	83 ec 1c             	sub    $0x1c,%esp
     824:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     827:	8b 55 10             	mov    0x10(%ebp),%edx
     82a:	8b 45 14             	mov    0x14(%ebp),%eax
     82d:	88 4d ec             	mov    %cl,-0x14(%ebp)
     830:	88 55 e8             	mov    %dl,-0x18(%ebp)
     833:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     836:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     83a:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     83d:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     841:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     844:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     848:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     84b:	8b 45 08             	mov    0x8(%ebp),%eax
     84e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     852:	66 89 10             	mov    %dx,(%eax)
     855:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     859:	88 50 02             	mov    %dl,0x2(%eax)
}
     85c:	8b 45 08             	mov    0x8(%ebp),%eax
     85f:	c9                   	leave  
     860:	c2 04 00             	ret    $0x4

00000863 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     863:	55                   	push   %ebp
     864:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     866:	8b 45 08             	mov    0x8(%ebp),%eax
     869:	2b 45 10             	sub    0x10(%ebp),%eax
     86c:	89 c2                	mov    %eax,%edx
     86e:	8b 45 08             	mov    0x8(%ebp),%eax
     871:	2b 45 10             	sub    0x10(%ebp),%eax
     874:	0f af d0             	imul   %eax,%edx
     877:	8b 45 0c             	mov    0xc(%ebp),%eax
     87a:	2b 45 14             	sub    0x14(%ebp),%eax
     87d:	89 c1                	mov    %eax,%ecx
     87f:	8b 45 0c             	mov    0xc(%ebp),%eax
     882:	2b 45 14             	sub    0x14(%ebp),%eax
     885:	0f af c1             	imul   %ecx,%eax
     888:	01 d0                	add    %edx,%eax
}
     88a:	5d                   	pop    %ebp
     88b:	c3                   	ret    

0000088c <abs_int>:

static inline int abs_int(int x)
{
     88c:	55                   	push   %ebp
     88d:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     88f:	8b 45 08             	mov    0x8(%ebp),%eax
     892:	99                   	cltd   
     893:	89 d0                	mov    %edx,%eax
     895:	33 45 08             	xor    0x8(%ebp),%eax
     898:	29 d0                	sub    %edx,%eax
}
     89a:	5d                   	pop    %ebp
     89b:	c3                   	ret    

0000089c <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     89c:	55                   	push   %ebp
     89d:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     89f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8a3:	79 07                	jns    8ac <APGetIndex+0x10>
        return X_SMALLER;
     8a5:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8aa:	eb 40                	jmp    8ec <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8ac:	8b 45 08             	mov    0x8(%ebp),%eax
     8af:	8b 00                	mov    (%eax),%eax
     8b1:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8b4:	7f 07                	jg     8bd <APGetIndex+0x21>
        return X_BIGGER;
     8b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8bb:	eb 2f                	jmp    8ec <APGetIndex+0x50>
    if (y < 0)
     8bd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8c1:	79 07                	jns    8ca <APGetIndex+0x2e>
        return Y_SMALLER;
     8c3:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8c8:	eb 22                	jmp    8ec <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8ca:	8b 45 08             	mov    0x8(%ebp),%eax
     8cd:	8b 40 04             	mov    0x4(%eax),%eax
     8d0:	3b 45 10             	cmp    0x10(%ebp),%eax
     8d3:	7f 07                	jg     8dc <APGetIndex+0x40>
        return Y_BIGGER;
     8d5:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8da:	eb 10                	jmp    8ec <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8dc:	8b 45 08             	mov    0x8(%ebp),%eax
     8df:	8b 00                	mov    (%eax),%eax
     8e1:	0f af 45 10          	imul   0x10(%ebp),%eax
     8e5:	89 c2                	mov    %eax,%edx
     8e7:	8b 45 0c             	mov    0xc(%ebp),%eax
     8ea:	01 d0                	add    %edx,%eax
}
     8ec:	5d                   	pop    %ebp
     8ed:	c3                   	ret    

000008ee <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     8ee:	55                   	push   %ebp
     8ef:	89 e5                	mov    %esp,%ebp
     8f1:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     8f4:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     8fb:	8b 45 cc             	mov    -0x34(%ebp),%eax
     8fe:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     901:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     908:	83 ec 08             	sub    $0x8,%esp
     90b:	6a 00                	push   $0x0
     90d:	ff 75 0c             	pushl  0xc(%ebp)
     910:	e8 f4 f9 ff ff       	call   309 <open>
     915:	83 c4 10             	add    $0x10,%esp
     918:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     91b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     91f:	79 2e                	jns    94f <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     921:	83 ec 04             	sub    $0x4,%esp
     924:	ff 75 0c             	pushl  0xc(%ebp)
     927:	68 47 22 00 00       	push   $0x2247
     92c:	6a 01                	push   $0x1
     92e:	e8 35 fb ff ff       	call   468 <printf>
     933:	83 c4 10             	add    $0x10,%esp
        return bmp;
     936:	8b 45 08             	mov    0x8(%ebp),%eax
     939:	8b 55 c8             	mov    -0x38(%ebp),%edx
     93c:	89 10                	mov    %edx,(%eax)
     93e:	8b 55 cc             	mov    -0x34(%ebp),%edx
     941:	89 50 04             	mov    %edx,0x4(%eax)
     944:	8b 55 d0             	mov    -0x30(%ebp),%edx
     947:	89 50 08             	mov    %edx,0x8(%eax)
     94a:	e9 d2 01 00 00       	jmp    b21 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     94f:	83 ec 04             	sub    $0x4,%esp
     952:	6a 0e                	push   $0xe
     954:	8d 45 ba             	lea    -0x46(%ebp),%eax
     957:	50                   	push   %eax
     958:	ff 75 ec             	pushl  -0x14(%ebp)
     95b:	e8 81 f9 ff ff       	call   2e1 <read>
     960:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     963:	83 ec 04             	sub    $0x4,%esp
     966:	6a 28                	push   $0x28
     968:	8d 45 92             	lea    -0x6e(%ebp),%eax
     96b:	50                   	push   %eax
     96c:	ff 75 ec             	pushl  -0x14(%ebp)
     96f:	e8 6d f9 ff ff       	call   2e1 <read>
     974:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     977:	8b 45 96             	mov    -0x6a(%ebp),%eax
     97a:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     97d:	8b 45 9a             	mov    -0x66(%ebp),%eax
     980:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     983:	8b 55 c8             	mov    -0x38(%ebp),%edx
     986:	8b 45 cc             	mov    -0x34(%ebp),%eax
     989:	0f af d0             	imul   %eax,%edx
     98c:	89 d0                	mov    %edx,%eax
     98e:	01 c0                	add    %eax,%eax
     990:	01 d0                	add    %edx,%eax
     992:	83 ec 0c             	sub    $0xc,%esp
     995:	50                   	push   %eax
     996:	e8 a0 fd ff ff       	call   73b <malloc>
     99b:	83 c4 10             	add    $0x10,%esp
     99e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9a1:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9a5:	0f b7 c0             	movzwl %ax,%eax
     9a8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9ab:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9ae:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9b1:	0f af c2             	imul   %edx,%eax
     9b4:	83 c0 1f             	add    $0x1f,%eax
     9b7:	c1 e8 05             	shr    $0x5,%eax
     9ba:	c1 e0 02             	shl    $0x2,%eax
     9bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9c0:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9c6:	0f af c2             	imul   %edx,%eax
     9c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9cf:	83 ec 0c             	sub    $0xc,%esp
     9d2:	50                   	push   %eax
     9d3:	e8 63 fd ff ff       	call   73b <malloc>
     9d8:	83 c4 10             	add    $0x10,%esp
     9db:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9de:	83 ec 04             	sub    $0x4,%esp
     9e1:	ff 75 e0             	pushl  -0x20(%ebp)
     9e4:	ff 75 dc             	pushl  -0x24(%ebp)
     9e7:	ff 75 ec             	pushl  -0x14(%ebp)
     9ea:	e8 f2 f8 ff ff       	call   2e1 <read>
     9ef:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     9f2:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9f6:	66 c1 e8 03          	shr    $0x3,%ax
     9fa:	0f b7 c0             	movzwl %ax,%eax
     9fd:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a00:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a07:	e9 e5 00 00 00       	jmp    af1 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a0c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a12:	29 c2                	sub    %eax,%edx
     a14:	89 d0                	mov    %edx,%eax
     a16:	8d 50 ff             	lea    -0x1(%eax),%edx
     a19:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a1c:	0f af c2             	imul   %edx,%eax
     a1f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a22:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a29:	e9 b1 00 00 00       	jmp    adf <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a2e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a31:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a34:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a37:	01 c8                	add    %ecx,%eax
     a39:	89 c1                	mov    %eax,%ecx
     a3b:	89 c8                	mov    %ecx,%eax
     a3d:	01 c0                	add    %eax,%eax
     a3f:	01 c8                	add    %ecx,%eax
     a41:	01 c2                	add    %eax,%edx
     a43:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a46:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a4a:	89 c1                	mov    %eax,%ecx
     a4c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a4f:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a53:	01 c1                	add    %eax,%ecx
     a55:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a58:	01 c8                	add    %ecx,%eax
     a5a:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a5d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a60:	01 c8                	add    %ecx,%eax
     a62:	0f b6 00             	movzbl (%eax),%eax
     a65:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a68:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a6b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a71:	01 c8                	add    %ecx,%eax
     a73:	89 c1                	mov    %eax,%ecx
     a75:	89 c8                	mov    %ecx,%eax
     a77:	01 c0                	add    %eax,%eax
     a79:	01 c8                	add    %ecx,%eax
     a7b:	01 c2                	add    %eax,%edx
     a7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a80:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a84:	89 c1                	mov    %eax,%ecx
     a86:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a89:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a8d:	01 c1                	add    %eax,%ecx
     a8f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a92:	01 c8                	add    %ecx,%eax
     a94:	8d 48 fe             	lea    -0x2(%eax),%ecx
     a97:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a9a:	01 c8                	add    %ecx,%eax
     a9c:	0f b6 00             	movzbl (%eax),%eax
     a9f:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     aa2:	8b 55 d0             	mov    -0x30(%ebp),%edx
     aa5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     aa8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aab:	01 c8                	add    %ecx,%eax
     aad:	89 c1                	mov    %eax,%ecx
     aaf:	89 c8                	mov    %ecx,%eax
     ab1:	01 c0                	add    %eax,%eax
     ab3:	01 c8                	add    %ecx,%eax
     ab5:	01 c2                	add    %eax,%edx
     ab7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aba:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     abe:	89 c1                	mov    %eax,%ecx
     ac0:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ac3:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ac7:	01 c1                	add    %eax,%ecx
     ac9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     acc:	01 c8                	add    %ecx,%eax
     ace:	8d 48 fd             	lea    -0x3(%eax),%ecx
     ad1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ad4:	01 c8                	add    %ecx,%eax
     ad6:	0f b6 00             	movzbl (%eax),%eax
     ad9:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     adb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     adf:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ae2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ae5:	39 c2                	cmp    %eax,%edx
     ae7:	0f 87 41 ff ff ff    	ja     a2e <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     aed:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     af1:	8b 55 cc             	mov    -0x34(%ebp),%edx
     af4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af7:	39 c2                	cmp    %eax,%edx
     af9:	0f 87 0d ff ff ff    	ja     a0c <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     aff:	83 ec 0c             	sub    $0xc,%esp
     b02:	ff 75 ec             	pushl  -0x14(%ebp)
     b05:	e8 e7 f7 ff ff       	call   2f1 <close>
     b0a:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b0d:	8b 45 08             	mov    0x8(%ebp),%eax
     b10:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b13:	89 10                	mov    %edx,(%eax)
     b15:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b18:	89 50 04             	mov    %edx,0x4(%eax)
     b1b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b1e:	89 50 08             	mov    %edx,0x8(%eax)
}
     b21:	8b 45 08             	mov    0x8(%ebp),%eax
     b24:	c9                   	leave  
     b25:	c2 04 00             	ret    $0x4

00000b28 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b28:	55                   	push   %ebp
     b29:	89 e5                	mov    %esp,%ebp
     b2b:	53                   	push   %ebx
     b2c:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b2f:	83 ec 0c             	sub    $0xc,%esp
     b32:	6a 1c                	push   $0x1c
     b34:	e8 02 fc ff ff       	call   73b <malloc>
     b39:	83 c4 10             	add    $0x10,%esp
     b3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b42:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b49:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b4c:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b4f:	6a 0c                	push   $0xc
     b51:	6a 0c                	push   $0xc
     b53:	6a 0c                	push   $0xc
     b55:	50                   	push   %eax
     b56:	e8 c3 fc ff ff       	call   81e <RGB>
     b5b:	83 c4 0c             	add    $0xc,%esp
     b5e:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b62:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b66:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b6a:	88 43 15             	mov    %al,0x15(%ebx)
     b6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b70:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b73:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b77:	66 89 48 10          	mov    %cx,0x10(%eax)
     b7b:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b7f:	88 50 12             	mov    %dl,0x12(%eax)
     b82:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b85:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b88:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     b8c:	66 89 48 08          	mov    %cx,0x8(%eax)
     b90:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     b94:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     b97:	8b 45 08             	mov    0x8(%ebp),%eax
     b9a:	89 c2                	mov    %eax,%edx
     b9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b9f:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     ba1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ba4:	89 c2                	mov    %eax,%edx
     ba6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba9:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bac:	8b 55 10             	mov    0x10(%ebp),%edx
     baf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb2:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     bb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bb8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bbb:	c9                   	leave  
     bbc:	c3                   	ret    

00000bbd <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     bbd:	55                   	push   %ebp
     bbe:	89 e5                	mov    %esp,%ebp
     bc0:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     bc3:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc6:	8b 50 08             	mov    0x8(%eax),%edx
     bc9:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bcc:	8b 40 0c             	mov    0xc(%eax),%eax
     bcf:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     bd2:	8b 45 0c             	mov    0xc(%ebp),%eax
     bd5:	8b 55 10             	mov    0x10(%ebp),%edx
     bd8:	89 50 08             	mov    %edx,0x8(%eax)
     bdb:	8b 55 14             	mov    0x14(%ebp),%edx
     bde:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     be1:	8b 45 08             	mov    0x8(%ebp),%eax
     be4:	8b 55 f8             	mov    -0x8(%ebp),%edx
     be7:	89 10                	mov    %edx,(%eax)
     be9:	8b 55 fc             	mov    -0x4(%ebp),%edx
     bec:	89 50 04             	mov    %edx,0x4(%eax)
}
     bef:	8b 45 08             	mov    0x8(%ebp),%eax
     bf2:	c9                   	leave  
     bf3:	c2 04 00             	ret    $0x4

00000bf6 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     bf6:	55                   	push   %ebp
     bf7:	89 e5                	mov    %esp,%ebp
     bf9:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     bfc:	8b 45 0c             	mov    0xc(%ebp),%eax
     bff:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c03:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c07:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c0b:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c0e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c11:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c15:	66 89 50 10          	mov    %dx,0x10(%eax)
     c19:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c1d:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c20:	8b 45 08             	mov    0x8(%ebp),%eax
     c23:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c27:	66 89 10             	mov    %dx,(%eax)
     c2a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c2e:	88 50 02             	mov    %dl,0x2(%eax)
}
     c31:	8b 45 08             	mov    0x8(%ebp),%eax
     c34:	c9                   	leave  
     c35:	c2 04 00             	ret    $0x4

00000c38 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c38:	55                   	push   %ebp
     c39:	89 e5                	mov    %esp,%ebp
     c3b:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c3e:	8b 45 08             	mov    0x8(%ebp),%eax
     c41:	8b 40 0c             	mov    0xc(%eax),%eax
     c44:	89 c2                	mov    %eax,%edx
     c46:	c1 ea 1f             	shr    $0x1f,%edx
     c49:	01 d0                	add    %edx,%eax
     c4b:	d1 f8                	sar    %eax
     c4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c50:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c53:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c57:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c5a:	8b 45 10             	mov    0x10(%ebp),%eax
     c5d:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c60:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c63:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c67:	0f 89 98 00 00 00    	jns    d05 <APDrawPoint+0xcd>
        i = 0;
     c6d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c74:	e9 8c 00 00 00       	jmp    d05 <APDrawPoint+0xcd>
    {
        j = x - off;
     c79:	8b 45 0c             	mov    0xc(%ebp),%eax
     c7c:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c7f:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     c82:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     c86:	79 69                	jns    cf1 <APDrawPoint+0xb9>
            j = 0;
     c88:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     c8f:	eb 60                	jmp    cf1 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     c91:	ff 75 fc             	pushl  -0x4(%ebp)
     c94:	ff 75 f8             	pushl  -0x8(%ebp)
     c97:	ff 75 08             	pushl  0x8(%ebp)
     c9a:	e8 fd fb ff ff       	call   89c <APGetIndex>
     c9f:	83 c4 0c             	add    $0xc,%esp
     ca2:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     ca5:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     ca9:	74 55                	je     d00 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cab:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     caf:	74 67                	je     d18 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     cb1:	ff 75 10             	pushl  0x10(%ebp)
     cb4:	ff 75 0c             	pushl  0xc(%ebp)
     cb7:	ff 75 fc             	pushl  -0x4(%ebp)
     cba:	ff 75 f8             	pushl  -0x8(%ebp)
     cbd:	e8 a1 fb ff ff       	call   863 <distance_2>
     cc2:	83 c4 10             	add    $0x10,%esp
     cc5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     cc8:	7f 23                	jg     ced <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     cca:	8b 45 08             	mov    0x8(%ebp),%eax
     ccd:	8b 48 18             	mov    0x18(%eax),%ecx
     cd0:	8b 55 ec             	mov    -0x14(%ebp),%edx
     cd3:	89 d0                	mov    %edx,%eax
     cd5:	01 c0                	add    %eax,%eax
     cd7:	01 d0                	add    %edx,%eax
     cd9:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     cdc:	8b 45 08             	mov    0x8(%ebp),%eax
     cdf:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     ce3:	66 89 0a             	mov    %cx,(%edx)
     ce6:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     cea:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     ced:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     cf1:	8b 55 0c             	mov    0xc(%ebp),%edx
     cf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf7:	01 d0                	add    %edx,%eax
     cf9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     cfc:	7d 93                	jge    c91 <APDrawPoint+0x59>
     cfe:	eb 01                	jmp    d01 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d00:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d01:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d05:	8b 55 10             	mov    0x10(%ebp),%edx
     d08:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d0b:	01 d0                	add    %edx,%eax
     d0d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d10:	0f 8d 63 ff ff ff    	jge    c79 <APDrawPoint+0x41>
     d16:	eb 01                	jmp    d19 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d18:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d19:	c9                   	leave  
     d1a:	c3                   	ret    

00000d1b <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d1b:	55                   	push   %ebp
     d1c:	89 e5                	mov    %esp,%ebp
     d1e:	53                   	push   %ebx
     d1f:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d22:	8b 45 0c             	mov    0xc(%ebp),%eax
     d25:	3b 45 14             	cmp    0x14(%ebp),%eax
     d28:	0f 85 80 00 00 00    	jne    dae <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d2e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d32:	0f 88 9d 02 00 00    	js     fd5 <APDrawLine+0x2ba>
     d38:	8b 45 08             	mov    0x8(%ebp),%eax
     d3b:	8b 00                	mov    (%eax),%eax
     d3d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d40:	0f 8e 8f 02 00 00    	jle    fd5 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d46:	8b 45 10             	mov    0x10(%ebp),%eax
     d49:	3b 45 18             	cmp    0x18(%ebp),%eax
     d4c:	7e 12                	jle    d60 <APDrawLine+0x45>
        {
            int tmp = y2;
     d4e:	8b 45 18             	mov    0x18(%ebp),%eax
     d51:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d54:	8b 45 10             	mov    0x10(%ebp),%eax
     d57:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d5a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d5d:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d60:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d64:	79 07                	jns    d6d <APDrawLine+0x52>
     d66:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d6d:	8b 45 08             	mov    0x8(%ebp),%eax
     d70:	8b 40 04             	mov    0x4(%eax),%eax
     d73:	3b 45 18             	cmp    0x18(%ebp),%eax
     d76:	7d 0c                	jge    d84 <APDrawLine+0x69>
     d78:	8b 45 08             	mov    0x8(%ebp),%eax
     d7b:	8b 40 04             	mov    0x4(%eax),%eax
     d7e:	83 e8 01             	sub    $0x1,%eax
     d81:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     d84:	8b 45 10             	mov    0x10(%ebp),%eax
     d87:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d8a:	eb 15                	jmp    da1 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     d8c:	ff 75 f4             	pushl  -0xc(%ebp)
     d8f:	ff 75 0c             	pushl  0xc(%ebp)
     d92:	ff 75 08             	pushl  0x8(%ebp)
     d95:	e8 9e fe ff ff       	call   c38 <APDrawPoint>
     d9a:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     d9d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     da1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da4:	3b 45 18             	cmp    0x18(%ebp),%eax
     da7:	7e e3                	jle    d8c <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     da9:	e9 2b 02 00 00       	jmp    fd9 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     dae:	8b 45 10             	mov    0x10(%ebp),%eax
     db1:	3b 45 18             	cmp    0x18(%ebp),%eax
     db4:	75 7f                	jne    e35 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     db6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dba:	0f 88 18 02 00 00    	js     fd8 <APDrawLine+0x2bd>
     dc0:	8b 45 08             	mov    0x8(%ebp),%eax
     dc3:	8b 40 04             	mov    0x4(%eax),%eax
     dc6:	3b 45 10             	cmp    0x10(%ebp),%eax
     dc9:	0f 8e 09 02 00 00    	jle    fd8 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     dcf:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd2:	3b 45 14             	cmp    0x14(%ebp),%eax
     dd5:	7e 12                	jle    de9 <APDrawLine+0xce>
        {
            int tmp = x2;
     dd7:	8b 45 14             	mov    0x14(%ebp),%eax
     dda:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     ddd:	8b 45 0c             	mov    0xc(%ebp),%eax
     de0:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     de3:	8b 45 d8             	mov    -0x28(%ebp),%eax
     de6:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     de9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ded:	79 07                	jns    df6 <APDrawLine+0xdb>
     def:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     df6:	8b 45 08             	mov    0x8(%ebp),%eax
     df9:	8b 00                	mov    (%eax),%eax
     dfb:	3b 45 14             	cmp    0x14(%ebp),%eax
     dfe:	7d 0b                	jge    e0b <APDrawLine+0xf0>
     e00:	8b 45 08             	mov    0x8(%ebp),%eax
     e03:	8b 00                	mov    (%eax),%eax
     e05:	83 e8 01             	sub    $0x1,%eax
     e08:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e0b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e11:	eb 15                	jmp    e28 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e13:	ff 75 10             	pushl  0x10(%ebp)
     e16:	ff 75 f0             	pushl  -0x10(%ebp)
     e19:	ff 75 08             	pushl  0x8(%ebp)
     e1c:	e8 17 fe ff ff       	call   c38 <APDrawPoint>
     e21:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e24:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e28:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e2b:	3b 45 14             	cmp    0x14(%ebp),%eax
     e2e:	7e e3                	jle    e13 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e30:	e9 a4 01 00 00       	jmp    fd9 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e35:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e3c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e43:	8b 45 0c             	mov    0xc(%ebp),%eax
     e46:	2b 45 14             	sub    0x14(%ebp),%eax
     e49:	50                   	push   %eax
     e4a:	e8 3d fa ff ff       	call   88c <abs_int>
     e4f:	83 c4 04             	add    $0x4,%esp
     e52:	89 c3                	mov    %eax,%ebx
     e54:	8b 45 10             	mov    0x10(%ebp),%eax
     e57:	2b 45 18             	sub    0x18(%ebp),%eax
     e5a:	50                   	push   %eax
     e5b:	e8 2c fa ff ff       	call   88c <abs_int>
     e60:	83 c4 04             	add    $0x4,%esp
     e63:	39 c3                	cmp    %eax,%ebx
     e65:	0f 8e b5 00 00 00    	jle    f20 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e6b:	8b 45 10             	mov    0x10(%ebp),%eax
     e6e:	2b 45 18             	sub    0x18(%ebp),%eax
     e71:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e74:	db 45 b0             	fildl  -0x50(%ebp)
     e77:	8b 45 0c             	mov    0xc(%ebp),%eax
     e7a:	2b 45 14             	sub    0x14(%ebp),%eax
     e7d:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e80:	db 45 b0             	fildl  -0x50(%ebp)
     e83:	de f9                	fdivrp %st,%st(1)
     e85:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     e88:	8b 45 14             	mov    0x14(%ebp),%eax
     e8b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e8e:	7e 0e                	jle    e9e <APDrawLine+0x183>
        {
            s = x1;
     e90:	8b 45 0c             	mov    0xc(%ebp),%eax
     e93:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     e96:	8b 45 14             	mov    0x14(%ebp),%eax
     e99:	89 45 e8             	mov    %eax,-0x18(%ebp)
     e9c:	eb 0c                	jmp    eaa <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     e9e:	8b 45 14             	mov    0x14(%ebp),%eax
     ea1:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     ea4:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea7:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     eaa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     eae:	79 07                	jns    eb7 <APDrawLine+0x19c>
     eb0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     eb7:	8b 45 08             	mov    0x8(%ebp),%eax
     eba:	8b 00                	mov    (%eax),%eax
     ebc:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ebf:	7f 0b                	jg     ecc <APDrawLine+0x1b1>
     ec1:	8b 45 08             	mov    0x8(%ebp),%eax
     ec4:	8b 00                	mov    (%eax),%eax
     ec6:	83 e8 01             	sub    $0x1,%eax
     ec9:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     ecc:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ecf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     ed2:	eb 3f                	jmp    f13 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     ed4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ed7:	2b 45 0c             	sub    0xc(%ebp),%eax
     eda:	89 45 b0             	mov    %eax,-0x50(%ebp)
     edd:	db 45 b0             	fildl  -0x50(%ebp)
     ee0:	dc 4d d0             	fmull  -0x30(%ebp)
     ee3:	db 45 10             	fildl  0x10(%ebp)
     ee6:	de c1                	faddp  %st,%st(1)
     ee8:	d9 7d b6             	fnstcw -0x4a(%ebp)
     eeb:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     eef:	b4 0c                	mov    $0xc,%ah
     ef1:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     ef5:	d9 6d b4             	fldcw  -0x4c(%ebp)
     ef8:	db 5d cc             	fistpl -0x34(%ebp)
     efb:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     efe:	ff 75 cc             	pushl  -0x34(%ebp)
     f01:	ff 75 e4             	pushl  -0x1c(%ebp)
     f04:	ff 75 08             	pushl  0x8(%ebp)
     f07:	e8 2c fd ff ff       	call   c38 <APDrawPoint>
     f0c:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f0f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f16:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f19:	7e b9                	jle    ed4 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f1b:	e9 b9 00 00 00       	jmp    fd9 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f20:	8b 45 0c             	mov    0xc(%ebp),%eax
     f23:	2b 45 14             	sub    0x14(%ebp),%eax
     f26:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f29:	db 45 b0             	fildl  -0x50(%ebp)
     f2c:	8b 45 10             	mov    0x10(%ebp),%eax
     f2f:	2b 45 18             	sub    0x18(%ebp),%eax
     f32:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f35:	db 45 b0             	fildl  -0x50(%ebp)
     f38:	de f9                	fdivrp %st,%st(1)
     f3a:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f3d:	8b 45 10             	mov    0x10(%ebp),%eax
     f40:	3b 45 18             	cmp    0x18(%ebp),%eax
     f43:	7e 0e                	jle    f53 <APDrawLine+0x238>
    {
        s = y2;
     f45:	8b 45 18             	mov    0x18(%ebp),%eax
     f48:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f4b:	8b 45 10             	mov    0x10(%ebp),%eax
     f4e:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f51:	eb 0c                	jmp    f5f <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f53:	8b 45 10             	mov    0x10(%ebp),%eax
     f56:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f59:	8b 45 18             	mov    0x18(%ebp),%eax
     f5c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f5f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f63:	79 07                	jns    f6c <APDrawLine+0x251>
     f65:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f6c:	8b 45 08             	mov    0x8(%ebp),%eax
     f6f:	8b 40 04             	mov    0x4(%eax),%eax
     f72:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f75:	7f 0c                	jg     f83 <APDrawLine+0x268>
     f77:	8b 45 08             	mov    0x8(%ebp),%eax
     f7a:	8b 40 04             	mov    0x4(%eax),%eax
     f7d:	83 e8 01             	sub    $0x1,%eax
     f80:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     f83:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f86:	89 45 e0             	mov    %eax,-0x20(%ebp)
     f89:	eb 3f                	jmp    fca <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     f8b:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f8e:	2b 45 10             	sub    0x10(%ebp),%eax
     f91:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f94:	db 45 b0             	fildl  -0x50(%ebp)
     f97:	dc 4d c0             	fmull  -0x40(%ebp)
     f9a:	db 45 0c             	fildl  0xc(%ebp)
     f9d:	de c1                	faddp  %st,%st(1)
     f9f:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fa2:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fa6:	b4 0c                	mov    $0xc,%ah
     fa8:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fac:	d9 6d b4             	fldcw  -0x4c(%ebp)
     faf:	db 5d bc             	fistpl -0x44(%ebp)
     fb2:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     fb5:	ff 75 e0             	pushl  -0x20(%ebp)
     fb8:	ff 75 bc             	pushl  -0x44(%ebp)
     fbb:	ff 75 08             	pushl  0x8(%ebp)
     fbe:	e8 75 fc ff ff       	call   c38 <APDrawPoint>
     fc3:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     fc6:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     fca:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fcd:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fd0:	7e b9                	jle    f8b <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     fd2:	90                   	nop
     fd3:	eb 04                	jmp    fd9 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     fd5:	90                   	nop
     fd6:	eb 01                	jmp    fd9 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     fd8:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     fd9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fdc:	c9                   	leave  
     fdd:	c3                   	ret    

00000fde <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     fde:	55                   	push   %ebp
     fdf:	89 e5                	mov    %esp,%ebp
     fe1:	53                   	push   %ebx
     fe2:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
     fe5:	8b 55 10             	mov    0x10(%ebp),%edx
     fe8:	8b 45 18             	mov    0x18(%ebp),%eax
     feb:	01 d0                	add    %edx,%eax
     fed:	83 e8 01             	sub    $0x1,%eax
     ff0:	83 ec 04             	sub    $0x4,%esp
     ff3:	50                   	push   %eax
     ff4:	ff 75 0c             	pushl  0xc(%ebp)
     ff7:	ff 75 10             	pushl  0x10(%ebp)
     ffa:	ff 75 0c             	pushl  0xc(%ebp)
     ffd:	ff 75 08             	pushl  0x8(%ebp)
    1000:	e8 16 fd ff ff       	call   d1b <APDrawLine>
    1005:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1008:	8b 55 0c             	mov    0xc(%ebp),%edx
    100b:	8b 45 14             	mov    0x14(%ebp),%eax
    100e:	01 d0                	add    %edx,%eax
    1010:	83 e8 01             	sub    $0x1,%eax
    1013:	83 ec 04             	sub    $0x4,%esp
    1016:	ff 75 10             	pushl  0x10(%ebp)
    1019:	50                   	push   %eax
    101a:	ff 75 10             	pushl  0x10(%ebp)
    101d:	ff 75 0c             	pushl  0xc(%ebp)
    1020:	ff 75 08             	pushl  0x8(%ebp)
    1023:	e8 f3 fc ff ff       	call   d1b <APDrawLine>
    1028:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    102b:	8b 55 10             	mov    0x10(%ebp),%edx
    102e:	8b 45 18             	mov    0x18(%ebp),%eax
    1031:	01 d0                	add    %edx,%eax
    1033:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1036:	8b 55 0c             	mov    0xc(%ebp),%edx
    1039:	8b 45 14             	mov    0x14(%ebp),%eax
    103c:	01 d0                	add    %edx,%eax
    103e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1041:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1044:	8b 45 14             	mov    0x14(%ebp),%eax
    1047:	01 d8                	add    %ebx,%eax
    1049:	83 e8 01             	sub    $0x1,%eax
    104c:	83 ec 04             	sub    $0x4,%esp
    104f:	51                   	push   %ecx
    1050:	52                   	push   %edx
    1051:	ff 75 10             	pushl  0x10(%ebp)
    1054:	50                   	push   %eax
    1055:	ff 75 08             	pushl  0x8(%ebp)
    1058:	e8 be fc ff ff       	call   d1b <APDrawLine>
    105d:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1060:	8b 55 10             	mov    0x10(%ebp),%edx
    1063:	8b 45 18             	mov    0x18(%ebp),%eax
    1066:	01 d0                	add    %edx,%eax
    1068:	8d 48 ff             	lea    -0x1(%eax),%ecx
    106b:	8b 55 0c             	mov    0xc(%ebp),%edx
    106e:	8b 45 14             	mov    0x14(%ebp),%eax
    1071:	01 d0                	add    %edx,%eax
    1073:	8d 50 ff             	lea    -0x1(%eax),%edx
    1076:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1079:	8b 45 18             	mov    0x18(%ebp),%eax
    107c:	01 d8                	add    %ebx,%eax
    107e:	83 e8 01             	sub    $0x1,%eax
    1081:	83 ec 04             	sub    $0x4,%esp
    1084:	51                   	push   %ecx
    1085:	52                   	push   %edx
    1086:	50                   	push   %eax
    1087:	ff 75 0c             	pushl  0xc(%ebp)
    108a:	ff 75 08             	pushl  0x8(%ebp)
    108d:	e8 89 fc ff ff       	call   d1b <APDrawLine>
    1092:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1095:	8b 55 0c             	mov    0xc(%ebp),%edx
    1098:	8b 45 14             	mov    0x14(%ebp),%eax
    109b:	01 d0                	add    %edx,%eax
    109d:	8d 50 ff             	lea    -0x1(%eax),%edx
    10a0:	8b 45 08             	mov    0x8(%ebp),%eax
    10a3:	8b 40 0c             	mov    0xc(%eax),%eax
    10a6:	89 c1                	mov    %eax,%ecx
    10a8:	c1 e9 1f             	shr    $0x1f,%ecx
    10ab:	01 c8                	add    %ecx,%eax
    10ad:	d1 f8                	sar    %eax
    10af:	29 c2                	sub    %eax,%edx
    10b1:	89 d0                	mov    %edx,%eax
    10b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10b6:	8b 55 10             	mov    0x10(%ebp),%edx
    10b9:	8b 45 18             	mov    0x18(%ebp),%eax
    10bc:	01 d0                	add    %edx,%eax
    10be:	8d 50 ff             	lea    -0x1(%eax),%edx
    10c1:	8b 45 08             	mov    0x8(%ebp),%eax
    10c4:	8b 40 0c             	mov    0xc(%eax),%eax
    10c7:	89 c1                	mov    %eax,%ecx
    10c9:	c1 e9 1f             	shr    $0x1f,%ecx
    10cc:	01 c8                	add    %ecx,%eax
    10ce:	d1 f8                	sar    %eax
    10d0:	29 c2                	sub    %eax,%edx
    10d2:	89 d0                	mov    %edx,%eax
    10d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    10d7:	8b 45 08             	mov    0x8(%ebp),%eax
    10da:	8b 40 0c             	mov    0xc(%eax),%eax
    10dd:	89 c2                	mov    %eax,%edx
    10df:	c1 ea 1f             	shr    $0x1f,%edx
    10e2:	01 d0                	add    %edx,%eax
    10e4:	d1 f8                	sar    %eax
    10e6:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    10e9:	8b 45 08             	mov    0x8(%ebp),%eax
    10ec:	8b 40 0c             	mov    0xc(%eax),%eax
    10ef:	89 c2                	mov    %eax,%edx
    10f1:	c1 ea 1f             	shr    $0x1f,%edx
    10f4:	01 d0                	add    %edx,%eax
    10f6:	d1 f8                	sar    %eax
    10f8:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    10fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10ff:	0f 88 d8 00 00 00    	js     11dd <APDrawRect+0x1ff>
    1105:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1109:	0f 88 ce 00 00 00    	js     11dd <APDrawRect+0x1ff>
    110f:	8b 45 08             	mov    0x8(%ebp),%eax
    1112:	8b 00                	mov    (%eax),%eax
    1114:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1117:	0f 8e c0 00 00 00    	jle    11dd <APDrawRect+0x1ff>
    111d:	8b 45 08             	mov    0x8(%ebp),%eax
    1120:	8b 40 04             	mov    0x4(%eax),%eax
    1123:	3b 45 10             	cmp    0x10(%ebp),%eax
    1126:	0f 8e b1 00 00 00    	jle    11dd <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    112c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1130:	79 07                	jns    1139 <APDrawRect+0x15b>
    1132:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1139:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    113d:	79 07                	jns    1146 <APDrawRect+0x168>
    113f:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1146:	8b 45 08             	mov    0x8(%ebp),%eax
    1149:	8b 00                	mov    (%eax),%eax
    114b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    114e:	7f 0b                	jg     115b <APDrawRect+0x17d>
    1150:	8b 45 08             	mov    0x8(%ebp),%eax
    1153:	8b 00                	mov    (%eax),%eax
    1155:	83 e8 01             	sub    $0x1,%eax
    1158:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    115b:	8b 45 08             	mov    0x8(%ebp),%eax
    115e:	8b 40 04             	mov    0x4(%eax),%eax
    1161:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1164:	7f 0c                	jg     1172 <APDrawRect+0x194>
    1166:	8b 45 08             	mov    0x8(%ebp),%eax
    1169:	8b 40 04             	mov    0x4(%eax),%eax
    116c:	83 e8 01             	sub    $0x1,%eax
    116f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1172:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1179:	8b 45 0c             	mov    0xc(%ebp),%eax
    117c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    117f:	eb 52                	jmp    11d3 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1181:	8b 45 10             	mov    0x10(%ebp),%eax
    1184:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1187:	eb 3e                	jmp    11c7 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1189:	83 ec 04             	sub    $0x4,%esp
    118c:	ff 75 e8             	pushl  -0x18(%ebp)
    118f:	ff 75 ec             	pushl  -0x14(%ebp)
    1192:	ff 75 08             	pushl  0x8(%ebp)
    1195:	e8 02 f7 ff ff       	call   89c <APGetIndex>
    119a:	83 c4 10             	add    $0x10,%esp
    119d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11a0:	8b 45 08             	mov    0x8(%ebp),%eax
    11a3:	8b 48 18             	mov    0x18(%eax),%ecx
    11a6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11a9:	89 d0                	mov    %edx,%eax
    11ab:	01 c0                	add    %eax,%eax
    11ad:	01 d0                	add    %edx,%eax
    11af:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11b2:	8b 45 08             	mov    0x8(%ebp),%eax
    11b5:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11b9:	66 89 0a             	mov    %cx,(%edx)
    11bc:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    11c0:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    11c3:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11c7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11ca:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11cd:	7e ba                	jle    1189 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11cf:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    11d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11d6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11d9:	7e a6                	jle    1181 <APDrawRect+0x1a3>
    11db:	eb 01                	jmp    11de <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    11dd:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    11de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11e1:	c9                   	leave  
    11e2:	c3                   	ret    

000011e3 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    11e3:	55                   	push   %ebp
    11e4:	89 e5                	mov    %esp,%ebp
}
    11e6:	90                   	nop
    11e7:	5d                   	pop    %ebp
    11e8:	c3                   	ret    

000011e9 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    11e9:	55                   	push   %ebp
    11ea:	89 e5                	mov    %esp,%ebp
    11ec:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    11ef:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    11f3:	0f 88 8e 01 00 00    	js     1387 <APDcCopy+0x19e>
    11f9:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    11fd:	0f 88 84 01 00 00    	js     1387 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1203:	8b 55 0c             	mov    0xc(%ebp),%edx
    1206:	8b 45 20             	mov    0x20(%ebp),%eax
    1209:	01 d0                	add    %edx,%eax
    120b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    120e:	8b 55 10             	mov    0x10(%ebp),%edx
    1211:	8b 45 24             	mov    0x24(%ebp),%eax
    1214:	01 d0                	add    %edx,%eax
    1216:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1219:	8b 55 18             	mov    0x18(%ebp),%edx
    121c:	8b 45 20             	mov    0x20(%ebp),%eax
    121f:	01 d0                	add    %edx,%eax
    1221:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1224:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1227:	8b 45 24             	mov    0x24(%ebp),%eax
    122a:	01 d0                	add    %edx,%eax
    122c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    122f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1233:	0f 88 51 01 00 00    	js     138a <APDcCopy+0x1a1>
    1239:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    123d:	0f 88 47 01 00 00    	js     138a <APDcCopy+0x1a1>
    1243:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1247:	0f 88 3d 01 00 00    	js     138a <APDcCopy+0x1a1>
    124d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1251:	0f 88 33 01 00 00    	js     138a <APDcCopy+0x1a1>
    1257:	8b 45 14             	mov    0x14(%ebp),%eax
    125a:	8b 00                	mov    (%eax),%eax
    125c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    125f:	0f 8c 25 01 00 00    	jl     138a <APDcCopy+0x1a1>
    1265:	8b 45 14             	mov    0x14(%ebp),%eax
    1268:	8b 40 04             	mov    0x4(%eax),%eax
    126b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    126e:	0f 8c 16 01 00 00    	jl     138a <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1274:	8b 45 08             	mov    0x8(%ebp),%eax
    1277:	8b 00                	mov    (%eax),%eax
    1279:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    127c:	7f 0b                	jg     1289 <APDcCopy+0xa0>
    127e:	8b 45 08             	mov    0x8(%ebp),%eax
    1281:	8b 00                	mov    (%eax),%eax
    1283:	83 e8 01             	sub    $0x1,%eax
    1286:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1289:	8b 45 08             	mov    0x8(%ebp),%eax
    128c:	8b 40 04             	mov    0x4(%eax),%eax
    128f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1292:	7f 0c                	jg     12a0 <APDcCopy+0xb7>
    1294:	8b 45 08             	mov    0x8(%ebp),%eax
    1297:	8b 40 04             	mov    0x4(%eax),%eax
    129a:	83 e8 01             	sub    $0x1,%eax
    129d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    12a0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12a7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    12ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12b5:	e9 bc 00 00 00       	jmp    1376 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12ba:	8b 45 08             	mov    0x8(%ebp),%eax
    12bd:	8b 00                	mov    (%eax),%eax
    12bf:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12c2:	8b 55 10             	mov    0x10(%ebp),%edx
    12c5:	01 ca                	add    %ecx,%edx
    12c7:	0f af d0             	imul   %eax,%edx
    12ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    12cd:	01 d0                	add    %edx,%eax
    12cf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    12d2:	8b 45 14             	mov    0x14(%ebp),%eax
    12d5:	8b 00                	mov    (%eax),%eax
    12d7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12da:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12dd:	01 ca                	add    %ecx,%edx
    12df:	0f af d0             	imul   %eax,%edx
    12e2:	8b 45 18             	mov    0x18(%ebp),%eax
    12e5:	01 d0                	add    %edx,%eax
    12e7:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    12ea:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12f1:	eb 74                	jmp    1367 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    12f3:	8b 45 14             	mov    0x14(%ebp),%eax
    12f6:	8b 50 18             	mov    0x18(%eax),%edx
    12f9:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12ff:	01 c8                	add    %ecx,%eax
    1301:	89 c1                	mov    %eax,%ecx
    1303:	89 c8                	mov    %ecx,%eax
    1305:	01 c0                	add    %eax,%eax
    1307:	01 c8                	add    %ecx,%eax
    1309:	01 d0                	add    %edx,%eax
    130b:	0f b7 10             	movzwl (%eax),%edx
    130e:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1312:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1316:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1319:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    131d:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1321:	38 c2                	cmp    %al,%dl
    1323:	75 18                	jne    133d <APDcCopy+0x154>
    1325:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1329:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    132d:	38 c2                	cmp    %al,%dl
    132f:	75 0c                	jne    133d <APDcCopy+0x154>
    1331:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1335:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1339:	38 c2                	cmp    %al,%dl
    133b:	74 26                	je     1363 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    133d:	8b 45 08             	mov    0x8(%ebp),%eax
    1340:	8b 50 18             	mov    0x18(%eax),%edx
    1343:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1346:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1349:	01 c8                	add    %ecx,%eax
    134b:	89 c1                	mov    %eax,%ecx
    134d:	89 c8                	mov    %ecx,%eax
    134f:	01 c0                	add    %eax,%eax
    1351:	01 c8                	add    %ecx,%eax
    1353:	01 d0                	add    %edx,%eax
    1355:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1359:	66 89 10             	mov    %dx,(%eax)
    135c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1360:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1363:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1367:	8b 45 fc             	mov    -0x4(%ebp),%eax
    136a:	2b 45 0c             	sub    0xc(%ebp),%eax
    136d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1370:	7d 81                	jge    12f3 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1372:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1376:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1379:	2b 45 10             	sub    0x10(%ebp),%eax
    137c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    137f:	0f 8d 35 ff ff ff    	jge    12ba <APDcCopy+0xd1>
    1385:	eb 04                	jmp    138b <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1387:	90                   	nop
    1388:	eb 01                	jmp    138b <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    138a:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    138b:	c9                   	leave  
    138c:	c3                   	ret    

0000138d <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    138d:	55                   	push   %ebp
    138e:	89 e5                	mov    %esp,%ebp
    1390:	83 ec 1c             	sub    $0x1c,%esp
    1393:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1396:	8b 55 10             	mov    0x10(%ebp),%edx
    1399:	8b 45 14             	mov    0x14(%ebp),%eax
    139c:	88 4d ec             	mov    %cl,-0x14(%ebp)
    139f:	88 55 e8             	mov    %dl,-0x18(%ebp)
    13a2:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    13a5:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13a9:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13ac:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13b0:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13b3:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13b7:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13ba:	8b 45 08             	mov    0x8(%ebp),%eax
    13bd:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13c1:	66 89 10             	mov    %dx,(%eax)
    13c4:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13c8:	88 50 02             	mov    %dl,0x2(%eax)
}
    13cb:	8b 45 08             	mov    0x8(%ebp),%eax
    13ce:	c9                   	leave  
    13cf:	c2 04 00             	ret    $0x4

000013d2 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    13d2:	55                   	push   %ebp
    13d3:	89 e5                	mov    %esp,%ebp
    13d5:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13d8:	8b 45 08             	mov    0x8(%ebp),%eax
    13db:	8b 00                	mov    (%eax),%eax
    13dd:	83 ec 08             	sub    $0x8,%esp
    13e0:	8d 55 0c             	lea    0xc(%ebp),%edx
    13e3:	52                   	push   %edx
    13e4:	50                   	push   %eax
    13e5:	e8 87 ef ff ff       	call   371 <sendMessage>
    13ea:	83 c4 10             	add    $0x10,%esp
}
    13ed:	90                   	nop
    13ee:	c9                   	leave  
    13ef:	c3                   	ret    

000013f0 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    13f0:	55                   	push   %ebp
    13f1:	89 e5                	mov    %esp,%ebp
    13f3:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    13f6:	83 ec 0c             	sub    $0xc,%esp
    13f9:	68 98 00 00 00       	push   $0x98
    13fe:	e8 38 f3 ff ff       	call   73b <malloc>
    1403:	83 c4 10             	add    $0x10,%esp
    1406:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1409:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    140d:	75 15                	jne    1424 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    140f:	83 ec 04             	sub    $0x4,%esp
    1412:	ff 75 08             	pushl  0x8(%ebp)
    1415:	68 58 22 00 00       	push   $0x2258
    141a:	6a 01                	push   $0x1
    141c:	e8 47 f0 ff ff       	call   468 <printf>
    1421:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1424:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1427:	05 84 00 00 00       	add    $0x84,%eax
    142c:	83 ec 08             	sub    $0x8,%esp
    142f:	ff 75 08             	pushl  0x8(%ebp)
    1432:	50                   	push   %eax
    1433:	e8 60 ec ff ff       	call   98 <strcpy>
    1438:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    143b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    143e:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1445:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1448:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    144f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1452:	8b 40 3c             	mov    0x3c(%eax),%eax
    1455:	89 c2                	mov    %eax,%edx
    1457:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145a:	8b 40 40             	mov    0x40(%eax),%eax
    145d:	0f af d0             	imul   %eax,%edx
    1460:	89 d0                	mov    %edx,%eax
    1462:	01 c0                	add    %eax,%eax
    1464:	01 d0                	add    %edx,%eax
    1466:	83 ec 0c             	sub    $0xc,%esp
    1469:	50                   	push   %eax
    146a:	e8 cc f2 ff ff       	call   73b <malloc>
    146f:	83 c4 10             	add    $0x10,%esp
    1472:	89 c2                	mov    %eax,%edx
    1474:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1477:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    147a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    147d:	8b 40 54             	mov    0x54(%eax),%eax
    1480:	85 c0                	test   %eax,%eax
    1482:	75 15                	jne    1499 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1484:	83 ec 04             	sub    $0x4,%esp
    1487:	ff 75 08             	pushl  0x8(%ebp)
    148a:	68 78 22 00 00       	push   $0x2278
    148f:	6a 01                	push   $0x1
    1491:	e8 d2 ef ff ff       	call   468 <printf>
    1496:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1499:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149c:	8b 40 3c             	mov    0x3c(%eax),%eax
    149f:	89 c2                	mov    %eax,%edx
    14a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a4:	8b 40 40             	mov    0x40(%eax),%eax
    14a7:	0f af d0             	imul   %eax,%edx
    14aa:	89 d0                	mov    %edx,%eax
    14ac:	01 c0                	add    %eax,%eax
    14ae:	01 c2                	add    %eax,%edx
    14b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b3:	8b 40 54             	mov    0x54(%eax),%eax
    14b6:	83 ec 04             	sub    $0x4,%esp
    14b9:	52                   	push   %edx
    14ba:	68 ff ff ff 00       	push   $0xffffff
    14bf:	50                   	push   %eax
    14c0:	e8 69 ec ff ff       	call   12e <memset>
    14c5:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cb:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    14d2:	e8 72 ee ff ff       	call   349 <getpid>
    14d7:	89 c2                	mov    %eax,%edx
    14d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14dc:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e2:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ec:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    14f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f6:	8b 40 58             	mov    0x58(%eax),%eax
    14f9:	89 c2                	mov    %eax,%edx
    14fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14fe:	8b 40 5c             	mov    0x5c(%eax),%eax
    1501:	0f af d0             	imul   %eax,%edx
    1504:	89 d0                	mov    %edx,%eax
    1506:	01 c0                	add    %eax,%eax
    1508:	01 d0                	add    %edx,%eax
    150a:	83 ec 0c             	sub    $0xc,%esp
    150d:	50                   	push   %eax
    150e:	e8 28 f2 ff ff       	call   73b <malloc>
    1513:	83 c4 10             	add    $0x10,%esp
    1516:	89 c2                	mov    %eax,%edx
    1518:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151b:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    151e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1521:	8b 40 70             	mov    0x70(%eax),%eax
    1524:	85 c0                	test   %eax,%eax
    1526:	75 15                	jne    153d <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1528:	83 ec 04             	sub    $0x4,%esp
    152b:	ff 75 08             	pushl  0x8(%ebp)
    152e:	68 9c 22 00 00       	push   $0x229c
    1533:	6a 01                	push   $0x1
    1535:	e8 2e ef ff ff       	call   468 <printf>
    153a:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    153d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1540:	8b 40 3c             	mov    0x3c(%eax),%eax
    1543:	89 c2                	mov    %eax,%edx
    1545:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1548:	8b 40 40             	mov    0x40(%eax),%eax
    154b:	0f af d0             	imul   %eax,%edx
    154e:	89 d0                	mov    %edx,%eax
    1550:	01 c0                	add    %eax,%eax
    1552:	01 c2                	add    %eax,%edx
    1554:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1557:	8b 40 54             	mov    0x54(%eax),%eax
    155a:	83 ec 04             	sub    $0x4,%esp
    155d:	52                   	push   %edx
    155e:	68 ff 00 00 00       	push   $0xff
    1563:	50                   	push   %eax
    1564:	e8 c5 eb ff ff       	call   12e <memset>
    1569:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    156c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1572:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1575:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1579:	74 49                	je     15c4 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    157b:	8b 45 10             	mov    0x10(%ebp),%eax
    157e:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1584:	83 ec 0c             	sub    $0xc,%esp
    1587:	50                   	push   %eax
    1588:	e8 ae f1 ff ff       	call   73b <malloc>
    158d:	83 c4 10             	add    $0x10,%esp
    1590:	89 c2                	mov    %eax,%edx
    1592:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1595:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1598:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159b:	8b 55 10             	mov    0x10(%ebp),%edx
    159e:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    15a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a4:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    15ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ae:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    15b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b8:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    15bf:	e9 8d 00 00 00       	jmp    1651 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c7:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d1:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15db:	8b 40 20             	mov    0x20(%eax),%eax
    15de:	89 c2                	mov    %eax,%edx
    15e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e3:	8b 40 24             	mov    0x24(%eax),%eax
    15e6:	0f af d0             	imul   %eax,%edx
    15e9:	89 d0                	mov    %edx,%eax
    15eb:	01 c0                	add    %eax,%eax
    15ed:	01 d0                	add    %edx,%eax
    15ef:	83 ec 0c             	sub    $0xc,%esp
    15f2:	50                   	push   %eax
    15f3:	e8 43 f1 ff ff       	call   73b <malloc>
    15f8:	83 c4 10             	add    $0x10,%esp
    15fb:	89 c2                	mov    %eax,%edx
    15fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1600:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1603:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1606:	8b 40 38             	mov    0x38(%eax),%eax
    1609:	85 c0                	test   %eax,%eax
    160b:	75 15                	jne    1622 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    160d:	83 ec 04             	sub    $0x4,%esp
    1610:	ff 75 08             	pushl  0x8(%ebp)
    1613:	68 c4 22 00 00       	push   $0x22c4
    1618:	6a 01                	push   $0x1
    161a:	e8 49 ee ff ff       	call   468 <printf>
    161f:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1622:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1625:	8b 40 20             	mov    0x20(%eax),%eax
    1628:	89 c2                	mov    %eax,%edx
    162a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162d:	8b 40 24             	mov    0x24(%eax),%eax
    1630:	0f af d0             	imul   %eax,%edx
    1633:	89 d0                	mov    %edx,%eax
    1635:	01 c0                	add    %eax,%eax
    1637:	01 c2                	add    %eax,%edx
    1639:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163c:	8b 40 38             	mov    0x38(%eax),%eax
    163f:	83 ec 04             	sub    $0x4,%esp
    1642:	52                   	push   %edx
    1643:	68 ff ff ff 00       	push   $0xffffff
    1648:	50                   	push   %eax
    1649:	e8 e0 ea ff ff       	call   12e <memset>
    164e:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1651:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1654:	c9                   	leave  
    1655:	c3                   	ret    

00001656 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1656:	55                   	push   %ebp
    1657:	89 e5                	mov    %esp,%ebp
    1659:	57                   	push   %edi
    165a:	56                   	push   %esi
    165b:	53                   	push   %ebx
    165c:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    165f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1662:	83 f8 03             	cmp    $0x3,%eax
    1665:	74 02                	je     1669 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1667:	eb 7c                	jmp    16e5 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1669:	8b 45 08             	mov    0x8(%ebp),%eax
    166c:	8b 58 1c             	mov    0x1c(%eax),%ebx
    166f:	8b 45 08             	mov    0x8(%ebp),%eax
    1672:	8b 48 18             	mov    0x18(%eax),%ecx
    1675:	8b 45 08             	mov    0x8(%ebp),%eax
    1678:	8b 50 5c             	mov    0x5c(%eax),%edx
    167b:	8b 45 08             	mov    0x8(%ebp),%eax
    167e:	8b 40 58             	mov    0x58(%eax),%eax
    1681:	8b 75 08             	mov    0x8(%ebp),%esi
    1684:	83 c6 58             	add    $0x58,%esi
    1687:	83 ec 04             	sub    $0x4,%esp
    168a:	53                   	push   %ebx
    168b:	51                   	push   %ecx
    168c:	6a 00                	push   $0x0
    168e:	52                   	push   %edx
    168f:	50                   	push   %eax
    1690:	6a 00                	push   $0x0
    1692:	6a 00                	push   $0x0
    1694:	56                   	push   %esi
    1695:	6a 00                	push   $0x0
    1697:	6a 00                	push   $0x0
    1699:	ff 75 08             	pushl  0x8(%ebp)
    169c:	e8 c8 ec ff ff       	call   369 <paintWindow>
    16a1:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    16a4:	8b 45 08             	mov    0x8(%ebp),%eax
    16a7:	8b 70 1c             	mov    0x1c(%eax),%esi
    16aa:	8b 45 08             	mov    0x8(%ebp),%eax
    16ad:	8b 58 18             	mov    0x18(%eax),%ebx
    16b0:	8b 45 08             	mov    0x8(%ebp),%eax
    16b3:	8b 48 08             	mov    0x8(%eax),%ecx
    16b6:	8b 45 08             	mov    0x8(%ebp),%eax
    16b9:	8b 50 40             	mov    0x40(%eax),%edx
    16bc:	8b 45 08             	mov    0x8(%ebp),%eax
    16bf:	8b 40 3c             	mov    0x3c(%eax),%eax
    16c2:	8b 7d 08             	mov    0x8(%ebp),%edi
    16c5:	83 c7 3c             	add    $0x3c,%edi
    16c8:	83 ec 04             	sub    $0x4,%esp
    16cb:	56                   	push   %esi
    16cc:	53                   	push   %ebx
    16cd:	51                   	push   %ecx
    16ce:	52                   	push   %edx
    16cf:	50                   	push   %eax
    16d0:	6a 00                	push   $0x0
    16d2:	6a 00                	push   $0x0
    16d4:	57                   	push   %edi
    16d5:	6a 32                	push   $0x32
    16d7:	6a 00                	push   $0x0
    16d9:	ff 75 08             	pushl  0x8(%ebp)
    16dc:	e8 88 ec ff ff       	call   369 <paintWindow>
    16e1:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    16e4:	90                   	nop
        default: break;
            
            
    }
    return False;
    16e5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    16ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16ed:	5b                   	pop    %ebx
    16ee:	5e                   	pop    %esi
    16ef:	5f                   	pop    %edi
    16f0:	5d                   	pop    %ebp
    16f1:	c3                   	ret    

000016f2 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    16f2:	55                   	push   %ebp
    16f3:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    16f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    16f8:	8b 50 08             	mov    0x8(%eax),%edx
    16fb:	8b 45 08             	mov    0x8(%ebp),%eax
    16fe:	8b 00                	mov    (%eax),%eax
    1700:	39 c2                	cmp    %eax,%edx
    1702:	74 07                	je     170b <APPreJudge+0x19>
        return False;
    1704:	b8 00 00 00 00       	mov    $0x0,%eax
    1709:	eb 05                	jmp    1710 <APPreJudge+0x1e>
    return True;
    170b:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1710:	5d                   	pop    %ebp
    1711:	c3                   	ret    

00001712 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1712:	55                   	push   %ebp
    1713:	89 e5                	mov    %esp,%ebp
    1715:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1718:	8b 45 08             	mov    0x8(%ebp),%eax
    171b:	8b 55 0c             	mov    0xc(%ebp),%edx
    171e:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1724:	83 ec 0c             	sub    $0xc,%esp
    1727:	ff 75 08             	pushl  0x8(%ebp)
    172a:	e8 52 ec ff ff       	call   381 <registWindow>
    172f:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1732:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1739:	8b 45 08             	mov    0x8(%ebp),%eax
    173c:	8b 00                	mov    (%eax),%eax
    173e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1741:	ff 75 f4             	pushl  -0xc(%ebp)
    1744:	ff 75 f0             	pushl  -0x10(%ebp)
    1747:	ff 75 ec             	pushl  -0x14(%ebp)
    174a:	ff 75 08             	pushl  0x8(%ebp)
    174d:	e8 80 fc ff ff       	call   13d2 <APSendMessage>
    1752:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1755:	83 ec 0c             	sub    $0xc,%esp
    1758:	ff 75 08             	pushl  0x8(%ebp)
    175b:	e8 19 ec ff ff       	call   379 <getMessage>
    1760:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1763:	8b 45 08             	mov    0x8(%ebp),%eax
    1766:	83 c0 74             	add    $0x74,%eax
    1769:	83 ec 08             	sub    $0x8,%esp
    176c:	50                   	push   %eax
    176d:	ff 75 08             	pushl  0x8(%ebp)
    1770:	e8 7d ff ff ff       	call   16f2 <APPreJudge>
    1775:	83 c4 10             	add    $0x10,%esp
    1778:	84 c0                	test   %al,%al
    177a:	74 1b                	je     1797 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    177c:	8b 45 08             	mov    0x8(%ebp),%eax
    177f:	ff 70 7c             	pushl  0x7c(%eax)
    1782:	ff 70 78             	pushl  0x78(%eax)
    1785:	ff 70 74             	pushl  0x74(%eax)
    1788:	ff 75 08             	pushl  0x8(%ebp)
    178b:	8b 45 0c             	mov    0xc(%ebp),%eax
    178e:	ff d0                	call   *%eax
    1790:	83 c4 10             	add    $0x10,%esp
    1793:	84 c0                	test   %al,%al
    1795:	75 0c                	jne    17a3 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1797:	8b 45 08             	mov    0x8(%ebp),%eax
    179a:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    17a1:	eb b2                	jmp    1755 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    17a3:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    17a4:	90                   	nop
    17a5:	c9                   	leave  
    17a6:	c3                   	ret    

000017a7 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    17a7:	55                   	push   %ebp
    17a8:	89 e5                	mov    %esp,%ebp
    17aa:	57                   	push   %edi
    17ab:	56                   	push   %esi
    17ac:	53                   	push   %ebx
    17ad:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    17b0:	a1 4c 29 00 00       	mov    0x294c,%eax
    17b5:	85 c0                	test   %eax,%eax
    17b7:	0f 85 2c 02 00 00    	jne    19e9 <APGridPaint+0x242>
    {
        iconReady = 1;
    17bd:	c7 05 4c 29 00 00 01 	movl   $0x1,0x294c
    17c4:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    17c7:	8d 45 98             	lea    -0x68(%ebp),%eax
    17ca:	83 ec 08             	sub    $0x8,%esp
    17cd:	68 eb 22 00 00       	push   $0x22eb
    17d2:	50                   	push   %eax
    17d3:	e8 16 f1 ff ff       	call   8ee <APLoadBitmap>
    17d8:	83 c4 0c             	add    $0xc,%esp
    17db:	8b 45 98             	mov    -0x68(%ebp),%eax
    17de:	a3 70 29 00 00       	mov    %eax,0x2970
    17e3:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17e6:	a3 74 29 00 00       	mov    %eax,0x2974
    17eb:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17ee:	a3 78 29 00 00       	mov    %eax,0x2978
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    17f3:	83 ec 04             	sub    $0x4,%esp
    17f6:	ff 35 78 29 00 00    	pushl  0x2978
    17fc:	ff 35 74 29 00 00    	pushl  0x2974
    1802:	ff 35 70 29 00 00    	pushl  0x2970
    1808:	e8 1b f3 ff ff       	call   b28 <APCreateCompatibleDCFromBitmap>
    180d:	83 c4 10             	add    $0x10,%esp
    1810:	a3 7c 29 00 00       	mov    %eax,0x297c
        grid_river = APLoadBitmap ("grid_river.bmp");
    1815:	8d 45 98             	lea    -0x68(%ebp),%eax
    1818:	83 ec 08             	sub    $0x8,%esp
    181b:	68 f9 22 00 00       	push   $0x22f9
    1820:	50                   	push   %eax
    1821:	e8 c8 f0 ff ff       	call   8ee <APLoadBitmap>
    1826:	83 c4 0c             	add    $0xc,%esp
    1829:	8b 45 98             	mov    -0x68(%ebp),%eax
    182c:	a3 ac 29 00 00       	mov    %eax,0x29ac
    1831:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1834:	a3 b0 29 00 00       	mov    %eax,0x29b0
    1839:	8b 45 a0             	mov    -0x60(%ebp),%eax
    183c:	a3 b4 29 00 00       	mov    %eax,0x29b4
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1841:	83 ec 04             	sub    $0x4,%esp
    1844:	ff 35 b4 29 00 00    	pushl  0x29b4
    184a:	ff 35 b0 29 00 00    	pushl  0x29b0
    1850:	ff 35 ac 29 00 00    	pushl  0x29ac
    1856:	e8 cd f2 ff ff       	call   b28 <APCreateCompatibleDCFromBitmap>
    185b:	83 c4 10             	add    $0x10,%esp
    185e:	a3 9c 29 00 00       	mov    %eax,0x299c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1863:	8d 45 98             	lea    -0x68(%ebp),%eax
    1866:	83 ec 08             	sub    $0x8,%esp
    1869:	68 08 23 00 00       	push   $0x2308
    186e:	50                   	push   %eax
    186f:	e8 7a f0 ff ff       	call   8ee <APLoadBitmap>
    1874:	83 c4 0c             	add    $0xc,%esp
    1877:	8b 45 98             	mov    -0x68(%ebp),%eax
    187a:	a3 a0 29 00 00       	mov    %eax,0x29a0
    187f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1882:	a3 a4 29 00 00       	mov    %eax,0x29a4
    1887:	8b 45 a0             	mov    -0x60(%ebp),%eax
    188a:	a3 a8 29 00 00       	mov    %eax,0x29a8
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    188f:	83 ec 04             	sub    $0x4,%esp
    1892:	ff 35 a8 29 00 00    	pushl  0x29a8
    1898:	ff 35 a4 29 00 00    	pushl  0x29a4
    189e:	ff 35 a0 29 00 00    	pushl  0x29a0
    18a4:	e8 7f f2 ff ff       	call   b28 <APCreateCompatibleDCFromBitmap>
    18a9:	83 c4 10             	add    $0x10,%esp
    18ac:	a3 50 29 00 00       	mov    %eax,0x2950
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    18b1:	8d 45 98             	lea    -0x68(%ebp),%eax
    18b4:	83 ec 08             	sub    $0x8,%esp
    18b7:	68 17 23 00 00       	push   $0x2317
    18bc:	50                   	push   %eax
    18bd:	e8 2c f0 ff ff       	call   8ee <APLoadBitmap>
    18c2:	83 c4 0c             	add    $0xc,%esp
    18c5:	8b 45 98             	mov    -0x68(%ebp),%eax
    18c8:	a3 84 29 00 00       	mov    %eax,0x2984
    18cd:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18d0:	a3 88 29 00 00       	mov    %eax,0x2988
    18d5:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18d8:	a3 8c 29 00 00       	mov    %eax,0x298c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    18dd:	83 ec 04             	sub    $0x4,%esp
    18e0:	ff 35 8c 29 00 00    	pushl  0x298c
    18e6:	ff 35 88 29 00 00    	pushl  0x2988
    18ec:	ff 35 84 29 00 00    	pushl  0x2984
    18f2:	e8 31 f2 ff ff       	call   b28 <APCreateCompatibleDCFromBitmap>
    18f7:	83 c4 10             	add    $0x10,%esp
    18fa:	a3 b8 29 00 00       	mov    %eax,0x29b8
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    18ff:	8d 45 98             	lea    -0x68(%ebp),%eax
    1902:	83 ec 08             	sub    $0x8,%esp
    1905:	68 25 23 00 00       	push   $0x2325
    190a:	50                   	push   %eax
    190b:	e8 de ef ff ff       	call   8ee <APLoadBitmap>
    1910:	83 c4 0c             	add    $0xc,%esp
    1913:	8b 45 98             	mov    -0x68(%ebp),%eax
    1916:	a3 60 29 00 00       	mov    %eax,0x2960
    191b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    191e:	a3 64 29 00 00       	mov    %eax,0x2964
    1923:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1926:	a3 68 29 00 00       	mov    %eax,0x2968
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    192b:	83 ec 04             	sub    $0x4,%esp
    192e:	ff 35 68 29 00 00    	pushl  0x2968
    1934:	ff 35 64 29 00 00    	pushl  0x2964
    193a:	ff 35 60 29 00 00    	pushl  0x2960
    1940:	e8 e3 f1 ff ff       	call   b28 <APCreateCompatibleDCFromBitmap>
    1945:	83 c4 10             	add    $0x10,%esp
    1948:	a3 80 29 00 00       	mov    %eax,0x2980
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    194d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1950:	83 ec 08             	sub    $0x8,%esp
    1953:	68 35 23 00 00       	push   $0x2335
    1958:	50                   	push   %eax
    1959:	e8 90 ef ff ff       	call   8ee <APLoadBitmap>
    195e:	83 c4 0c             	add    $0xc,%esp
    1961:	8b 45 98             	mov    -0x68(%ebp),%eax
    1964:	a3 54 29 00 00       	mov    %eax,0x2954
    1969:	8b 45 9c             	mov    -0x64(%ebp),%eax
    196c:	a3 58 29 00 00       	mov    %eax,0x2958
    1971:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1974:	a3 5c 29 00 00       	mov    %eax,0x295c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1979:	83 ec 04             	sub    $0x4,%esp
    197c:	ff 35 5c 29 00 00    	pushl  0x295c
    1982:	ff 35 58 29 00 00    	pushl  0x2958
    1988:	ff 35 54 29 00 00    	pushl  0x2954
    198e:	e8 95 f1 ff ff       	call   b28 <APCreateCompatibleDCFromBitmap>
    1993:	83 c4 10             	add    $0x10,%esp
    1996:	a3 6c 29 00 00       	mov    %eax,0x296c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    199b:	8d 45 98             	lea    -0x68(%ebp),%eax
    199e:	83 ec 08             	sub    $0x8,%esp
    19a1:	68 47 23 00 00       	push   $0x2347
    19a6:	50                   	push   %eax
    19a7:	e8 42 ef ff ff       	call   8ee <APLoadBitmap>
    19ac:	83 c4 0c             	add    $0xc,%esp
    19af:	8b 45 98             	mov    -0x68(%ebp),%eax
    19b2:	a3 90 29 00 00       	mov    %eax,0x2990
    19b7:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19ba:	a3 94 29 00 00       	mov    %eax,0x2994
    19bf:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19c2:	a3 98 29 00 00       	mov    %eax,0x2998
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    19c7:	83 ec 04             	sub    $0x4,%esp
    19ca:	ff 35 98 29 00 00    	pushl  0x2998
    19d0:	ff 35 94 29 00 00    	pushl  0x2994
    19d6:	ff 35 90 29 00 00    	pushl  0x2990
    19dc:	e8 47 f1 ff ff       	call   b28 <APCreateCompatibleDCFromBitmap>
    19e1:	83 c4 10             	add    $0x10,%esp
    19e4:	a3 bc 29 00 00       	mov    %eax,0x29bc
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    19e9:	8b 45 08             	mov    0x8(%ebp),%eax
    19ec:	8b 40 08             	mov    0x8(%eax),%eax
    19ef:	85 c0                	test   %eax,%eax
    19f1:	75 17                	jne    1a0a <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    19f3:	83 ec 08             	sub    $0x8,%esp
    19f6:	68 58 23 00 00       	push   $0x2358
    19fb:	6a 01                	push   $0x1
    19fd:	e8 66 ea ff ff       	call   468 <printf>
    1a02:	83 c4 10             	add    $0x10,%esp
        return;
    1a05:	e9 a0 04 00 00       	jmp    1eaa <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1a0a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0d:	8b 40 10             	mov    0x10(%eax),%eax
    1a10:	85 c0                	test   %eax,%eax
    1a12:	7e 10                	jle    1a24 <APGridPaint+0x27d>
    1a14:	8b 45 08             	mov    0x8(%ebp),%eax
    1a17:	8b 50 14             	mov    0x14(%eax),%edx
    1a1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1d:	8b 40 10             	mov    0x10(%eax),%eax
    1a20:	39 c2                	cmp    %eax,%edx
    1a22:	7c 17                	jl     1a3b <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1a24:	83 ec 08             	sub    $0x8,%esp
    1a27:	68 7e 23 00 00       	push   $0x237e
    1a2c:	6a 01                	push   $0x1
    1a2e:	e8 35 ea ff ff       	call   468 <printf>
    1a33:	83 c4 10             	add    $0x10,%esp
        return;
    1a36:	e9 6f 04 00 00       	jmp    1eaa <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1a3b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3e:	8b 40 14             	mov    0x14(%eax),%eax
    1a41:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a47:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a4a:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a4d:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a50:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a57:	e9 96 03 00 00       	jmp    1df2 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a5c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a63:	e9 7c 03 00 00       	jmp    1de4 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a6b:	c1 e0 04             	shl    $0x4,%eax
    1a6e:	89 c2                	mov    %eax,%edx
    1a70:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a73:	01 c2                	add    %eax,%edx
    1a75:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a78:	01 d0                	add    %edx,%eax
    1a7a:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a80:	8b 40 0c             	mov    0xc(%eax),%eax
    1a83:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a86:	c1 e2 02             	shl    $0x2,%edx
    1a89:	01 d0                	add    %edx,%eax
    1a8b:	8b 00                	mov    (%eax),%eax
    1a8d:	83 f8 07             	cmp    $0x7,%eax
    1a90:	0f 87 49 03 00 00    	ja     1ddf <APGridPaint+0x638>
    1a96:	8b 04 85 94 23 00 00 	mov    0x2394(,%eax,4),%eax
    1a9d:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1a9f:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1aa2:	6a 0c                	push   $0xc
    1aa4:	6a 0c                	push   $0xc
    1aa6:	6a 0c                	push   $0xc
    1aa8:	50                   	push   %eax
    1aa9:	e8 df f8 ff ff       	call   138d <RGB>
    1aae:	83 c4 0c             	add    $0xc,%esp
    1ab1:	8b 1d 7c 29 00 00    	mov    0x297c,%ebx
    1ab7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1aba:	6b c8 32             	imul   $0x32,%eax,%ecx
    1abd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ac0:	6b c0 32             	imul   $0x32,%eax,%eax
    1ac3:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ac6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac9:	8d 78 3c             	lea    0x3c(%eax),%edi
    1acc:	83 ec 0c             	sub    $0xc,%esp
    1acf:	83 ec 04             	sub    $0x4,%esp
    1ad2:	89 e0                	mov    %esp,%eax
    1ad4:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1ad8:	66 89 30             	mov    %si,(%eax)
    1adb:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1adf:	88 50 02             	mov    %dl,0x2(%eax)
    1ae2:	6a 32                	push   $0x32
    1ae4:	6a 32                	push   $0x32
    1ae6:	6a 00                	push   $0x0
    1ae8:	6a 00                	push   $0x0
    1aea:	53                   	push   %ebx
    1aeb:	51                   	push   %ecx
    1aec:	ff 75 94             	pushl  -0x6c(%ebp)
    1aef:	57                   	push   %edi
    1af0:	e8 f4 f6 ff ff       	call   11e9 <APDcCopy>
    1af5:	83 c4 30             	add    $0x30,%esp
                    break;
    1af8:	e9 e3 02 00 00       	jmp    1de0 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1afd:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b00:	6a 69                	push   $0x69
    1b02:	6a 69                	push   $0x69
    1b04:	6a 69                	push   $0x69
    1b06:	50                   	push   %eax
    1b07:	e8 81 f8 ff ff       	call   138d <RGB>
    1b0c:	83 c4 0c             	add    $0xc,%esp
    1b0f:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b13:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1b17:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b1b:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1b1e:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1b25:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b28:	6a 69                	push   $0x69
    1b2a:	6a 69                	push   $0x69
    1b2c:	6a 69                	push   $0x69
    1b2e:	50                   	push   %eax
    1b2f:	e8 59 f8 ff ff       	call   138d <RGB>
    1b34:	83 c4 0c             	add    $0xc,%esp
    1b37:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b3b:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1b3f:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b43:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b46:	8b 45 08             	mov    0x8(%ebp),%eax
    1b49:	8d 50 3c             	lea    0x3c(%eax),%edx
    1b4c:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b4f:	ff 75 b0             	pushl  -0x50(%ebp)
    1b52:	ff 75 ac             	pushl  -0x54(%ebp)
    1b55:	52                   	push   %edx
    1b56:	50                   	push   %eax
    1b57:	e8 61 f0 ff ff       	call   bbd <APSetPen>
    1b5c:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b62:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1b65:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b68:	83 ec 04             	sub    $0x4,%esp
    1b6b:	83 ec 04             	sub    $0x4,%esp
    1b6e:	89 e0                	mov    %esp,%eax
    1b70:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1b74:	66 89 08             	mov    %cx,(%eax)
    1b77:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1b7b:	88 48 02             	mov    %cl,0x2(%eax)
    1b7e:	53                   	push   %ebx
    1b7f:	52                   	push   %edx
    1b80:	e8 71 f0 ff ff       	call   bf6 <APSetBrush>
    1b85:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b88:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b8b:	6b d0 32             	imul   $0x32,%eax,%edx
    1b8e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b91:	6b c0 32             	imul   $0x32,%eax,%eax
    1b94:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b97:	83 c1 3c             	add    $0x3c,%ecx
    1b9a:	83 ec 0c             	sub    $0xc,%esp
    1b9d:	6a 32                	push   $0x32
    1b9f:	6a 32                	push   $0x32
    1ba1:	52                   	push   %edx
    1ba2:	50                   	push   %eax
    1ba3:	51                   	push   %ecx
    1ba4:	e8 35 f4 ff ff       	call   fde <APDrawRect>
    1ba9:	83 c4 20             	add    $0x20,%esp
                    break;
    1bac:	e9 2f 02 00 00       	jmp    1de0 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bb1:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1bb4:	6a 0c                	push   $0xc
    1bb6:	6a 0c                	push   $0xc
    1bb8:	6a 0c                	push   $0xc
    1bba:	50                   	push   %eax
    1bbb:	e8 cd f7 ff ff       	call   138d <RGB>
    1bc0:	83 c4 0c             	add    $0xc,%esp
    1bc3:	8b 1d bc 29 00 00    	mov    0x29bc,%ebx
    1bc9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bcc:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bcf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bd2:	6b c0 32             	imul   $0x32,%eax,%eax
    1bd5:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bd8:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdb:	8d 78 3c             	lea    0x3c(%eax),%edi
    1bde:	83 ec 0c             	sub    $0xc,%esp
    1be1:	83 ec 04             	sub    $0x4,%esp
    1be4:	89 e0                	mov    %esp,%eax
    1be6:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1bea:	66 89 30             	mov    %si,(%eax)
    1bed:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1bf1:	88 50 02             	mov    %dl,0x2(%eax)
    1bf4:	6a 32                	push   $0x32
    1bf6:	6a 32                	push   $0x32
    1bf8:	6a 00                	push   $0x0
    1bfa:	6a 00                	push   $0x0
    1bfc:	53                   	push   %ebx
    1bfd:	51                   	push   %ecx
    1bfe:	ff 75 94             	pushl  -0x6c(%ebp)
    1c01:	57                   	push   %edi
    1c02:	e8 e2 f5 ff ff       	call   11e9 <APDcCopy>
    1c07:	83 c4 30             	add    $0x30,%esp
                    break;
    1c0a:	e9 d1 01 00 00       	jmp    1de0 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c0f:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1c12:	6a 0c                	push   $0xc
    1c14:	6a 0c                	push   $0xc
    1c16:	6a 0c                	push   $0xc
    1c18:	50                   	push   %eax
    1c19:	e8 6f f7 ff ff       	call   138d <RGB>
    1c1e:	83 c4 0c             	add    $0xc,%esp
    1c21:	8b 1d 9c 29 00 00    	mov    0x299c,%ebx
    1c27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c2a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c2d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c30:	6b c0 32             	imul   $0x32,%eax,%eax
    1c33:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c36:	8b 45 08             	mov    0x8(%ebp),%eax
    1c39:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c3c:	83 ec 0c             	sub    $0xc,%esp
    1c3f:	83 ec 04             	sub    $0x4,%esp
    1c42:	89 e0                	mov    %esp,%eax
    1c44:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1c48:	66 89 30             	mov    %si,(%eax)
    1c4b:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c4f:	88 50 02             	mov    %dl,0x2(%eax)
    1c52:	6a 32                	push   $0x32
    1c54:	6a 32                	push   $0x32
    1c56:	6a 00                	push   $0x0
    1c58:	6a 00                	push   $0x0
    1c5a:	53                   	push   %ebx
    1c5b:	51                   	push   %ecx
    1c5c:	ff 75 94             	pushl  -0x6c(%ebp)
    1c5f:	57                   	push   %edi
    1c60:	e8 84 f5 ff ff       	call   11e9 <APDcCopy>
    1c65:	83 c4 30             	add    $0x30,%esp
                    break;
    1c68:	e9 73 01 00 00       	jmp    1de0 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c6d:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c70:	6a 0c                	push   $0xc
    1c72:	6a 0c                	push   $0xc
    1c74:	6a 0c                	push   $0xc
    1c76:	50                   	push   %eax
    1c77:	e8 11 f7 ff ff       	call   138d <RGB>
    1c7c:	83 c4 0c             	add    $0xc,%esp
    1c7f:	8b 1d 80 29 00 00    	mov    0x2980,%ebx
    1c85:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c88:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c8b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c8e:	6b c0 32             	imul   $0x32,%eax,%eax
    1c91:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c94:	8b 45 08             	mov    0x8(%ebp),%eax
    1c97:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c9a:	83 ec 0c             	sub    $0xc,%esp
    1c9d:	83 ec 04             	sub    $0x4,%esp
    1ca0:	89 e0                	mov    %esp,%eax
    1ca2:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1ca6:	66 89 30             	mov    %si,(%eax)
    1ca9:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1cad:	88 50 02             	mov    %dl,0x2(%eax)
    1cb0:	6a 32                	push   $0x32
    1cb2:	6a 32                	push   $0x32
    1cb4:	6a 00                	push   $0x0
    1cb6:	6a 00                	push   $0x0
    1cb8:	53                   	push   %ebx
    1cb9:	51                   	push   %ecx
    1cba:	ff 75 94             	pushl  -0x6c(%ebp)
    1cbd:	57                   	push   %edi
    1cbe:	e8 26 f5 ff ff       	call   11e9 <APDcCopy>
    1cc3:	83 c4 30             	add    $0x30,%esp
                    break;
    1cc6:	e9 15 01 00 00       	jmp    1de0 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ccb:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1cce:	6a 0c                	push   $0xc
    1cd0:	6a 0c                	push   $0xc
    1cd2:	6a 0c                	push   $0xc
    1cd4:	50                   	push   %eax
    1cd5:	e8 b3 f6 ff ff       	call   138d <RGB>
    1cda:	83 c4 0c             	add    $0xc,%esp
    1cdd:	8b 1d b8 29 00 00    	mov    0x29b8,%ebx
    1ce3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ce6:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ce9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cec:	6b c0 32             	imul   $0x32,%eax,%eax
    1cef:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cf2:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf5:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cf8:	83 ec 0c             	sub    $0xc,%esp
    1cfb:	83 ec 04             	sub    $0x4,%esp
    1cfe:	89 e0                	mov    %esp,%eax
    1d00:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1d04:	66 89 30             	mov    %si,(%eax)
    1d07:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1d0b:	88 50 02             	mov    %dl,0x2(%eax)
    1d0e:	6a 32                	push   $0x32
    1d10:	6a 32                	push   $0x32
    1d12:	6a 00                	push   $0x0
    1d14:	6a 00                	push   $0x0
    1d16:	53                   	push   %ebx
    1d17:	51                   	push   %ecx
    1d18:	ff 75 94             	pushl  -0x6c(%ebp)
    1d1b:	57                   	push   %edi
    1d1c:	e8 c8 f4 ff ff       	call   11e9 <APDcCopy>
    1d21:	83 c4 30             	add    $0x30,%esp
                    break;
    1d24:	e9 b7 00 00 00       	jmp    1de0 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d29:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1d2c:	6a 0c                	push   $0xc
    1d2e:	6a 0c                	push   $0xc
    1d30:	6a 0c                	push   $0xc
    1d32:	50                   	push   %eax
    1d33:	e8 55 f6 ff ff       	call   138d <RGB>
    1d38:	83 c4 0c             	add    $0xc,%esp
    1d3b:	8b 1d 50 29 00 00    	mov    0x2950,%ebx
    1d41:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d44:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d47:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d4a:	6b c0 32             	imul   $0x32,%eax,%eax
    1d4d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d50:	8b 45 08             	mov    0x8(%ebp),%eax
    1d53:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d56:	83 ec 0c             	sub    $0xc,%esp
    1d59:	83 ec 04             	sub    $0x4,%esp
    1d5c:	89 e0                	mov    %esp,%eax
    1d5e:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d62:	66 89 30             	mov    %si,(%eax)
    1d65:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d69:	88 50 02             	mov    %dl,0x2(%eax)
    1d6c:	6a 32                	push   $0x32
    1d6e:	6a 32                	push   $0x32
    1d70:	6a 00                	push   $0x0
    1d72:	6a 00                	push   $0x0
    1d74:	53                   	push   %ebx
    1d75:	51                   	push   %ecx
    1d76:	ff 75 94             	pushl  -0x6c(%ebp)
    1d79:	57                   	push   %edi
    1d7a:	e8 6a f4 ff ff       	call   11e9 <APDcCopy>
    1d7f:	83 c4 30             	add    $0x30,%esp
                    break;
    1d82:	eb 5c                	jmp    1de0 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d84:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d87:	6a 0c                	push   $0xc
    1d89:	6a 0c                	push   $0xc
    1d8b:	6a 0c                	push   $0xc
    1d8d:	50                   	push   %eax
    1d8e:	e8 fa f5 ff ff       	call   138d <RGB>
    1d93:	83 c4 0c             	add    $0xc,%esp
    1d96:	8b 1d 6c 29 00 00    	mov    0x296c,%ebx
    1d9c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d9f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1da2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1da5:	6b c0 32             	imul   $0x32,%eax,%eax
    1da8:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dab:	8b 45 08             	mov    0x8(%ebp),%eax
    1dae:	8d 78 3c             	lea    0x3c(%eax),%edi
    1db1:	83 ec 0c             	sub    $0xc,%esp
    1db4:	83 ec 04             	sub    $0x4,%esp
    1db7:	89 e0                	mov    %esp,%eax
    1db9:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1dbd:	66 89 30             	mov    %si,(%eax)
    1dc0:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1dc4:	88 50 02             	mov    %dl,0x2(%eax)
    1dc7:	6a 32                	push   $0x32
    1dc9:	6a 32                	push   $0x32
    1dcb:	6a 00                	push   $0x0
    1dcd:	6a 00                	push   $0x0
    1dcf:	53                   	push   %ebx
    1dd0:	51                   	push   %ecx
    1dd1:	ff 75 94             	pushl  -0x6c(%ebp)
    1dd4:	57                   	push   %edi
    1dd5:	e8 0f f4 ff ff       	call   11e9 <APDcCopy>
    1dda:	83 c4 30             	add    $0x30,%esp
                    break;
    1ddd:	eb 01                	jmp    1de0 <APGridPaint+0x639>
                default: break;
    1ddf:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1de0:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1de4:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1de8:	0f 8e 7a fc ff ff    	jle    1a68 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1dee:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1df2:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1df6:	0f 8e 60 fc ff ff    	jle    1a5c <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1dfc:	8d 45 98             	lea    -0x68(%ebp),%eax
    1dff:	68 cd 00 00 00       	push   $0xcd
    1e04:	6a 74                	push   $0x74
    1e06:	6a 18                	push   $0x18
    1e08:	50                   	push   %eax
    1e09:	e8 7f f5 ff ff       	call   138d <RGB>
    1e0e:	83 c4 0c             	add    $0xc,%esp
    1e11:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e15:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1e19:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e1d:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1e20:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1e27:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e2a:	68 cd 00 00 00       	push   $0xcd
    1e2f:	6a 74                	push   $0x74
    1e31:	6a 18                	push   $0x18
    1e33:	50                   	push   %eax
    1e34:	e8 54 f5 ff ff       	call   138d <RGB>
    1e39:	83 c4 0c             	add    $0xc,%esp
    1e3c:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e40:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1e44:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e48:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1e4b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e4e:	8d 50 58             	lea    0x58(%eax),%edx
    1e51:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e54:	ff 75 bc             	pushl  -0x44(%ebp)
    1e57:	ff 75 b8             	pushl  -0x48(%ebp)
    1e5a:	52                   	push   %edx
    1e5b:	50                   	push   %eax
    1e5c:	e8 5c ed ff ff       	call   bbd <APSetPen>
    1e61:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1e64:	8b 45 08             	mov    0x8(%ebp),%eax
    1e67:	8d 58 58             	lea    0x58(%eax),%ebx
    1e6a:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e6d:	83 ec 04             	sub    $0x4,%esp
    1e70:	83 ec 04             	sub    $0x4,%esp
    1e73:	89 e0                	mov    %esp,%eax
    1e75:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1e79:	66 89 08             	mov    %cx,(%eax)
    1e7c:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1e80:	88 48 02             	mov    %cl,0x2(%eax)
    1e83:	53                   	push   %ebx
    1e84:	52                   	push   %edx
    1e85:	e8 6c ed ff ff       	call   bf6 <APSetBrush>
    1e8a:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1e8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1e90:	83 c0 58             	add    $0x58,%eax
    1e93:	83 ec 0c             	sub    $0xc,%esp
    1e96:	6a 32                	push   $0x32
    1e98:	68 20 03 00 00       	push   $0x320
    1e9d:	6a 00                	push   $0x0
    1e9f:	6a 00                	push   $0x0
    1ea1:	50                   	push   %eax
    1ea2:	e8 37 f1 ff ff       	call   fde <APDrawRect>
    1ea7:	83 c4 20             	add    $0x20,%esp
}
    1eaa:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1ead:	5b                   	pop    %ebx
    1eae:	5e                   	pop    %esi
    1eaf:	5f                   	pop    %edi
    1eb0:	5d                   	pop    %ebp
    1eb1:	c3                   	ret    

00001eb2 <random>:
//

#include "APLib.h"

int random(int seed)
{
    1eb2:	55                   	push   %ebp
    1eb3:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1eb5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1eb9:	7e 08                	jle    1ec3 <random+0x11>
{
rand_num = seed;
    1ebb:	8b 45 08             	mov    0x8(%ebp),%eax
    1ebe:	a3 28 29 00 00       	mov    %eax,0x2928
}
rand_num *= 3;
    1ec3:	8b 15 28 29 00 00    	mov    0x2928,%edx
    1ec9:	89 d0                	mov    %edx,%eax
    1ecb:	01 c0                	add    %eax,%eax
    1ecd:	01 d0                	add    %edx,%eax
    1ecf:	a3 28 29 00 00       	mov    %eax,0x2928
if (rand_num < 0)
    1ed4:	a1 28 29 00 00       	mov    0x2928,%eax
    1ed9:	85 c0                	test   %eax,%eax
    1edb:	79 0c                	jns    1ee9 <random+0x37>
{
rand_num *= (-1);
    1edd:	a1 28 29 00 00       	mov    0x2928,%eax
    1ee2:	f7 d8                	neg    %eax
    1ee4:	a3 28 29 00 00       	mov    %eax,0x2928
}
return rand_num % 997;
    1ee9:	8b 0d 28 29 00 00    	mov    0x2928,%ecx
    1eef:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1ef4:	89 c8                	mov    %ecx,%eax
    1ef6:	f7 ea                	imul   %edx
    1ef8:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1efb:	c1 f8 09             	sar    $0x9,%eax
    1efe:	89 c2                	mov    %eax,%edx
    1f00:	89 c8                	mov    %ecx,%eax
    1f02:	c1 f8 1f             	sar    $0x1f,%eax
    1f05:	29 c2                	sub    %eax,%edx
    1f07:	89 d0                	mov    %edx,%eax
    1f09:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1f0f:	29 c1                	sub    %eax,%ecx
    1f11:	89 c8                	mov    %ecx,%eax
}
    1f13:	5d                   	pop    %ebp
    1f14:	c3                   	ret    

00001f15 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1f15:	55                   	push   %ebp
    1f16:	89 e5                	mov    %esp,%ebp
    1f18:	53                   	push   %ebx
    1f19:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1f1c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1f23:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1f27:	74 17                	je     1f40 <sprintint+0x2b>
    1f29:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1f2d:	79 11                	jns    1f40 <sprintint+0x2b>
        neg = 1;
    1f2f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1f36:	8b 45 10             	mov    0x10(%ebp),%eax
    1f39:	f7 d8                	neg    %eax
    1f3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f3e:	eb 06                	jmp    1f46 <sprintint+0x31>
    } else {
        x = xx;
    1f40:	8b 45 10             	mov    0x10(%ebp),%eax
    1f43:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1f46:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1f4d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1f50:	8d 41 01             	lea    0x1(%ecx),%eax
    1f53:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1f56:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f59:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f5c:	ba 00 00 00 00       	mov    $0x0,%edx
    1f61:	f7 f3                	div    %ebx
    1f63:	89 d0                	mov    %edx,%eax
    1f65:	0f b6 80 2c 29 00 00 	movzbl 0x292c(%eax),%eax
    1f6c:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1f70:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f73:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f76:	ba 00 00 00 00       	mov    $0x0,%edx
    1f7b:	f7 f3                	div    %ebx
    1f7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f80:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f84:	75 c7                	jne    1f4d <sprintint+0x38>
    if(neg)
    1f86:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f8a:	74 0e                	je     1f9a <sprintint+0x85>
        buf[i++] = '-';
    1f8c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f8f:	8d 50 01             	lea    0x1(%eax),%edx
    1f92:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1f95:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1f9a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f9d:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1fa0:	eb 1b                	jmp    1fbd <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1fa2:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fa5:	8b 00                	mov    (%eax),%eax
    1fa7:	8d 48 01             	lea    0x1(%eax),%ecx
    1faa:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fad:	89 0a                	mov    %ecx,(%edx)
    1faf:	89 c2                	mov    %eax,%edx
    1fb1:	8b 45 08             	mov    0x8(%ebp),%eax
    1fb4:	01 d0                	add    %edx,%eax
    1fb6:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1fb9:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1fbd:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1fc1:	7f df                	jg     1fa2 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fc3:	eb 21                	jmp    1fe6 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1fc5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fc8:	8b 00                	mov    (%eax),%eax
    1fca:	8d 48 01             	lea    0x1(%eax),%ecx
    1fcd:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fd0:	89 0a                	mov    %ecx,(%edx)
    1fd2:	89 c2                	mov    %eax,%edx
    1fd4:	8b 45 08             	mov    0x8(%ebp),%eax
    1fd7:	01 c2                	add    %eax,%edx
    1fd9:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1fdc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fdf:	01 c8                	add    %ecx,%eax
    1fe1:	0f b6 00             	movzbl (%eax),%eax
    1fe4:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fe6:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1fea:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1fee:	79 d5                	jns    1fc5 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1ff0:	90                   	nop
    1ff1:	83 c4 20             	add    $0x20,%esp
    1ff4:	5b                   	pop    %ebx
    1ff5:	5d                   	pop    %ebp
    1ff6:	c3                   	ret    

00001ff7 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1ff7:	55                   	push   %ebp
    1ff8:	89 e5                	mov    %esp,%ebp
    1ffa:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1ffd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2004:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    200b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2012:	8d 45 0c             	lea    0xc(%ebp),%eax
    2015:	83 c0 04             	add    $0x4,%eax
    2018:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    201b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2022:	e9 d9 01 00 00       	jmp    2200 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2027:	8b 55 0c             	mov    0xc(%ebp),%edx
    202a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    202d:	01 d0                	add    %edx,%eax
    202f:	0f b6 00             	movzbl (%eax),%eax
    2032:	0f be c0             	movsbl %al,%eax
    2035:	25 ff 00 00 00       	and    $0xff,%eax
    203a:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    203d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2041:	75 2c                	jne    206f <sprintf+0x78>
            if(c == '%'){
    2043:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2047:	75 0c                	jne    2055 <sprintf+0x5e>
                state = '%';
    2049:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2050:	e9 a7 01 00 00       	jmp    21fc <sprintf+0x205>
            } else {
                dst[j++] = c;
    2055:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2058:	8d 50 01             	lea    0x1(%eax),%edx
    205b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    205e:	89 c2                	mov    %eax,%edx
    2060:	8b 45 08             	mov    0x8(%ebp),%eax
    2063:	01 d0                	add    %edx,%eax
    2065:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2068:	88 10                	mov    %dl,(%eax)
    206a:	e9 8d 01 00 00       	jmp    21fc <sprintf+0x205>
            }
        } else if(state == '%'){
    206f:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2073:	0f 85 83 01 00 00    	jne    21fc <sprintf+0x205>
            if(c == 'd'){
    2079:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    207d:	75 4c                	jne    20cb <sprintf+0xd4>
                buf[bi] = '\0';
    207f:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2082:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2085:	01 d0                	add    %edx,%eax
    2087:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    208a:	83 ec 0c             	sub    $0xc,%esp
    208d:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2090:	50                   	push   %eax
    2091:	e8 a1 e1 ff ff       	call   237 <atoi>
    2096:	83 c4 10             	add    $0x10,%esp
    2099:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    209c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    20a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20a6:	8b 00                	mov    (%eax),%eax
    20a8:	83 ec 08             	sub    $0x8,%esp
    20ab:	ff 75 d8             	pushl  -0x28(%ebp)
    20ae:	6a 01                	push   $0x1
    20b0:	6a 0a                	push   $0xa
    20b2:	50                   	push   %eax
    20b3:	8d 45 c8             	lea    -0x38(%ebp),%eax
    20b6:	50                   	push   %eax
    20b7:	ff 75 08             	pushl  0x8(%ebp)
    20ba:	e8 56 fe ff ff       	call   1f15 <sprintint>
    20bf:	83 c4 20             	add    $0x20,%esp
                ap++;
    20c2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    20c6:	e9 2a 01 00 00       	jmp    21f5 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    20cb:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    20cf:	74 06                	je     20d7 <sprintf+0xe0>
    20d1:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    20d5:	75 4c                	jne    2123 <sprintf+0x12c>
                buf[bi] = '\0';
    20d7:	8d 55 ce             	lea    -0x32(%ebp),%edx
    20da:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20dd:	01 d0                	add    %edx,%eax
    20df:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    20e2:	83 ec 0c             	sub    $0xc,%esp
    20e5:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20e8:	50                   	push   %eax
    20e9:	e8 49 e1 ff ff       	call   237 <atoi>
    20ee:	83 c4 10             	add    $0x10,%esp
    20f1:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    20f4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    20fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20fe:	8b 00                	mov    (%eax),%eax
    2100:	83 ec 08             	sub    $0x8,%esp
    2103:	ff 75 dc             	pushl  -0x24(%ebp)
    2106:	6a 00                	push   $0x0
    2108:	6a 10                	push   $0x10
    210a:	50                   	push   %eax
    210b:	8d 45 c8             	lea    -0x38(%ebp),%eax
    210e:	50                   	push   %eax
    210f:	ff 75 08             	pushl  0x8(%ebp)
    2112:	e8 fe fd ff ff       	call   1f15 <sprintint>
    2117:	83 c4 20             	add    $0x20,%esp
                ap++;
    211a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    211e:	e9 d2 00 00 00       	jmp    21f5 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2123:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2127:	75 46                	jne    216f <sprintf+0x178>
                s = (char*)*ap;
    2129:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    212c:	8b 00                	mov    (%eax),%eax
    212e:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2131:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2135:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2139:	75 25                	jne    2160 <sprintf+0x169>
                    s = "(null)";
    213b:	c7 45 f4 b4 23 00 00 	movl   $0x23b4,-0xc(%ebp)
                while(*s != 0){
    2142:	eb 1c                	jmp    2160 <sprintf+0x169>
                    dst[j++] = *s;
    2144:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2147:	8d 50 01             	lea    0x1(%eax),%edx
    214a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    214d:	89 c2                	mov    %eax,%edx
    214f:	8b 45 08             	mov    0x8(%ebp),%eax
    2152:	01 c2                	add    %eax,%edx
    2154:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2157:	0f b6 00             	movzbl (%eax),%eax
    215a:	88 02                	mov    %al,(%edx)
                    s++;
    215c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2160:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2163:	0f b6 00             	movzbl (%eax),%eax
    2166:	84 c0                	test   %al,%al
    2168:	75 da                	jne    2144 <sprintf+0x14d>
    216a:	e9 86 00 00 00       	jmp    21f5 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    216f:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2173:	75 1d                	jne    2192 <sprintf+0x19b>
                dst[j++] = *ap;
    2175:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2178:	8d 50 01             	lea    0x1(%eax),%edx
    217b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    217e:	89 c2                	mov    %eax,%edx
    2180:	8b 45 08             	mov    0x8(%ebp),%eax
    2183:	01 c2                	add    %eax,%edx
    2185:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2188:	8b 00                	mov    (%eax),%eax
    218a:	88 02                	mov    %al,(%edx)
                ap++;
    218c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2190:	eb 63                	jmp    21f5 <sprintf+0x1fe>
            } else if(c == '%'){
    2192:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2196:	75 17                	jne    21af <sprintf+0x1b8>
                dst[j++] = c;
    2198:	8b 45 c8             	mov    -0x38(%ebp),%eax
    219b:	8d 50 01             	lea    0x1(%eax),%edx
    219e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21a1:	89 c2                	mov    %eax,%edx
    21a3:	8b 45 08             	mov    0x8(%ebp),%eax
    21a6:	01 d0                	add    %edx,%eax
    21a8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21ab:	88 10                	mov    %dl,(%eax)
    21ad:	eb 46                	jmp    21f5 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    21af:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    21b3:	7e 18                	jle    21cd <sprintf+0x1d6>
    21b5:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    21b9:	7f 12                	jg     21cd <sprintf+0x1d6>
            {
                buf[bi++] = c;
    21bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21be:	8d 50 01             	lea    0x1(%eax),%edx
    21c1:	89 55 f0             	mov    %edx,-0x10(%ebp)
    21c4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21c7:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    21cb:	eb 2f                	jmp    21fc <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    21cd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21d0:	8d 50 01             	lea    0x1(%eax),%edx
    21d3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21d6:	89 c2                	mov    %eax,%edx
    21d8:	8b 45 08             	mov    0x8(%ebp),%eax
    21db:	01 d0                	add    %edx,%eax
    21dd:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    21e0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21e3:	8d 50 01             	lea    0x1(%eax),%edx
    21e6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21e9:	89 c2                	mov    %eax,%edx
    21eb:	8b 45 08             	mov    0x8(%ebp),%eax
    21ee:	01 d0                	add    %edx,%eax
    21f0:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21f3:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    21f5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    21fc:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2200:	8b 55 0c             	mov    0xc(%ebp),%edx
    2203:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2206:	01 d0                	add    %edx,%eax
    2208:	0f b6 00             	movzbl (%eax),%eax
    220b:	84 c0                	test   %al,%al
    220d:	0f 85 14 fe ff ff    	jne    2027 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2213:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2216:	8d 50 01             	lea    0x1(%eax),%edx
    2219:	89 55 c8             	mov    %edx,-0x38(%ebp)
    221c:	89 c2                	mov    %eax,%edx
    221e:	8b 45 08             	mov    0x8(%ebp),%eax
    2221:	01 d0                	add    %edx,%eax
    2223:	c6 00 00             	movb   $0x0,(%eax)
}
    2226:	90                   	nop
    2227:	c9                   	leave  
    2228:	c3                   	ret    
