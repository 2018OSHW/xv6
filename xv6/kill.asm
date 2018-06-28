
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
      1c:	68 18 21 00 00       	push   $0x2118
      21:	6a 02                	push   $0x2
      23:	e8 48 04 00 00       	call   470 <printf>
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

00000371 <initStringFigure>:
SYSCALL(initStringFigure)
     371:	b8 17 00 00 00       	mov    $0x17,%eax
     376:	cd 40                	int    $0x40
     378:	c3                   	ret    

00000379 <sendMessage>:
SYSCALL(sendMessage)
     379:	b8 18 00 00 00       	mov    $0x18,%eax
     37e:	cd 40                	int    $0x40
     380:	c3                   	ret    

00000381 <getMessage>:
SYSCALL(getMessage)
     381:	b8 1a 00 00 00       	mov    $0x1a,%eax
     386:	cd 40                	int    $0x40
     388:	c3                   	ret    

00000389 <registWindow>:
SYSCALL(registWindow)
     389:	b8 19 00 00 00       	mov    $0x19,%eax
     38e:	cd 40                	int    $0x40
     390:	c3                   	ret    

00000391 <changePosition>:
SYSCALL(changePosition)
     391:	b8 1b 00 00 00       	mov    $0x1b,%eax
     396:	cd 40                	int    $0x40
     398:	c3                   	ret    

00000399 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     399:	55                   	push   %ebp
     39a:	89 e5                	mov    %esp,%ebp
     39c:	83 ec 18             	sub    $0x18,%esp
     39f:	8b 45 0c             	mov    0xc(%ebp),%eax
     3a2:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3a5:	83 ec 04             	sub    $0x4,%esp
     3a8:	6a 01                	push   $0x1
     3aa:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3ad:	50                   	push   %eax
     3ae:	ff 75 08             	pushl  0x8(%ebp)
     3b1:	e8 33 ff ff ff       	call   2e9 <write>
     3b6:	83 c4 10             	add    $0x10,%esp
}
     3b9:	90                   	nop
     3ba:	c9                   	leave  
     3bb:	c3                   	ret    

000003bc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3bc:	55                   	push   %ebp
     3bd:	89 e5                	mov    %esp,%ebp
     3bf:	53                   	push   %ebx
     3c0:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3c3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3ca:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3ce:	74 17                	je     3e7 <printint+0x2b>
     3d0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3d4:	79 11                	jns    3e7 <printint+0x2b>
    neg = 1;
     3d6:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3dd:	8b 45 0c             	mov    0xc(%ebp),%eax
     3e0:	f7 d8                	neg    %eax
     3e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3e5:	eb 06                	jmp    3ed <printint+0x31>
  } else {
    x = xx;
     3e7:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ea:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3ed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3f4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3f7:	8d 41 01             	lea    0x1(%ecx),%eax
     3fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3fd:	8b 5d 10             	mov    0x10(%ebp),%ebx
     400:	8b 45 ec             	mov    -0x14(%ebp),%eax
     403:	ba 00 00 00 00       	mov    $0x0,%edx
     408:	f7 f3                	div    %ebx
     40a:	89 d0                	mov    %edx,%eax
     40c:	0f b6 80 d8 27 00 00 	movzbl 0x27d8(%eax),%eax
     413:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     417:	8b 5d 10             	mov    0x10(%ebp),%ebx
     41a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     41d:	ba 00 00 00 00       	mov    $0x0,%edx
     422:	f7 f3                	div    %ebx
     424:	89 45 ec             	mov    %eax,-0x14(%ebp)
     427:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     42b:	75 c7                	jne    3f4 <printint+0x38>
  if(neg)
     42d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     431:	74 2d                	je     460 <printint+0xa4>
    buf[i++] = '-';
     433:	8b 45 f4             	mov    -0xc(%ebp),%eax
     436:	8d 50 01             	lea    0x1(%eax),%edx
     439:	89 55 f4             	mov    %edx,-0xc(%ebp)
     43c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     441:	eb 1d                	jmp    460 <printint+0xa4>
    putc(fd, buf[i]);
     443:	8d 55 dc             	lea    -0x24(%ebp),%edx
     446:	8b 45 f4             	mov    -0xc(%ebp),%eax
     449:	01 d0                	add    %edx,%eax
     44b:	0f b6 00             	movzbl (%eax),%eax
     44e:	0f be c0             	movsbl %al,%eax
     451:	83 ec 08             	sub    $0x8,%esp
     454:	50                   	push   %eax
     455:	ff 75 08             	pushl  0x8(%ebp)
     458:	e8 3c ff ff ff       	call   399 <putc>
     45d:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     460:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     464:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     468:	79 d9                	jns    443 <printint+0x87>
    putc(fd, buf[i]);
}
     46a:	90                   	nop
     46b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     46e:	c9                   	leave  
     46f:	c3                   	ret    

00000470 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     470:	55                   	push   %ebp
     471:	89 e5                	mov    %esp,%ebp
     473:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     476:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     47d:	8d 45 0c             	lea    0xc(%ebp),%eax
     480:	83 c0 04             	add    $0x4,%eax
     483:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     486:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     48d:	e9 59 01 00 00       	jmp    5eb <printf+0x17b>
    c = fmt[i] & 0xff;
     492:	8b 55 0c             	mov    0xc(%ebp),%edx
     495:	8b 45 f0             	mov    -0x10(%ebp),%eax
     498:	01 d0                	add    %edx,%eax
     49a:	0f b6 00             	movzbl (%eax),%eax
     49d:	0f be c0             	movsbl %al,%eax
     4a0:	25 ff 00 00 00       	and    $0xff,%eax
     4a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4ac:	75 2c                	jne    4da <printf+0x6a>
      if(c == '%'){
     4ae:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4b2:	75 0c                	jne    4c0 <printf+0x50>
        state = '%';
     4b4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4bb:	e9 27 01 00 00       	jmp    5e7 <printf+0x177>
      } else {
        putc(fd, c);
     4c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4c3:	0f be c0             	movsbl %al,%eax
     4c6:	83 ec 08             	sub    $0x8,%esp
     4c9:	50                   	push   %eax
     4ca:	ff 75 08             	pushl  0x8(%ebp)
     4cd:	e8 c7 fe ff ff       	call   399 <putc>
     4d2:	83 c4 10             	add    $0x10,%esp
     4d5:	e9 0d 01 00 00       	jmp    5e7 <printf+0x177>
      }
    } else if(state == '%'){
     4da:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4de:	0f 85 03 01 00 00    	jne    5e7 <printf+0x177>
      if(c == 'd'){
     4e4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4e8:	75 1e                	jne    508 <printf+0x98>
        printint(fd, *ap, 10, 1);
     4ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4ed:	8b 00                	mov    (%eax),%eax
     4ef:	6a 01                	push   $0x1
     4f1:	6a 0a                	push   $0xa
     4f3:	50                   	push   %eax
     4f4:	ff 75 08             	pushl  0x8(%ebp)
     4f7:	e8 c0 fe ff ff       	call   3bc <printint>
     4fc:	83 c4 10             	add    $0x10,%esp
        ap++;
     4ff:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     503:	e9 d8 00 00 00       	jmp    5e0 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     508:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     50c:	74 06                	je     514 <printf+0xa4>
     50e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     512:	75 1e                	jne    532 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     514:	8b 45 e8             	mov    -0x18(%ebp),%eax
     517:	8b 00                	mov    (%eax),%eax
     519:	6a 00                	push   $0x0
     51b:	6a 10                	push   $0x10
     51d:	50                   	push   %eax
     51e:	ff 75 08             	pushl  0x8(%ebp)
     521:	e8 96 fe ff ff       	call   3bc <printint>
     526:	83 c4 10             	add    $0x10,%esp
        ap++;
     529:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     52d:	e9 ae 00 00 00       	jmp    5e0 <printf+0x170>
      } else if(c == 's'){
     532:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     536:	75 43                	jne    57b <printf+0x10b>
        s = (char*)*ap;
     538:	8b 45 e8             	mov    -0x18(%ebp),%eax
     53b:	8b 00                	mov    (%eax),%eax
     53d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     540:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     544:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     548:	75 25                	jne    56f <printf+0xff>
          s = "(null)";
     54a:	c7 45 f4 2c 21 00 00 	movl   $0x212c,-0xc(%ebp)
        while(*s != 0){
     551:	eb 1c                	jmp    56f <printf+0xff>
          putc(fd, *s);
     553:	8b 45 f4             	mov    -0xc(%ebp),%eax
     556:	0f b6 00             	movzbl (%eax),%eax
     559:	0f be c0             	movsbl %al,%eax
     55c:	83 ec 08             	sub    $0x8,%esp
     55f:	50                   	push   %eax
     560:	ff 75 08             	pushl  0x8(%ebp)
     563:	e8 31 fe ff ff       	call   399 <putc>
     568:	83 c4 10             	add    $0x10,%esp
          s++;
     56b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     56f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     572:	0f b6 00             	movzbl (%eax),%eax
     575:	84 c0                	test   %al,%al
     577:	75 da                	jne    553 <printf+0xe3>
     579:	eb 65                	jmp    5e0 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     57b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     57f:	75 1d                	jne    59e <printf+0x12e>
        putc(fd, *ap);
     581:	8b 45 e8             	mov    -0x18(%ebp),%eax
     584:	8b 00                	mov    (%eax),%eax
     586:	0f be c0             	movsbl %al,%eax
     589:	83 ec 08             	sub    $0x8,%esp
     58c:	50                   	push   %eax
     58d:	ff 75 08             	pushl  0x8(%ebp)
     590:	e8 04 fe ff ff       	call   399 <putc>
     595:	83 c4 10             	add    $0x10,%esp
        ap++;
     598:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     59c:	eb 42                	jmp    5e0 <printf+0x170>
      } else if(c == '%'){
     59e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5a2:	75 17                	jne    5bb <printf+0x14b>
        putc(fd, c);
     5a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5a7:	0f be c0             	movsbl %al,%eax
     5aa:	83 ec 08             	sub    $0x8,%esp
     5ad:	50                   	push   %eax
     5ae:	ff 75 08             	pushl  0x8(%ebp)
     5b1:	e8 e3 fd ff ff       	call   399 <putc>
     5b6:	83 c4 10             	add    $0x10,%esp
     5b9:	eb 25                	jmp    5e0 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5bb:	83 ec 08             	sub    $0x8,%esp
     5be:	6a 25                	push   $0x25
     5c0:	ff 75 08             	pushl  0x8(%ebp)
     5c3:	e8 d1 fd ff ff       	call   399 <putc>
     5c8:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5ce:	0f be c0             	movsbl %al,%eax
     5d1:	83 ec 08             	sub    $0x8,%esp
     5d4:	50                   	push   %eax
     5d5:	ff 75 08             	pushl  0x8(%ebp)
     5d8:	e8 bc fd ff ff       	call   399 <putc>
     5dd:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5e0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5e7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5eb:	8b 55 0c             	mov    0xc(%ebp),%edx
     5ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5f1:	01 d0                	add    %edx,%eax
     5f3:	0f b6 00             	movzbl (%eax),%eax
     5f6:	84 c0                	test   %al,%al
     5f8:	0f 85 94 fe ff ff    	jne    492 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     5fe:	90                   	nop
     5ff:	c9                   	leave  
     600:	c3                   	ret    

00000601 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     601:	55                   	push   %ebp
     602:	89 e5                	mov    %esp,%ebp
     604:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     607:	8b 45 08             	mov    0x8(%ebp),%eax
     60a:	83 e8 08             	sub    $0x8,%eax
     60d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     610:	a1 0c 28 00 00       	mov    0x280c,%eax
     615:	89 45 fc             	mov    %eax,-0x4(%ebp)
     618:	eb 24                	jmp    63e <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     61a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     61d:	8b 00                	mov    (%eax),%eax
     61f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     622:	77 12                	ja     636 <free+0x35>
     624:	8b 45 f8             	mov    -0x8(%ebp),%eax
     627:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     62a:	77 24                	ja     650 <free+0x4f>
     62c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     62f:	8b 00                	mov    (%eax),%eax
     631:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     634:	77 1a                	ja     650 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     636:	8b 45 fc             	mov    -0x4(%ebp),%eax
     639:	8b 00                	mov    (%eax),%eax
     63b:	89 45 fc             	mov    %eax,-0x4(%ebp)
     63e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     641:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     644:	76 d4                	jbe    61a <free+0x19>
     646:	8b 45 fc             	mov    -0x4(%ebp),%eax
     649:	8b 00                	mov    (%eax),%eax
     64b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     64e:	76 ca                	jbe    61a <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     650:	8b 45 f8             	mov    -0x8(%ebp),%eax
     653:	8b 40 04             	mov    0x4(%eax),%eax
     656:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     65d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     660:	01 c2                	add    %eax,%edx
     662:	8b 45 fc             	mov    -0x4(%ebp),%eax
     665:	8b 00                	mov    (%eax),%eax
     667:	39 c2                	cmp    %eax,%edx
     669:	75 24                	jne    68f <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     66b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     66e:	8b 50 04             	mov    0x4(%eax),%edx
     671:	8b 45 fc             	mov    -0x4(%ebp),%eax
     674:	8b 00                	mov    (%eax),%eax
     676:	8b 40 04             	mov    0x4(%eax),%eax
     679:	01 c2                	add    %eax,%edx
     67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     67e:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     681:	8b 45 fc             	mov    -0x4(%ebp),%eax
     684:	8b 00                	mov    (%eax),%eax
     686:	8b 10                	mov    (%eax),%edx
     688:	8b 45 f8             	mov    -0x8(%ebp),%eax
     68b:	89 10                	mov    %edx,(%eax)
     68d:	eb 0a                	jmp    699 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     68f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     692:	8b 10                	mov    (%eax),%edx
     694:	8b 45 f8             	mov    -0x8(%ebp),%eax
     697:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     699:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69c:	8b 40 04             	mov    0x4(%eax),%eax
     69f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a9:	01 d0                	add    %edx,%eax
     6ab:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6ae:	75 20                	jne    6d0 <free+0xcf>
    p->s.size += bp->s.size;
     6b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b3:	8b 50 04             	mov    0x4(%eax),%edx
     6b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b9:	8b 40 04             	mov    0x4(%eax),%eax
     6bc:	01 c2                	add    %eax,%edx
     6be:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c7:	8b 10                	mov    (%eax),%edx
     6c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cc:	89 10                	mov    %edx,(%eax)
     6ce:	eb 08                	jmp    6d8 <free+0xd7>
  } else
    p->s.ptr = bp;
     6d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d3:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6d6:	89 10                	mov    %edx,(%eax)
  freep = p;
     6d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6db:	a3 0c 28 00 00       	mov    %eax,0x280c
}
     6e0:	90                   	nop
     6e1:	c9                   	leave  
     6e2:	c3                   	ret    

000006e3 <morecore>:

static Header*
morecore(uint nu)
{
     6e3:	55                   	push   %ebp
     6e4:	89 e5                	mov    %esp,%ebp
     6e6:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6e9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6f0:	77 07                	ja     6f9 <morecore+0x16>
    nu = 4096;
     6f2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     6f9:	8b 45 08             	mov    0x8(%ebp),%eax
     6fc:	c1 e0 03             	shl    $0x3,%eax
     6ff:	83 ec 0c             	sub    $0xc,%esp
     702:	50                   	push   %eax
     703:	e8 49 fc ff ff       	call   351 <sbrk>
     708:	83 c4 10             	add    $0x10,%esp
     70b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     70e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     712:	75 07                	jne    71b <morecore+0x38>
    return 0;
     714:	b8 00 00 00 00       	mov    $0x0,%eax
     719:	eb 26                	jmp    741 <morecore+0x5e>
  hp = (Header*)p;
     71b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     71e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     721:	8b 45 f0             	mov    -0x10(%ebp),%eax
     724:	8b 55 08             	mov    0x8(%ebp),%edx
     727:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     72a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     72d:	83 c0 08             	add    $0x8,%eax
     730:	83 ec 0c             	sub    $0xc,%esp
     733:	50                   	push   %eax
     734:	e8 c8 fe ff ff       	call   601 <free>
     739:	83 c4 10             	add    $0x10,%esp
  return freep;
     73c:	a1 0c 28 00 00       	mov    0x280c,%eax
}
     741:	c9                   	leave  
     742:	c3                   	ret    

00000743 <malloc>:

void*
malloc(uint nbytes)
{
     743:	55                   	push   %ebp
     744:	89 e5                	mov    %esp,%ebp
     746:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     749:	8b 45 08             	mov    0x8(%ebp),%eax
     74c:	83 c0 07             	add    $0x7,%eax
     74f:	c1 e8 03             	shr    $0x3,%eax
     752:	83 c0 01             	add    $0x1,%eax
     755:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     758:	a1 0c 28 00 00       	mov    0x280c,%eax
     75d:	89 45 f0             	mov    %eax,-0x10(%ebp)
     760:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     764:	75 23                	jne    789 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     766:	c7 45 f0 04 28 00 00 	movl   $0x2804,-0x10(%ebp)
     76d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     770:	a3 0c 28 00 00       	mov    %eax,0x280c
     775:	a1 0c 28 00 00       	mov    0x280c,%eax
     77a:	a3 04 28 00 00       	mov    %eax,0x2804
    base.s.size = 0;
     77f:	c7 05 08 28 00 00 00 	movl   $0x0,0x2808
     786:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     789:	8b 45 f0             	mov    -0x10(%ebp),%eax
     78c:	8b 00                	mov    (%eax),%eax
     78e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     791:	8b 45 f4             	mov    -0xc(%ebp),%eax
     794:	8b 40 04             	mov    0x4(%eax),%eax
     797:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     79a:	72 4d                	jb     7e9 <malloc+0xa6>
      if(p->s.size == nunits)
     79c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     79f:	8b 40 04             	mov    0x4(%eax),%eax
     7a2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7a5:	75 0c                	jne    7b3 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7aa:	8b 10                	mov    (%eax),%edx
     7ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7af:	89 10                	mov    %edx,(%eax)
     7b1:	eb 26                	jmp    7d9 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b6:	8b 40 04             	mov    0x4(%eax),%eax
     7b9:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7bc:	89 c2                	mov    %eax,%edx
     7be:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c7:	8b 40 04             	mov    0x4(%eax),%eax
     7ca:	c1 e0 03             	shl    $0x3,%eax
     7cd:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d3:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7d6:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7dc:	a3 0c 28 00 00       	mov    %eax,0x280c
      return (void*)(p + 1);
     7e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e4:	83 c0 08             	add    $0x8,%eax
     7e7:	eb 3b                	jmp    824 <malloc+0xe1>
    }
    if(p == freep)
     7e9:	a1 0c 28 00 00       	mov    0x280c,%eax
     7ee:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7f1:	75 1e                	jne    811 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7f3:	83 ec 0c             	sub    $0xc,%esp
     7f6:	ff 75 ec             	pushl  -0x14(%ebp)
     7f9:	e8 e5 fe ff ff       	call   6e3 <morecore>
     7fe:	83 c4 10             	add    $0x10,%esp
     801:	89 45 f4             	mov    %eax,-0xc(%ebp)
     804:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     808:	75 07                	jne    811 <malloc+0xce>
        return 0;
     80a:	b8 00 00 00 00       	mov    $0x0,%eax
     80f:	eb 13                	jmp    824 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     811:	8b 45 f4             	mov    -0xc(%ebp),%eax
     814:	89 45 f0             	mov    %eax,-0x10(%ebp)
     817:	8b 45 f4             	mov    -0xc(%ebp),%eax
     81a:	8b 00                	mov    (%eax),%eax
     81c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     81f:	e9 6d ff ff ff       	jmp    791 <malloc+0x4e>
}
     824:	c9                   	leave  
     825:	c3                   	ret    

