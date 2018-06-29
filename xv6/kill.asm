
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
      1c:	68 e4 23 00 00       	push   $0x23e4
      21:	6a 02                	push   $0x2
      23:	e8 50 04 00 00       	call   478 <printf>
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

000003a1 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3a1:	55                   	push   %ebp
     3a2:	89 e5                	mov    %esp,%ebp
     3a4:	83 ec 18             	sub    $0x18,%esp
     3a7:	8b 45 0c             	mov    0xc(%ebp),%eax
     3aa:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3ad:	83 ec 04             	sub    $0x4,%esp
     3b0:	6a 01                	push   $0x1
     3b2:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3b5:	50                   	push   %eax
     3b6:	ff 75 08             	pushl  0x8(%ebp)
     3b9:	e8 2b ff ff ff       	call   2e9 <write>
     3be:	83 c4 10             	add    $0x10,%esp
}
     3c1:	90                   	nop
     3c2:	c9                   	leave  
     3c3:	c3                   	ret    

000003c4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3c4:	55                   	push   %ebp
     3c5:	89 e5                	mov    %esp,%ebp
     3c7:	53                   	push   %ebx
     3c8:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3cb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3d2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3d6:	74 17                	je     3ef <printint+0x2b>
     3d8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3dc:	79 11                	jns    3ef <printint+0x2b>
    neg = 1;
     3de:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3e5:	8b 45 0c             	mov    0xc(%ebp),%eax
     3e8:	f7 d8                	neg    %eax
     3ea:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3ed:	eb 06                	jmp    3f5 <printint+0x31>
  } else {
    x = xx;
     3ef:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3f5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3fc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3ff:	8d 41 01             	lea    0x1(%ecx),%eax
     402:	89 45 f4             	mov    %eax,-0xc(%ebp)
     405:	8b 5d 10             	mov    0x10(%ebp),%ebx
     408:	8b 45 ec             	mov    -0x14(%ebp),%eax
     40b:	ba 00 00 00 00       	mov    $0x0,%edx
     410:	f7 f3                	div    %ebx
     412:	89 d0                	mov    %edx,%eax
     414:	0f b6 80 00 2b 00 00 	movzbl 0x2b00(%eax),%eax
     41b:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     41f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     422:	8b 45 ec             	mov    -0x14(%ebp),%eax
     425:	ba 00 00 00 00       	mov    $0x0,%edx
     42a:	f7 f3                	div    %ebx
     42c:	89 45 ec             	mov    %eax,-0x14(%ebp)
     42f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     433:	75 c7                	jne    3fc <printint+0x38>
  if(neg)
     435:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     439:	74 2d                	je     468 <printint+0xa4>
    buf[i++] = '-';
     43b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     43e:	8d 50 01             	lea    0x1(%eax),%edx
     441:	89 55 f4             	mov    %edx,-0xc(%ebp)
     444:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     449:	eb 1d                	jmp    468 <printint+0xa4>
    putc(fd, buf[i]);
     44b:	8d 55 dc             	lea    -0x24(%ebp),%edx
     44e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     451:	01 d0                	add    %edx,%eax
     453:	0f b6 00             	movzbl (%eax),%eax
     456:	0f be c0             	movsbl %al,%eax
     459:	83 ec 08             	sub    $0x8,%esp
     45c:	50                   	push   %eax
     45d:	ff 75 08             	pushl  0x8(%ebp)
     460:	e8 3c ff ff ff       	call   3a1 <putc>
     465:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     468:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     46c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     470:	79 d9                	jns    44b <printint+0x87>
    putc(fd, buf[i]);
}
     472:	90                   	nop
     473:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     476:	c9                   	leave  
     477:	c3                   	ret    

00000478 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     478:	55                   	push   %ebp
     479:	89 e5                	mov    %esp,%ebp
     47b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     47e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     485:	8d 45 0c             	lea    0xc(%ebp),%eax
     488:	83 c0 04             	add    $0x4,%eax
     48b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     48e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     495:	e9 59 01 00 00       	jmp    5f3 <printf+0x17b>
    c = fmt[i] & 0xff;
     49a:	8b 55 0c             	mov    0xc(%ebp),%edx
     49d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4a0:	01 d0                	add    %edx,%eax
     4a2:	0f b6 00             	movzbl (%eax),%eax
     4a5:	0f be c0             	movsbl %al,%eax
     4a8:	25 ff 00 00 00       	and    $0xff,%eax
     4ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4b0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4b4:	75 2c                	jne    4e2 <printf+0x6a>
      if(c == '%'){
     4b6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4ba:	75 0c                	jne    4c8 <printf+0x50>
        state = '%';
     4bc:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4c3:	e9 27 01 00 00       	jmp    5ef <printf+0x177>
      } else {
        putc(fd, c);
     4c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4cb:	0f be c0             	movsbl %al,%eax
     4ce:	83 ec 08             	sub    $0x8,%esp
     4d1:	50                   	push   %eax
     4d2:	ff 75 08             	pushl  0x8(%ebp)
     4d5:	e8 c7 fe ff ff       	call   3a1 <putc>
     4da:	83 c4 10             	add    $0x10,%esp
     4dd:	e9 0d 01 00 00       	jmp    5ef <printf+0x177>
      }
    } else if(state == '%'){
     4e2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4e6:	0f 85 03 01 00 00    	jne    5ef <printf+0x177>
      if(c == 'd'){
     4ec:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4f0:	75 1e                	jne    510 <printf+0x98>
        printint(fd, *ap, 10, 1);
     4f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4f5:	8b 00                	mov    (%eax),%eax
     4f7:	6a 01                	push   $0x1
     4f9:	6a 0a                	push   $0xa
     4fb:	50                   	push   %eax
     4fc:	ff 75 08             	pushl  0x8(%ebp)
     4ff:	e8 c0 fe ff ff       	call   3c4 <printint>
     504:	83 c4 10             	add    $0x10,%esp
        ap++;
     507:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     50b:	e9 d8 00 00 00       	jmp    5e8 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     510:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     514:	74 06                	je     51c <printf+0xa4>
     516:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     51a:	75 1e                	jne    53a <printf+0xc2>
        printint(fd, *ap, 16, 0);
     51c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     51f:	8b 00                	mov    (%eax),%eax
     521:	6a 00                	push   $0x0
     523:	6a 10                	push   $0x10
     525:	50                   	push   %eax
     526:	ff 75 08             	pushl  0x8(%ebp)
     529:	e8 96 fe ff ff       	call   3c4 <printint>
     52e:	83 c4 10             	add    $0x10,%esp
        ap++;
     531:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     535:	e9 ae 00 00 00       	jmp    5e8 <printf+0x170>
      } else if(c == 's'){
     53a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     53e:	75 43                	jne    583 <printf+0x10b>
        s = (char*)*ap;
     540:	8b 45 e8             	mov    -0x18(%ebp),%eax
     543:	8b 00                	mov    (%eax),%eax
     545:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     548:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     54c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     550:	75 25                	jne    577 <printf+0xff>
          s = "(null)";
     552:	c7 45 f4 f8 23 00 00 	movl   $0x23f8,-0xc(%ebp)
        while(*s != 0){
     559:	eb 1c                	jmp    577 <printf+0xff>
          putc(fd, *s);
     55b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     55e:	0f b6 00             	movzbl (%eax),%eax
     561:	0f be c0             	movsbl %al,%eax
     564:	83 ec 08             	sub    $0x8,%esp
     567:	50                   	push   %eax
     568:	ff 75 08             	pushl  0x8(%ebp)
     56b:	e8 31 fe ff ff       	call   3a1 <putc>
     570:	83 c4 10             	add    $0x10,%esp
          s++;
     573:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     577:	8b 45 f4             	mov    -0xc(%ebp),%eax
     57a:	0f b6 00             	movzbl (%eax),%eax
     57d:	84 c0                	test   %al,%al
     57f:	75 da                	jne    55b <printf+0xe3>
     581:	eb 65                	jmp    5e8 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     583:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     587:	75 1d                	jne    5a6 <printf+0x12e>
        putc(fd, *ap);
     589:	8b 45 e8             	mov    -0x18(%ebp),%eax
     58c:	8b 00                	mov    (%eax),%eax
     58e:	0f be c0             	movsbl %al,%eax
     591:	83 ec 08             	sub    $0x8,%esp
     594:	50                   	push   %eax
     595:	ff 75 08             	pushl  0x8(%ebp)
     598:	e8 04 fe ff ff       	call   3a1 <putc>
     59d:	83 c4 10             	add    $0x10,%esp
        ap++;
     5a0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5a4:	eb 42                	jmp    5e8 <printf+0x170>
      } else if(c == '%'){
     5a6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5aa:	75 17                	jne    5c3 <printf+0x14b>
        putc(fd, c);
     5ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5af:	0f be c0             	movsbl %al,%eax
     5b2:	83 ec 08             	sub    $0x8,%esp
     5b5:	50                   	push   %eax
     5b6:	ff 75 08             	pushl  0x8(%ebp)
     5b9:	e8 e3 fd ff ff       	call   3a1 <putc>
     5be:	83 c4 10             	add    $0x10,%esp
     5c1:	eb 25                	jmp    5e8 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5c3:	83 ec 08             	sub    $0x8,%esp
     5c6:	6a 25                	push   $0x25
     5c8:	ff 75 08             	pushl  0x8(%ebp)
     5cb:	e8 d1 fd ff ff       	call   3a1 <putc>
     5d0:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5d6:	0f be c0             	movsbl %al,%eax
     5d9:	83 ec 08             	sub    $0x8,%esp
     5dc:	50                   	push   %eax
     5dd:	ff 75 08             	pushl  0x8(%ebp)
     5e0:	e8 bc fd ff ff       	call   3a1 <putc>
     5e5:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5e8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5ef:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5f3:	8b 55 0c             	mov    0xc(%ebp),%edx
     5f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5f9:	01 d0                	add    %edx,%eax
     5fb:	0f b6 00             	movzbl (%eax),%eax
     5fe:	84 c0                	test   %al,%al
     600:	0f 85 94 fe ff ff    	jne    49a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     606:	90                   	nop
     607:	c9                   	leave  
     608:	c3                   	ret    

00000609 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     609:	55                   	push   %ebp
     60a:	89 e5                	mov    %esp,%ebp
     60c:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     60f:	8b 45 08             	mov    0x8(%ebp),%eax
     612:	83 e8 08             	sub    $0x8,%eax
     615:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     618:	a1 60 67 00 00       	mov    0x6760,%eax
     61d:	89 45 fc             	mov    %eax,-0x4(%ebp)
     620:	eb 24                	jmp    646 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     622:	8b 45 fc             	mov    -0x4(%ebp),%eax
     625:	8b 00                	mov    (%eax),%eax
     627:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     62a:	77 12                	ja     63e <free+0x35>
     62c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     62f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     632:	77 24                	ja     658 <free+0x4f>
     634:	8b 45 fc             	mov    -0x4(%ebp),%eax
     637:	8b 00                	mov    (%eax),%eax
     639:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     63c:	77 1a                	ja     658 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     63e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     641:	8b 00                	mov    (%eax),%eax
     643:	89 45 fc             	mov    %eax,-0x4(%ebp)
     646:	8b 45 f8             	mov    -0x8(%ebp),%eax
     649:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     64c:	76 d4                	jbe    622 <free+0x19>
     64e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     651:	8b 00                	mov    (%eax),%eax
     653:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     656:	76 ca                	jbe    622 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     658:	8b 45 f8             	mov    -0x8(%ebp),%eax
     65b:	8b 40 04             	mov    0x4(%eax),%eax
     65e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     665:	8b 45 f8             	mov    -0x8(%ebp),%eax
     668:	01 c2                	add    %eax,%edx
     66a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66d:	8b 00                	mov    (%eax),%eax
     66f:	39 c2                	cmp    %eax,%edx
     671:	75 24                	jne    697 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     673:	8b 45 f8             	mov    -0x8(%ebp),%eax
     676:	8b 50 04             	mov    0x4(%eax),%edx
     679:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67c:	8b 00                	mov    (%eax),%eax
     67e:	8b 40 04             	mov    0x4(%eax),%eax
     681:	01 c2                	add    %eax,%edx
     683:	8b 45 f8             	mov    -0x8(%ebp),%eax
     686:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     689:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68c:	8b 00                	mov    (%eax),%eax
     68e:	8b 10                	mov    (%eax),%edx
     690:	8b 45 f8             	mov    -0x8(%ebp),%eax
     693:	89 10                	mov    %edx,(%eax)
     695:	eb 0a                	jmp    6a1 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     697:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69a:	8b 10                	mov    (%eax),%edx
     69c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     69f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a4:	8b 40 04             	mov    0x4(%eax),%eax
     6a7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b1:	01 d0                	add    %edx,%eax
     6b3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6b6:	75 20                	jne    6d8 <free+0xcf>
    p->s.size += bp->s.size;
     6b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6bb:	8b 50 04             	mov    0x4(%eax),%edx
     6be:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c1:	8b 40 04             	mov    0x4(%eax),%eax
     6c4:	01 c2                	add    %eax,%edx
     6c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c9:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6cf:	8b 10                	mov    (%eax),%edx
     6d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d4:	89 10                	mov    %edx,(%eax)
     6d6:	eb 08                	jmp    6e0 <free+0xd7>
  } else
    p->s.ptr = bp;
     6d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6db:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6de:	89 10                	mov    %edx,(%eax)
  freep = p;
     6e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e3:	a3 60 67 00 00       	mov    %eax,0x6760
}
     6e8:	90                   	nop
     6e9:	c9                   	leave  
     6ea:	c3                   	ret    

000006eb <morecore>:

static Header*
morecore(uint nu)
{
     6eb:	55                   	push   %ebp
     6ec:	89 e5                	mov    %esp,%ebp
     6ee:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6f1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6f8:	77 07                	ja     701 <morecore+0x16>
    nu = 4096;
     6fa:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     701:	8b 45 08             	mov    0x8(%ebp),%eax
     704:	c1 e0 03             	shl    $0x3,%eax
     707:	83 ec 0c             	sub    $0xc,%esp
     70a:	50                   	push   %eax
     70b:	e8 41 fc ff ff       	call   351 <sbrk>
     710:	83 c4 10             	add    $0x10,%esp
     713:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     716:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     71a:	75 07                	jne    723 <morecore+0x38>
    return 0;
     71c:	b8 00 00 00 00       	mov    $0x0,%eax
     721:	eb 26                	jmp    749 <morecore+0x5e>
  hp = (Header*)p;
     723:	8b 45 f4             	mov    -0xc(%ebp),%eax
     726:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     729:	8b 45 f0             	mov    -0x10(%ebp),%eax
     72c:	8b 55 08             	mov    0x8(%ebp),%edx
     72f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     732:	8b 45 f0             	mov    -0x10(%ebp),%eax
     735:	83 c0 08             	add    $0x8,%eax
     738:	83 ec 0c             	sub    $0xc,%esp
     73b:	50                   	push   %eax
     73c:	e8 c8 fe ff ff       	call   609 <free>
     741:	83 c4 10             	add    $0x10,%esp
  return freep;
     744:	a1 60 67 00 00       	mov    0x6760,%eax
}
     749:	c9                   	leave  
     74a:	c3                   	ret    

0000074b <malloc>:

void*
malloc(uint nbytes)
{
     74b:	55                   	push   %ebp
     74c:	89 e5                	mov    %esp,%ebp
     74e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     751:	8b 45 08             	mov    0x8(%ebp),%eax
     754:	83 c0 07             	add    $0x7,%eax
     757:	c1 e8 03             	shr    $0x3,%eax
     75a:	83 c0 01             	add    $0x1,%eax
     75d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     760:	a1 60 67 00 00       	mov    0x6760,%eax
     765:	89 45 f0             	mov    %eax,-0x10(%ebp)
     768:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     76c:	75 23                	jne    791 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     76e:	c7 45 f0 58 67 00 00 	movl   $0x6758,-0x10(%ebp)
     775:	8b 45 f0             	mov    -0x10(%ebp),%eax
     778:	a3 60 67 00 00       	mov    %eax,0x6760
     77d:	a1 60 67 00 00       	mov    0x6760,%eax
     782:	a3 58 67 00 00       	mov    %eax,0x6758
    base.s.size = 0;
     787:	c7 05 5c 67 00 00 00 	movl   $0x0,0x675c
     78e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     791:	8b 45 f0             	mov    -0x10(%ebp),%eax
     794:	8b 00                	mov    (%eax),%eax
     796:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     799:	8b 45 f4             	mov    -0xc(%ebp),%eax
     79c:	8b 40 04             	mov    0x4(%eax),%eax
     79f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7a2:	72 4d                	jb     7f1 <malloc+0xa6>
      if(p->s.size == nunits)
     7a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a7:	8b 40 04             	mov    0x4(%eax),%eax
     7aa:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7ad:	75 0c                	jne    7bb <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7af:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b2:	8b 10                	mov    (%eax),%edx
     7b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7b7:	89 10                	mov    %edx,(%eax)
     7b9:	eb 26                	jmp    7e1 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7be:	8b 40 04             	mov    0x4(%eax),%eax
     7c1:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7c4:	89 c2                	mov    %eax,%edx
     7c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7cf:	8b 40 04             	mov    0x4(%eax),%eax
     7d2:	c1 e0 03             	shl    $0x3,%eax
     7d5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7db:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7de:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e4:	a3 60 67 00 00       	mov    %eax,0x6760
      return (void*)(p + 1);
     7e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ec:	83 c0 08             	add    $0x8,%eax
     7ef:	eb 3b                	jmp    82c <malloc+0xe1>
    }
    if(p == freep)
     7f1:	a1 60 67 00 00       	mov    0x6760,%eax
     7f6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7f9:	75 1e                	jne    819 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7fb:	83 ec 0c             	sub    $0xc,%esp
     7fe:	ff 75 ec             	pushl  -0x14(%ebp)
     801:	e8 e5 fe ff ff       	call   6eb <morecore>
     806:	83 c4 10             	add    $0x10,%esp
     809:	89 45 f4             	mov    %eax,-0xc(%ebp)
     80c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     810:	75 07                	jne    819 <malloc+0xce>
        return 0;
     812:	b8 00 00 00 00       	mov    $0x0,%eax
     817:	eb 13                	jmp    82c <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     819:	8b 45 f4             	mov    -0xc(%ebp),%eax
     81c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     81f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     822:	8b 00                	mov    (%eax),%eax
     824:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     827:	e9 6d ff ff ff       	jmp    799 <malloc+0x4e>
}
     82c:	c9                   	leave  
     82d:	c3                   	ret    