00000826 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     826:	55                   	push   %ebp
     827:	89 e5                	mov    %esp,%ebp
     829:	83 ec 1c             	sub    $0x1c,%esp
     82c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     82f:	8b 55 10             	mov    0x10(%ebp),%edx
     832:	8b 45 14             	mov    0x14(%ebp),%eax
     835:	88 4d ec             	mov    %cl,-0x14(%ebp)
     838:	88 55 e8             	mov    %dl,-0x18(%ebp)
     83b:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     83e:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     842:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     845:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     849:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     84c:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     850:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     853:	8b 45 08             	mov    0x8(%ebp),%eax
     856:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     85a:	66 89 10             	mov    %dx,(%eax)
     85d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     861:	88 50 02             	mov    %dl,0x2(%eax)
}
     864:	8b 45 08             	mov    0x8(%ebp),%eax
     867:	c9                   	leave  
     868:	c2 04 00             	ret    $0x4

0000086b <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     86b:	55                   	push   %ebp
     86c:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     86e:	8b 45 08             	mov    0x8(%ebp),%eax
     871:	2b 45 10             	sub    0x10(%ebp),%eax
     874:	89 c2                	mov    %eax,%edx
     876:	8b 45 08             	mov    0x8(%ebp),%eax
     879:	2b 45 10             	sub    0x10(%ebp),%eax
     87c:	0f af d0             	imul   %eax,%edx
     87f:	8b 45 0c             	mov    0xc(%ebp),%eax
     882:	2b 45 14             	sub    0x14(%ebp),%eax
     885:	89 c1                	mov    %eax,%ecx
     887:	8b 45 0c             	mov    0xc(%ebp),%eax
     88a:	2b 45 14             	sub    0x14(%ebp),%eax
     88d:	0f af c1             	imul   %ecx,%eax
     890:	01 d0                	add    %edx,%eax
}
     892:	5d                   	pop    %ebp
     893:	c3                   	ret    

00000894 <abs_int>:

static inline int abs_int(int x)
{
     894:	55                   	push   %ebp
     895:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     897:	8b 45 08             	mov    0x8(%ebp),%eax
     89a:	99                   	cltd   
     89b:	89 d0                	mov    %edx,%eax
     89d:	33 45 08             	xor    0x8(%ebp),%eax
     8a0:	29 d0                	sub    %edx,%eax
}
     8a2:	5d                   	pop    %ebp
     8a3:	c3                   	ret    

000008a4 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     8a4:	55                   	push   %ebp
     8a5:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     8a7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8ab:	79 07                	jns    8b4 <APGetIndex+0x10>
        return X_SMALLER;
     8ad:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8b2:	eb 40                	jmp    8f4 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8b4:	8b 45 08             	mov    0x8(%ebp),%eax
     8b7:	8b 00                	mov    (%eax),%eax
     8b9:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8bc:	7f 07                	jg     8c5 <APGetIndex+0x21>
        return X_BIGGER;
     8be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8c3:	eb 2f                	jmp    8f4 <APGetIndex+0x50>
    if (y < 0)
     8c5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8c9:	79 07                	jns    8d2 <APGetIndex+0x2e>
        return Y_SMALLER;
     8cb:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8d0:	eb 22                	jmp    8f4 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8d2:	8b 45 08             	mov    0x8(%ebp),%eax
     8d5:	8b 40 04             	mov    0x4(%eax),%eax
     8d8:	3b 45 10             	cmp    0x10(%ebp),%eax
     8db:	7f 07                	jg     8e4 <APGetIndex+0x40>
        return Y_BIGGER;
     8dd:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8e2:	eb 10                	jmp    8f4 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8e4:	8b 45 08             	mov    0x8(%ebp),%eax
     8e7:	8b 00                	mov    (%eax),%eax
     8e9:	0f af 45 10          	imul   0x10(%ebp),%eax
     8ed:	89 c2                	mov    %eax,%edx
     8ef:	8b 45 0c             	mov    0xc(%ebp),%eax
     8f2:	01 d0                	add    %edx,%eax
}
     8f4:	5d                   	pop    %ebp
     8f5:	c3                   	ret    

000008f6 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     8f6:	55                   	push   %ebp
     8f7:	89 e5                	mov    %esp,%ebp
     8f9:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     8fc:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     903:	8b 45 cc             	mov    -0x34(%ebp),%eax
     906:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     909:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     910:	83 ec 08             	sub    $0x8,%esp
     913:	6a 00                	push   $0x0
     915:	ff 75 0c             	pushl  0xc(%ebp)
     918:	e8 ec f9 ff ff       	call   309 <open>
     91d:	83 c4 10             	add    $0x10,%esp
     920:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     923:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     927:	79 2e                	jns    957 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     929:	83 ec 04             	sub    $0x4,%esp
     92c:	ff 75 0c             	pushl  0xc(%ebp)
     92f:	68 33 21 00 00       	push   $0x2133
     934:	6a 01                	push   $0x1
     936:	e8 35 fb ff ff       	call   470 <printf>
     93b:	83 c4 10             	add    $0x10,%esp
        return bmp;
     93e:	8b 45 08             	mov    0x8(%ebp),%eax
     941:	8b 55 c8             	mov    -0x38(%ebp),%edx
     944:	89 10                	mov    %edx,(%eax)
     946:	8b 55 cc             	mov    -0x34(%ebp),%edx
     949:	89 50 04             	mov    %edx,0x4(%eax)
     94c:	8b 55 d0             	mov    -0x30(%ebp),%edx
     94f:	89 50 08             	mov    %edx,0x8(%eax)
     952:	e9 d2 01 00 00       	jmp    b29 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     957:	83 ec 04             	sub    $0x4,%esp
     95a:	6a 0e                	push   $0xe
     95c:	8d 45 ba             	lea    -0x46(%ebp),%eax
     95f:	50                   	push   %eax
     960:	ff 75 ec             	pushl  -0x14(%ebp)
     963:	e8 79 f9 ff ff       	call   2e1 <read>
     968:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     96b:	83 ec 04             	sub    $0x4,%esp
     96e:	6a 28                	push   $0x28
     970:	8d 45 92             	lea    -0x6e(%ebp),%eax
     973:	50                   	push   %eax
     974:	ff 75 ec             	pushl  -0x14(%ebp)
     977:	e8 65 f9 ff ff       	call   2e1 <read>
     97c:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     97f:	8b 45 96             	mov    -0x6a(%ebp),%eax
     982:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     985:	8b 45 9a             	mov    -0x66(%ebp),%eax
     988:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     98b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     98e:	8b 45 cc             	mov    -0x34(%ebp),%eax
     991:	0f af d0             	imul   %eax,%edx
     994:	89 d0                	mov    %edx,%eax
     996:	01 c0                	add    %eax,%eax
     998:	01 d0                	add    %edx,%eax
     99a:	83 ec 0c             	sub    $0xc,%esp
     99d:	50                   	push   %eax
     99e:	e8 a0 fd ff ff       	call   743 <malloc>
     9a3:	83 c4 10             	add    $0x10,%esp
     9a6:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9a9:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9ad:	0f b7 c0             	movzwl %ax,%eax
     9b0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9b3:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9b9:	0f af c2             	imul   %edx,%eax
     9bc:	83 c0 1f             	add    $0x1f,%eax
     9bf:	c1 e8 05             	shr    $0x5,%eax
     9c2:	c1 e0 02             	shl    $0x2,%eax
     9c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9c8:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9ce:	0f af c2             	imul   %edx,%eax
     9d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9d7:	83 ec 0c             	sub    $0xc,%esp
     9da:	50                   	push   %eax
     9db:	e8 63 fd ff ff       	call   743 <malloc>
     9e0:	83 c4 10             	add    $0x10,%esp
     9e3:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9e6:	83 ec 04             	sub    $0x4,%esp
     9e9:	ff 75 e0             	pushl  -0x20(%ebp)
     9ec:	ff 75 dc             	pushl  -0x24(%ebp)
     9ef:	ff 75 ec             	pushl  -0x14(%ebp)
     9f2:	e8 ea f8 ff ff       	call   2e1 <read>
     9f7:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     9fa:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9fe:	66 c1 e8 03          	shr    $0x3,%ax
     a02:	0f b7 c0             	movzwl %ax,%eax
     a05:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a08:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a0f:	e9 e5 00 00 00       	jmp    af9 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a14:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a17:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a1a:	29 c2                	sub    %eax,%edx
     a1c:	89 d0                	mov    %edx,%eax
     a1e:	8d 50 ff             	lea    -0x1(%eax),%edx
     a21:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a24:	0f af c2             	imul   %edx,%eax
     a27:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a2a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a31:	e9 b1 00 00 00       	jmp    ae7 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a36:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a39:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a3f:	01 c8                	add    %ecx,%eax
     a41:	89 c1                	mov    %eax,%ecx
     a43:	89 c8                	mov    %ecx,%eax
     a45:	01 c0                	add    %eax,%eax
     a47:	01 c8                	add    %ecx,%eax
     a49:	01 c2                	add    %eax,%edx
     a4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a4e:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a52:	89 c1                	mov    %eax,%ecx
     a54:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a57:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a5b:	01 c1                	add    %eax,%ecx
     a5d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a60:	01 c8                	add    %ecx,%eax
     a62:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a65:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a68:	01 c8                	add    %ecx,%eax
     a6a:	0f b6 00             	movzbl (%eax),%eax
     a6d:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a70:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a73:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a76:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a79:	01 c8                	add    %ecx,%eax
     a7b:	89 c1                	mov    %eax,%ecx
     a7d:	89 c8                	mov    %ecx,%eax
     a7f:	01 c0                	add    %eax,%eax
     a81:	01 c8                	add    %ecx,%eax
     a83:	01 c2                	add    %eax,%edx
     a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a88:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a8c:	89 c1                	mov    %eax,%ecx
     a8e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a91:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a95:	01 c1                	add    %eax,%ecx
     a97:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a9a:	01 c8                	add    %ecx,%eax
     a9c:	8d 48 fe             	lea    -0x2(%eax),%ecx
     a9f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     aa2:	01 c8                	add    %ecx,%eax
     aa4:	0f b6 00             	movzbl (%eax),%eax
     aa7:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     aaa:	8b 55 d0             	mov    -0x30(%ebp),%edx
     aad:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ab0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ab3:	01 c8                	add    %ecx,%eax
     ab5:	89 c1                	mov    %eax,%ecx
     ab7:	89 c8                	mov    %ecx,%eax
     ab9:	01 c0                	add    %eax,%eax
     abb:	01 c8                	add    %ecx,%eax
     abd:	01 c2                	add    %eax,%edx
     abf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac2:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ac6:	89 c1                	mov    %eax,%ecx
     ac8:	8b 45 d8             	mov    -0x28(%ebp),%eax
     acb:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     acf:	01 c1                	add    %eax,%ecx
     ad1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ad4:	01 c8                	add    %ecx,%eax
     ad6:	8d 48 fd             	lea    -0x3(%eax),%ecx
     ad9:	8b 45 dc             	mov    -0x24(%ebp),%eax
     adc:	01 c8                	add    %ecx,%eax
     ade:	0f b6 00             	movzbl (%eax),%eax
     ae1:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     ae3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ae7:	8b 55 c8             	mov    -0x38(%ebp),%edx
     aea:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aed:	39 c2                	cmp    %eax,%edx
     aef:	0f 87 41 ff ff ff    	ja     a36 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     af5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     af9:	8b 55 cc             	mov    -0x34(%ebp),%edx
     afc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aff:	39 c2                	cmp    %eax,%edx
     b01:	0f 87 0d ff ff ff    	ja     a14 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b07:	83 ec 0c             	sub    $0xc,%esp
     b0a:	ff 75 ec             	pushl  -0x14(%ebp)
     b0d:	e8 df f7 ff ff       	call   2f1 <close>
     b12:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b15:	8b 45 08             	mov    0x8(%ebp),%eax
     b18:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b1b:	89 10                	mov    %edx,(%eax)
     b1d:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b20:	89 50 04             	mov    %edx,0x4(%eax)
     b23:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b26:	89 50 08             	mov    %edx,0x8(%eax)
}
     b29:	8b 45 08             	mov    0x8(%ebp),%eax
     b2c:	c9                   	leave  
     b2d:	c2 04 00             	ret    $0x4

00000b30 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b30:	55                   	push   %ebp
     b31:	89 e5                	mov    %esp,%ebp
     b33:	53                   	push   %ebx
     b34:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b37:	83 ec 0c             	sub    $0xc,%esp
     b3a:	6a 1c                	push   $0x1c
     b3c:	e8 02 fc ff ff       	call   743 <malloc>
     b41:	83 c4 10             	add    $0x10,%esp
     b44:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b47:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b4a:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b51:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b54:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b57:	6a 0c                	push   $0xc
     b59:	6a 0c                	push   $0xc
     b5b:	6a 0c                	push   $0xc
     b5d:	50                   	push   %eax
     b5e:	e8 c3 fc ff ff       	call   826 <RGB>
     b63:	83 c4 0c             	add    $0xc,%esp
     b66:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b6a:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b6e:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b72:	88 43 15             	mov    %al,0x15(%ebx)
     b75:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b78:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b7b:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b7f:	66 89 48 10          	mov    %cx,0x10(%eax)
     b83:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b87:	88 50 12             	mov    %dl,0x12(%eax)
     b8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b8d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b90:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     b94:	66 89 48 08          	mov    %cx,0x8(%eax)
     b98:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     b9c:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     b9f:	8b 45 08             	mov    0x8(%ebp),%eax
     ba2:	89 c2                	mov    %eax,%edx
     ba4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba7:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     ba9:	8b 45 0c             	mov    0xc(%ebp),%eax
     bac:	89 c2                	mov    %eax,%edx
     bae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb1:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bb4:	8b 55 10             	mov    0x10(%ebp),%edx
     bb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bba:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     bbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bc0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bc3:	c9                   	leave  
     bc4:	c3                   	ret    

00000bc5 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     bc5:	55                   	push   %ebp
     bc6:	89 e5                	mov    %esp,%ebp
     bc8:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     bcb:	8b 45 0c             	mov    0xc(%ebp),%eax
     bce:	8b 50 08             	mov    0x8(%eax),%edx
     bd1:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bd4:	8b 40 0c             	mov    0xc(%eax),%eax
     bd7:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     bda:	8b 45 0c             	mov    0xc(%ebp),%eax
     bdd:	8b 55 10             	mov    0x10(%ebp),%edx
     be0:	89 50 08             	mov    %edx,0x8(%eax)
     be3:	8b 55 14             	mov    0x14(%ebp),%edx
     be6:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     be9:	8b 45 08             	mov    0x8(%ebp),%eax
     bec:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bef:	89 10                	mov    %edx,(%eax)
     bf1:	8b 55 fc             	mov    -0x4(%ebp),%edx
     bf4:	89 50 04             	mov    %edx,0x4(%eax)
}
     bf7:	8b 45 08             	mov    0x8(%ebp),%eax
     bfa:	c9                   	leave  
     bfb:	c2 04 00             	ret    $0x4

00000bfe <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     bfe:	55                   	push   %ebp
     bff:	89 e5                	mov    %esp,%ebp
     c01:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c04:	8b 45 0c             	mov    0xc(%ebp),%eax
     c07:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c0b:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c0f:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c13:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c16:	8b 45 0c             	mov    0xc(%ebp),%eax
     c19:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c1d:	66 89 50 10          	mov    %dx,0x10(%eax)
     c21:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c25:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c28:	8b 45 08             	mov    0x8(%ebp),%eax
     c2b:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c2f:	66 89 10             	mov    %dx,(%eax)
     c32:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c36:	88 50 02             	mov    %dl,0x2(%eax)
}
     c39:	8b 45 08             	mov    0x8(%ebp),%eax
     c3c:	c9                   	leave  
     c3d:	c2 04 00             	ret    $0x4