0000082e <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     82e:	55                   	push   %ebp
     82f:	89 e5                	mov    %esp,%ebp
     831:	83 ec 1c             	sub    $0x1c,%esp
     834:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     837:	8b 55 10             	mov    0x10(%ebp),%edx
     83a:	8b 45 14             	mov    0x14(%ebp),%eax
     83d:	88 4d ec             	mov    %cl,-0x14(%ebp)
     840:	88 55 e8             	mov    %dl,-0x18(%ebp)
     843:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     846:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     84a:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     84d:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     851:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     854:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     858:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     85b:	8b 45 08             	mov    0x8(%ebp),%eax
     85e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     862:	66 89 10             	mov    %dx,(%eax)
     865:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     869:	88 50 02             	mov    %dl,0x2(%eax)
}
     86c:	8b 45 08             	mov    0x8(%ebp),%eax
     86f:	c9                   	leave  
     870:	c2 04 00             	ret    $0x4

00000873 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     873:	55                   	push   %ebp
     874:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     876:	8b 45 08             	mov    0x8(%ebp),%eax
     879:	2b 45 10             	sub    0x10(%ebp),%eax
     87c:	89 c2                	mov    %eax,%edx
     87e:	8b 45 08             	mov    0x8(%ebp),%eax
     881:	2b 45 10             	sub    0x10(%ebp),%eax
     884:	0f af d0             	imul   %eax,%edx
     887:	8b 45 0c             	mov    0xc(%ebp),%eax
     88a:	2b 45 14             	sub    0x14(%ebp),%eax
     88d:	89 c1                	mov    %eax,%ecx
     88f:	8b 45 0c             	mov    0xc(%ebp),%eax
     892:	2b 45 14             	sub    0x14(%ebp),%eax
     895:	0f af c1             	imul   %ecx,%eax
     898:	01 d0                	add    %edx,%eax
}
     89a:	5d                   	pop    %ebp
     89b:	c3                   	ret    

0000089c <abs_int>:

static inline int abs_int(int x)
{
     89c:	55                   	push   %ebp
     89d:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     89f:	8b 45 08             	mov    0x8(%ebp),%eax
     8a2:	99                   	cltd   
     8a3:	89 d0                	mov    %edx,%eax
     8a5:	33 45 08             	xor    0x8(%ebp),%eax
     8a8:	29 d0                	sub    %edx,%eax
}
     8aa:	5d                   	pop    %ebp
     8ab:	c3                   	ret    

000008ac <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     8ac:	55                   	push   %ebp
     8ad:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     8af:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8b3:	79 07                	jns    8bc <APGetIndex+0x10>
        return X_SMALLER;
     8b5:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8ba:	eb 40                	jmp    8fc <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8bc:	8b 45 08             	mov    0x8(%ebp),%eax
     8bf:	8b 00                	mov    (%eax),%eax
     8c1:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8c4:	7f 07                	jg     8cd <APGetIndex+0x21>
        return X_BIGGER;
     8c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8cb:	eb 2f                	jmp    8fc <APGetIndex+0x50>
    if (y < 0)
     8cd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8d1:	79 07                	jns    8da <APGetIndex+0x2e>
        return Y_SMALLER;
     8d3:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8d8:	eb 22                	jmp    8fc <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8da:	8b 45 08             	mov    0x8(%ebp),%eax
     8dd:	8b 40 04             	mov    0x4(%eax),%eax
     8e0:	3b 45 10             	cmp    0x10(%ebp),%eax
     8e3:	7f 07                	jg     8ec <APGetIndex+0x40>
        return Y_BIGGER;
     8e5:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8ea:	eb 10                	jmp    8fc <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8ec:	8b 45 08             	mov    0x8(%ebp),%eax
     8ef:	8b 00                	mov    (%eax),%eax
     8f1:	0f af 45 10          	imul   0x10(%ebp),%eax
     8f5:	89 c2                	mov    %eax,%edx
     8f7:	8b 45 0c             	mov    0xc(%ebp),%eax
     8fa:	01 d0                	add    %edx,%eax
}
     8fc:	5d                   	pop    %ebp
     8fd:	c3                   	ret    

000008fe <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     8fe:	55                   	push   %ebp
     8ff:	89 e5                	mov    %esp,%ebp
     901:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     904:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     90b:	8b 45 cc             	mov    -0x34(%ebp),%eax
     90e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     911:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     918:	83 ec 08             	sub    $0x8,%esp
     91b:	6a 00                	push   $0x0
     91d:	ff 75 0c             	pushl  0xc(%ebp)
     920:	e8 e4 f9 ff ff       	call   309 <open>
     925:	83 c4 10             	add    $0x10,%esp
     928:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     92b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     92f:	79 2e                	jns    95f <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     931:	83 ec 04             	sub    $0x4,%esp
     934:	ff 75 0c             	pushl  0xc(%ebp)
     937:	68 ff 23 00 00       	push   $0x23ff
     93c:	6a 01                	push   $0x1
     93e:	e8 35 fb ff ff       	call   478 <printf>
     943:	83 c4 10             	add    $0x10,%esp
        return bmp;
     946:	8b 45 08             	mov    0x8(%ebp),%eax
     949:	8b 55 c8             	mov    -0x38(%ebp),%edx
     94c:	89 10                	mov    %edx,(%eax)
     94e:	8b 55 cc             	mov    -0x34(%ebp),%edx
     951:	89 50 04             	mov    %edx,0x4(%eax)
     954:	8b 55 d0             	mov    -0x30(%ebp),%edx
     957:	89 50 08             	mov    %edx,0x8(%eax)
     95a:	e9 d2 01 00 00       	jmp    b31 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     95f:	83 ec 04             	sub    $0x4,%esp
     962:	6a 0e                	push   $0xe
     964:	8d 45 ba             	lea    -0x46(%ebp),%eax
     967:	50                   	push   %eax
     968:	ff 75 ec             	pushl  -0x14(%ebp)
     96b:	e8 71 f9 ff ff       	call   2e1 <read>
     970:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     973:	83 ec 04             	sub    $0x4,%esp
     976:	6a 28                	push   $0x28
     978:	8d 45 92             	lea    -0x6e(%ebp),%eax
     97b:	50                   	push   %eax
     97c:	ff 75 ec             	pushl  -0x14(%ebp)
     97f:	e8 5d f9 ff ff       	call   2e1 <read>
     984:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     987:	8b 45 96             	mov    -0x6a(%ebp),%eax
     98a:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     98d:	8b 45 9a             	mov    -0x66(%ebp),%eax
     990:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     993:	8b 55 c8             	mov    -0x38(%ebp),%edx
     996:	8b 45 cc             	mov    -0x34(%ebp),%eax
     999:	0f af d0             	imul   %eax,%edx
     99c:	89 d0                	mov    %edx,%eax
     99e:	01 c0                	add    %eax,%eax
     9a0:	01 d0                	add    %edx,%eax
     9a2:	83 ec 0c             	sub    $0xc,%esp
     9a5:	50                   	push   %eax
     9a6:	e8 a0 fd ff ff       	call   74b <malloc>
     9ab:	83 c4 10             	add    $0x10,%esp
     9ae:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9b1:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9b5:	0f b7 c0             	movzwl %ax,%eax
     9b8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9bb:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9be:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9c1:	0f af c2             	imul   %edx,%eax
     9c4:	83 c0 1f             	add    $0x1f,%eax
     9c7:	c1 e8 05             	shr    $0x5,%eax
     9ca:	c1 e0 02             	shl    $0x2,%eax
     9cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9d0:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9d6:	0f af c2             	imul   %edx,%eax
     9d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9dc:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9df:	83 ec 0c             	sub    $0xc,%esp
     9e2:	50                   	push   %eax
     9e3:	e8 63 fd ff ff       	call   74b <malloc>
     9e8:	83 c4 10             	add    $0x10,%esp
     9eb:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9ee:	83 ec 04             	sub    $0x4,%esp
     9f1:	ff 75 e0             	pushl  -0x20(%ebp)
     9f4:	ff 75 dc             	pushl  -0x24(%ebp)
     9f7:	ff 75 ec             	pushl  -0x14(%ebp)
     9fa:	e8 e2 f8 ff ff       	call   2e1 <read>
     9ff:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a02:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a06:	66 c1 e8 03          	shr    $0x3,%ax
     a0a:	0f b7 c0             	movzwl %ax,%eax
     a0d:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a10:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a17:	e9 e5 00 00 00       	jmp    b01 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a1c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a22:	29 c2                	sub    %eax,%edx
     a24:	89 d0                	mov    %edx,%eax
     a26:	8d 50 ff             	lea    -0x1(%eax),%edx
     a29:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a2c:	0f af c2             	imul   %edx,%eax
     a2f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a32:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a39:	e9 b1 00 00 00       	jmp    aef <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a3e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a41:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a44:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a47:	01 c8                	add    %ecx,%eax
     a49:	89 c1                	mov    %eax,%ecx
     a4b:	89 c8                	mov    %ecx,%eax
     a4d:	01 c0                	add    %eax,%eax
     a4f:	01 c8                	add    %ecx,%eax
     a51:	01 c2                	add    %eax,%edx
     a53:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a56:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a5a:	89 c1                	mov    %eax,%ecx
     a5c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a5f:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a63:	01 c1                	add    %eax,%ecx
     a65:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a68:	01 c8                	add    %ecx,%eax
     a6a:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a6d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a70:	01 c8                	add    %ecx,%eax
     a72:	0f b6 00             	movzbl (%eax),%eax
     a75:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a78:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a7b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a81:	01 c8                	add    %ecx,%eax
     a83:	89 c1                	mov    %eax,%ecx
     a85:	89 c8                	mov    %ecx,%eax
     a87:	01 c0                	add    %eax,%eax
     a89:	01 c8                	add    %ecx,%eax
     a8b:	01 c2                	add    %eax,%edx
     a8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a90:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a94:	89 c1                	mov    %eax,%ecx
     a96:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a99:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a9d:	01 c1                	add    %eax,%ecx
     a9f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aa2:	01 c8                	add    %ecx,%eax
     aa4:	8d 48 fe             	lea    -0x2(%eax),%ecx
     aa7:	8b 45 dc             	mov    -0x24(%ebp),%eax
     aaa:	01 c8                	add    %ecx,%eax
     aac:	0f b6 00             	movzbl (%eax),%eax
     aaf:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     ab2:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ab5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ab8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     abb:	01 c8                	add    %ecx,%eax
     abd:	89 c1                	mov    %eax,%ecx
     abf:	89 c8                	mov    %ecx,%eax
     ac1:	01 c0                	add    %eax,%eax
     ac3:	01 c8                	add    %ecx,%eax
     ac5:	01 c2                	add    %eax,%edx
     ac7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aca:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ace:	89 c1                	mov    %eax,%ecx
     ad0:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ad3:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ad7:	01 c1                	add    %eax,%ecx
     ad9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     adc:	01 c8                	add    %ecx,%eax
     ade:	8d 48 fd             	lea    -0x3(%eax),%ecx
     ae1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ae4:	01 c8                	add    %ecx,%eax
     ae6:	0f b6 00             	movzbl (%eax),%eax
     ae9:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     aeb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     aef:	8b 55 c8             	mov    -0x38(%ebp),%edx
     af2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     af5:	39 c2                	cmp    %eax,%edx
     af7:	0f 87 41 ff ff ff    	ja     a3e <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     afd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b01:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b04:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b07:	39 c2                	cmp    %eax,%edx
     b09:	0f 87 0d ff ff ff    	ja     a1c <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b0f:	83 ec 0c             	sub    $0xc,%esp
     b12:	ff 75 ec             	pushl  -0x14(%ebp)
     b15:	e8 d7 f7 ff ff       	call   2f1 <close>
     b1a:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b1d:	8b 45 08             	mov    0x8(%ebp),%eax
     b20:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b23:	89 10                	mov    %edx,(%eax)
     b25:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b28:	89 50 04             	mov    %edx,0x4(%eax)
     b2b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b2e:	89 50 08             	mov    %edx,0x8(%eax)
}
     b31:	8b 45 08             	mov    0x8(%ebp),%eax
     b34:	c9                   	leave  
     b35:	c2 04 00             	ret    $0x4

00000b38 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b38:	55                   	push   %ebp
     b39:	89 e5                	mov    %esp,%ebp
     b3b:	53                   	push   %ebx
     b3c:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b3f:	83 ec 0c             	sub    $0xc,%esp
     b42:	6a 1c                	push   $0x1c
     b44:	e8 02 fc ff ff       	call   74b <malloc>
     b49:	83 c4 10             	add    $0x10,%esp
     b4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b52:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b59:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b5c:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b5f:	6a 0c                	push   $0xc
     b61:	6a 0c                	push   $0xc
     b63:	6a 0c                	push   $0xc
     b65:	50                   	push   %eax
     b66:	e8 c3 fc ff ff       	call   82e <RGB>
     b6b:	83 c4 0c             	add    $0xc,%esp
     b6e:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b72:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b76:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b7a:	88 43 15             	mov    %al,0x15(%ebx)
     b7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b80:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b83:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b87:	66 89 48 10          	mov    %cx,0x10(%eax)
     b8b:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b8f:	88 50 12             	mov    %dl,0x12(%eax)
     b92:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b95:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b98:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     b9c:	66 89 48 08          	mov    %cx,0x8(%eax)
     ba0:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     ba4:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     ba7:	8b 45 08             	mov    0x8(%ebp),%eax
     baa:	89 c2                	mov    %eax,%edx
     bac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     baf:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     bb1:	8b 45 0c             	mov    0xc(%ebp),%eax
     bb4:	89 c2                	mov    %eax,%edx
     bb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb9:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bbc:	8b 55 10             	mov    0x10(%ebp),%edx
     bbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc2:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     bc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bc8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bcb:	c9                   	leave  
     bcc:	c3                   	ret    

00000bcd <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     bcd:	55                   	push   %ebp
     bce:	89 e5                	mov    %esp,%ebp
     bd0:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     bd3:	8b 45 0c             	mov    0xc(%ebp),%eax
     bd6:	8b 50 08             	mov    0x8(%eax),%edx
     bd9:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bdc:	8b 40 0c             	mov    0xc(%eax),%eax
     bdf:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     be2:	8b 45 0c             	mov    0xc(%ebp),%eax
     be5:	8b 55 10             	mov    0x10(%ebp),%edx
     be8:	89 50 08             	mov    %edx,0x8(%eax)
     beb:	8b 55 14             	mov    0x14(%ebp),%edx
     bee:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     bf1:	8b 45 08             	mov    0x8(%ebp),%eax
     bf4:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bf7:	89 10                	mov    %edx,(%eax)
     bf9:	8b 55 fc             	mov    -0x4(%ebp),%edx
     bfc:	89 50 04             	mov    %edx,0x4(%eax)
}
     bff:	8b 45 08             	mov    0x8(%ebp),%eax
     c02:	c9                   	leave  
     c03:	c2 04 00             	ret    $0x4

00000c06 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c06:	55                   	push   %ebp
     c07:	89 e5                	mov    %esp,%ebp
     c09:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c0c:	8b 45 0c             	mov    0xc(%ebp),%eax
     c0f:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c13:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c17:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c1b:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c1e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c21:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c25:	66 89 50 10          	mov    %dx,0x10(%eax)
     c29:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c2d:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c30:	8b 45 08             	mov    0x8(%ebp),%eax
     c33:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c37:	66 89 10             	mov    %dx,(%eax)
     c3a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c3e:	88 50 02             	mov    %dl,0x2(%eax)
}
     c41:	8b 45 08             	mov    0x8(%ebp),%eax
     c44:	c9                   	leave  
     c45:	c2 04 00             	ret    $0x4

00000c48 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     c48:	55                   	push   %ebp
     c49:	89 e5                	mov    %esp,%ebp
     c4b:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     c4e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c51:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     c55:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c59:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     c5d:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     c60:	8b 45 0c             	mov    0xc(%ebp),%eax
     c63:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c67:	66 89 50 13          	mov    %dx,0x13(%eax)
     c6b:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c6f:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     c72:	8b 45 08             	mov    0x8(%ebp),%eax
     c75:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c79:	66 89 10             	mov    %dx,(%eax)
     c7c:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c80:	88 50 02             	mov    %dl,0x2(%eax)
}
     c83:	8b 45 08             	mov    0x8(%ebp),%eax
     c86:	c9                   	leave  
     c87:	c2 04 00             	ret    $0x4