00000c40 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c46:	8b 45 08             	mov    0x8(%ebp),%eax
     c49:	8b 40 0c             	mov    0xc(%eax),%eax
     c4c:	89 c2                	mov    %eax,%edx
     c4e:	c1 ea 1f             	shr    $0x1f,%edx
     c51:	01 d0                	add    %edx,%eax
     c53:	d1 f8                	sar    %eax
     c55:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c58:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5b:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c62:	8b 45 10             	mov    0x10(%ebp),%eax
     c65:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c68:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c6b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c6f:	0f 89 98 00 00 00    	jns    d0d <APDrawPoint+0xcd>
        i = 0;
     c75:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c7c:	e9 8c 00 00 00       	jmp    d0d <APDrawPoint+0xcd>
    {
        j = x - off;
     c81:	8b 45 0c             	mov    0xc(%ebp),%eax
     c84:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c87:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     c8a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     c8e:	79 69                	jns    cf9 <APDrawPoint+0xb9>
            j = 0;
     c90:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     c97:	eb 60                	jmp    cf9 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     c99:	ff 75 fc             	pushl  -0x4(%ebp)
     c9c:	ff 75 f8             	pushl  -0x8(%ebp)
     c9f:	ff 75 08             	pushl  0x8(%ebp)
     ca2:	e8 fd fb ff ff       	call   8a4 <APGetIndex>
     ca7:	83 c4 0c             	add    $0xc,%esp
     caa:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     cad:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cb1:	74 55                	je     d08 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cb3:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     cb7:	74 67                	je     d20 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     cb9:	ff 75 10             	pushl  0x10(%ebp)
     cbc:	ff 75 0c             	pushl  0xc(%ebp)
     cbf:	ff 75 fc             	pushl  -0x4(%ebp)
     cc2:	ff 75 f8             	pushl  -0x8(%ebp)
     cc5:	e8 a1 fb ff ff       	call   86b <distance_2>
     cca:	83 c4 10             	add    $0x10,%esp
     ccd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     cd0:	7f 23                	jg     cf5 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     cd2:	8b 45 08             	mov    0x8(%ebp),%eax
     cd5:	8b 48 18             	mov    0x18(%eax),%ecx
     cd8:	8b 55 ec             	mov    -0x14(%ebp),%edx
     cdb:	89 d0                	mov    %edx,%eax
     cdd:	01 c0                	add    %eax,%eax
     cdf:	01 d0                	add    %edx,%eax
     ce1:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     ce4:	8b 45 08             	mov    0x8(%ebp),%eax
     ce7:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     ceb:	66 89 0a             	mov    %cx,(%edx)
     cee:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     cf2:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     cf5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     cf9:	8b 55 0c             	mov    0xc(%ebp),%edx
     cfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cff:	01 d0                	add    %edx,%eax
     d01:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d04:	7d 93                	jge    c99 <APDrawPoint+0x59>
     d06:	eb 01                	jmp    d09 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d08:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d09:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d0d:	8b 55 10             	mov    0x10(%ebp),%edx
     d10:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d13:	01 d0                	add    %edx,%eax
     d15:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d18:	0f 8d 63 ff ff ff    	jge    c81 <APDrawPoint+0x41>
     d1e:	eb 01                	jmp    d21 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d20:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d21:	c9                   	leave  
     d22:	c3                   	ret    

00000d23 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d23:	55                   	push   %ebp
     d24:	89 e5                	mov    %esp,%ebp
     d26:	53                   	push   %ebx
     d27:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d2a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d2d:	3b 45 14             	cmp    0x14(%ebp),%eax
     d30:	0f 85 80 00 00 00    	jne    db6 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d36:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d3a:	0f 88 9d 02 00 00    	js     fdd <APDrawLine+0x2ba>
     d40:	8b 45 08             	mov    0x8(%ebp),%eax
     d43:	8b 00                	mov    (%eax),%eax
     d45:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d48:	0f 8e 8f 02 00 00    	jle    fdd <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d4e:	8b 45 10             	mov    0x10(%ebp),%eax
     d51:	3b 45 18             	cmp    0x18(%ebp),%eax
     d54:	7e 12                	jle    d68 <APDrawLine+0x45>
        {
            int tmp = y2;
     d56:	8b 45 18             	mov    0x18(%ebp),%eax
     d59:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d5c:	8b 45 10             	mov    0x10(%ebp),%eax
     d5f:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d62:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d65:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d68:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d6c:	79 07                	jns    d75 <APDrawLine+0x52>
     d6e:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d75:	8b 45 08             	mov    0x8(%ebp),%eax
     d78:	8b 40 04             	mov    0x4(%eax),%eax
     d7b:	3b 45 18             	cmp    0x18(%ebp),%eax
     d7e:	7d 0c                	jge    d8c <APDrawLine+0x69>
     d80:	8b 45 08             	mov    0x8(%ebp),%eax
     d83:	8b 40 04             	mov    0x4(%eax),%eax
     d86:	83 e8 01             	sub    $0x1,%eax
     d89:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     d8c:	8b 45 10             	mov    0x10(%ebp),%eax
     d8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d92:	eb 15                	jmp    da9 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     d94:	ff 75 f4             	pushl  -0xc(%ebp)
     d97:	ff 75 0c             	pushl  0xc(%ebp)
     d9a:	ff 75 08             	pushl  0x8(%ebp)
     d9d:	e8 9e fe ff ff       	call   c40 <APDrawPoint>
     da2:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     da5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     da9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dac:	3b 45 18             	cmp    0x18(%ebp),%eax
     daf:	7e e3                	jle    d94 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     db1:	e9 2b 02 00 00       	jmp    fe1 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     db6:	8b 45 10             	mov    0x10(%ebp),%eax
     db9:	3b 45 18             	cmp    0x18(%ebp),%eax
     dbc:	75 7f                	jne    e3d <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     dbe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dc2:	0f 88 18 02 00 00    	js     fe0 <APDrawLine+0x2bd>
     dc8:	8b 45 08             	mov    0x8(%ebp),%eax
     dcb:	8b 40 04             	mov    0x4(%eax),%eax
     dce:	3b 45 10             	cmp    0x10(%ebp),%eax
     dd1:	0f 8e 09 02 00 00    	jle    fe0 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
     dda:	3b 45 14             	cmp    0x14(%ebp),%eax
     ddd:	7e 12                	jle    df1 <APDrawLine+0xce>
        {
            int tmp = x2;
     ddf:	8b 45 14             	mov    0x14(%ebp),%eax
     de2:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     de5:	8b 45 0c             	mov    0xc(%ebp),%eax
     de8:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     deb:	8b 45 d8             	mov    -0x28(%ebp),%eax
     dee:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     df1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     df5:	79 07                	jns    dfe <APDrawLine+0xdb>
     df7:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     dfe:	8b 45 08             	mov    0x8(%ebp),%eax
     e01:	8b 00                	mov    (%eax),%eax
     e03:	3b 45 14             	cmp    0x14(%ebp),%eax
     e06:	7d 0b                	jge    e13 <APDrawLine+0xf0>
     e08:	8b 45 08             	mov    0x8(%ebp),%eax
     e0b:	8b 00                	mov    (%eax),%eax
     e0d:	83 e8 01             	sub    $0x1,%eax
     e10:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e13:	8b 45 0c             	mov    0xc(%ebp),%eax
     e16:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e19:	eb 15                	jmp    e30 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e1b:	ff 75 10             	pushl  0x10(%ebp)
     e1e:	ff 75 f0             	pushl  -0x10(%ebp)
     e21:	ff 75 08             	pushl  0x8(%ebp)
     e24:	e8 17 fe ff ff       	call   c40 <APDrawPoint>
     e29:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e2c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e30:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e33:	3b 45 14             	cmp    0x14(%ebp),%eax
     e36:	7e e3                	jle    e1b <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e38:	e9 a4 01 00 00       	jmp    fe1 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e3d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e44:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e4b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e4e:	2b 45 14             	sub    0x14(%ebp),%eax
     e51:	50                   	push   %eax
     e52:	e8 3d fa ff ff       	call   894 <abs_int>
     e57:	83 c4 04             	add    $0x4,%esp
     e5a:	89 c3                	mov    %eax,%ebx
     e5c:	8b 45 10             	mov    0x10(%ebp),%eax
     e5f:	2b 45 18             	sub    0x18(%ebp),%eax
     e62:	50                   	push   %eax
     e63:	e8 2c fa ff ff       	call   894 <abs_int>
     e68:	83 c4 04             	add    $0x4,%esp
     e6b:	39 c3                	cmp    %eax,%ebx
     e6d:	0f 8e b5 00 00 00    	jle    f28 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e73:	8b 45 10             	mov    0x10(%ebp),%eax
     e76:	2b 45 18             	sub    0x18(%ebp),%eax
     e79:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e7c:	db 45 b0             	fildl  -0x50(%ebp)
     e7f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e82:	2b 45 14             	sub    0x14(%ebp),%eax
     e85:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e88:	db 45 b0             	fildl  -0x50(%ebp)
     e8b:	de f9                	fdivrp %st,%st(1)
     e8d:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     e90:	8b 45 14             	mov    0x14(%ebp),%eax
     e93:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e96:	7e 0e                	jle    ea6 <APDrawLine+0x183>
        {
            s = x1;
     e98:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9b:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     e9e:	8b 45 14             	mov    0x14(%ebp),%eax
     ea1:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ea4:	eb 0c                	jmp    eb2 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ea6:	8b 45 14             	mov    0x14(%ebp),%eax
     ea9:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     eac:	8b 45 0c             	mov    0xc(%ebp),%eax
     eaf:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     eb2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     eb6:	79 07                	jns    ebf <APDrawLine+0x19c>
     eb8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     ebf:	8b 45 08             	mov    0x8(%ebp),%eax
     ec2:	8b 00                	mov    (%eax),%eax
     ec4:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ec7:	7f 0b                	jg     ed4 <APDrawLine+0x1b1>
     ec9:	8b 45 08             	mov    0x8(%ebp),%eax
     ecc:	8b 00                	mov    (%eax),%eax
     ece:	83 e8 01             	sub    $0x1,%eax
     ed1:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     ed4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ed7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     eda:	eb 3f                	jmp    f1b <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     edc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     edf:	2b 45 0c             	sub    0xc(%ebp),%eax
     ee2:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ee5:	db 45 b0             	fildl  -0x50(%ebp)
     ee8:	dc 4d d0             	fmull  -0x30(%ebp)
     eeb:	db 45 10             	fildl  0x10(%ebp)
     eee:	de c1                	faddp  %st,%st(1)
     ef0:	d9 7d b6             	fnstcw -0x4a(%ebp)
     ef3:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     ef7:	b4 0c                	mov    $0xc,%ah
     ef9:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     efd:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f00:	db 5d cc             	fistpl -0x34(%ebp)
     f03:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f06:	ff 75 cc             	pushl  -0x34(%ebp)
     f09:	ff 75 e4             	pushl  -0x1c(%ebp)
     f0c:	ff 75 08             	pushl  0x8(%ebp)
     f0f:	e8 2c fd ff ff       	call   c40 <APDrawPoint>
     f14:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f17:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f1b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f1e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f21:	7e b9                	jle    edc <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f23:	e9 b9 00 00 00       	jmp    fe1 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f28:	8b 45 0c             	mov    0xc(%ebp),%eax
     f2b:	2b 45 14             	sub    0x14(%ebp),%eax
     f2e:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f31:	db 45 b0             	fildl  -0x50(%ebp)
     f34:	8b 45 10             	mov    0x10(%ebp),%eax
     f37:	2b 45 18             	sub    0x18(%ebp),%eax
     f3a:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f3d:	db 45 b0             	fildl  -0x50(%ebp)
     f40:	de f9                	fdivrp %st,%st(1)
     f42:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f45:	8b 45 10             	mov    0x10(%ebp),%eax
     f48:	3b 45 18             	cmp    0x18(%ebp),%eax
     f4b:	7e 0e                	jle    f5b <APDrawLine+0x238>
    {
        s = y2;
     f4d:	8b 45 18             	mov    0x18(%ebp),%eax
     f50:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f53:	8b 45 10             	mov    0x10(%ebp),%eax
     f56:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f59:	eb 0c                	jmp    f67 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f5b:	8b 45 10             	mov    0x10(%ebp),%eax
     f5e:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f61:	8b 45 18             	mov    0x18(%ebp),%eax
     f64:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f67:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f6b:	79 07                	jns    f74 <APDrawLine+0x251>
     f6d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f74:	8b 45 08             	mov    0x8(%ebp),%eax
     f77:	8b 40 04             	mov    0x4(%eax),%eax
     f7a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f7d:	7f 0c                	jg     f8b <APDrawLine+0x268>
     f7f:	8b 45 08             	mov    0x8(%ebp),%eax
     f82:	8b 40 04             	mov    0x4(%eax),%eax
     f85:	83 e8 01             	sub    $0x1,%eax
     f88:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     f8b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f8e:	89 45 e0             	mov    %eax,-0x20(%ebp)
     f91:	eb 3f                	jmp    fd2 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     f93:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f96:	2b 45 10             	sub    0x10(%ebp),%eax
     f99:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f9c:	db 45 b0             	fildl  -0x50(%ebp)
     f9f:	dc 4d c0             	fmull  -0x40(%ebp)
     fa2:	db 45 0c             	fildl  0xc(%ebp)
     fa5:	de c1                	faddp  %st,%st(1)
     fa7:	d9 7d b6             	fnstcw -0x4a(%ebp)
     faa:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fae:	b4 0c                	mov    $0xc,%ah
     fb0:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fb4:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fb7:	db 5d bc             	fistpl -0x44(%ebp)
     fba:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     fbd:	ff 75 e0             	pushl  -0x20(%ebp)
     fc0:	ff 75 bc             	pushl  -0x44(%ebp)
     fc3:	ff 75 08             	pushl  0x8(%ebp)
     fc6:	e8 75 fc ff ff       	call   c40 <APDrawPoint>
     fcb:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     fce:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     fd2:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fd5:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fd8:	7e b9                	jle    f93 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     fda:	90                   	nop
     fdb:	eb 04                	jmp    fe1 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     fdd:	90                   	nop
     fde:	eb 01                	jmp    fe1 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     fe0:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     fe1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fe4:	c9                   	leave  
     fe5:	c3                   	ret    

00000fe6 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     fe6:	55                   	push   %ebp
     fe7:	89 e5                	mov    %esp,%ebp
     fe9:	53                   	push   %ebx
     fea:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
     fed:	8b 55 10             	mov    0x10(%ebp),%edx
     ff0:	8b 45 18             	mov    0x18(%ebp),%eax
     ff3:	01 d0                	add    %edx,%eax
     ff5:	83 e8 01             	sub    $0x1,%eax
     ff8:	83 ec 04             	sub    $0x4,%esp
     ffb:	50                   	push   %eax
     ffc:	ff 75 0c             	pushl  0xc(%ebp)
     fff:	ff 75 10             	pushl  0x10(%ebp)
    1002:	ff 75 0c             	pushl  0xc(%ebp)
    1005:	ff 75 08             	pushl  0x8(%ebp)
    1008:	e8 16 fd ff ff       	call   d23 <APDrawLine>
    100d:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1010:	8b 55 0c             	mov    0xc(%ebp),%edx
    1013:	8b 45 14             	mov    0x14(%ebp),%eax
    1016:	01 d0                	add    %edx,%eax
    1018:	83 e8 01             	sub    $0x1,%eax
    101b:	83 ec 04             	sub    $0x4,%esp
    101e:	ff 75 10             	pushl  0x10(%ebp)
    1021:	50                   	push   %eax
    1022:	ff 75 10             	pushl  0x10(%ebp)
    1025:	ff 75 0c             	pushl  0xc(%ebp)
    1028:	ff 75 08             	pushl  0x8(%ebp)
    102b:	e8 f3 fc ff ff       	call   d23 <APDrawLine>
    1030:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1033:	8b 55 10             	mov    0x10(%ebp),%edx
    1036:	8b 45 18             	mov    0x18(%ebp),%eax
    1039:	01 d0                	add    %edx,%eax
    103b:	8d 48 ff             	lea    -0x1(%eax),%ecx
    103e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1041:	8b 45 14             	mov    0x14(%ebp),%eax
    1044:	01 d0                	add    %edx,%eax
    1046:	8d 50 ff             	lea    -0x1(%eax),%edx
    1049:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    104c:	8b 45 14             	mov    0x14(%ebp),%eax
    104f:	01 d8                	add    %ebx,%eax
    1051:	83 e8 01             	sub    $0x1,%eax
    1054:	83 ec 04             	sub    $0x4,%esp
    1057:	51                   	push   %ecx
    1058:	52                   	push   %edx
    1059:	ff 75 10             	pushl  0x10(%ebp)
    105c:	50                   	push   %eax
    105d:	ff 75 08             	pushl  0x8(%ebp)
    1060:	e8 be fc ff ff       	call   d23 <APDrawLine>
    1065:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1068:	8b 55 10             	mov    0x10(%ebp),%edx
    106b:	8b 45 18             	mov    0x18(%ebp),%eax
    106e:	01 d0                	add    %edx,%eax
    1070:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1073:	8b 55 0c             	mov    0xc(%ebp),%edx
    1076:	8b 45 14             	mov    0x14(%ebp),%eax
    1079:	01 d0                	add    %edx,%eax
    107b:	8d 50 ff             	lea    -0x1(%eax),%edx
    107e:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1081:	8b 45 18             	mov    0x18(%ebp),%eax
    1084:	01 d8                	add    %ebx,%eax
    1086:	83 e8 01             	sub    $0x1,%eax
    1089:	83 ec 04             	sub    $0x4,%esp
    108c:	51                   	push   %ecx
    108d:	52                   	push   %edx
    108e:	50                   	push   %eax
    108f:	ff 75 0c             	pushl  0xc(%ebp)
    1092:	ff 75 08             	pushl  0x8(%ebp)
    1095:	e8 89 fc ff ff       	call   d23 <APDrawLine>
    109a:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    109d:	8b 55 0c             	mov    0xc(%ebp),%edx
    10a0:	8b 45 14             	mov    0x14(%ebp),%eax
    10a3:	01 d0                	add    %edx,%eax
    10a5:	8d 50 ff             	lea    -0x1(%eax),%edx
    10a8:	8b 45 08             	mov    0x8(%ebp),%eax
    10ab:	8b 40 0c             	mov    0xc(%eax),%eax
    10ae:	89 c1                	mov    %eax,%ecx
    10b0:	c1 e9 1f             	shr    $0x1f,%ecx
    10b3:	01 c8                	add    %ecx,%eax
    10b5:	d1 f8                	sar    %eax
    10b7:	29 c2                	sub    %eax,%edx
    10b9:	89 d0                	mov    %edx,%eax
    10bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10be:	8b 55 10             	mov    0x10(%ebp),%edx
    10c1:	8b 45 18             	mov    0x18(%ebp),%eax
    10c4:	01 d0                	add    %edx,%eax
    10c6:	8d 50 ff             	lea    -0x1(%eax),%edx
    10c9:	8b 45 08             	mov    0x8(%ebp),%eax
    10cc:	8b 40 0c             	mov    0xc(%eax),%eax
    10cf:	89 c1                	mov    %eax,%ecx
    10d1:	c1 e9 1f             	shr    $0x1f,%ecx
    10d4:	01 c8                	add    %ecx,%eax
    10d6:	d1 f8                	sar    %eax
    10d8:	29 c2                	sub    %eax,%edx
    10da:	89 d0                	mov    %edx,%eax
    10dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    10df:	8b 45 08             	mov    0x8(%ebp),%eax
    10e2:	8b 40 0c             	mov    0xc(%eax),%eax
    10e5:	89 c2                	mov    %eax,%edx
    10e7:	c1 ea 1f             	shr    $0x1f,%edx
    10ea:	01 d0                	add    %edx,%eax
    10ec:	d1 f8                	sar    %eax
    10ee:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    10f1:	8b 45 08             	mov    0x8(%ebp),%eax
    10f4:	8b 40 0c             	mov    0xc(%eax),%eax
    10f7:	89 c2                	mov    %eax,%edx
    10f9:	c1 ea 1f             	shr    $0x1f,%edx
    10fc:	01 d0                	add    %edx,%eax
    10fe:	d1 f8                	sar    %eax
    1100:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1103:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1107:	0f 88 d8 00 00 00    	js     11e5 <APDrawRect+0x1ff>
    110d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1111:	0f 88 ce 00 00 00    	js     11e5 <APDrawRect+0x1ff>
    1117:	8b 45 08             	mov    0x8(%ebp),%eax
    111a:	8b 00                	mov    (%eax),%eax
    111c:	3b 45 0c             	cmp    0xc(%ebp),%eax
    111f:	0f 8e c0 00 00 00    	jle    11e5 <APDrawRect+0x1ff>
    1125:	8b 45 08             	mov    0x8(%ebp),%eax
    1128:	8b 40 04             	mov    0x4(%eax),%eax
    112b:	3b 45 10             	cmp    0x10(%ebp),%eax
    112e:	0f 8e b1 00 00 00    	jle    11e5 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1134:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1138:	79 07                	jns    1141 <APDrawRect+0x15b>
    113a:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1141:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1145:	79 07                	jns    114e <APDrawRect+0x168>
    1147:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    114e:	8b 45 08             	mov    0x8(%ebp),%eax
    1151:	8b 00                	mov    (%eax),%eax
    1153:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1156:	7f 0b                	jg     1163 <APDrawRect+0x17d>
    1158:	8b 45 08             	mov    0x8(%ebp),%eax
    115b:	8b 00                	mov    (%eax),%eax
    115d:	83 e8 01             	sub    $0x1,%eax
    1160:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1163:	8b 45 08             	mov    0x8(%ebp),%eax
    1166:	8b 40 04             	mov    0x4(%eax),%eax
    1169:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    116c:	7f 0c                	jg     117a <APDrawRect+0x194>
    116e:	8b 45 08             	mov    0x8(%ebp),%eax
    1171:	8b 40 04             	mov    0x4(%eax),%eax
    1174:	83 e8 01             	sub    $0x1,%eax
    1177:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    117a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1181:	8b 45 0c             	mov    0xc(%ebp),%eax
    1184:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1187:	eb 52                	jmp    11db <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1189:	8b 45 10             	mov    0x10(%ebp),%eax
    118c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    118f:	eb 3e                	jmp    11cf <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1191:	83 ec 04             	sub    $0x4,%esp
    1194:	ff 75 e8             	pushl  -0x18(%ebp)
    1197:	ff 75 ec             	pushl  -0x14(%ebp)
    119a:	ff 75 08             	pushl  0x8(%ebp)
    119d:	e8 02 f7 ff ff       	call   8a4 <APGetIndex>
    11a2:	83 c4 10             	add    $0x10,%esp
    11a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11a8:	8b 45 08             	mov    0x8(%ebp),%eax
    11ab:	8b 48 18             	mov    0x18(%eax),%ecx
    11ae:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11b1:	89 d0                	mov    %edx,%eax
    11b3:	01 c0                	add    %eax,%eax
    11b5:	01 d0                	add    %edx,%eax
    11b7:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11ba:	8b 45 08             	mov    0x8(%ebp),%eax
    11bd:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11c1:	66 89 0a             	mov    %cx,(%edx)
    11c4:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    11c8:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    11cb:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11d2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11d5:	7e ba                	jle    1191 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11d7:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    11db:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11de:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11e1:	7e a6                	jle    1189 <APDrawRect+0x1a3>
    11e3:	eb 01                	jmp    11e6 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    11e5:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    11e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11e9:	c9                   	leave  
    11ea:	c3                   	ret    

000011eb <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    11eb:	55                   	push   %ebp
    11ec:	89 e5                	mov    %esp,%ebp
    11ee:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    11f1:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    11f5:	0f 88 8e 01 00 00    	js     1389 <APDcCopy+0x19e>
    11fb:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    11ff:	0f 88 84 01 00 00    	js     1389 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1205:	8b 55 0c             	mov    0xc(%ebp),%edx
    1208:	8b 45 20             	mov    0x20(%ebp),%eax
    120b:	01 d0                	add    %edx,%eax
    120d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1210:	8b 55 10             	mov    0x10(%ebp),%edx
    1213:	8b 45 24             	mov    0x24(%ebp),%eax
    1216:	01 d0                	add    %edx,%eax
    1218:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    121b:	8b 55 18             	mov    0x18(%ebp),%edx
    121e:	8b 45 20             	mov    0x20(%ebp),%eax
    1221:	01 d0                	add    %edx,%eax
    1223:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1226:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1229:	8b 45 24             	mov    0x24(%ebp),%eax
    122c:	01 d0                	add    %edx,%eax
    122e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1231:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1235:	0f 88 51 01 00 00    	js     138c <APDcCopy+0x1a1>
    123b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    123f:	0f 88 47 01 00 00    	js     138c <APDcCopy+0x1a1>
    1245:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1249:	0f 88 3d 01 00 00    	js     138c <APDcCopy+0x1a1>
    124f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1253:	0f 88 33 01 00 00    	js     138c <APDcCopy+0x1a1>
    1259:	8b 45 14             	mov    0x14(%ebp),%eax
    125c:	8b 00                	mov    (%eax),%eax
    125e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1261:	0f 8c 25 01 00 00    	jl     138c <APDcCopy+0x1a1>
    1267:	8b 45 14             	mov    0x14(%ebp),%eax
    126a:	8b 40 04             	mov    0x4(%eax),%eax
    126d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1270:	0f 8c 16 01 00 00    	jl     138c <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1276:	8b 45 08             	mov    0x8(%ebp),%eax
    1279:	8b 00                	mov    (%eax),%eax
    127b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    127e:	7f 0b                	jg     128b <APDcCopy+0xa0>
    1280:	8b 45 08             	mov    0x8(%ebp),%eax
    1283:	8b 00                	mov    (%eax),%eax
    1285:	83 e8 01             	sub    $0x1,%eax
    1288:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    128b:	8b 45 08             	mov    0x8(%ebp),%eax
    128e:	8b 40 04             	mov    0x4(%eax),%eax
    1291:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1294:	7f 0c                	jg     12a2 <APDcCopy+0xb7>
    1296:	8b 45 08             	mov    0x8(%ebp),%eax
    1299:	8b 40 04             	mov    0x4(%eax),%eax
    129c:	83 e8 01             	sub    $0x1,%eax
    129f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    12a2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12a9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    12b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12b7:	e9 bc 00 00 00       	jmp    1378 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12bc:	8b 45 08             	mov    0x8(%ebp),%eax
    12bf:	8b 00                	mov    (%eax),%eax
    12c1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12c4:	8b 55 10             	mov    0x10(%ebp),%edx
    12c7:	01 ca                	add    %ecx,%edx
    12c9:	0f af d0             	imul   %eax,%edx
    12cc:	8b 45 0c             	mov    0xc(%ebp),%eax
    12cf:	01 d0                	add    %edx,%eax
    12d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    12d4:	8b 45 14             	mov    0x14(%ebp),%eax
    12d7:	8b 00                	mov    (%eax),%eax
    12d9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12dc:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12df:	01 ca                	add    %ecx,%edx
    12e1:	0f af d0             	imul   %eax,%edx
    12e4:	8b 45 18             	mov    0x18(%ebp),%eax
    12e7:	01 d0                	add    %edx,%eax
    12e9:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    12ec:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12f3:	eb 74                	jmp    1369 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    12f5:	8b 45 14             	mov    0x14(%ebp),%eax
    12f8:	8b 50 18             	mov    0x18(%eax),%edx
    12fb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1301:	01 c8                	add    %ecx,%eax
    1303:	89 c1                	mov    %eax,%ecx
    1305:	89 c8                	mov    %ecx,%eax
    1307:	01 c0                	add    %eax,%eax
    1309:	01 c8                	add    %ecx,%eax
    130b:	01 d0                	add    %edx,%eax
    130d:	0f b7 10             	movzwl (%eax),%edx
    1310:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1314:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1318:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    131b:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    131f:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1323:	38 c2                	cmp    %al,%dl
    1325:	75 18                	jne    133f <APDcCopy+0x154>
    1327:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    132b:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    132f:	38 c2                	cmp    %al,%dl
    1331:	75 0c                	jne    133f <APDcCopy+0x154>
    1333:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1337:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    133b:	38 c2                	cmp    %al,%dl
    133d:	74 26                	je     1365 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    133f:	8b 45 08             	mov    0x8(%ebp),%eax
    1342:	8b 50 18             	mov    0x18(%eax),%edx
    1345:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1348:	8b 45 f0             	mov    -0x10(%ebp),%eax
    134b:	01 c8                	add    %ecx,%eax
    134d:	89 c1                	mov    %eax,%ecx
    134f:	89 c8                	mov    %ecx,%eax
    1351:	01 c0                	add    %eax,%eax
    1353:	01 c8                	add    %ecx,%eax
    1355:	01 d0                	add    %edx,%eax
    1357:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    135b:	66 89 10             	mov    %dx,(%eax)
    135e:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1362:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1365:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1369:	8b 45 fc             	mov    -0x4(%ebp),%eax
    136c:	2b 45 0c             	sub    0xc(%ebp),%eax
    136f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1372:	7d 81                	jge    12f5 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1374:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1378:	8b 45 f8             	mov    -0x8(%ebp),%eax
    137b:	2b 45 10             	sub    0x10(%ebp),%eax
    137e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1381:	0f 8d 35 ff ff ff    	jge    12bc <APDcCopy+0xd1>
    1387:	eb 04                	jmp    138d <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1389:	90                   	nop
    138a:	eb 01                	jmp    138d <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    138c:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    138d:	c9                   	leave  
    138e:	c3                   	ret    

0000138f <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    138f:	55                   	push   %ebp
    1390:	89 e5                	mov    %esp,%ebp
    1392:	83 ec 1c             	sub    $0x1c,%esp
    1395:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1398:	8b 55 10             	mov    0x10(%ebp),%edx
    139b:	8b 45 14             	mov    0x14(%ebp),%eax
    139e:	88 4d ec             	mov    %cl,-0x14(%ebp)
    13a1:	88 55 e8             	mov    %dl,-0x18(%ebp)
    13a4:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    13a7:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13ab:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13ae:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13b2:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13b5:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13b9:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13bc:	8b 45 08             	mov    0x8(%ebp),%eax
    13bf:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13c3:	66 89 10             	mov    %dx,(%eax)
    13c6:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13ca:	88 50 02             	mov    %dl,0x2(%eax)
}
    13cd:	8b 45 08             	mov    0x8(%ebp),%eax
    13d0:	c9                   	leave  
    13d1:	c2 04 00             	ret    $0x4

000013d4 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    13d4:	55                   	push   %ebp
    13d5:	89 e5                	mov    %esp,%ebp
    13d7:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13da:	8b 45 08             	mov    0x8(%ebp),%eax
    13dd:	8b 00                	mov    (%eax),%eax
    13df:	83 ec 08             	sub    $0x8,%esp
    13e2:	8d 55 0c             	lea    0xc(%ebp),%edx
    13e5:	52                   	push   %edx
    13e6:	50                   	push   %eax
    13e7:	e8 8d ef ff ff       	call   379 <sendMessage>
    13ec:	83 c4 10             	add    $0x10,%esp
}
    13ef:	90                   	nop
    13f0:	c9                   	leave  
    13f1:	c3                   	ret    

000013f2 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    13f2:	55                   	push   %ebp
    13f3:	89 e5                	mov    %esp,%ebp
    13f5:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    13f8:	83 ec 0c             	sub    $0xc,%esp
    13fb:	68 90 00 00 00       	push   $0x90
    1400:	e8 3e f3 ff ff       	call   743 <malloc>
    1405:	83 c4 10             	add    $0x10,%esp
    1408:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    140b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    140f:	75 15                	jne    1426 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1411:	83 ec 04             	sub    $0x4,%esp
    1414:	ff 75 08             	pushl  0x8(%ebp)
    1417:	68 44 21 00 00       	push   $0x2144
    141c:	6a 01                	push   $0x1
    141e:	e8 4d f0 ff ff       	call   470 <printf>
    1423:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1426:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1429:	83 c0 7c             	add    $0x7c,%eax
    142c:	83 ec 08             	sub    $0x8,%esp
    142f:	ff 75 08             	pushl  0x8(%ebp)
    1432:	50                   	push   %eax
    1433:	e8 60 ec ff ff       	call   98 <strcpy>
    1438:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    143b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    143e:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1445:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1448:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    144f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1452:	8b 40 34             	mov    0x34(%eax),%eax
    1455:	89 c2                	mov    %eax,%edx
    1457:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145a:	8b 40 38             	mov    0x38(%eax),%eax
    145d:	0f af d0             	imul   %eax,%edx
    1460:	89 d0                	mov    %edx,%eax
    1462:	01 c0                	add    %eax,%eax
    1464:	01 d0                	add    %edx,%eax
    1466:	83 ec 0c             	sub    $0xc,%esp
    1469:	50                   	push   %eax
    146a:	e8 d4 f2 ff ff       	call   743 <malloc>
    146f:	83 c4 10             	add    $0x10,%esp
    1472:	89 c2                	mov    %eax,%edx
    1474:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1477:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    147a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    147d:	8b 40 4c             	mov    0x4c(%eax),%eax
    1480:	85 c0                	test   %eax,%eax
    1482:	75 15                	jne    1499 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1484:	83 ec 04             	sub    $0x4,%esp
    1487:	ff 75 08             	pushl  0x8(%ebp)
    148a:	68 64 21 00 00       	push   $0x2164
    148f:	6a 01                	push   $0x1
    1491:	e8 da ef ff ff       	call   470 <printf>
    1496:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1499:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149c:	8b 40 34             	mov    0x34(%eax),%eax
    149f:	89 c2                	mov    %eax,%edx
    14a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a4:	8b 40 38             	mov    0x38(%eax),%eax
    14a7:	0f af d0             	imul   %eax,%edx
    14aa:	89 d0                	mov    %edx,%eax
    14ac:	01 c0                	add    %eax,%eax
    14ae:	01 c2                	add    %eax,%edx
    14b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b3:	8b 40 4c             	mov    0x4c(%eax),%eax
    14b6:	83 ec 04             	sub    $0x4,%esp
    14b9:	52                   	push   %edx
    14ba:	68 ff ff ff 00       	push   $0xffffff
    14bf:	50                   	push   %eax
    14c0:	e8 69 ec ff ff       	call   12e <memset>
    14c5:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cb:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    14d2:	e8 72 ee ff ff       	call   349 <getpid>
    14d7:	89 c2                	mov    %eax,%edx
    14d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14dc:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e2:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ec:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    14f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f6:	8b 40 50             	mov    0x50(%eax),%eax
    14f9:	89 c2                	mov    %eax,%edx
    14fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14fe:	8b 40 54             	mov    0x54(%eax),%eax
    1501:	0f af d0             	imul   %eax,%edx
    1504:	89 d0                	mov    %edx,%eax
    1506:	01 c0                	add    %eax,%eax
    1508:	01 d0                	add    %edx,%eax
    150a:	83 ec 0c             	sub    $0xc,%esp
    150d:	50                   	push   %eax
    150e:	e8 30 f2 ff ff       	call   743 <malloc>
    1513:	83 c4 10             	add    $0x10,%esp
    1516:	89 c2                	mov    %eax,%edx
    1518:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151b:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    151e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1521:	8b 40 68             	mov    0x68(%eax),%eax
    1524:	85 c0                	test   %eax,%eax
    1526:	75 15                	jne    153d <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1528:	83 ec 04             	sub    $0x4,%esp
    152b:	ff 75 08             	pushl  0x8(%ebp)
    152e:	68 88 21 00 00       	push   $0x2188
    1533:	6a 01                	push   $0x1
    1535:	e8 36 ef ff ff       	call   470 <printf>
    153a:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    153d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1540:	8b 40 34             	mov    0x34(%eax),%eax
    1543:	89 c2                	mov    %eax,%edx
    1545:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1548:	8b 40 38             	mov    0x38(%eax),%eax
    154b:	0f af d0             	imul   %eax,%edx
    154e:	89 d0                	mov    %edx,%eax
    1550:	01 c0                	add    %eax,%eax
    1552:	01 c2                	add    %eax,%edx
    1554:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1557:	8b 40 4c             	mov    0x4c(%eax),%eax
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
    1579:	74 35                	je     15b0 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    157b:	8b 45 10             	mov    0x10(%ebp),%eax
    157e:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1584:	83 ec 0c             	sub    $0xc,%esp
    1587:	50                   	push   %eax
    1588:	e8 b6 f1 ff ff       	call   743 <malloc>
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
    15ab:	e9 8d 00 00 00       	jmp    163d <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b3:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bd:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c7:	8b 40 18             	mov    0x18(%eax),%eax
    15ca:	89 c2                	mov    %eax,%edx
    15cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cf:	8b 40 1c             	mov    0x1c(%eax),%eax
    15d2:	0f af d0             	imul   %eax,%edx
    15d5:	89 d0                	mov    %edx,%eax
    15d7:	01 c0                	add    %eax,%eax
    15d9:	01 d0                	add    %edx,%eax
    15db:	83 ec 0c             	sub    $0xc,%esp
    15de:	50                   	push   %eax
    15df:	e8 5f f1 ff ff       	call   743 <malloc>
    15e4:	83 c4 10             	add    $0x10,%esp
    15e7:	89 c2                	mov    %eax,%edx
    15e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ec:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    15ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f2:	8b 40 30             	mov    0x30(%eax),%eax
    15f5:	85 c0                	test   %eax,%eax
    15f7:	75 15                	jne    160e <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    15f9:	83 ec 04             	sub    $0x4,%esp
    15fc:	ff 75 08             	pushl  0x8(%ebp)
    15ff:	68 b0 21 00 00       	push   $0x21b0
    1604:	6a 01                	push   $0x1
    1606:	e8 65 ee ff ff       	call   470 <printf>
    160b:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    160e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1611:	8b 40 18             	mov    0x18(%eax),%eax
    1614:	89 c2                	mov    %eax,%edx
    1616:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1619:	8b 40 1c             	mov    0x1c(%eax),%eax
    161c:	0f af d0             	imul   %eax,%edx
    161f:	89 d0                	mov    %edx,%eax
    1621:	01 c0                	add    %eax,%eax
    1623:	01 c2                	add    %eax,%edx
    1625:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1628:	8b 40 30             	mov    0x30(%eax),%eax
    162b:	83 ec 04             	sub    $0x4,%esp
    162e:	52                   	push   %edx
    162f:	68 ff ff ff 00       	push   $0xffffff
    1634:	50                   	push   %eax
    1635:	e8 f4 ea ff ff       	call   12e <memset>
    163a:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    163d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1640:	c9                   	leave  
    1641:	c3                   	ret    

00001642 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1642:	55                   	push   %ebp
    1643:	89 e5                	mov    %esp,%ebp
    1645:	53                   	push   %ebx
    1646:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1649:	8b 45 0c             	mov    0xc(%ebp),%eax
    164c:	83 f8 03             	cmp    $0x3,%eax
    164f:	74 02                	je     1653 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1651:	eb 33                	jmp    1686 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1653:	8b 45 08             	mov    0x8(%ebp),%eax
    1656:	8b 48 08             	mov    0x8(%eax),%ecx
    1659:	8b 45 08             	mov    0x8(%ebp),%eax
    165c:	8b 50 38             	mov    0x38(%eax),%edx
    165f:	8b 45 08             	mov    0x8(%ebp),%eax
    1662:	8b 40 34             	mov    0x34(%eax),%eax
    1665:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1668:	83 c3 34             	add    $0x34,%ebx
    166b:	83 ec 0c             	sub    $0xc,%esp
    166e:	51                   	push   %ecx
    166f:	52                   	push   %edx
    1670:	50                   	push   %eax
    1671:	6a 00                	push   $0x0
    1673:	6a 00                	push   $0x0
    1675:	53                   	push   %ebx
    1676:	6a 32                	push   $0x32
    1678:	6a 00                	push   $0x0
    167a:	ff 75 08             	pushl  0x8(%ebp)
    167d:	e8 e7 ec ff ff       	call   369 <paintWindow>
    1682:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1685:	90                   	nop
        default: break;
            
            
    }
    return False;
    1686:	b8 00 00 00 00       	mov    $0x0,%eax
}
    168b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    168e:	c9                   	leave  
    168f:	c3                   	ret    

00001690 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1690:	55                   	push   %ebp
    1691:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1693:	8b 45 0c             	mov    0xc(%ebp),%eax
    1696:	8b 50 08             	mov    0x8(%eax),%edx
    1699:	8b 45 08             	mov    0x8(%ebp),%eax
    169c:	8b 00                	mov    (%eax),%eax
    169e:	39 c2                	cmp    %eax,%edx
    16a0:	74 07                	je     16a9 <APPreJudge+0x19>
        return False;
    16a2:	b8 00 00 00 00       	mov    $0x0,%eax
    16a7:	eb 05                	jmp    16ae <APPreJudge+0x1e>
    return True;
    16a9:	b8 01 00 00 00       	mov    $0x1,%eax
}
    16ae:	5d                   	pop    %ebp
    16af:	c3                   	ret    