00000c8a <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c8a:	55                   	push   %ebp
     c8b:	89 e5                	mov    %esp,%ebp
     c8d:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c90:	8b 45 08             	mov    0x8(%ebp),%eax
     c93:	8b 40 0c             	mov    0xc(%eax),%eax
     c96:	89 c2                	mov    %eax,%edx
     c98:	c1 ea 1f             	shr    $0x1f,%edx
     c9b:	01 d0                	add    %edx,%eax
     c9d:	d1 f8                	sar    %eax
     c9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     ca2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca5:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     ca9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     cac:	8b 45 10             	mov    0x10(%ebp),%eax
     caf:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cb2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     cb5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     cb9:	0f 89 98 00 00 00    	jns    d57 <APDrawPoint+0xcd>
        i = 0;
     cbf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     cc6:	e9 8c 00 00 00       	jmp    d57 <APDrawPoint+0xcd>
    {
        j = x - off;
     ccb:	8b 45 0c             	mov    0xc(%ebp),%eax
     cce:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cd1:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     cd4:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     cd8:	79 69                	jns    d43 <APDrawPoint+0xb9>
            j = 0;
     cda:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     ce1:	eb 60                	jmp    d43 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     ce3:	ff 75 fc             	pushl  -0x4(%ebp)
     ce6:	ff 75 f8             	pushl  -0x8(%ebp)
     ce9:	ff 75 08             	pushl  0x8(%ebp)
     cec:	e8 bb fb ff ff       	call   8ac <APGetIndex>
     cf1:	83 c4 0c             	add    $0xc,%esp
     cf4:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     cf7:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cfb:	74 55                	je     d52 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cfd:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d01:	74 67                	je     d6a <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d03:	ff 75 10             	pushl  0x10(%ebp)
     d06:	ff 75 0c             	pushl  0xc(%ebp)
     d09:	ff 75 fc             	pushl  -0x4(%ebp)
     d0c:	ff 75 f8             	pushl  -0x8(%ebp)
     d0f:	e8 5f fb ff ff       	call   873 <distance_2>
     d14:	83 c4 10             	add    $0x10,%esp
     d17:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d1a:	7f 23                	jg     d3f <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d1c:	8b 45 08             	mov    0x8(%ebp),%eax
     d1f:	8b 48 18             	mov    0x18(%eax),%ecx
     d22:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d25:	89 d0                	mov    %edx,%eax
     d27:	01 c0                	add    %eax,%eax
     d29:	01 d0                	add    %edx,%eax
     d2b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d2e:	8b 45 08             	mov    0x8(%ebp),%eax
     d31:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d35:	66 89 0a             	mov    %cx,(%edx)
     d38:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d3c:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d3f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d43:	8b 55 0c             	mov    0xc(%ebp),%edx
     d46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d49:	01 d0                	add    %edx,%eax
     d4b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d4e:	7d 93                	jge    ce3 <APDrawPoint+0x59>
     d50:	eb 01                	jmp    d53 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d52:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d53:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d57:	8b 55 10             	mov    0x10(%ebp),%edx
     d5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d5d:	01 d0                	add    %edx,%eax
     d5f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d62:	0f 8d 63 ff ff ff    	jge    ccb <APDrawPoint+0x41>
     d68:	eb 01                	jmp    d6b <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d6a:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d6b:	c9                   	leave  
     d6c:	c3                   	ret    

00000d6d <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d6d:	55                   	push   %ebp
     d6e:	89 e5                	mov    %esp,%ebp
     d70:	53                   	push   %ebx
     d71:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d74:	8b 45 0c             	mov    0xc(%ebp),%eax
     d77:	3b 45 14             	cmp    0x14(%ebp),%eax
     d7a:	0f 85 80 00 00 00    	jne    e00 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d80:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d84:	0f 88 9d 02 00 00    	js     1027 <APDrawLine+0x2ba>
     d8a:	8b 45 08             	mov    0x8(%ebp),%eax
     d8d:	8b 00                	mov    (%eax),%eax
     d8f:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d92:	0f 8e 8f 02 00 00    	jle    1027 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d98:	8b 45 10             	mov    0x10(%ebp),%eax
     d9b:	3b 45 18             	cmp    0x18(%ebp),%eax
     d9e:	7e 12                	jle    db2 <APDrawLine+0x45>
        {
            int tmp = y2;
     da0:	8b 45 18             	mov    0x18(%ebp),%eax
     da3:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     da6:	8b 45 10             	mov    0x10(%ebp),%eax
     da9:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     dac:	8b 45 dc             	mov    -0x24(%ebp),%eax
     daf:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     db2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     db6:	79 07                	jns    dbf <APDrawLine+0x52>
     db8:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     dbf:	8b 45 08             	mov    0x8(%ebp),%eax
     dc2:	8b 40 04             	mov    0x4(%eax),%eax
     dc5:	3b 45 18             	cmp    0x18(%ebp),%eax
     dc8:	7d 0c                	jge    dd6 <APDrawLine+0x69>
     dca:	8b 45 08             	mov    0x8(%ebp),%eax
     dcd:	8b 40 04             	mov    0x4(%eax),%eax
     dd0:	83 e8 01             	sub    $0x1,%eax
     dd3:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     dd6:	8b 45 10             	mov    0x10(%ebp),%eax
     dd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ddc:	eb 15                	jmp    df3 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     dde:	ff 75 f4             	pushl  -0xc(%ebp)
     de1:	ff 75 0c             	pushl  0xc(%ebp)
     de4:	ff 75 08             	pushl  0x8(%ebp)
     de7:	e8 9e fe ff ff       	call   c8a <APDrawPoint>
     dec:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     def:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     df3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df6:	3b 45 18             	cmp    0x18(%ebp),%eax
     df9:	7e e3                	jle    dde <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     dfb:	e9 2b 02 00 00       	jmp    102b <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e00:	8b 45 10             	mov    0x10(%ebp),%eax
     e03:	3b 45 18             	cmp    0x18(%ebp),%eax
     e06:	75 7f                	jne    e87 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e08:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e0c:	0f 88 18 02 00 00    	js     102a <APDrawLine+0x2bd>
     e12:	8b 45 08             	mov    0x8(%ebp),%eax
     e15:	8b 40 04             	mov    0x4(%eax),%eax
     e18:	3b 45 10             	cmp    0x10(%ebp),%eax
     e1b:	0f 8e 09 02 00 00    	jle    102a <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e21:	8b 45 0c             	mov    0xc(%ebp),%eax
     e24:	3b 45 14             	cmp    0x14(%ebp),%eax
     e27:	7e 12                	jle    e3b <APDrawLine+0xce>
        {
            int tmp = x2;
     e29:	8b 45 14             	mov    0x14(%ebp),%eax
     e2c:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e2f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e32:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e35:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e38:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e3b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e3f:	79 07                	jns    e48 <APDrawLine+0xdb>
     e41:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e48:	8b 45 08             	mov    0x8(%ebp),%eax
     e4b:	8b 00                	mov    (%eax),%eax
     e4d:	3b 45 14             	cmp    0x14(%ebp),%eax
     e50:	7d 0b                	jge    e5d <APDrawLine+0xf0>
     e52:	8b 45 08             	mov    0x8(%ebp),%eax
     e55:	8b 00                	mov    (%eax),%eax
     e57:	83 e8 01             	sub    $0x1,%eax
     e5a:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e5d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e60:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e63:	eb 15                	jmp    e7a <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e65:	ff 75 10             	pushl  0x10(%ebp)
     e68:	ff 75 f0             	pushl  -0x10(%ebp)
     e6b:	ff 75 08             	pushl  0x8(%ebp)
     e6e:	e8 17 fe ff ff       	call   c8a <APDrawPoint>
     e73:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e76:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e7d:	3b 45 14             	cmp    0x14(%ebp),%eax
     e80:	7e e3                	jle    e65 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e82:	e9 a4 01 00 00       	jmp    102b <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e87:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e8e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e95:	8b 45 0c             	mov    0xc(%ebp),%eax
     e98:	2b 45 14             	sub    0x14(%ebp),%eax
     e9b:	50                   	push   %eax
     e9c:	e8 fb f9 ff ff       	call   89c <abs_int>
     ea1:	83 c4 04             	add    $0x4,%esp
     ea4:	89 c3                	mov    %eax,%ebx
     ea6:	8b 45 10             	mov    0x10(%ebp),%eax
     ea9:	2b 45 18             	sub    0x18(%ebp),%eax
     eac:	50                   	push   %eax
     ead:	e8 ea f9 ff ff       	call   89c <abs_int>
     eb2:	83 c4 04             	add    $0x4,%esp
     eb5:	39 c3                	cmp    %eax,%ebx
     eb7:	0f 8e b5 00 00 00    	jle    f72 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     ebd:	8b 45 10             	mov    0x10(%ebp),%eax
     ec0:	2b 45 18             	sub    0x18(%ebp),%eax
     ec3:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ec6:	db 45 b0             	fildl  -0x50(%ebp)
     ec9:	8b 45 0c             	mov    0xc(%ebp),%eax
     ecc:	2b 45 14             	sub    0x14(%ebp),%eax
     ecf:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ed2:	db 45 b0             	fildl  -0x50(%ebp)
     ed5:	de f9                	fdivrp %st,%st(1)
     ed7:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     eda:	8b 45 14             	mov    0x14(%ebp),%eax
     edd:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ee0:	7e 0e                	jle    ef0 <APDrawLine+0x183>
        {
            s = x1;
     ee2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ee5:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     ee8:	8b 45 14             	mov    0x14(%ebp),%eax
     eeb:	89 45 e8             	mov    %eax,-0x18(%ebp)
     eee:	eb 0c                	jmp    efc <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ef0:	8b 45 14             	mov    0x14(%ebp),%eax
     ef3:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     ef6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef9:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     efc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f00:	79 07                	jns    f09 <APDrawLine+0x19c>
     f02:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f09:	8b 45 08             	mov    0x8(%ebp),%eax
     f0c:	8b 00                	mov    (%eax),%eax
     f0e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f11:	7f 0b                	jg     f1e <APDrawLine+0x1b1>
     f13:	8b 45 08             	mov    0x8(%ebp),%eax
     f16:	8b 00                	mov    (%eax),%eax
     f18:	83 e8 01             	sub    $0x1,%eax
     f1b:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f21:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f24:	eb 3f                	jmp    f65 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f29:	2b 45 0c             	sub    0xc(%ebp),%eax
     f2c:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f2f:	db 45 b0             	fildl  -0x50(%ebp)
     f32:	dc 4d d0             	fmull  -0x30(%ebp)
     f35:	db 45 10             	fildl  0x10(%ebp)
     f38:	de c1                	faddp  %st,%st(1)
     f3a:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f3d:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f41:	b4 0c                	mov    $0xc,%ah
     f43:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f47:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f4a:	db 5d cc             	fistpl -0x34(%ebp)
     f4d:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f50:	ff 75 cc             	pushl  -0x34(%ebp)
     f53:	ff 75 e4             	pushl  -0x1c(%ebp)
     f56:	ff 75 08             	pushl  0x8(%ebp)
     f59:	e8 2c fd ff ff       	call   c8a <APDrawPoint>
     f5e:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f61:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f65:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f68:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f6b:	7e b9                	jle    f26 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f6d:	e9 b9 00 00 00       	jmp    102b <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f72:	8b 45 0c             	mov    0xc(%ebp),%eax
     f75:	2b 45 14             	sub    0x14(%ebp),%eax
     f78:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f7b:	db 45 b0             	fildl  -0x50(%ebp)
     f7e:	8b 45 10             	mov    0x10(%ebp),%eax
     f81:	2b 45 18             	sub    0x18(%ebp),%eax
     f84:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f87:	db 45 b0             	fildl  -0x50(%ebp)
     f8a:	de f9                	fdivrp %st,%st(1)
     f8c:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f8f:	8b 45 10             	mov    0x10(%ebp),%eax
     f92:	3b 45 18             	cmp    0x18(%ebp),%eax
     f95:	7e 0e                	jle    fa5 <APDrawLine+0x238>
    {
        s = y2;
     f97:	8b 45 18             	mov    0x18(%ebp),%eax
     f9a:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f9d:	8b 45 10             	mov    0x10(%ebp),%eax
     fa0:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fa3:	eb 0c                	jmp    fb1 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     fa5:	8b 45 10             	mov    0x10(%ebp),%eax
     fa8:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     fab:	8b 45 18             	mov    0x18(%ebp),%eax
     fae:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     fb1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fb5:	79 07                	jns    fbe <APDrawLine+0x251>
     fb7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     fbe:	8b 45 08             	mov    0x8(%ebp),%eax
     fc1:	8b 40 04             	mov    0x4(%eax),%eax
     fc4:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fc7:	7f 0c                	jg     fd5 <APDrawLine+0x268>
     fc9:	8b 45 08             	mov    0x8(%ebp),%eax
     fcc:	8b 40 04             	mov    0x4(%eax),%eax
     fcf:	83 e8 01             	sub    $0x1,%eax
     fd2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     fd5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fd8:	89 45 e0             	mov    %eax,-0x20(%ebp)
     fdb:	eb 3f                	jmp    101c <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     fdd:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fe0:	2b 45 10             	sub    0x10(%ebp),%eax
     fe3:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fe6:	db 45 b0             	fildl  -0x50(%ebp)
     fe9:	dc 4d c0             	fmull  -0x40(%ebp)
     fec:	db 45 0c             	fildl  0xc(%ebp)
     fef:	de c1                	faddp  %st,%st(1)
     ff1:	d9 7d b6             	fnstcw -0x4a(%ebp)
     ff4:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     ff8:	b4 0c                	mov    $0xc,%ah
     ffa:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     ffe:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1001:	db 5d bc             	fistpl -0x44(%ebp)
    1004:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1007:	ff 75 e0             	pushl  -0x20(%ebp)
    100a:	ff 75 bc             	pushl  -0x44(%ebp)
    100d:	ff 75 08             	pushl  0x8(%ebp)
    1010:	e8 75 fc ff ff       	call   c8a <APDrawPoint>
    1015:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1018:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    101c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    101f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1022:	7e b9                	jle    fdd <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1024:	90                   	nop
    1025:	eb 04                	jmp    102b <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1027:	90                   	nop
    1028:	eb 01                	jmp    102b <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    102a:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    102b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    102e:	c9                   	leave  
    102f:	c3                   	ret    

00001030 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	53                   	push   %ebx
    1034:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1037:	8b 55 10             	mov    0x10(%ebp),%edx
    103a:	8b 45 18             	mov    0x18(%ebp),%eax
    103d:	01 d0                	add    %edx,%eax
    103f:	83 e8 01             	sub    $0x1,%eax
    1042:	83 ec 04             	sub    $0x4,%esp
    1045:	50                   	push   %eax
    1046:	ff 75 0c             	pushl  0xc(%ebp)
    1049:	ff 75 10             	pushl  0x10(%ebp)
    104c:	ff 75 0c             	pushl  0xc(%ebp)
    104f:	ff 75 08             	pushl  0x8(%ebp)
    1052:	e8 16 fd ff ff       	call   d6d <APDrawLine>
    1057:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    105a:	8b 55 0c             	mov    0xc(%ebp),%edx
    105d:	8b 45 14             	mov    0x14(%ebp),%eax
    1060:	01 d0                	add    %edx,%eax
    1062:	83 e8 01             	sub    $0x1,%eax
    1065:	83 ec 04             	sub    $0x4,%esp
    1068:	ff 75 10             	pushl  0x10(%ebp)
    106b:	50                   	push   %eax
    106c:	ff 75 10             	pushl  0x10(%ebp)
    106f:	ff 75 0c             	pushl  0xc(%ebp)
    1072:	ff 75 08             	pushl  0x8(%ebp)
    1075:	e8 f3 fc ff ff       	call   d6d <APDrawLine>
    107a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    107d:	8b 55 10             	mov    0x10(%ebp),%edx
    1080:	8b 45 18             	mov    0x18(%ebp),%eax
    1083:	01 d0                	add    %edx,%eax
    1085:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1088:	8b 55 0c             	mov    0xc(%ebp),%edx
    108b:	8b 45 14             	mov    0x14(%ebp),%eax
    108e:	01 d0                	add    %edx,%eax
    1090:	8d 50 ff             	lea    -0x1(%eax),%edx
    1093:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1096:	8b 45 14             	mov    0x14(%ebp),%eax
    1099:	01 d8                	add    %ebx,%eax
    109b:	83 e8 01             	sub    $0x1,%eax
    109e:	83 ec 04             	sub    $0x4,%esp
    10a1:	51                   	push   %ecx
    10a2:	52                   	push   %edx
    10a3:	ff 75 10             	pushl  0x10(%ebp)
    10a6:	50                   	push   %eax
    10a7:	ff 75 08             	pushl  0x8(%ebp)
    10aa:	e8 be fc ff ff       	call   d6d <APDrawLine>
    10af:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10b2:	8b 55 10             	mov    0x10(%ebp),%edx
    10b5:	8b 45 18             	mov    0x18(%ebp),%eax
    10b8:	01 d0                	add    %edx,%eax
    10ba:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10bd:	8b 55 0c             	mov    0xc(%ebp),%edx
    10c0:	8b 45 14             	mov    0x14(%ebp),%eax
    10c3:	01 d0                	add    %edx,%eax
    10c5:	8d 50 ff             	lea    -0x1(%eax),%edx
    10c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    10cb:	8b 45 18             	mov    0x18(%ebp),%eax
    10ce:	01 d8                	add    %ebx,%eax
    10d0:	83 e8 01             	sub    $0x1,%eax
    10d3:	83 ec 04             	sub    $0x4,%esp
    10d6:	51                   	push   %ecx
    10d7:	52                   	push   %edx
    10d8:	50                   	push   %eax
    10d9:	ff 75 0c             	pushl  0xc(%ebp)
    10dc:	ff 75 08             	pushl  0x8(%ebp)
    10df:	e8 89 fc ff ff       	call   d6d <APDrawLine>
    10e4:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10e7:	8b 55 0c             	mov    0xc(%ebp),%edx
    10ea:	8b 45 14             	mov    0x14(%ebp),%eax
    10ed:	01 d0                	add    %edx,%eax
    10ef:	8d 50 ff             	lea    -0x1(%eax),%edx
    10f2:	8b 45 08             	mov    0x8(%ebp),%eax
    10f5:	8b 40 0c             	mov    0xc(%eax),%eax
    10f8:	89 c1                	mov    %eax,%ecx
    10fa:	c1 e9 1f             	shr    $0x1f,%ecx
    10fd:	01 c8                	add    %ecx,%eax
    10ff:	d1 f8                	sar    %eax
    1101:	29 c2                	sub    %eax,%edx
    1103:	89 d0                	mov    %edx,%eax
    1105:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1108:	8b 55 10             	mov    0x10(%ebp),%edx
    110b:	8b 45 18             	mov    0x18(%ebp),%eax
    110e:	01 d0                	add    %edx,%eax
    1110:	8d 50 ff             	lea    -0x1(%eax),%edx
    1113:	8b 45 08             	mov    0x8(%ebp),%eax
    1116:	8b 40 0c             	mov    0xc(%eax),%eax
    1119:	89 c1                	mov    %eax,%ecx
    111b:	c1 e9 1f             	shr    $0x1f,%ecx
    111e:	01 c8                	add    %ecx,%eax
    1120:	d1 f8                	sar    %eax
    1122:	29 c2                	sub    %eax,%edx
    1124:	89 d0                	mov    %edx,%eax
    1126:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1129:	8b 45 08             	mov    0x8(%ebp),%eax
    112c:	8b 40 0c             	mov    0xc(%eax),%eax
    112f:	89 c2                	mov    %eax,%edx
    1131:	c1 ea 1f             	shr    $0x1f,%edx
    1134:	01 d0                	add    %edx,%eax
    1136:	d1 f8                	sar    %eax
    1138:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    113b:	8b 45 08             	mov    0x8(%ebp),%eax
    113e:	8b 40 0c             	mov    0xc(%eax),%eax
    1141:	89 c2                	mov    %eax,%edx
    1143:	c1 ea 1f             	shr    $0x1f,%edx
    1146:	01 d0                	add    %edx,%eax
    1148:	d1 f8                	sar    %eax
    114a:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    114d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1151:	0f 88 d8 00 00 00    	js     122f <APDrawRect+0x1ff>
    1157:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    115b:	0f 88 ce 00 00 00    	js     122f <APDrawRect+0x1ff>
    1161:	8b 45 08             	mov    0x8(%ebp),%eax
    1164:	8b 00                	mov    (%eax),%eax
    1166:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1169:	0f 8e c0 00 00 00    	jle    122f <APDrawRect+0x1ff>
    116f:	8b 45 08             	mov    0x8(%ebp),%eax
    1172:	8b 40 04             	mov    0x4(%eax),%eax
    1175:	3b 45 10             	cmp    0x10(%ebp),%eax
    1178:	0f 8e b1 00 00 00    	jle    122f <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    117e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1182:	79 07                	jns    118b <APDrawRect+0x15b>
    1184:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    118b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    118f:	79 07                	jns    1198 <APDrawRect+0x168>
    1191:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1198:	8b 45 08             	mov    0x8(%ebp),%eax
    119b:	8b 00                	mov    (%eax),%eax
    119d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11a0:	7f 0b                	jg     11ad <APDrawRect+0x17d>
    11a2:	8b 45 08             	mov    0x8(%ebp),%eax
    11a5:	8b 00                	mov    (%eax),%eax
    11a7:	83 e8 01             	sub    $0x1,%eax
    11aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    11ad:	8b 45 08             	mov    0x8(%ebp),%eax
    11b0:	8b 40 04             	mov    0x4(%eax),%eax
    11b3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11b6:	7f 0c                	jg     11c4 <APDrawRect+0x194>
    11b8:	8b 45 08             	mov    0x8(%ebp),%eax
    11bb:	8b 40 04             	mov    0x4(%eax),%eax
    11be:	83 e8 01             	sub    $0x1,%eax
    11c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    11c4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11cb:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ce:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11d1:	eb 52                	jmp    1225 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    11d3:	8b 45 10             	mov    0x10(%ebp),%eax
    11d6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11d9:	eb 3e                	jmp    1219 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    11db:	83 ec 04             	sub    $0x4,%esp
    11de:	ff 75 e8             	pushl  -0x18(%ebp)
    11e1:	ff 75 ec             	pushl  -0x14(%ebp)
    11e4:	ff 75 08             	pushl  0x8(%ebp)
    11e7:	e8 c0 f6 ff ff       	call   8ac <APGetIndex>
    11ec:	83 c4 10             	add    $0x10,%esp
    11ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11f2:	8b 45 08             	mov    0x8(%ebp),%eax
    11f5:	8b 48 18             	mov    0x18(%eax),%ecx
    11f8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11fb:	89 d0                	mov    %edx,%eax
    11fd:	01 c0                	add    %eax,%eax
    11ff:	01 d0                	add    %edx,%eax
    1201:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1204:	8b 45 08             	mov    0x8(%ebp),%eax
    1207:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    120b:	66 89 0a             	mov    %cx,(%edx)
    120e:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1212:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1215:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1219:	8b 45 e8             	mov    -0x18(%ebp),%eax
    121c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    121f:	7e ba                	jle    11db <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1221:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1225:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1228:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    122b:	7e a6                	jle    11d3 <APDrawRect+0x1a3>
    122d:	eb 01                	jmp    1230 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    122f:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1230:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1233:	c9                   	leave  
    1234:	c3                   	ret    

00001235 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1235:	55                   	push   %ebp
    1236:	89 e5                	mov    %esp,%ebp
    1238:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    123b:	83 ec 0c             	sub    $0xc,%esp
    123e:	ff 75 0c             	pushl  0xc(%ebp)
    1241:	e8 c1 ee ff ff       	call   107 <strlen>
    1246:	83 c4 10             	add    $0x10,%esp
    1249:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    124c:	8b 45 08             	mov    0x8(%ebp),%eax
    124f:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1253:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1257:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    125b:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    125e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1265:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    126c:	e9 bc 00 00 00       	jmp    132d <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1271:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1274:	8b 45 0c             	mov    0xc(%ebp),%eax
    1277:	01 d0                	add    %edx,%eax
    1279:	0f b6 00             	movzbl (%eax),%eax
    127c:	0f be c0             	movsbl %al,%eax
    127f:	83 e8 20             	sub    $0x20,%eax
    1282:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1285:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1289:	0f 87 9a 00 00 00    	ja     1329 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    128f:	8b 45 08             	mov    0x8(%ebp),%eax
    1292:	8b 00                	mov    (%eax),%eax
    1294:	0f af 45 14          	imul   0x14(%ebp),%eax
    1298:	89 c2                	mov    %eax,%edx
    129a:	8b 45 10             	mov    0x10(%ebp),%eax
    129d:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    12a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12a3:	89 d0                	mov    %edx,%eax
    12a5:	c1 e0 03             	shl    $0x3,%eax
    12a8:	01 d0                	add    %edx,%eax
    12aa:	01 c8                	add    %ecx,%eax
    12ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    12af:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    12b6:	eb 6b                	jmp    1323 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    12b8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    12bf:	eb 50                	jmp    1311 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    12c1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    12c4:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12c7:	89 d0                	mov    %edx,%eax
    12c9:	c1 e0 03             	shl    $0x3,%eax
    12cc:	01 d0                	add    %edx,%eax
    12ce:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    12d4:	01 c2                	add    %eax,%edx
    12d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12d9:	01 d0                	add    %edx,%eax
    12db:	05 20 2b 00 00       	add    $0x2b20,%eax
    12e0:	0f b6 00             	movzbl (%eax),%eax
    12e3:	84 c0                	test   %al,%al
    12e5:	74 26                	je     130d <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    12e7:	8b 45 08             	mov    0x8(%ebp),%eax
    12ea:	8b 50 18             	mov    0x18(%eax),%edx
    12ed:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    12f0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12f3:	01 c8                	add    %ecx,%eax
    12f5:	89 c1                	mov    %eax,%ecx
    12f7:	89 c8                	mov    %ecx,%eax
    12f9:	01 c0                	add    %eax,%eax
    12fb:	01 c8                	add    %ecx,%eax
    12fd:	01 d0                	add    %edx,%eax
    12ff:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1303:	66 89 10             	mov    %dx,(%eax)
    1306:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    130a:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    130d:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1311:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1315:	7e aa                	jle    12c1 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1317:	8b 45 08             	mov    0x8(%ebp),%eax
    131a:	8b 00                	mov    (%eax),%eax
    131c:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    131f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1323:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1327:	7e 8f                	jle    12b8 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    1329:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    132d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1330:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1333:	0f 82 38 ff ff ff    	jb     1271 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1339:	90                   	nop
    133a:	c9                   	leave  
    133b:	c3                   	ret    

0000133c <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    133c:	55                   	push   %ebp
    133d:	89 e5                	mov    %esp,%ebp
    133f:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1342:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1346:	0f 88 8e 01 00 00    	js     14da <APDcCopy+0x19e>
    134c:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1350:	0f 88 84 01 00 00    	js     14da <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1356:	8b 55 0c             	mov    0xc(%ebp),%edx
    1359:	8b 45 20             	mov    0x20(%ebp),%eax
    135c:	01 d0                	add    %edx,%eax
    135e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1361:	8b 55 10             	mov    0x10(%ebp),%edx
    1364:	8b 45 24             	mov    0x24(%ebp),%eax
    1367:	01 d0                	add    %edx,%eax
    1369:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    136c:	8b 55 18             	mov    0x18(%ebp),%edx
    136f:	8b 45 20             	mov    0x20(%ebp),%eax
    1372:	01 d0                	add    %edx,%eax
    1374:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1377:	8b 55 1c             	mov    0x1c(%ebp),%edx
    137a:	8b 45 24             	mov    0x24(%ebp),%eax
    137d:	01 d0                	add    %edx,%eax
    137f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1382:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1386:	0f 88 51 01 00 00    	js     14dd <APDcCopy+0x1a1>
    138c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1390:	0f 88 47 01 00 00    	js     14dd <APDcCopy+0x1a1>
    1396:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    139a:	0f 88 3d 01 00 00    	js     14dd <APDcCopy+0x1a1>
    13a0:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    13a4:	0f 88 33 01 00 00    	js     14dd <APDcCopy+0x1a1>
    13aa:	8b 45 14             	mov    0x14(%ebp),%eax
    13ad:	8b 00                	mov    (%eax),%eax
    13af:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13b2:	0f 8c 25 01 00 00    	jl     14dd <APDcCopy+0x1a1>
    13b8:	8b 45 14             	mov    0x14(%ebp),%eax
    13bb:	8b 40 04             	mov    0x4(%eax),%eax
    13be:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    13c1:	0f 8c 16 01 00 00    	jl     14dd <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    13c7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ca:	8b 00                	mov    (%eax),%eax
    13cc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    13cf:	7f 0b                	jg     13dc <APDcCopy+0xa0>
    13d1:	8b 45 08             	mov    0x8(%ebp),%eax
    13d4:	8b 00                	mov    (%eax),%eax
    13d6:	83 e8 01             	sub    $0x1,%eax
    13d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    13dc:	8b 45 08             	mov    0x8(%ebp),%eax
    13df:	8b 40 04             	mov    0x4(%eax),%eax
    13e2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13e5:	7f 0c                	jg     13f3 <APDcCopy+0xb7>
    13e7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ea:	8b 40 04             	mov    0x4(%eax),%eax
    13ed:	83 e8 01             	sub    $0x1,%eax
    13f0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    13f3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    13fa:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1401:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1408:	e9 bc 00 00 00       	jmp    14c9 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    140d:	8b 45 08             	mov    0x8(%ebp),%eax
    1410:	8b 00                	mov    (%eax),%eax
    1412:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1415:	8b 55 10             	mov    0x10(%ebp),%edx
    1418:	01 ca                	add    %ecx,%edx
    141a:	0f af d0             	imul   %eax,%edx
    141d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1420:	01 d0                	add    %edx,%eax
    1422:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1425:	8b 45 14             	mov    0x14(%ebp),%eax
    1428:	8b 00                	mov    (%eax),%eax
    142a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    142d:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1430:	01 ca                	add    %ecx,%edx
    1432:	0f af d0             	imul   %eax,%edx
    1435:	8b 45 18             	mov    0x18(%ebp),%eax
    1438:	01 d0                	add    %edx,%eax
    143a:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    143d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1444:	eb 74                	jmp    14ba <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1446:	8b 45 14             	mov    0x14(%ebp),%eax
    1449:	8b 50 18             	mov    0x18(%eax),%edx
    144c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    144f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1452:	01 c8                	add    %ecx,%eax
    1454:	89 c1                	mov    %eax,%ecx
    1456:	89 c8                	mov    %ecx,%eax
    1458:	01 c0                	add    %eax,%eax
    145a:	01 c8                	add    %ecx,%eax
    145c:	01 d0                	add    %edx,%eax
    145e:	0f b7 10             	movzwl (%eax),%edx
    1461:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1465:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1469:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    146c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1470:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1474:	38 c2                	cmp    %al,%dl
    1476:	75 18                	jne    1490 <APDcCopy+0x154>
    1478:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    147c:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1480:	38 c2                	cmp    %al,%dl
    1482:	75 0c                	jne    1490 <APDcCopy+0x154>
    1484:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1488:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    148c:	38 c2                	cmp    %al,%dl
    148e:	74 26                	je     14b6 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1490:	8b 45 08             	mov    0x8(%ebp),%eax
    1493:	8b 50 18             	mov    0x18(%eax),%edx
    1496:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1499:	8b 45 f0             	mov    -0x10(%ebp),%eax
    149c:	01 c8                	add    %ecx,%eax
    149e:	89 c1                	mov    %eax,%ecx
    14a0:	89 c8                	mov    %ecx,%eax
    14a2:	01 c0                	add    %eax,%eax
    14a4:	01 c8                	add    %ecx,%eax
    14a6:	01 d0                	add    %edx,%eax
    14a8:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    14ac:	66 89 10             	mov    %dx,(%eax)
    14af:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    14b3:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    14b6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14bd:	2b 45 0c             	sub    0xc(%ebp),%eax
    14c0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14c3:	7d 81                	jge    1446 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    14c5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14cc:	2b 45 10             	sub    0x10(%ebp),%eax
    14cf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14d2:	0f 8d 35 ff ff ff    	jge    140d <APDcCopy+0xd1>
    14d8:	eb 04                	jmp    14de <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    14da:	90                   	nop
    14db:	eb 01                	jmp    14de <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    14dd:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    14de:	c9                   	leave  
    14df:	c3                   	ret    

000014e0 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    14e0:	55                   	push   %ebp
    14e1:	89 e5                	mov    %esp,%ebp
    14e3:	83 ec 1c             	sub    $0x1c,%esp
    14e6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    14e9:	8b 55 10             	mov    0x10(%ebp),%edx
    14ec:	8b 45 14             	mov    0x14(%ebp),%eax
    14ef:	88 4d ec             	mov    %cl,-0x14(%ebp)
    14f2:	88 55 e8             	mov    %dl,-0x18(%ebp)
    14f5:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    14f8:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    14fc:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    14ff:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1503:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1506:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    150a:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    150d:	8b 45 08             	mov    0x8(%ebp),%eax
    1510:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1514:	66 89 10             	mov    %dx,(%eax)
    1517:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    151b:	88 50 02             	mov    %dl,0x2(%eax)
}
    151e:	8b 45 08             	mov    0x8(%ebp),%eax
    1521:	c9                   	leave  
    1522:	c2 04 00             	ret    $0x4

00001525 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1525:	55                   	push   %ebp
    1526:	89 e5                	mov    %esp,%ebp
    1528:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    152b:	8b 45 08             	mov    0x8(%ebp),%eax
    152e:	8b 00                	mov    (%eax),%eax
    1530:	83 ec 08             	sub    $0x8,%esp
    1533:	8d 55 0c             	lea    0xc(%ebp),%edx
    1536:	52                   	push   %edx
    1537:	50                   	push   %eax
    1538:	e8 34 ee ff ff       	call   371 <sendMessage>
    153d:	83 c4 10             	add    $0x10,%esp
}
    1540:	90                   	nop
    1541:	c9                   	leave  
    1542:	c3                   	ret    

00001543 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1543:	55                   	push   %ebp
    1544:	89 e5                	mov    %esp,%ebp
    1546:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1549:	83 ec 0c             	sub    $0xc,%esp
    154c:	68 98 00 00 00       	push   $0x98
    1551:	e8 f5 f1 ff ff       	call   74b <malloc>
    1556:	83 c4 10             	add    $0x10,%esp
    1559:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    155c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1560:	75 15                	jne    1577 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1562:	83 ec 04             	sub    $0x4,%esp
    1565:	ff 75 08             	pushl  0x8(%ebp)
    1568:	68 10 24 00 00       	push   $0x2410
    156d:	6a 01                	push   $0x1
    156f:	e8 04 ef ff ff       	call   478 <printf>
    1574:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1577:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157a:	05 84 00 00 00       	add    $0x84,%eax
    157f:	83 ec 08             	sub    $0x8,%esp
    1582:	ff 75 08             	pushl  0x8(%ebp)
    1585:	50                   	push   %eax
    1586:	e8 0d eb ff ff       	call   98 <strcpy>
    158b:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    158e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1591:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1598:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159b:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a5:	8b 40 3c             	mov    0x3c(%eax),%eax
    15a8:	89 c2                	mov    %eax,%edx
    15aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ad:	8b 40 40             	mov    0x40(%eax),%eax
    15b0:	0f af d0             	imul   %eax,%edx
    15b3:	89 d0                	mov    %edx,%eax
    15b5:	01 c0                	add    %eax,%eax
    15b7:	01 d0                	add    %edx,%eax
    15b9:	83 ec 0c             	sub    $0xc,%esp
    15bc:	50                   	push   %eax
    15bd:	e8 89 f1 ff ff       	call   74b <malloc>
    15c2:	83 c4 10             	add    $0x10,%esp
    15c5:	89 c2                	mov    %eax,%edx
    15c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ca:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    15cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d0:	8b 40 54             	mov    0x54(%eax),%eax
    15d3:	85 c0                	test   %eax,%eax
    15d5:	75 15                	jne    15ec <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    15d7:	83 ec 04             	sub    $0x4,%esp
    15da:	ff 75 08             	pushl  0x8(%ebp)
    15dd:	68 30 24 00 00       	push   $0x2430
    15e2:	6a 01                	push   $0x1
    15e4:	e8 8f ee ff ff       	call   478 <printf>
    15e9:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ef:	8b 40 3c             	mov    0x3c(%eax),%eax
    15f2:	89 c2                	mov    %eax,%edx
    15f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f7:	8b 40 40             	mov    0x40(%eax),%eax
    15fa:	0f af d0             	imul   %eax,%edx
    15fd:	89 d0                	mov    %edx,%eax
    15ff:	01 c0                	add    %eax,%eax
    1601:	01 c2                	add    %eax,%edx
    1603:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1606:	8b 40 54             	mov    0x54(%eax),%eax
    1609:	83 ec 04             	sub    $0x4,%esp
    160c:	52                   	push   %edx
    160d:	68 ff ff ff 00       	push   $0xffffff
    1612:	50                   	push   %eax
    1613:	e8 16 eb ff ff       	call   12e <memset>
    1618:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    161b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161e:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1625:	e8 1f ed ff ff       	call   349 <getpid>
    162a:	89 c2                	mov    %eax,%edx
    162c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162f:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1632:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1635:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    163c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163f:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1646:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1649:	8b 40 58             	mov    0x58(%eax),%eax
    164c:	89 c2                	mov    %eax,%edx
    164e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1651:	8b 40 5c             	mov    0x5c(%eax),%eax
    1654:	0f af d0             	imul   %eax,%edx
    1657:	89 d0                	mov    %edx,%eax
    1659:	01 c0                	add    %eax,%eax
    165b:	01 d0                	add    %edx,%eax
    165d:	83 ec 0c             	sub    $0xc,%esp
    1660:	50                   	push   %eax
    1661:	e8 e5 f0 ff ff       	call   74b <malloc>
    1666:	83 c4 10             	add    $0x10,%esp
    1669:	89 c2                	mov    %eax,%edx
    166b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166e:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1671:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1674:	8b 40 70             	mov    0x70(%eax),%eax
    1677:	85 c0                	test   %eax,%eax
    1679:	75 15                	jne    1690 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    167b:	83 ec 04             	sub    $0x4,%esp
    167e:	ff 75 08             	pushl  0x8(%ebp)
    1681:	68 54 24 00 00       	push   $0x2454
    1686:	6a 01                	push   $0x1
    1688:	e8 eb ed ff ff       	call   478 <printf>
    168d:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1690:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1693:	8b 40 3c             	mov    0x3c(%eax),%eax
    1696:	89 c2                	mov    %eax,%edx
    1698:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169b:	8b 40 40             	mov    0x40(%eax),%eax
    169e:	0f af d0             	imul   %eax,%edx
    16a1:	89 d0                	mov    %edx,%eax
    16a3:	01 c0                	add    %eax,%eax
    16a5:	01 c2                	add    %eax,%edx
    16a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16aa:	8b 40 54             	mov    0x54(%eax),%eax
    16ad:	83 ec 04             	sub    $0x4,%esp
    16b0:	52                   	push   %edx
    16b1:	68 ff 00 00 00       	push   $0xff
    16b6:	50                   	push   %eax
    16b7:	e8 72 ea ff ff       	call   12e <memset>
    16bc:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    16bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c2:	8b 55 0c             	mov    0xc(%ebp),%edx
    16c5:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    16c8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16cc:	74 49                	je     1717 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    16ce:	8b 45 10             	mov    0x10(%ebp),%eax
    16d1:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    16d7:	83 ec 0c             	sub    $0xc,%esp
    16da:	50                   	push   %eax
    16db:	e8 6b f0 ff ff       	call   74b <malloc>
    16e0:	83 c4 10             	add    $0x10,%esp
    16e3:	89 c2                	mov    %eax,%edx
    16e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e8:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    16eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ee:	8b 55 10             	mov    0x10(%ebp),%edx
    16f1:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    16f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f7:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    16fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1701:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1708:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170b:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1712:	e9 8d 00 00 00       	jmp    17a4 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1717:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171a:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1721:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1724:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    172b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172e:	8b 40 20             	mov    0x20(%eax),%eax
    1731:	89 c2                	mov    %eax,%edx
    1733:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1736:	8b 40 24             	mov    0x24(%eax),%eax
    1739:	0f af d0             	imul   %eax,%edx
    173c:	89 d0                	mov    %edx,%eax
    173e:	01 c0                	add    %eax,%eax
    1740:	01 d0                	add    %edx,%eax
    1742:	83 ec 0c             	sub    $0xc,%esp
    1745:	50                   	push   %eax
    1746:	e8 00 f0 ff ff       	call   74b <malloc>
    174b:	83 c4 10             	add    $0x10,%esp
    174e:	89 c2                	mov    %eax,%edx
    1750:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1753:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1756:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1759:	8b 40 38             	mov    0x38(%eax),%eax
    175c:	85 c0                	test   %eax,%eax
    175e:	75 15                	jne    1775 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1760:	83 ec 04             	sub    $0x4,%esp
    1763:	ff 75 08             	pushl  0x8(%ebp)
    1766:	68 7c 24 00 00       	push   $0x247c
    176b:	6a 01                	push   $0x1
    176d:	e8 06 ed ff ff       	call   478 <printf>
    1772:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1775:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1778:	8b 40 20             	mov    0x20(%eax),%eax
    177b:	89 c2                	mov    %eax,%edx
    177d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1780:	8b 40 24             	mov    0x24(%eax),%eax
    1783:	0f af d0             	imul   %eax,%edx
    1786:	89 d0                	mov    %edx,%eax
    1788:	01 c0                	add    %eax,%eax
    178a:	01 c2                	add    %eax,%edx
    178c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178f:	8b 40 38             	mov    0x38(%eax),%eax
    1792:	83 ec 04             	sub    $0x4,%esp
    1795:	52                   	push   %edx
    1796:	68 ff ff ff 00       	push   $0xffffff
    179b:	50                   	push   %eax
    179c:	e8 8d e9 ff ff       	call   12e <memset>
    17a1:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    17a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    17a7:	c9                   	leave  
    17a8:	c3                   	ret    

000017a9 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    17a9:	55                   	push   %ebp
    17aa:	89 e5                	mov    %esp,%ebp
    17ac:	57                   	push   %edi
    17ad:	56                   	push   %esi
    17ae:	53                   	push   %ebx
    17af:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    17b2:	8b 45 0c             	mov    0xc(%ebp),%eax
    17b5:	83 f8 03             	cmp    $0x3,%eax
    17b8:	74 02                	je     17bc <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    17ba:	eb 7c                	jmp    1838 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    17bc:	8b 45 08             	mov    0x8(%ebp),%eax
    17bf:	8b 58 1c             	mov    0x1c(%eax),%ebx
    17c2:	8b 45 08             	mov    0x8(%ebp),%eax
    17c5:	8b 48 18             	mov    0x18(%eax),%ecx
    17c8:	8b 45 08             	mov    0x8(%ebp),%eax
    17cb:	8b 50 5c             	mov    0x5c(%eax),%edx
    17ce:	8b 45 08             	mov    0x8(%ebp),%eax
    17d1:	8b 40 58             	mov    0x58(%eax),%eax
    17d4:	8b 75 08             	mov    0x8(%ebp),%esi
    17d7:	83 c6 58             	add    $0x58,%esi
    17da:	83 ec 04             	sub    $0x4,%esp
    17dd:	53                   	push   %ebx
    17de:	51                   	push   %ecx
    17df:	6a 00                	push   $0x0
    17e1:	52                   	push   %edx
    17e2:	50                   	push   %eax
    17e3:	6a 00                	push   $0x0
    17e5:	6a 00                	push   $0x0
    17e7:	56                   	push   %esi
    17e8:	6a 00                	push   $0x0
    17ea:	6a 00                	push   $0x0
    17ec:	ff 75 08             	pushl  0x8(%ebp)
    17ef:	e8 75 eb ff ff       	call   369 <paintWindow>
    17f4:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    17f7:	8b 45 08             	mov    0x8(%ebp),%eax
    17fa:	8b 70 1c             	mov    0x1c(%eax),%esi
    17fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1800:	8b 58 18             	mov    0x18(%eax),%ebx
    1803:	8b 45 08             	mov    0x8(%ebp),%eax
    1806:	8b 48 08             	mov    0x8(%eax),%ecx
    1809:	8b 45 08             	mov    0x8(%ebp),%eax
    180c:	8b 50 40             	mov    0x40(%eax),%edx
    180f:	8b 45 08             	mov    0x8(%ebp),%eax
    1812:	8b 40 3c             	mov    0x3c(%eax),%eax
    1815:	8b 7d 08             	mov    0x8(%ebp),%edi
    1818:	83 c7 3c             	add    $0x3c,%edi
    181b:	83 ec 04             	sub    $0x4,%esp
    181e:	56                   	push   %esi
    181f:	53                   	push   %ebx
    1820:	51                   	push   %ecx
    1821:	52                   	push   %edx
    1822:	50                   	push   %eax
    1823:	6a 00                	push   $0x0
    1825:	6a 00                	push   $0x0
    1827:	57                   	push   %edi
    1828:	6a 32                	push   $0x32
    182a:	6a 00                	push   $0x0
    182c:	ff 75 08             	pushl  0x8(%ebp)
    182f:	e8 35 eb ff ff       	call   369 <paintWindow>
    1834:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1837:	90                   	nop
        default: break;
            
            
    }
    return False;
    1838:	b8 00 00 00 00       	mov    $0x0,%eax
}
    183d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1840:	5b                   	pop    %ebx
    1841:	5e                   	pop    %esi
    1842:	5f                   	pop    %edi
    1843:	5d                   	pop    %ebp
    1844:	c3                   	ret    

00001845 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1845:	55                   	push   %ebp
    1846:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1848:	8b 45 0c             	mov    0xc(%ebp),%eax
    184b:	8b 50 08             	mov    0x8(%eax),%edx
    184e:	8b 45 08             	mov    0x8(%ebp),%eax
    1851:	8b 00                	mov    (%eax),%eax
    1853:	39 c2                	cmp    %eax,%edx
    1855:	74 07                	je     185e <APPreJudge+0x19>
        return False;
    1857:	b8 00 00 00 00       	mov    $0x0,%eax
    185c:	eb 05                	jmp    1863 <APPreJudge+0x1e>
    return True;
    185e:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1863:	5d                   	pop    %ebp
    1864:	c3                   	ret    

00001865 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1865:	55                   	push   %ebp
    1866:	89 e5                	mov    %esp,%ebp
    1868:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    186b:	8b 45 08             	mov    0x8(%ebp),%eax
    186e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1871:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1877:	83 ec 0c             	sub    $0xc,%esp
    187a:	ff 75 08             	pushl  0x8(%ebp)
    187d:	e8 ff ea ff ff       	call   381 <registWindow>
    1882:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1885:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    188c:	8b 45 08             	mov    0x8(%ebp),%eax
    188f:	8b 00                	mov    (%eax),%eax
    1891:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1894:	ff 75 f4             	pushl  -0xc(%ebp)
    1897:	ff 75 f0             	pushl  -0x10(%ebp)
    189a:	ff 75 ec             	pushl  -0x14(%ebp)
    189d:	ff 75 08             	pushl  0x8(%ebp)
    18a0:	e8 80 fc ff ff       	call   1525 <APSendMessage>
    18a5:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    18a8:	83 ec 0c             	sub    $0xc,%esp
    18ab:	ff 75 08             	pushl  0x8(%ebp)
    18ae:	e8 c6 ea ff ff       	call   379 <getMessage>
    18b3:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    18b6:	8b 45 08             	mov    0x8(%ebp),%eax
    18b9:	83 c0 74             	add    $0x74,%eax
    18bc:	83 ec 08             	sub    $0x8,%esp
    18bf:	50                   	push   %eax
    18c0:	ff 75 08             	pushl  0x8(%ebp)
    18c3:	e8 7d ff ff ff       	call   1845 <APPreJudge>
    18c8:	83 c4 10             	add    $0x10,%esp
    18cb:	84 c0                	test   %al,%al
    18cd:	74 1b                	je     18ea <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    18cf:	8b 45 08             	mov    0x8(%ebp),%eax
    18d2:	ff 70 7c             	pushl  0x7c(%eax)
    18d5:	ff 70 78             	pushl  0x78(%eax)
    18d8:	ff 70 74             	pushl  0x74(%eax)
    18db:	ff 75 08             	pushl  0x8(%ebp)
    18de:	8b 45 0c             	mov    0xc(%ebp),%eax
    18e1:	ff d0                	call   *%eax
    18e3:	83 c4 10             	add    $0x10,%esp
    18e6:	84 c0                	test   %al,%al
    18e8:	75 0c                	jne    18f6 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    18ea:	8b 45 08             	mov    0x8(%ebp),%eax
    18ed:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    18f4:	eb b2                	jmp    18a8 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    18f6:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    18f7:	90                   	nop
    18f8:	c9                   	leave  
    18f9:	c3                   	ret    

000018fa <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    18fa:	55                   	push   %ebp
    18fb:	89 e5                	mov    %esp,%ebp
    18fd:	57                   	push   %edi
    18fe:	56                   	push   %esi
    18ff:	53                   	push   %ebx
    1900:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    1903:	a1 64 67 00 00       	mov    0x6764,%eax
    1908:	85 c0                	test   %eax,%eax
    190a:	0f 85 2c 02 00 00    	jne    1b3c <APGridPaint+0x242>
    {
        iconReady = 1;
    1910:	c7 05 64 67 00 00 01 	movl   $0x1,0x6764
    1917:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    191a:	8d 45 88             	lea    -0x78(%ebp),%eax
    191d:	83 ec 08             	sub    $0x8,%esp
    1920:	68 a3 24 00 00       	push   $0x24a3
    1925:	50                   	push   %eax
    1926:	e8 d3 ef ff ff       	call   8fe <APLoadBitmap>
    192b:	83 c4 0c             	add    $0xc,%esp
    192e:	8b 45 88             	mov    -0x78(%ebp),%eax
    1931:	a3 88 67 00 00       	mov    %eax,0x6788
    1936:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1939:	a3 8c 67 00 00       	mov    %eax,0x678c
    193e:	8b 45 90             	mov    -0x70(%ebp),%eax
    1941:	a3 90 67 00 00       	mov    %eax,0x6790
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1946:	83 ec 04             	sub    $0x4,%esp
    1949:	ff 35 90 67 00 00    	pushl  0x6790
    194f:	ff 35 8c 67 00 00    	pushl  0x678c
    1955:	ff 35 88 67 00 00    	pushl  0x6788
    195b:	e8 d8 f1 ff ff       	call   b38 <APCreateCompatibleDCFromBitmap>
    1960:	83 c4 10             	add    $0x10,%esp
    1963:	a3 94 67 00 00       	mov    %eax,0x6794
        grid_river = APLoadBitmap ("grid_river.bmp");
    1968:	8d 45 88             	lea    -0x78(%ebp),%eax
    196b:	83 ec 08             	sub    $0x8,%esp
    196e:	68 b1 24 00 00       	push   $0x24b1
    1973:	50                   	push   %eax
    1974:	e8 85 ef ff ff       	call   8fe <APLoadBitmap>
    1979:	83 c4 0c             	add    $0xc,%esp
    197c:	8b 45 88             	mov    -0x78(%ebp),%eax
    197f:	a3 c4 67 00 00       	mov    %eax,0x67c4
    1984:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1987:	a3 c8 67 00 00       	mov    %eax,0x67c8
    198c:	8b 45 90             	mov    -0x70(%ebp),%eax
    198f:	a3 cc 67 00 00       	mov    %eax,0x67cc
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1994:	83 ec 04             	sub    $0x4,%esp
    1997:	ff 35 cc 67 00 00    	pushl  0x67cc
    199d:	ff 35 c8 67 00 00    	pushl  0x67c8
    19a3:	ff 35 c4 67 00 00    	pushl  0x67c4
    19a9:	e8 8a f1 ff ff       	call   b38 <APCreateCompatibleDCFromBitmap>
    19ae:	83 c4 10             	add    $0x10,%esp
    19b1:	a3 b4 67 00 00       	mov    %eax,0x67b4
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    19b6:	8d 45 88             	lea    -0x78(%ebp),%eax
    19b9:	83 ec 08             	sub    $0x8,%esp
    19bc:	68 c0 24 00 00       	push   $0x24c0
    19c1:	50                   	push   %eax
    19c2:	e8 37 ef ff ff       	call   8fe <APLoadBitmap>
    19c7:	83 c4 0c             	add    $0xc,%esp
    19ca:	8b 45 88             	mov    -0x78(%ebp),%eax
    19cd:	a3 b8 67 00 00       	mov    %eax,0x67b8
    19d2:	8b 45 8c             	mov    -0x74(%ebp),%eax
    19d5:	a3 bc 67 00 00       	mov    %eax,0x67bc
    19da:	8b 45 90             	mov    -0x70(%ebp),%eax
    19dd:	a3 c0 67 00 00       	mov    %eax,0x67c0
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    19e2:	83 ec 04             	sub    $0x4,%esp
    19e5:	ff 35 c0 67 00 00    	pushl  0x67c0
    19eb:	ff 35 bc 67 00 00    	pushl  0x67bc
    19f1:	ff 35 b8 67 00 00    	pushl  0x67b8
    19f7:	e8 3c f1 ff ff       	call   b38 <APCreateCompatibleDCFromBitmap>
    19fc:	83 c4 10             	add    $0x10,%esp
    19ff:	a3 68 67 00 00       	mov    %eax,0x6768
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1a04:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a07:	83 ec 08             	sub    $0x8,%esp
    1a0a:	68 cf 24 00 00       	push   $0x24cf
    1a0f:	50                   	push   %eax
    1a10:	e8 e9 ee ff ff       	call   8fe <APLoadBitmap>
    1a15:	83 c4 0c             	add    $0xc,%esp
    1a18:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a1b:	a3 9c 67 00 00       	mov    %eax,0x679c
    1a20:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a23:	a3 a0 67 00 00       	mov    %eax,0x67a0
    1a28:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a2b:	a3 a4 67 00 00       	mov    %eax,0x67a4
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1a30:	83 ec 04             	sub    $0x4,%esp
    1a33:	ff 35 a4 67 00 00    	pushl  0x67a4
    1a39:	ff 35 a0 67 00 00    	pushl  0x67a0
    1a3f:	ff 35 9c 67 00 00    	pushl  0x679c
    1a45:	e8 ee f0 ff ff       	call   b38 <APCreateCompatibleDCFromBitmap>
    1a4a:	83 c4 10             	add    $0x10,%esp
    1a4d:	a3 d0 67 00 00       	mov    %eax,0x67d0
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1a52:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a55:	83 ec 08             	sub    $0x8,%esp
    1a58:	68 dd 24 00 00       	push   $0x24dd
    1a5d:	50                   	push   %eax
    1a5e:	e8 9b ee ff ff       	call   8fe <APLoadBitmap>
    1a63:	83 c4 0c             	add    $0xc,%esp
    1a66:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a69:	a3 78 67 00 00       	mov    %eax,0x6778
    1a6e:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a71:	a3 7c 67 00 00       	mov    %eax,0x677c
    1a76:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a79:	a3 80 67 00 00       	mov    %eax,0x6780
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1a7e:	83 ec 04             	sub    $0x4,%esp
    1a81:	ff 35 80 67 00 00    	pushl  0x6780
    1a87:	ff 35 7c 67 00 00    	pushl  0x677c
    1a8d:	ff 35 78 67 00 00    	pushl  0x6778
    1a93:	e8 a0 f0 ff ff       	call   b38 <APCreateCompatibleDCFromBitmap>
    1a98:	83 c4 10             	add    $0x10,%esp
    1a9b:	a3 98 67 00 00       	mov    %eax,0x6798
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1aa0:	8d 45 88             	lea    -0x78(%ebp),%eax
    1aa3:	83 ec 08             	sub    $0x8,%esp
    1aa6:	68 ed 24 00 00       	push   $0x24ed
    1aab:	50                   	push   %eax
    1aac:	e8 4d ee ff ff       	call   8fe <APLoadBitmap>
    1ab1:	83 c4 0c             	add    $0xc,%esp
    1ab4:	8b 45 88             	mov    -0x78(%ebp),%eax
    1ab7:	a3 6c 67 00 00       	mov    %eax,0x676c
    1abc:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1abf:	a3 70 67 00 00       	mov    %eax,0x6770
    1ac4:	8b 45 90             	mov    -0x70(%ebp),%eax
    1ac7:	a3 74 67 00 00       	mov    %eax,0x6774
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1acc:	83 ec 04             	sub    $0x4,%esp
    1acf:	ff 35 74 67 00 00    	pushl  0x6774
    1ad5:	ff 35 70 67 00 00    	pushl  0x6770
    1adb:	ff 35 6c 67 00 00    	pushl  0x676c
    1ae1:	e8 52 f0 ff ff       	call   b38 <APCreateCompatibleDCFromBitmap>
    1ae6:	83 c4 10             	add    $0x10,%esp
    1ae9:	a3 84 67 00 00       	mov    %eax,0x6784
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1aee:	8d 45 88             	lea    -0x78(%ebp),%eax
    1af1:	83 ec 08             	sub    $0x8,%esp
    1af4:	68 ff 24 00 00       	push   $0x24ff
    1af9:	50                   	push   %eax
    1afa:	e8 ff ed ff ff       	call   8fe <APLoadBitmap>
    1aff:	83 c4 0c             	add    $0xc,%esp
    1b02:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b05:	a3 a8 67 00 00       	mov    %eax,0x67a8
    1b0a:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b0d:	a3 ac 67 00 00       	mov    %eax,0x67ac
    1b12:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b15:	a3 b0 67 00 00       	mov    %eax,0x67b0
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1b1a:	83 ec 04             	sub    $0x4,%esp
    1b1d:	ff 35 b0 67 00 00    	pushl  0x67b0
    1b23:	ff 35 ac 67 00 00    	pushl  0x67ac
    1b29:	ff 35 a8 67 00 00    	pushl  0x67a8
    1b2f:	e8 04 f0 ff ff       	call   b38 <APCreateCompatibleDCFromBitmap>
    1b34:	83 c4 10             	add    $0x10,%esp
    1b37:	a3 d4 67 00 00       	mov    %eax,0x67d4
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1b3c:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3f:	8b 40 08             	mov    0x8(%eax),%eax
    1b42:	85 c0                	test   %eax,%eax
    1b44:	75 17                	jne    1b5d <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1b46:	83 ec 08             	sub    $0x8,%esp
    1b49:	68 10 25 00 00       	push   $0x2510
    1b4e:	6a 01                	push   $0x1
    1b50:	e8 23 e9 ff ff       	call   478 <printf>
    1b55:	83 c4 10             	add    $0x10,%esp
        return;
    1b58:	e9 07 05 00 00       	jmp    2064 <APGridPaint+0x76a>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1b5d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b60:	8b 40 10             	mov    0x10(%eax),%eax
    1b63:	85 c0                	test   %eax,%eax
    1b65:	7e 10                	jle    1b77 <APGridPaint+0x27d>
    1b67:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6a:	8b 50 14             	mov    0x14(%eax),%edx
    1b6d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b70:	8b 40 10             	mov    0x10(%eax),%eax
    1b73:	39 c2                	cmp    %eax,%edx
    1b75:	7c 17                	jl     1b8e <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1b77:	83 ec 08             	sub    $0x8,%esp
    1b7a:	68 36 25 00 00       	push   $0x2536
    1b7f:	6a 01                	push   $0x1
    1b81:	e8 f2 e8 ff ff       	call   478 <printf>
    1b86:	83 c4 10             	add    $0x10,%esp
        return;
    1b89:	e9 d6 04 00 00       	jmp    2064 <APGridPaint+0x76a>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1b8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b91:	8b 40 14             	mov    0x14(%eax),%eax
    1b94:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1b9a:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1b9d:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1ba0:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1ba3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1baa:	e9 96 03 00 00       	jmp    1f45 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1baf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1bb6:	e9 7c 03 00 00       	jmp    1f37 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1bbb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bbe:	c1 e0 04             	shl    $0x4,%eax
    1bc1:	89 c2                	mov    %eax,%edx
    1bc3:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1bc6:	01 c2                	add    %eax,%edx
    1bc8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bcb:	01 d0                	add    %edx,%eax
    1bcd:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1bd0:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd3:	8b 40 0c             	mov    0xc(%eax),%eax
    1bd6:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1bd9:	c1 e2 02             	shl    $0x2,%edx
    1bdc:	01 d0                	add    %edx,%eax
    1bde:	8b 00                	mov    (%eax),%eax
    1be0:	83 f8 07             	cmp    $0x7,%eax
    1be3:	0f 87 49 03 00 00    	ja     1f32 <APGridPaint+0x638>
    1be9:	8b 04 85 4c 25 00 00 	mov    0x254c(,%eax,4),%eax
    1bf0:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bf2:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1bf5:	6a 0c                	push   $0xc
    1bf7:	6a 0c                	push   $0xc
    1bf9:	6a 0c                	push   $0xc
    1bfb:	50                   	push   %eax
    1bfc:	e8 df f8 ff ff       	call   14e0 <RGB>
    1c01:	83 c4 0c             	add    $0xc,%esp
    1c04:	8b 1d 94 67 00 00    	mov    0x6794,%ebx
    1c0a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c0d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c10:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c13:	6b c0 32             	imul   $0x32,%eax,%eax
    1c16:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1c19:	8b 45 08             	mov    0x8(%ebp),%eax
    1c1c:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c1f:	83 ec 0c             	sub    $0xc,%esp
    1c22:	83 ec 04             	sub    $0x4,%esp
    1c25:	89 e0                	mov    %esp,%eax
    1c27:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1c2b:	66 89 30             	mov    %si,(%eax)
    1c2e:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1c32:	88 50 02             	mov    %dl,0x2(%eax)
    1c35:	6a 32                	push   $0x32
    1c37:	6a 32                	push   $0x32
    1c39:	6a 00                	push   $0x0
    1c3b:	6a 00                	push   $0x0
    1c3d:	53                   	push   %ebx
    1c3e:	51                   	push   %ecx
    1c3f:	ff 75 84             	pushl  -0x7c(%ebp)
    1c42:	57                   	push   %edi
    1c43:	e8 f4 f6 ff ff       	call   133c <APDcCopy>
    1c48:	83 c4 30             	add    $0x30,%esp
                    break;
    1c4b:	e9 e3 02 00 00       	jmp    1f33 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1c50:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c53:	6a 69                	push   $0x69
    1c55:	6a 69                	push   $0x69
    1c57:	6a 69                	push   $0x69
    1c59:	50                   	push   %eax
    1c5a:	e8 81 f8 ff ff       	call   14e0 <RGB>
    1c5f:	83 c4 0c             	add    $0xc,%esp
    1c62:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1c66:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1c6a:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1c6e:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1c71:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1c78:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c7b:	6a 69                	push   $0x69
    1c7d:	6a 69                	push   $0x69
    1c7f:	6a 69                	push   $0x69
    1c81:	50                   	push   %eax
    1c82:	e8 59 f8 ff ff       	call   14e0 <RGB>
    1c87:	83 c4 0c             	add    $0xc,%esp
    1c8a:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1c8e:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1c92:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1c96:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1c99:	8b 45 08             	mov    0x8(%ebp),%eax
    1c9c:	8d 50 3c             	lea    0x3c(%eax),%edx
    1c9f:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ca2:	ff 75 ac             	pushl  -0x54(%ebp)
    1ca5:	ff 75 a8             	pushl  -0x58(%ebp)
    1ca8:	52                   	push   %edx
    1ca9:	50                   	push   %eax
    1caa:	e8 1e ef ff ff       	call   bcd <APSetPen>
    1caf:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1cb2:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb5:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1cb8:	8d 55 88             	lea    -0x78(%ebp),%edx
    1cbb:	83 ec 04             	sub    $0x4,%esp
    1cbe:	83 ec 04             	sub    $0x4,%esp
    1cc1:	89 e0                	mov    %esp,%eax
    1cc3:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1cc7:	66 89 08             	mov    %cx,(%eax)
    1cca:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    1cce:	88 48 02             	mov    %cl,0x2(%eax)
    1cd1:	53                   	push   %ebx
    1cd2:	52                   	push   %edx
    1cd3:	e8 2e ef ff ff       	call   c06 <APSetBrush>
    1cd8:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1cdb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cde:	6b d0 32             	imul   $0x32,%eax,%edx
    1ce1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ce4:	6b c0 32             	imul   $0x32,%eax,%eax
    1ce7:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1cea:	83 c1 3c             	add    $0x3c,%ecx
    1ced:	83 ec 0c             	sub    $0xc,%esp
    1cf0:	6a 32                	push   $0x32
    1cf2:	6a 32                	push   $0x32
    1cf4:	52                   	push   %edx
    1cf5:	50                   	push   %eax
    1cf6:	51                   	push   %ecx
    1cf7:	e8 34 f3 ff ff       	call   1030 <APDrawRect>
    1cfc:	83 c4 20             	add    $0x20,%esp
                    break;
    1cff:	e9 2f 02 00 00       	jmp    1f33 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d04:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1d07:	6a 0c                	push   $0xc
    1d09:	6a 0c                	push   $0xc
    1d0b:	6a 0c                	push   $0xc
    1d0d:	50                   	push   %eax
    1d0e:	e8 cd f7 ff ff       	call   14e0 <RGB>
    1d13:	83 c4 0c             	add    $0xc,%esp
    1d16:	8b 1d d4 67 00 00    	mov    0x67d4,%ebx
    1d1c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d1f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d22:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d25:	6b c0 32             	imul   $0x32,%eax,%eax
    1d28:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1d2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d2e:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d31:	83 ec 0c             	sub    $0xc,%esp
    1d34:	83 ec 04             	sub    $0x4,%esp
    1d37:	89 e0                	mov    %esp,%eax
    1d39:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1d3d:	66 89 30             	mov    %si,(%eax)
    1d40:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1d44:	88 50 02             	mov    %dl,0x2(%eax)
    1d47:	6a 32                	push   $0x32
    1d49:	6a 32                	push   $0x32
    1d4b:	6a 00                	push   $0x0
    1d4d:	6a 00                	push   $0x0
    1d4f:	53                   	push   %ebx
    1d50:	51                   	push   %ecx
    1d51:	ff 75 84             	pushl  -0x7c(%ebp)
    1d54:	57                   	push   %edi
    1d55:	e8 e2 f5 ff ff       	call   133c <APDcCopy>
    1d5a:	83 c4 30             	add    $0x30,%esp
                    break;
    1d5d:	e9 d1 01 00 00       	jmp    1f33 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d62:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1d65:	6a 0c                	push   $0xc
    1d67:	6a 0c                	push   $0xc
    1d69:	6a 0c                	push   $0xc
    1d6b:	50                   	push   %eax
    1d6c:	e8 6f f7 ff ff       	call   14e0 <RGB>
    1d71:	83 c4 0c             	add    $0xc,%esp
    1d74:	8b 1d b4 67 00 00    	mov    0x67b4,%ebx
    1d7a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d7d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d80:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d83:	6b c0 32             	imul   $0x32,%eax,%eax
    1d86:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1d89:	8b 45 08             	mov    0x8(%ebp),%eax
    1d8c:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d8f:	83 ec 0c             	sub    $0xc,%esp
    1d92:	83 ec 04             	sub    $0x4,%esp
    1d95:	89 e0                	mov    %esp,%eax
    1d97:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1d9b:	66 89 30             	mov    %si,(%eax)
    1d9e:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1da2:	88 50 02             	mov    %dl,0x2(%eax)
    1da5:	6a 32                	push   $0x32
    1da7:	6a 32                	push   $0x32
    1da9:	6a 00                	push   $0x0
    1dab:	6a 00                	push   $0x0
    1dad:	53                   	push   %ebx
    1dae:	51                   	push   %ecx
    1daf:	ff 75 84             	pushl  -0x7c(%ebp)
    1db2:	57                   	push   %edi
    1db3:	e8 84 f5 ff ff       	call   133c <APDcCopy>
    1db8:	83 c4 30             	add    $0x30,%esp
                    break;
    1dbb:	e9 73 01 00 00       	jmp    1f33 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dc0:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1dc3:	6a 0c                	push   $0xc
    1dc5:	6a 0c                	push   $0xc
    1dc7:	6a 0c                	push   $0xc
    1dc9:	50                   	push   %eax
    1dca:	e8 11 f7 ff ff       	call   14e0 <RGB>
    1dcf:	83 c4 0c             	add    $0xc,%esp
    1dd2:	8b 1d 98 67 00 00    	mov    0x6798,%ebx
    1dd8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ddb:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dde:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1de1:	6b c0 32             	imul   $0x32,%eax,%eax
    1de4:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1de7:	8b 45 08             	mov    0x8(%ebp),%eax
    1dea:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ded:	83 ec 0c             	sub    $0xc,%esp
    1df0:	83 ec 04             	sub    $0x4,%esp
    1df3:	89 e0                	mov    %esp,%eax
    1df5:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1df9:	66 89 30             	mov    %si,(%eax)
    1dfc:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1e00:	88 50 02             	mov    %dl,0x2(%eax)
    1e03:	6a 32                	push   $0x32
    1e05:	6a 32                	push   $0x32
    1e07:	6a 00                	push   $0x0
    1e09:	6a 00                	push   $0x0
    1e0b:	53                   	push   %ebx
    1e0c:	51                   	push   %ecx
    1e0d:	ff 75 84             	pushl  -0x7c(%ebp)
    1e10:	57                   	push   %edi
    1e11:	e8 26 f5 ff ff       	call   133c <APDcCopy>
    1e16:	83 c4 30             	add    $0x30,%esp
                    break;
    1e19:	e9 15 01 00 00       	jmp    1f33 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e1e:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1e21:	6a 0c                	push   $0xc
    1e23:	6a 0c                	push   $0xc
    1e25:	6a 0c                	push   $0xc
    1e27:	50                   	push   %eax
    1e28:	e8 b3 f6 ff ff       	call   14e0 <RGB>
    1e2d:	83 c4 0c             	add    $0xc,%esp
    1e30:	8b 1d d0 67 00 00    	mov    0x67d0,%ebx
    1e36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e39:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e3c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e3f:	6b c0 32             	imul   $0x32,%eax,%eax
    1e42:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e45:	8b 45 08             	mov    0x8(%ebp),%eax
    1e48:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e4b:	83 ec 0c             	sub    $0xc,%esp
    1e4e:	83 ec 04             	sub    $0x4,%esp
    1e51:	89 e0                	mov    %esp,%eax
    1e53:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1e57:	66 89 30             	mov    %si,(%eax)
    1e5a:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1e5e:	88 50 02             	mov    %dl,0x2(%eax)
    1e61:	6a 32                	push   $0x32
    1e63:	6a 32                	push   $0x32
    1e65:	6a 00                	push   $0x0
    1e67:	6a 00                	push   $0x0
    1e69:	53                   	push   %ebx
    1e6a:	51                   	push   %ecx
    1e6b:	ff 75 84             	pushl  -0x7c(%ebp)
    1e6e:	57                   	push   %edi
    1e6f:	e8 c8 f4 ff ff       	call   133c <APDcCopy>
    1e74:	83 c4 30             	add    $0x30,%esp
                    break;
    1e77:	e9 b7 00 00 00       	jmp    1f33 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e7c:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1e7f:	6a 0c                	push   $0xc
    1e81:	6a 0c                	push   $0xc
    1e83:	6a 0c                	push   $0xc
    1e85:	50                   	push   %eax
    1e86:	e8 55 f6 ff ff       	call   14e0 <RGB>
    1e8b:	83 c4 0c             	add    $0xc,%esp
    1e8e:	8b 1d 68 67 00 00    	mov    0x6768,%ebx
    1e94:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e97:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e9a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e9d:	6b c0 32             	imul   $0x32,%eax,%eax
    1ea0:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1ea3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea6:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ea9:	83 ec 0c             	sub    $0xc,%esp
    1eac:	83 ec 04             	sub    $0x4,%esp
    1eaf:	89 e0                	mov    %esp,%eax
    1eb1:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1eb5:	66 89 30             	mov    %si,(%eax)
    1eb8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1ebc:	88 50 02             	mov    %dl,0x2(%eax)
    1ebf:	6a 32                	push   $0x32
    1ec1:	6a 32                	push   $0x32
    1ec3:	6a 00                	push   $0x0
    1ec5:	6a 00                	push   $0x0
    1ec7:	53                   	push   %ebx
    1ec8:	51                   	push   %ecx
    1ec9:	ff 75 84             	pushl  -0x7c(%ebp)
    1ecc:	57                   	push   %edi
    1ecd:	e8 6a f4 ff ff       	call   133c <APDcCopy>
    1ed2:	83 c4 30             	add    $0x30,%esp
                    break;
    1ed5:	eb 5c                	jmp    1f33 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ed7:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1eda:	6a 0c                	push   $0xc
    1edc:	6a 0c                	push   $0xc
    1ede:	6a 0c                	push   $0xc
    1ee0:	50                   	push   %eax
    1ee1:	e8 fa f5 ff ff       	call   14e0 <RGB>
    1ee6:	83 c4 0c             	add    $0xc,%esp
    1ee9:	8b 1d 84 67 00 00    	mov    0x6784,%ebx
    1eef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ef2:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ef5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ef8:	6b c0 32             	imul   $0x32,%eax,%eax
    1efb:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1efe:	8b 45 08             	mov    0x8(%ebp),%eax
    1f01:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f04:	83 ec 0c             	sub    $0xc,%esp
    1f07:	83 ec 04             	sub    $0x4,%esp
    1f0a:	89 e0                	mov    %esp,%eax
    1f0c:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1f10:	66 89 30             	mov    %si,(%eax)
    1f13:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1f17:	88 50 02             	mov    %dl,0x2(%eax)
    1f1a:	6a 32                	push   $0x32
    1f1c:	6a 32                	push   $0x32
    1f1e:	6a 00                	push   $0x0
    1f20:	6a 00                	push   $0x0
    1f22:	53                   	push   %ebx
    1f23:	51                   	push   %ecx
    1f24:	ff 75 84             	pushl  -0x7c(%ebp)
    1f27:	57                   	push   %edi
    1f28:	e8 0f f4 ff ff       	call   133c <APDcCopy>
    1f2d:	83 c4 30             	add    $0x30,%esp
                    break;
    1f30:	eb 01                	jmp    1f33 <APGridPaint+0x639>
                default: break;
    1f32:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1f33:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1f37:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1f3b:	0f 8e 7a fc ff ff    	jle    1bbb <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1f41:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1f45:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1f49:	0f 8e 60 fc ff ff    	jle    1baf <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1f4f:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f52:	68 cd 00 00 00       	push   $0xcd
    1f57:	6a 74                	push   $0x74
    1f59:	6a 18                	push   $0x18
    1f5b:	50                   	push   %eax
    1f5c:	e8 7f f5 ff ff       	call   14e0 <RGB>
    1f61:	83 c4 0c             	add    $0xc,%esp
    1f64:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1f68:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1f6c:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1f70:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1f73:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1f7a:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f7d:	68 cd 00 00 00       	push   $0xcd
    1f82:	6a 74                	push   $0x74
    1f84:	6a 18                	push   $0x18
    1f86:	50                   	push   %eax
    1f87:	e8 54 f5 ff ff       	call   14e0 <RGB>
    1f8c:	83 c4 0c             	add    $0xc,%esp
    1f8f:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1f93:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1f97:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1f9b:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1f9e:	8b 45 08             	mov    0x8(%ebp),%eax
    1fa1:	8d 50 58             	lea    0x58(%eax),%edx
    1fa4:	8d 45 88             	lea    -0x78(%ebp),%eax
    1fa7:	ff 75 bc             	pushl  -0x44(%ebp)
    1faa:	ff 75 b8             	pushl  -0x48(%ebp)
    1fad:	52                   	push   %edx
    1fae:	50                   	push   %eax
    1faf:	e8 19 ec ff ff       	call   bcd <APSetPen>
    1fb4:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1fb7:	8b 45 08             	mov    0x8(%ebp),%eax
    1fba:	8d 58 58             	lea    0x58(%eax),%ebx
    1fbd:	8d 55 88             	lea    -0x78(%ebp),%edx
    1fc0:	83 ec 04             	sub    $0x4,%esp
    1fc3:	83 ec 04             	sub    $0x4,%esp
    1fc6:	89 e0                	mov    %esp,%eax
    1fc8:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1fcc:	66 89 08             	mov    %cx,(%eax)
    1fcf:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1fd3:	88 48 02             	mov    %cl,0x2(%eax)
    1fd6:	53                   	push   %ebx
    1fd7:	52                   	push   %edx
    1fd8:	e8 29 ec ff ff       	call   c06 <APSetBrush>
    1fdd:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1fe0:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe3:	83 c0 58             	add    $0x58,%eax
    1fe6:	83 ec 0c             	sub    $0xc,%esp
    1fe9:	6a 32                	push   $0x32
    1feb:	68 20 03 00 00       	push   $0x320
    1ff0:	6a 00                	push   $0x0
    1ff2:	6a 00                	push   $0x0
    1ff4:	50                   	push   %eax
    1ff5:	e8 36 f0 ff ff       	call   1030 <APDrawRect>
    1ffa:	83 c4 20             	add    $0x20,%esp
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    1ffd:	8d 45 88             	lea    -0x78(%ebp),%eax
    2000:	6a 08                	push   $0x8
    2002:	6a 08                	push   $0x8
    2004:	6a 08                	push   $0x8
    2006:	50                   	push   %eax
    2007:	e8 d4 f4 ff ff       	call   14e0 <RGB>
    200c:	83 c4 0c             	add    $0xc,%esp
    200f:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2013:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    2017:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    201b:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    201e:	8b 45 08             	mov    0x8(%ebp),%eax
    2021:	8d 58 58             	lea    0x58(%eax),%ebx
    2024:	8d 55 88             	lea    -0x78(%ebp),%edx
    2027:	83 ec 04             	sub    $0x4,%esp
    202a:	83 ec 04             	sub    $0x4,%esp
    202d:	89 e0                	mov    %esp,%eax
    202f:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    2033:	66 89 08             	mov    %cx,(%eax)
    2036:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    203a:	88 48 02             	mov    %cl,0x2(%eax)
    203d:	53                   	push   %ebx
    203e:	52                   	push   %edx
    203f:	e8 04 ec ff ff       	call   c48 <APSetFont>
    2044:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    2047:	8b 45 08             	mov    0x8(%ebp),%eax
    204a:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    2050:	8b 45 08             	mov    0x8(%ebp),%eax
    2053:	83 c0 58             	add    $0x58,%eax
    2056:	6a 14                	push   $0x14
    2058:	6a 14                	push   $0x14
    205a:	52                   	push   %edx
    205b:	50                   	push   %eax
    205c:	e8 d4 f1 ff ff       	call   1235 <APDrawText>
    2061:	83 c4 10             	add    $0x10,%esp
}
    2064:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2067:	5b                   	pop    %ebx
    2068:	5e                   	pop    %esi
    2069:	5f                   	pop    %edi
    206a:	5d                   	pop    %ebp
    206b:	c3                   	ret    

0000206c <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    206c:	55                   	push   %ebp
    206d:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    206f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2073:	7e 08                	jle    207d <random+0x11>
{
rand_num = seed;
    2075:	8b 45 08             	mov    0x8(%ebp),%eax
    2078:	a3 40 67 00 00       	mov    %eax,0x6740
}
rand_num *= 3;
    207d:	8b 15 40 67 00 00    	mov    0x6740,%edx
    2083:	89 d0                	mov    %edx,%eax
    2085:	01 c0                	add    %eax,%eax
    2087:	01 d0                	add    %edx,%eax
    2089:	a3 40 67 00 00       	mov    %eax,0x6740
if (rand_num < 0)
    208e:	a1 40 67 00 00       	mov    0x6740,%eax
    2093:	85 c0                	test   %eax,%eax
    2095:	79 0c                	jns    20a3 <random+0x37>
{
rand_num *= (-1);
    2097:	a1 40 67 00 00       	mov    0x6740,%eax
    209c:	f7 d8                	neg    %eax
    209e:	a3 40 67 00 00       	mov    %eax,0x6740
}
return rand_num % 997;
    20a3:	8b 0d 40 67 00 00    	mov    0x6740,%ecx
    20a9:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    20ae:	89 c8                	mov    %ecx,%eax
    20b0:	f7 ea                	imul   %edx
    20b2:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    20b5:	c1 f8 09             	sar    $0x9,%eax
    20b8:	89 c2                	mov    %eax,%edx
    20ba:	89 c8                	mov    %ecx,%eax
    20bc:	c1 f8 1f             	sar    $0x1f,%eax
    20bf:	29 c2                	sub    %eax,%edx
    20c1:	89 d0                	mov    %edx,%eax
    20c3:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    20c9:	29 c1                	sub    %eax,%ecx
    20cb:	89 c8                	mov    %ecx,%eax
}
    20cd:	5d                   	pop    %ebp
    20ce:	c3                   	ret    