000016b0 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    16b0:	55                   	push   %ebp
    16b1:	89 e5                	mov    %esp,%ebp
    16b3:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    16b6:	8b 45 08             	mov    0x8(%ebp),%eax
    16b9:	8b 55 0c             	mov    0xc(%ebp),%edx
    16bc:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    16bf:	83 ec 0c             	sub    $0xc,%esp
    16c2:	ff 75 08             	pushl  0x8(%ebp)
    16c5:	e8 bf ec ff ff       	call   389 <registWindow>
    16ca:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    16cd:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    16d4:	8b 45 08             	mov    0x8(%ebp),%eax
    16d7:	8b 00                	mov    (%eax),%eax
    16d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    16dc:	ff 75 f4             	pushl  -0xc(%ebp)
    16df:	ff 75 f0             	pushl  -0x10(%ebp)
    16e2:	ff 75 ec             	pushl  -0x14(%ebp)
    16e5:	ff 75 08             	pushl  0x8(%ebp)
    16e8:	e8 e7 fc ff ff       	call   13d4 <APSendMessage>
    16ed:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    16f0:	83 ec 0c             	sub    $0xc,%esp
    16f3:	ff 75 08             	pushl  0x8(%ebp)
    16f6:	e8 86 ec ff ff       	call   381 <getMessage>
    16fb:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    16fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1701:	83 c0 6c             	add    $0x6c,%eax
    1704:	83 ec 08             	sub    $0x8,%esp
    1707:	50                   	push   %eax
    1708:	ff 75 08             	pushl  0x8(%ebp)
    170b:	e8 80 ff ff ff       	call   1690 <APPreJudge>
    1710:	83 c4 10             	add    $0x10,%esp
    1713:	84 c0                	test   %al,%al
    1715:	74 1b                	je     1732 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    1717:	8b 45 08             	mov    0x8(%ebp),%eax
    171a:	ff 70 74             	pushl  0x74(%eax)
    171d:	ff 70 70             	pushl  0x70(%eax)
    1720:	ff 70 6c             	pushl  0x6c(%eax)
    1723:	ff 75 08             	pushl  0x8(%ebp)
    1726:	8b 45 0c             	mov    0xc(%ebp),%eax
    1729:	ff d0                	call   *%eax
    172b:	83 c4 10             	add    $0x10,%esp
    172e:	84 c0                	test   %al,%al
    1730:	75 0c                	jne    173e <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1732:	8b 45 08             	mov    0x8(%ebp),%eax
    1735:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    173c:	eb b2                	jmp    16f0 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    173e:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    173f:	90                   	nop
    1740:	c9                   	leave  
    1741:	c3                   	ret    

00001742 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1742:	55                   	push   %ebp
    1743:	89 e5                	mov    %esp,%ebp
    1745:	57                   	push   %edi
    1746:	56                   	push   %esi
    1747:	53                   	push   %ebx
    1748:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    174b:	a1 10 28 00 00       	mov    0x2810,%eax
    1750:	85 c0                	test   %eax,%eax
    1752:	0f 85 2c 02 00 00    	jne    1984 <APGridPaint+0x242>
    {
        iconReady = 1;
    1758:	c7 05 10 28 00 00 01 	movl   $0x1,0x2810
    175f:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1762:	8d 45 98             	lea    -0x68(%ebp),%eax
    1765:	83 ec 08             	sub    $0x8,%esp
    1768:	68 d7 21 00 00       	push   $0x21d7
    176d:	50                   	push   %eax
    176e:	e8 83 f1 ff ff       	call   8f6 <APLoadBitmap>
    1773:	83 c4 0c             	add    $0xc,%esp
    1776:	8b 45 98             	mov    -0x68(%ebp),%eax
    1779:	a3 34 28 00 00       	mov    %eax,0x2834
    177e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1781:	a3 38 28 00 00       	mov    %eax,0x2838
    1786:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1789:	a3 3c 28 00 00       	mov    %eax,0x283c
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    178e:	83 ec 04             	sub    $0x4,%esp
    1791:	ff 35 3c 28 00 00    	pushl  0x283c
    1797:	ff 35 38 28 00 00    	pushl  0x2838
    179d:	ff 35 34 28 00 00    	pushl  0x2834
    17a3:	e8 88 f3 ff ff       	call   b30 <APCreateCompatibleDCFromBitmap>
    17a8:	83 c4 10             	add    $0x10,%esp
    17ab:	a3 40 28 00 00       	mov    %eax,0x2840
        grid_river = APLoadBitmap ("grid_river.bmp");
    17b0:	8d 45 98             	lea    -0x68(%ebp),%eax
    17b3:	83 ec 08             	sub    $0x8,%esp
    17b6:	68 e5 21 00 00       	push   $0x21e5
    17bb:	50                   	push   %eax
    17bc:	e8 35 f1 ff ff       	call   8f6 <APLoadBitmap>
    17c1:	83 c4 0c             	add    $0xc,%esp
    17c4:	8b 45 98             	mov    -0x68(%ebp),%eax
    17c7:	a3 70 28 00 00       	mov    %eax,0x2870
    17cc:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17cf:	a3 74 28 00 00       	mov    %eax,0x2874
    17d4:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17d7:	a3 78 28 00 00       	mov    %eax,0x2878
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    17dc:	83 ec 04             	sub    $0x4,%esp
    17df:	ff 35 78 28 00 00    	pushl  0x2878
    17e5:	ff 35 74 28 00 00    	pushl  0x2874
    17eb:	ff 35 70 28 00 00    	pushl  0x2870
    17f1:	e8 3a f3 ff ff       	call   b30 <APCreateCompatibleDCFromBitmap>
    17f6:	83 c4 10             	add    $0x10,%esp
    17f9:	a3 60 28 00 00       	mov    %eax,0x2860
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    17fe:	8d 45 98             	lea    -0x68(%ebp),%eax
    1801:	83 ec 08             	sub    $0x8,%esp
    1804:	68 f4 21 00 00       	push   $0x21f4
    1809:	50                   	push   %eax
    180a:	e8 e7 f0 ff ff       	call   8f6 <APLoadBitmap>
    180f:	83 c4 0c             	add    $0xc,%esp
    1812:	8b 45 98             	mov    -0x68(%ebp),%eax
    1815:	a3 64 28 00 00       	mov    %eax,0x2864
    181a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    181d:	a3 68 28 00 00       	mov    %eax,0x2868
    1822:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1825:	a3 6c 28 00 00       	mov    %eax,0x286c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    182a:	83 ec 04             	sub    $0x4,%esp
    182d:	ff 35 6c 28 00 00    	pushl  0x286c
    1833:	ff 35 68 28 00 00    	pushl  0x2868
    1839:	ff 35 64 28 00 00    	pushl  0x2864
    183f:	e8 ec f2 ff ff       	call   b30 <APCreateCompatibleDCFromBitmap>
    1844:	83 c4 10             	add    $0x10,%esp
    1847:	a3 14 28 00 00       	mov    %eax,0x2814
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    184c:	8d 45 98             	lea    -0x68(%ebp),%eax
    184f:	83 ec 08             	sub    $0x8,%esp
    1852:	68 03 22 00 00       	push   $0x2203
    1857:	50                   	push   %eax
    1858:	e8 99 f0 ff ff       	call   8f6 <APLoadBitmap>
    185d:	83 c4 0c             	add    $0xc,%esp
    1860:	8b 45 98             	mov    -0x68(%ebp),%eax
    1863:	a3 48 28 00 00       	mov    %eax,0x2848
    1868:	8b 45 9c             	mov    -0x64(%ebp),%eax
    186b:	a3 4c 28 00 00       	mov    %eax,0x284c
    1870:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1873:	a3 50 28 00 00       	mov    %eax,0x2850
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1878:	83 ec 04             	sub    $0x4,%esp
    187b:	ff 35 50 28 00 00    	pushl  0x2850
    1881:	ff 35 4c 28 00 00    	pushl  0x284c
    1887:	ff 35 48 28 00 00    	pushl  0x2848
    188d:	e8 9e f2 ff ff       	call   b30 <APCreateCompatibleDCFromBitmap>
    1892:	83 c4 10             	add    $0x10,%esp
    1895:	a3 7c 28 00 00       	mov    %eax,0x287c
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    189a:	8d 45 98             	lea    -0x68(%ebp),%eax
    189d:	83 ec 08             	sub    $0x8,%esp
    18a0:	68 11 22 00 00       	push   $0x2211
    18a5:	50                   	push   %eax
    18a6:	e8 4b f0 ff ff       	call   8f6 <APLoadBitmap>
    18ab:	83 c4 0c             	add    $0xc,%esp
    18ae:	8b 45 98             	mov    -0x68(%ebp),%eax
    18b1:	a3 24 28 00 00       	mov    %eax,0x2824
    18b6:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18b9:	a3 28 28 00 00       	mov    %eax,0x2828
    18be:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18c1:	a3 2c 28 00 00       	mov    %eax,0x282c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    18c6:	83 ec 04             	sub    $0x4,%esp
    18c9:	ff 35 2c 28 00 00    	pushl  0x282c
    18cf:	ff 35 28 28 00 00    	pushl  0x2828
    18d5:	ff 35 24 28 00 00    	pushl  0x2824
    18db:	e8 50 f2 ff ff       	call   b30 <APCreateCompatibleDCFromBitmap>
    18e0:	83 c4 10             	add    $0x10,%esp
    18e3:	a3 44 28 00 00       	mov    %eax,0x2844
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    18e8:	8d 45 98             	lea    -0x68(%ebp),%eax
    18eb:	83 ec 08             	sub    $0x8,%esp
    18ee:	68 21 22 00 00       	push   $0x2221
    18f3:	50                   	push   %eax
    18f4:	e8 fd ef ff ff       	call   8f6 <APLoadBitmap>
    18f9:	83 c4 0c             	add    $0xc,%esp
    18fc:	8b 45 98             	mov    -0x68(%ebp),%eax
    18ff:	a3 18 28 00 00       	mov    %eax,0x2818
    1904:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1907:	a3 1c 28 00 00       	mov    %eax,0x281c
    190c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    190f:	a3 20 28 00 00       	mov    %eax,0x2820
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1914:	83 ec 04             	sub    $0x4,%esp
    1917:	ff 35 20 28 00 00    	pushl  0x2820
    191d:	ff 35 1c 28 00 00    	pushl  0x281c
    1923:	ff 35 18 28 00 00    	pushl  0x2818
    1929:	e8 02 f2 ff ff       	call   b30 <APCreateCompatibleDCFromBitmap>
    192e:	83 c4 10             	add    $0x10,%esp
    1931:	a3 30 28 00 00       	mov    %eax,0x2830
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1936:	8d 45 98             	lea    -0x68(%ebp),%eax
    1939:	83 ec 08             	sub    $0x8,%esp
    193c:	68 33 22 00 00       	push   $0x2233
    1941:	50                   	push   %eax
    1942:	e8 af ef ff ff       	call   8f6 <APLoadBitmap>
    1947:	83 c4 0c             	add    $0xc,%esp
    194a:	8b 45 98             	mov    -0x68(%ebp),%eax
    194d:	a3 54 28 00 00       	mov    %eax,0x2854
    1952:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1955:	a3 58 28 00 00       	mov    %eax,0x2858
    195a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    195d:	a3 5c 28 00 00       	mov    %eax,0x285c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1962:	83 ec 04             	sub    $0x4,%esp
    1965:	ff 35 5c 28 00 00    	pushl  0x285c
    196b:	ff 35 58 28 00 00    	pushl  0x2858
    1971:	ff 35 54 28 00 00    	pushl  0x2854
    1977:	e8 b4 f1 ff ff       	call   b30 <APCreateCompatibleDCFromBitmap>
    197c:	83 c4 10             	add    $0x10,%esp
    197f:	a3 80 28 00 00       	mov    %eax,0x2880
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1984:	8b 45 08             	mov    0x8(%ebp),%eax
    1987:	8b 40 08             	mov    0x8(%eax),%eax
    198a:	85 c0                	test   %eax,%eax
    198c:	75 17                	jne    19a5 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    198e:	83 ec 08             	sub    $0x8,%esp
    1991:	68 44 22 00 00       	push   $0x2244
    1996:	6a 01                	push   $0x1
    1998:	e8 d3 ea ff ff       	call   470 <printf>
    199d:	83 c4 10             	add    $0x10,%esp
        return;
    19a0:	e9 f2 03 00 00       	jmp    1d97 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    19a5:	8b 45 08             	mov    0x8(%ebp),%eax
    19a8:	8b 40 10             	mov    0x10(%eax),%eax
    19ab:	85 c0                	test   %eax,%eax
    19ad:	7e 10                	jle    19bf <APGridPaint+0x27d>
    19af:	8b 45 08             	mov    0x8(%ebp),%eax
    19b2:	8b 50 14             	mov    0x14(%eax),%edx
    19b5:	8b 45 08             	mov    0x8(%ebp),%eax
    19b8:	8b 40 10             	mov    0x10(%eax),%eax
    19bb:	39 c2                	cmp    %eax,%edx
    19bd:	7c 17                	jl     19d6 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    19bf:	83 ec 08             	sub    $0x8,%esp
    19c2:	68 6a 22 00 00       	push   $0x226a
    19c7:	6a 01                	push   $0x1
    19c9:	e8 a2 ea ff ff       	call   470 <printf>
    19ce:	83 c4 10             	add    $0x10,%esp
        return;
    19d1:	e9 c1 03 00 00       	jmp    1d97 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    19d6:	8b 45 08             	mov    0x8(%ebp),%eax
    19d9:	8b 40 14             	mov    0x14(%eax),%eax
    19dc:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    19e2:	89 45 dc             	mov    %eax,-0x24(%ebp)
    19e5:	8b 45 dc             	mov    -0x24(%ebp),%eax
    19e8:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    19eb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    19f2:	e9 96 03 00 00       	jmp    1d8d <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    19f7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    19fe:	e9 7c 03 00 00       	jmp    1d7f <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a03:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a06:	c1 e0 04             	shl    $0x4,%eax
    1a09:	89 c2                	mov    %eax,%edx
    1a0b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a0e:	01 c2                	add    %eax,%edx
    1a10:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a13:	01 d0                	add    %edx,%eax
    1a15:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a18:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1b:	8b 40 0c             	mov    0xc(%eax),%eax
    1a1e:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a21:	c1 e2 02             	shl    $0x2,%edx
    1a24:	01 d0                	add    %edx,%eax
    1a26:	8b 00                	mov    (%eax),%eax
    1a28:	83 f8 07             	cmp    $0x7,%eax
    1a2b:	0f 87 49 03 00 00    	ja     1d7a <APGridPaint+0x638>
    1a31:	8b 04 85 80 22 00 00 	mov    0x2280(,%eax,4),%eax
    1a38:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1a3a:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1a3d:	6a 0c                	push   $0xc
    1a3f:	6a 0c                	push   $0xc
    1a41:	6a 0c                	push   $0xc
    1a43:	50                   	push   %eax
    1a44:	e8 46 f9 ff ff       	call   138f <RGB>
    1a49:	83 c4 0c             	add    $0xc,%esp
    1a4c:	8b 1d 40 28 00 00    	mov    0x2840,%ebx
    1a52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a55:	6b c8 32             	imul   $0x32,%eax,%ecx
    1a58:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a5b:	6b c0 32             	imul   $0x32,%eax,%eax
    1a5e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1a61:	8b 45 08             	mov    0x8(%ebp),%eax
    1a64:	8d 78 34             	lea    0x34(%eax),%edi
    1a67:	83 ec 0c             	sub    $0xc,%esp
    1a6a:	83 ec 04             	sub    $0x4,%esp
    1a6d:	89 e0                	mov    %esp,%eax
    1a6f:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1a73:	66 89 30             	mov    %si,(%eax)
    1a76:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1a7a:	88 50 02             	mov    %dl,0x2(%eax)
    1a7d:	6a 32                	push   $0x32
    1a7f:	6a 32                	push   $0x32
    1a81:	6a 00                	push   $0x0
    1a83:	6a 00                	push   $0x0
    1a85:	53                   	push   %ebx
    1a86:	51                   	push   %ecx
    1a87:	ff 75 94             	pushl  -0x6c(%ebp)
    1a8a:	57                   	push   %edi
    1a8b:	e8 5b f7 ff ff       	call   11eb <APDcCopy>
    1a90:	83 c4 30             	add    $0x30,%esp
                    break;
    1a93:	e9 e3 02 00 00       	jmp    1d7b <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1a98:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a9b:	6a 69                	push   $0x69
    1a9d:	6a 69                	push   $0x69
    1a9f:	6a 69                	push   $0x69
    1aa1:	50                   	push   %eax
    1aa2:	e8 e8 f8 ff ff       	call   138f <RGB>
    1aa7:	83 c4 0c             	add    $0xc,%esp
    1aaa:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1aae:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1ab2:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ab6:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1ab9:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1ac0:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ac3:	6a 69                	push   $0x69
    1ac5:	6a 69                	push   $0x69
    1ac7:	6a 69                	push   $0x69
    1ac9:	50                   	push   %eax
    1aca:	e8 c0 f8 ff ff       	call   138f <RGB>
    1acf:	83 c4 0c             	add    $0xc,%esp
    1ad2:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ad6:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1ada:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ade:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1ae1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae4:	8d 50 34             	lea    0x34(%eax),%edx
    1ae7:	8d 45 98             	lea    -0x68(%ebp),%eax
    1aea:	ff 75 bc             	pushl  -0x44(%ebp)
    1aed:	ff 75 b8             	pushl  -0x48(%ebp)
    1af0:	52                   	push   %edx
    1af1:	50                   	push   %eax
    1af2:	e8 ce f0 ff ff       	call   bc5 <APSetPen>
    1af7:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1afa:	8b 45 08             	mov    0x8(%ebp),%eax
    1afd:	8d 58 34             	lea    0x34(%eax),%ebx
    1b00:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b03:	83 ec 04             	sub    $0x4,%esp
    1b06:	83 ec 04             	sub    $0x4,%esp
    1b09:	89 e0                	mov    %esp,%eax
    1b0b:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1b0f:	66 89 08             	mov    %cx,(%eax)
    1b12:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1b16:	88 48 02             	mov    %cl,0x2(%eax)
    1b19:	53                   	push   %ebx
    1b1a:	52                   	push   %edx
    1b1b:	e8 de f0 ff ff       	call   bfe <APSetBrush>
    1b20:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b26:	6b d0 32             	imul   $0x32,%eax,%edx
    1b29:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b2c:	6b c0 32             	imul   $0x32,%eax,%eax
    1b2f:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b32:	83 c1 34             	add    $0x34,%ecx
    1b35:	83 ec 0c             	sub    $0xc,%esp
    1b38:	6a 32                	push   $0x32
    1b3a:	6a 32                	push   $0x32
    1b3c:	52                   	push   %edx
    1b3d:	50                   	push   %eax
    1b3e:	51                   	push   %ecx
    1b3f:	e8 a2 f4 ff ff       	call   fe6 <APDrawRect>
    1b44:	83 c4 20             	add    $0x20,%esp
                    break;
    1b47:	e9 2f 02 00 00       	jmp    1d7b <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b4c:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1b4f:	6a 0c                	push   $0xc
    1b51:	6a 0c                	push   $0xc
    1b53:	6a 0c                	push   $0xc
    1b55:	50                   	push   %eax
    1b56:	e8 34 f8 ff ff       	call   138f <RGB>
    1b5b:	83 c4 0c             	add    $0xc,%esp
    1b5e:	8b 1d 80 28 00 00    	mov    0x2880,%ebx
    1b64:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b67:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b6a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b6d:	6b c0 32             	imul   $0x32,%eax,%eax
    1b70:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b73:	8b 45 08             	mov    0x8(%ebp),%eax
    1b76:	8d 78 34             	lea    0x34(%eax),%edi
    1b79:	83 ec 0c             	sub    $0xc,%esp
    1b7c:	83 ec 04             	sub    $0x4,%esp
    1b7f:	89 e0                	mov    %esp,%eax
    1b81:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1b85:	66 89 30             	mov    %si,(%eax)
    1b88:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1b8c:	88 50 02             	mov    %dl,0x2(%eax)
    1b8f:	6a 32                	push   $0x32
    1b91:	6a 32                	push   $0x32
    1b93:	6a 00                	push   $0x0
    1b95:	6a 00                	push   $0x0
    1b97:	53                   	push   %ebx
    1b98:	51                   	push   %ecx
    1b99:	ff 75 94             	pushl  -0x6c(%ebp)
    1b9c:	57                   	push   %edi
    1b9d:	e8 49 f6 ff ff       	call   11eb <APDcCopy>
    1ba2:	83 c4 30             	add    $0x30,%esp
                    break;
    1ba5:	e9 d1 01 00 00       	jmp    1d7b <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1baa:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1bad:	6a 0c                	push   $0xc
    1baf:	6a 0c                	push   $0xc
    1bb1:	6a 0c                	push   $0xc
    1bb3:	50                   	push   %eax
    1bb4:	e8 d6 f7 ff ff       	call   138f <RGB>
    1bb9:	83 c4 0c             	add    $0xc,%esp
    1bbc:	8b 1d 60 28 00 00    	mov    0x2860,%ebx
    1bc2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bc5:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bc8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bcb:	6b c0 32             	imul   $0x32,%eax,%eax
    1bce:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bd1:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd4:	8d 78 34             	lea    0x34(%eax),%edi
    1bd7:	83 ec 0c             	sub    $0xc,%esp
    1bda:	83 ec 04             	sub    $0x4,%esp
    1bdd:	89 e0                	mov    %esp,%eax
    1bdf:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1be3:	66 89 30             	mov    %si,(%eax)
    1be6:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1bea:	88 50 02             	mov    %dl,0x2(%eax)
    1bed:	6a 32                	push   $0x32
    1bef:	6a 32                	push   $0x32
    1bf1:	6a 00                	push   $0x0
    1bf3:	6a 00                	push   $0x0
    1bf5:	53                   	push   %ebx
    1bf6:	51                   	push   %ecx
    1bf7:	ff 75 94             	pushl  -0x6c(%ebp)
    1bfa:	57                   	push   %edi
    1bfb:	e8 eb f5 ff ff       	call   11eb <APDcCopy>
    1c00:	83 c4 30             	add    $0x30,%esp
                    break;
    1c03:	e9 73 01 00 00       	jmp    1d7b <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c08:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c0b:	6a 0c                	push   $0xc
    1c0d:	6a 0c                	push   $0xc
    1c0f:	6a 0c                	push   $0xc
    1c11:	50                   	push   %eax
    1c12:	e8 78 f7 ff ff       	call   138f <RGB>
    1c17:	83 c4 0c             	add    $0xc,%esp
    1c1a:	8b 1d 44 28 00 00    	mov    0x2844,%ebx
    1c20:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c23:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c26:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c29:	6b c0 32             	imul   $0x32,%eax,%eax
    1c2c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c2f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c32:	8d 78 34             	lea    0x34(%eax),%edi
    1c35:	83 ec 0c             	sub    $0xc,%esp
    1c38:	83 ec 04             	sub    $0x4,%esp
    1c3b:	89 e0                	mov    %esp,%eax
    1c3d:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1c41:	66 89 30             	mov    %si,(%eax)
    1c44:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1c48:	88 50 02             	mov    %dl,0x2(%eax)
    1c4b:	6a 32                	push   $0x32
    1c4d:	6a 32                	push   $0x32
    1c4f:	6a 00                	push   $0x0
    1c51:	6a 00                	push   $0x0
    1c53:	53                   	push   %ebx
    1c54:	51                   	push   %ecx
    1c55:	ff 75 94             	pushl  -0x6c(%ebp)
    1c58:	57                   	push   %edi
    1c59:	e8 8d f5 ff ff       	call   11eb <APDcCopy>
    1c5e:	83 c4 30             	add    $0x30,%esp
                    break;
    1c61:	e9 15 01 00 00       	jmp    1d7b <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c66:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1c69:	6a 0c                	push   $0xc
    1c6b:	6a 0c                	push   $0xc
    1c6d:	6a 0c                	push   $0xc
    1c6f:	50                   	push   %eax
    1c70:	e8 1a f7 ff ff       	call   138f <RGB>
    1c75:	83 c4 0c             	add    $0xc,%esp
    1c78:	8b 1d 7c 28 00 00    	mov    0x287c,%ebx
    1c7e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c81:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c84:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c87:	6b c0 32             	imul   $0x32,%eax,%eax
    1c8a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c90:	8d 78 34             	lea    0x34(%eax),%edi
    1c93:	83 ec 0c             	sub    $0xc,%esp
    1c96:	83 ec 04             	sub    $0x4,%esp
    1c99:	89 e0                	mov    %esp,%eax
    1c9b:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1c9f:	66 89 30             	mov    %si,(%eax)
    1ca2:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1ca6:	88 50 02             	mov    %dl,0x2(%eax)
    1ca9:	6a 32                	push   $0x32
    1cab:	6a 32                	push   $0x32
    1cad:	6a 00                	push   $0x0
    1caf:	6a 00                	push   $0x0
    1cb1:	53                   	push   %ebx
    1cb2:	51                   	push   %ecx
    1cb3:	ff 75 94             	pushl  -0x6c(%ebp)
    1cb6:	57                   	push   %edi
    1cb7:	e8 2f f5 ff ff       	call   11eb <APDcCopy>
    1cbc:	83 c4 30             	add    $0x30,%esp
                    break;
    1cbf:	e9 b7 00 00 00       	jmp    1d7b <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cc4:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1cc7:	6a 0c                	push   $0xc
    1cc9:	6a 0c                	push   $0xc
    1ccb:	6a 0c                	push   $0xc
    1ccd:	50                   	push   %eax
    1cce:	e8 bc f6 ff ff       	call   138f <RGB>
    1cd3:	83 c4 0c             	add    $0xc,%esp
    1cd6:	8b 1d 14 28 00 00    	mov    0x2814,%ebx
    1cdc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cdf:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ce2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ce5:	6b c0 32             	imul   $0x32,%eax,%eax
    1ce8:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ceb:	8b 45 08             	mov    0x8(%ebp),%eax
    1cee:	8d 78 34             	lea    0x34(%eax),%edi
    1cf1:	83 ec 0c             	sub    $0xc,%esp
    1cf4:	83 ec 04             	sub    $0x4,%esp
    1cf7:	89 e0                	mov    %esp,%eax
    1cf9:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1cfd:	66 89 30             	mov    %si,(%eax)
    1d00:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d04:	88 50 02             	mov    %dl,0x2(%eax)
    1d07:	6a 32                	push   $0x32
    1d09:	6a 32                	push   $0x32
    1d0b:	6a 00                	push   $0x0
    1d0d:	6a 00                	push   $0x0
    1d0f:	53                   	push   %ebx
    1d10:	51                   	push   %ecx
    1d11:	ff 75 94             	pushl  -0x6c(%ebp)
    1d14:	57                   	push   %edi
    1d15:	e8 d1 f4 ff ff       	call   11eb <APDcCopy>
    1d1a:	83 c4 30             	add    $0x30,%esp
                    break;
    1d1d:	eb 5c                	jmp    1d7b <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d1f:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d22:	6a 0c                	push   $0xc
    1d24:	6a 0c                	push   $0xc
    1d26:	6a 0c                	push   $0xc
    1d28:	50                   	push   %eax
    1d29:	e8 61 f6 ff ff       	call   138f <RGB>
    1d2e:	83 c4 0c             	add    $0xc,%esp
    1d31:	8b 1d 30 28 00 00    	mov    0x2830,%ebx
    1d37:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d3a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d3d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d40:	6b c0 32             	imul   $0x32,%eax,%eax
    1d43:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d46:	8b 45 08             	mov    0x8(%ebp),%eax
    1d49:	8d 78 34             	lea    0x34(%eax),%edi
    1d4c:	83 ec 0c             	sub    $0xc,%esp
    1d4f:	83 ec 04             	sub    $0x4,%esp
    1d52:	89 e0                	mov    %esp,%eax
    1d54:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1d58:	66 89 30             	mov    %si,(%eax)
    1d5b:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1d5f:	88 50 02             	mov    %dl,0x2(%eax)
    1d62:	6a 32                	push   $0x32
    1d64:	6a 32                	push   $0x32
    1d66:	6a 00                	push   $0x0
    1d68:	6a 00                	push   $0x0
    1d6a:	53                   	push   %ebx
    1d6b:	51                   	push   %ecx
    1d6c:	ff 75 94             	pushl  -0x6c(%ebp)
    1d6f:	57                   	push   %edi
    1d70:	e8 76 f4 ff ff       	call   11eb <APDcCopy>
    1d75:	83 c4 30             	add    $0x30,%esp
                    break;
    1d78:	eb 01                	jmp    1d7b <APGridPaint+0x639>
                default: break;
    1d7a:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d7b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1d7f:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1d83:	0f 8e 7a fc ff ff    	jle    1a03 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d89:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1d8d:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1d91:	0f 8e 60 fc ff ff    	jle    19f7 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1d97:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1d9a:	5b                   	pop    %ebx
    1d9b:	5e                   	pop    %esi
    1d9c:	5f                   	pop    %edi
    1d9d:	5d                   	pop    %ebp
    1d9e:	c3                   	ret    

00001d9f <random>:
//

#include "APLib.h"

int random(int seed)
{
    1d9f:	55                   	push   %ebp
    1da0:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1da2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1da6:	7e 08                	jle    1db0 <random+0x11>
{
rand_num = seed;
    1da8:	8b 45 08             	mov    0x8(%ebp),%eax
    1dab:	a3 ec 27 00 00       	mov    %eax,0x27ec
}
rand_num *= 3;
    1db0:	8b 15 ec 27 00 00    	mov    0x27ec,%edx
    1db6:	89 d0                	mov    %edx,%eax
    1db8:	01 c0                	add    %eax,%eax
    1dba:	01 d0                	add    %edx,%eax
    1dbc:	a3 ec 27 00 00       	mov    %eax,0x27ec
if (rand_num < 0)
    1dc1:	a1 ec 27 00 00       	mov    0x27ec,%eax
    1dc6:	85 c0                	test   %eax,%eax
    1dc8:	79 0c                	jns    1dd6 <random+0x37>
{
rand_num *= (-1);
    1dca:	a1 ec 27 00 00       	mov    0x27ec,%eax
    1dcf:	f7 d8                	neg    %eax
    1dd1:	a3 ec 27 00 00       	mov    %eax,0x27ec
}
return rand_num % 997;
    1dd6:	8b 0d ec 27 00 00    	mov    0x27ec,%ecx
    1ddc:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1de1:	89 c8                	mov    %ecx,%eax
    1de3:	f7 ea                	imul   %edx
    1de5:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1de8:	c1 f8 09             	sar    $0x9,%eax
    1deb:	89 c2                	mov    %eax,%edx
    1ded:	89 c8                	mov    %ecx,%eax
    1def:	c1 f8 1f             	sar    $0x1f,%eax
    1df2:	29 c2                	sub    %eax,%edx
    1df4:	89 d0                	mov    %edx,%eax
    1df6:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1dfc:	29 c1                	sub    %eax,%ecx
    1dfe:	89 c8                	mov    %ecx,%eax
}
    1e00:	5d                   	pop    %ebp
    1e01:	c3                   	ret    

00001e02 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1e02:	55                   	push   %ebp
    1e03:	89 e5                	mov    %esp,%ebp
    1e05:	53                   	push   %ebx
    1e06:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1e09:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1e10:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1e14:	74 17                	je     1e2d <sprintint+0x2b>
    1e16:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e1a:	79 11                	jns    1e2d <sprintint+0x2b>
        neg = 1;
    1e1c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1e23:	8b 45 10             	mov    0x10(%ebp),%eax
    1e26:	f7 d8                	neg    %eax
    1e28:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e2b:	eb 06                	jmp    1e33 <sprintint+0x31>
    } else {
        x = xx;
    1e2d:	8b 45 10             	mov    0x10(%ebp),%eax
    1e30:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1e33:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1e3a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1e3d:	8d 41 01             	lea    0x1(%ecx),%eax
    1e40:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1e43:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e46:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e49:	ba 00 00 00 00       	mov    $0x0,%edx
    1e4e:	f7 f3                	div    %ebx
    1e50:	89 d0                	mov    %edx,%eax
    1e52:	0f b6 80 f0 27 00 00 	movzbl 0x27f0(%eax),%eax
    1e59:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1e5d:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e60:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e63:	ba 00 00 00 00       	mov    $0x0,%edx
    1e68:	f7 f3                	div    %ebx
    1e6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e6d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e71:	75 c7                	jne    1e3a <sprintint+0x38>
    if(neg)
    1e73:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e77:	74 0e                	je     1e87 <sprintint+0x85>
        buf[i++] = '-';
    1e79:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e7c:	8d 50 01             	lea    0x1(%eax),%edx
    1e7f:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1e82:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1e87:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e8a:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1e8d:	eb 1b                	jmp    1eaa <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1e8f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e92:	8b 00                	mov    (%eax),%eax
    1e94:	8d 48 01             	lea    0x1(%eax),%ecx
    1e97:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e9a:	89 0a                	mov    %ecx,(%edx)
    1e9c:	89 c2                	mov    %eax,%edx
    1e9e:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea1:	01 d0                	add    %edx,%eax
    1ea3:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1ea6:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1eaa:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1eae:	7f df                	jg     1e8f <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1eb0:	eb 21                	jmp    1ed3 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1eb2:	8b 45 0c             	mov    0xc(%ebp),%eax
    1eb5:	8b 00                	mov    (%eax),%eax
    1eb7:	8d 48 01             	lea    0x1(%eax),%ecx
    1eba:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ebd:	89 0a                	mov    %ecx,(%edx)
    1ebf:	89 c2                	mov    %eax,%edx
    1ec1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec4:	01 c2                	add    %eax,%edx
    1ec6:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1ec9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ecc:	01 c8                	add    %ecx,%eax
    1ece:	0f b6 00             	movzbl (%eax),%eax
    1ed1:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1ed3:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1ed7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1edb:	79 d5                	jns    1eb2 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1edd:	90                   	nop
    1ede:	83 c4 20             	add    $0x20,%esp
    1ee1:	5b                   	pop    %ebx
    1ee2:	5d                   	pop    %ebp
    1ee3:	c3                   	ret    

00001ee4 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1ee4:	55                   	push   %ebp
    1ee5:	89 e5                	mov    %esp,%ebp
    1ee7:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1eea:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1ef1:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1ef8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1eff:	8d 45 0c             	lea    0xc(%ebp),%eax
    1f02:	83 c0 04             	add    $0x4,%eax
    1f05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1f08:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1f0f:	e9 d9 01 00 00       	jmp    20ed <sprintf+0x209>
        c = fmt[i] & 0xff;
    1f14:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f17:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f1a:	01 d0                	add    %edx,%eax
    1f1c:	0f b6 00             	movzbl (%eax),%eax
    1f1f:	0f be c0             	movsbl %al,%eax
    1f22:	25 ff 00 00 00       	and    $0xff,%eax
    1f27:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1f2a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1f2e:	75 2c                	jne    1f5c <sprintf+0x78>
            if(c == '%'){
    1f30:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1f34:	75 0c                	jne    1f42 <sprintf+0x5e>
                state = '%';
    1f36:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1f3d:	e9 a7 01 00 00       	jmp    20e9 <sprintf+0x205>
            } else {
                dst[j++] = c;
    1f42:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f45:	8d 50 01             	lea    0x1(%eax),%edx
    1f48:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f4b:	89 c2                	mov    %eax,%edx
    1f4d:	8b 45 08             	mov    0x8(%ebp),%eax
    1f50:	01 d0                	add    %edx,%eax
    1f52:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f55:	88 10                	mov    %dl,(%eax)
    1f57:	e9 8d 01 00 00       	jmp    20e9 <sprintf+0x205>
            }
        } else if(state == '%'){
    1f5c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1f60:	0f 85 83 01 00 00    	jne    20e9 <sprintf+0x205>
            if(c == 'd'){
    1f66:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1f6a:	75 4c                	jne    1fb8 <sprintf+0xd4>
                buf[bi] = '\0';
    1f6c:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f72:	01 d0                	add    %edx,%eax
    1f74:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f77:	83 ec 0c             	sub    $0xc,%esp
    1f7a:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f7d:	50                   	push   %eax
    1f7e:	e8 b4 e2 ff ff       	call   237 <atoi>
    1f83:	83 c4 10             	add    $0x10,%esp
    1f86:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1f89:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1f90:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f93:	8b 00                	mov    (%eax),%eax
    1f95:	83 ec 08             	sub    $0x8,%esp
    1f98:	ff 75 d8             	pushl  -0x28(%ebp)
    1f9b:	6a 01                	push   $0x1
    1f9d:	6a 0a                	push   $0xa
    1f9f:	50                   	push   %eax
    1fa0:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1fa3:	50                   	push   %eax
    1fa4:	ff 75 08             	pushl  0x8(%ebp)
    1fa7:	e8 56 fe ff ff       	call   1e02 <sprintint>
    1fac:	83 c4 20             	add    $0x20,%esp
                ap++;
    1faf:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1fb3:	e9 2a 01 00 00       	jmp    20e2 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1fb8:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1fbc:	74 06                	je     1fc4 <sprintf+0xe0>
    1fbe:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1fc2:	75 4c                	jne    2010 <sprintf+0x12c>
                buf[bi] = '\0';
    1fc4:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1fc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1fca:	01 d0                	add    %edx,%eax
    1fcc:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1fcf:	83 ec 0c             	sub    $0xc,%esp
    1fd2:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1fd5:	50                   	push   %eax
    1fd6:	e8 5c e2 ff ff       	call   237 <atoi>
    1fdb:	83 c4 10             	add    $0x10,%esp
    1fde:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1fe1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1fe8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1feb:	8b 00                	mov    (%eax),%eax
    1fed:	83 ec 08             	sub    $0x8,%esp
    1ff0:	ff 75 dc             	pushl  -0x24(%ebp)
    1ff3:	6a 00                	push   $0x0
    1ff5:	6a 10                	push   $0x10
    1ff7:	50                   	push   %eax
    1ff8:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1ffb:	50                   	push   %eax
    1ffc:	ff 75 08             	pushl  0x8(%ebp)
    1fff:	e8 fe fd ff ff       	call   1e02 <sprintint>
    2004:	83 c4 20             	add    $0x20,%esp
                ap++;
    2007:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    200b:	e9 d2 00 00 00       	jmp    20e2 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2010:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2014:	75 46                	jne    205c <sprintf+0x178>
                s = (char*)*ap;
    2016:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2019:	8b 00                	mov    (%eax),%eax
    201b:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    201e:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2022:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2026:	75 25                	jne    204d <sprintf+0x169>
                    s = "(null)";
    2028:	c7 45 f4 a0 22 00 00 	movl   $0x22a0,-0xc(%ebp)
                while(*s != 0){
    202f:	eb 1c                	jmp    204d <sprintf+0x169>
                    dst[j++] = *s;
    2031:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2034:	8d 50 01             	lea    0x1(%eax),%edx
    2037:	89 55 c8             	mov    %edx,-0x38(%ebp)
    203a:	89 c2                	mov    %eax,%edx
    203c:	8b 45 08             	mov    0x8(%ebp),%eax
    203f:	01 c2                	add    %eax,%edx
    2041:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2044:	0f b6 00             	movzbl (%eax),%eax
    2047:	88 02                	mov    %al,(%edx)
                    s++;
    2049:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    204d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2050:	0f b6 00             	movzbl (%eax),%eax
    2053:	84 c0                	test   %al,%al
    2055:	75 da                	jne    2031 <sprintf+0x14d>
    2057:	e9 86 00 00 00       	jmp    20e2 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    205c:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2060:	75 1d                	jne    207f <sprintf+0x19b>
                dst[j++] = *ap;
    2062:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2065:	8d 50 01             	lea    0x1(%eax),%edx
    2068:	89 55 c8             	mov    %edx,-0x38(%ebp)
    206b:	89 c2                	mov    %eax,%edx
    206d:	8b 45 08             	mov    0x8(%ebp),%eax
    2070:	01 c2                	add    %eax,%edx
    2072:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2075:	8b 00                	mov    (%eax),%eax
    2077:	88 02                	mov    %al,(%edx)
                ap++;
    2079:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    207d:	eb 63                	jmp    20e2 <sprintf+0x1fe>
            } else if(c == '%'){
    207f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2083:	75 17                	jne    209c <sprintf+0x1b8>
                dst[j++] = c;
    2085:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2088:	8d 50 01             	lea    0x1(%eax),%edx
    208b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    208e:	89 c2                	mov    %eax,%edx
    2090:	8b 45 08             	mov    0x8(%ebp),%eax
    2093:	01 d0                	add    %edx,%eax
    2095:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2098:	88 10                	mov    %dl,(%eax)
    209a:	eb 46                	jmp    20e2 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    209c:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    20a0:	7e 18                	jle    20ba <sprintf+0x1d6>
    20a2:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    20a6:	7f 12                	jg     20ba <sprintf+0x1d6>
            {
                buf[bi++] = c;
    20a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20ab:	8d 50 01             	lea    0x1(%eax),%edx
    20ae:	89 55 f0             	mov    %edx,-0x10(%ebp)
    20b1:	8b 55 e0             	mov    -0x20(%ebp),%edx
    20b4:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    20b8:	eb 2f                	jmp    20e9 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    20ba:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20bd:	8d 50 01             	lea    0x1(%eax),%edx
    20c0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20c3:	89 c2                	mov    %eax,%edx
    20c5:	8b 45 08             	mov    0x8(%ebp),%eax
    20c8:	01 d0                	add    %edx,%eax
    20ca:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    20cd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20d0:	8d 50 01             	lea    0x1(%eax),%edx
    20d3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20d6:	89 c2                	mov    %eax,%edx
    20d8:	8b 45 08             	mov    0x8(%ebp),%eax
    20db:	01 d0                	add    %edx,%eax
    20dd:	8b 55 e0             	mov    -0x20(%ebp),%edx
    20e0:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    20e2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    20e9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    20ed:	8b 55 0c             	mov    0xc(%ebp),%edx
    20f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    20f3:	01 d0                	add    %edx,%eax
    20f5:	0f b6 00             	movzbl (%eax),%eax
    20f8:	84 c0                	test   %al,%al
    20fa:	0f 85 14 fe ff ff    	jne    1f14 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2100:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2103:	8d 50 01             	lea    0x1(%eax),%edx
    2106:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2109:	89 c2                	mov    %eax,%edx
    210b:	8b 45 08             	mov    0x8(%ebp),%eax
    210e:	01 d0                	add    %edx,%eax
    2110:	c6 00 00             	movb   $0x0,(%eax)
}
    2113:	90                   	nop
    2114:	c9                   	leave  
    2115:	c3                   	ret    