000020cf <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    20cf:	55                   	push   %ebp
    20d0:	89 e5                	mov    %esp,%ebp
    20d2:	53                   	push   %ebx
    20d3:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    20d6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    20dd:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    20e1:	74 17                	je     20fa <sprintint+0x2b>
    20e3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    20e7:	79 11                	jns    20fa <sprintint+0x2b>
        neg = 1;
    20e9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    20f0:	8b 45 10             	mov    0x10(%ebp),%eax
    20f3:	f7 d8                	neg    %eax
    20f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    20f8:	eb 06                	jmp    2100 <sprintint+0x31>
    } else {
        x = xx;
    20fa:	8b 45 10             	mov    0x10(%ebp),%eax
    20fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2100:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2107:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    210a:	8d 41 01             	lea    0x1(%ecx),%eax
    210d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2110:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2113:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2116:	ba 00 00 00 00       	mov    $0x0,%edx
    211b:	f7 f3                	div    %ebx
    211d:	89 d0                	mov    %edx,%eax
    211f:	0f b6 80 44 67 00 00 	movzbl 0x6744(%eax),%eax
    2126:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    212a:	8b 5d 14             	mov    0x14(%ebp),%ebx
    212d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2130:	ba 00 00 00 00       	mov    $0x0,%edx
    2135:	f7 f3                	div    %ebx
    2137:	89 45 f0             	mov    %eax,-0x10(%ebp)
    213a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    213e:	75 c7                	jne    2107 <sprintint+0x38>
    if(neg)
    2140:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2144:	74 0e                	je     2154 <sprintint+0x85>
        buf[i++] = '-';
    2146:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2149:	8d 50 01             	lea    0x1(%eax),%edx
    214c:	89 55 f8             	mov    %edx,-0x8(%ebp)
    214f:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2154:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2157:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    215a:	eb 1b                	jmp    2177 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    215c:	8b 45 0c             	mov    0xc(%ebp),%eax
    215f:	8b 00                	mov    (%eax),%eax
    2161:	8d 48 01             	lea    0x1(%eax),%ecx
    2164:	8b 55 0c             	mov    0xc(%ebp),%edx
    2167:	89 0a                	mov    %ecx,(%edx)
    2169:	89 c2                	mov    %eax,%edx
    216b:	8b 45 08             	mov    0x8(%ebp),%eax
    216e:	01 d0                	add    %edx,%eax
    2170:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2173:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2177:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    217b:	7f df                	jg     215c <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    217d:	eb 21                	jmp    21a0 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    217f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2182:	8b 00                	mov    (%eax),%eax
    2184:	8d 48 01             	lea    0x1(%eax),%ecx
    2187:	8b 55 0c             	mov    0xc(%ebp),%edx
    218a:	89 0a                	mov    %ecx,(%edx)
    218c:	89 c2                	mov    %eax,%edx
    218e:	8b 45 08             	mov    0x8(%ebp),%eax
    2191:	01 c2                	add    %eax,%edx
    2193:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2196:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2199:	01 c8                	add    %ecx,%eax
    219b:	0f b6 00             	movzbl (%eax),%eax
    219e:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    21a0:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    21a4:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    21a8:	79 d5                	jns    217f <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    21aa:	90                   	nop
    21ab:	83 c4 20             	add    $0x20,%esp
    21ae:	5b                   	pop    %ebx
    21af:	5d                   	pop    %ebp
    21b0:	c3                   	ret    

000021b1 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    21b1:	55                   	push   %ebp
    21b2:	89 e5                	mov    %esp,%ebp
    21b4:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    21b7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    21be:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    21c5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    21cc:	8d 45 0c             	lea    0xc(%ebp),%eax
    21cf:	83 c0 04             	add    $0x4,%eax
    21d2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    21d5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    21dc:	e9 d9 01 00 00       	jmp    23ba <sprintf+0x209>
        c = fmt[i] & 0xff;
    21e1:	8b 55 0c             	mov    0xc(%ebp),%edx
    21e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    21e7:	01 d0                	add    %edx,%eax
    21e9:	0f b6 00             	movzbl (%eax),%eax
    21ec:	0f be c0             	movsbl %al,%eax
    21ef:	25 ff 00 00 00       	and    $0xff,%eax
    21f4:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    21f7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    21fb:	75 2c                	jne    2229 <sprintf+0x78>
            if(c == '%'){
    21fd:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2201:	75 0c                	jne    220f <sprintf+0x5e>
                state = '%';
    2203:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    220a:	e9 a7 01 00 00       	jmp    23b6 <sprintf+0x205>
            } else {
                dst[j++] = c;
    220f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2212:	8d 50 01             	lea    0x1(%eax),%edx
    2215:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2218:	89 c2                	mov    %eax,%edx
    221a:	8b 45 08             	mov    0x8(%ebp),%eax
    221d:	01 d0                	add    %edx,%eax
    221f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2222:	88 10                	mov    %dl,(%eax)
    2224:	e9 8d 01 00 00       	jmp    23b6 <sprintf+0x205>
            }
        } else if(state == '%'){
    2229:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    222d:	0f 85 83 01 00 00    	jne    23b6 <sprintf+0x205>
            if(c == 'd'){
    2233:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2237:	75 4c                	jne    2285 <sprintf+0xd4>
                buf[bi] = '\0';
    2239:	8d 55 ce             	lea    -0x32(%ebp),%edx
    223c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    223f:	01 d0                	add    %edx,%eax
    2241:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2244:	83 ec 0c             	sub    $0xc,%esp
    2247:	8d 45 ce             	lea    -0x32(%ebp),%eax
    224a:	50                   	push   %eax
    224b:	e8 e7 df ff ff       	call   237 <atoi>
    2250:	83 c4 10             	add    $0x10,%esp
    2253:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2256:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    225d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2260:	8b 00                	mov    (%eax),%eax
    2262:	83 ec 08             	sub    $0x8,%esp
    2265:	ff 75 d8             	pushl  -0x28(%ebp)
    2268:	6a 01                	push   $0x1
    226a:	6a 0a                	push   $0xa
    226c:	50                   	push   %eax
    226d:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2270:	50                   	push   %eax
    2271:	ff 75 08             	pushl  0x8(%ebp)
    2274:	e8 56 fe ff ff       	call   20cf <sprintint>
    2279:	83 c4 20             	add    $0x20,%esp
                ap++;
    227c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2280:	e9 2a 01 00 00       	jmp    23af <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2285:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2289:	74 06                	je     2291 <sprintf+0xe0>
    228b:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    228f:	75 4c                	jne    22dd <sprintf+0x12c>
                buf[bi] = '\0';
    2291:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2294:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2297:	01 d0                	add    %edx,%eax
    2299:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    229c:	83 ec 0c             	sub    $0xc,%esp
    229f:	8d 45 ce             	lea    -0x32(%ebp),%eax
    22a2:	50                   	push   %eax
    22a3:	e8 8f df ff ff       	call   237 <atoi>
    22a8:	83 c4 10             	add    $0x10,%esp
    22ab:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    22ae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    22b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22b8:	8b 00                	mov    (%eax),%eax
    22ba:	83 ec 08             	sub    $0x8,%esp
    22bd:	ff 75 dc             	pushl  -0x24(%ebp)
    22c0:	6a 00                	push   $0x0
    22c2:	6a 10                	push   $0x10
    22c4:	50                   	push   %eax
    22c5:	8d 45 c8             	lea    -0x38(%ebp),%eax
    22c8:	50                   	push   %eax
    22c9:	ff 75 08             	pushl  0x8(%ebp)
    22cc:	e8 fe fd ff ff       	call   20cf <sprintint>
    22d1:	83 c4 20             	add    $0x20,%esp
                ap++;
    22d4:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    22d8:	e9 d2 00 00 00       	jmp    23af <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    22dd:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    22e1:	75 46                	jne    2329 <sprintf+0x178>
                s = (char*)*ap;
    22e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22e6:	8b 00                	mov    (%eax),%eax
    22e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    22eb:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    22ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    22f3:	75 25                	jne    231a <sprintf+0x169>
                    s = "(null)";
    22f5:	c7 45 f4 6c 25 00 00 	movl   $0x256c,-0xc(%ebp)
                while(*s != 0){
    22fc:	eb 1c                	jmp    231a <sprintf+0x169>
                    dst[j++] = *s;
    22fe:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2301:	8d 50 01             	lea    0x1(%eax),%edx
    2304:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2307:	89 c2                	mov    %eax,%edx
    2309:	8b 45 08             	mov    0x8(%ebp),%eax
    230c:	01 c2                	add    %eax,%edx
    230e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2311:	0f b6 00             	movzbl (%eax),%eax
    2314:	88 02                	mov    %al,(%edx)
                    s++;
    2316:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    231a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    231d:	0f b6 00             	movzbl (%eax),%eax
    2320:	84 c0                	test   %al,%al
    2322:	75 da                	jne    22fe <sprintf+0x14d>
    2324:	e9 86 00 00 00       	jmp    23af <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2329:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    232d:	75 1d                	jne    234c <sprintf+0x19b>
                dst[j++] = *ap;
    232f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2332:	8d 50 01             	lea    0x1(%eax),%edx
    2335:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2338:	89 c2                	mov    %eax,%edx
    233a:	8b 45 08             	mov    0x8(%ebp),%eax
    233d:	01 c2                	add    %eax,%edx
    233f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2342:	8b 00                	mov    (%eax),%eax
    2344:	88 02                	mov    %al,(%edx)
                ap++;
    2346:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    234a:	eb 63                	jmp    23af <sprintf+0x1fe>
            } else if(c == '%'){
    234c:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2350:	75 17                	jne    2369 <sprintf+0x1b8>
                dst[j++] = c;
    2352:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2355:	8d 50 01             	lea    0x1(%eax),%edx
    2358:	89 55 c8             	mov    %edx,-0x38(%ebp)
    235b:	89 c2                	mov    %eax,%edx
    235d:	8b 45 08             	mov    0x8(%ebp),%eax
    2360:	01 d0                	add    %edx,%eax
    2362:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2365:	88 10                	mov    %dl,(%eax)
    2367:	eb 46                	jmp    23af <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2369:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    236d:	7e 18                	jle    2387 <sprintf+0x1d6>
    236f:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2373:	7f 12                	jg     2387 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2375:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2378:	8d 50 01             	lea    0x1(%eax),%edx
    237b:	89 55 f0             	mov    %edx,-0x10(%ebp)
    237e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2381:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2385:	eb 2f                	jmp    23b6 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2387:	8b 45 c8             	mov    -0x38(%ebp),%eax
    238a:	8d 50 01             	lea    0x1(%eax),%edx
    238d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2390:	89 c2                	mov    %eax,%edx
    2392:	8b 45 08             	mov    0x8(%ebp),%eax
    2395:	01 d0                	add    %edx,%eax
    2397:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    239a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    239d:	8d 50 01             	lea    0x1(%eax),%edx
    23a0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23a3:	89 c2                	mov    %eax,%edx
    23a5:	8b 45 08             	mov    0x8(%ebp),%eax
    23a8:	01 d0                	add    %edx,%eax
    23aa:	8b 55 e0             	mov    -0x20(%ebp),%edx
    23ad:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    23af:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    23b6:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    23ba:	8b 55 0c             	mov    0xc(%ebp),%edx
    23bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23c0:	01 d0                	add    %edx,%eax
    23c2:	0f b6 00             	movzbl (%eax),%eax
    23c5:	84 c0                	test   %al,%al
    23c7:	0f 85 14 fe ff ff    	jne    21e1 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    23cd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23d0:	8d 50 01             	lea    0x1(%eax),%edx
    23d3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23d6:	89 c2                	mov    %eax,%edx
    23d8:	8b 45 08             	mov    0x8(%ebp),%eax
    23db:	01 d0                	add    %edx,%eax
    23dd:	c6 00 00             	movb   $0x0,(%eax)
}
    23e0:	90                   	nop
    23e1:	c9                   	leave  
    23e2:	c3                   	ret    
