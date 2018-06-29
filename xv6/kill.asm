
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
      1c:	68 3c 22 00 00       	push   $0x223c
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
     414:	0f b6 80 24 29 00 00 	movzbl 0x2924(%eax),%eax
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
     552:	c7 45 f4 50 22 00 00 	movl   $0x2250,-0xc(%ebp)
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
     618:	a1 58 29 00 00       	mov    0x2958,%eax
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
     6e3:	a3 58 29 00 00       	mov    %eax,0x2958
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
     744:	a1 58 29 00 00       	mov    0x2958,%eax
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
     760:	a1 58 29 00 00       	mov    0x2958,%eax
     765:	89 45 f0             	mov    %eax,-0x10(%ebp)
     768:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     76c:	75 23                	jne    791 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     76e:	c7 45 f0 50 29 00 00 	movl   $0x2950,-0x10(%ebp)
     775:	8b 45 f0             	mov    -0x10(%ebp),%eax
     778:	a3 58 29 00 00       	mov    %eax,0x2958
     77d:	a1 58 29 00 00       	mov    0x2958,%eax
     782:	a3 50 29 00 00       	mov    %eax,0x2950
    base.s.size = 0;
     787:	c7 05 54 29 00 00 00 	movl   $0x0,0x2954
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
     7e4:	a3 58 29 00 00       	mov    %eax,0x2958
      return (void*)(p + 1);
     7e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ec:	83 c0 08             	add    $0x8,%eax
     7ef:	eb 3b                	jmp    82c <malloc+0xe1>
    }
    if(p == freep)
     7f1:	a1 58 29 00 00       	mov    0x2958,%eax
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
     937:	68 57 22 00 00       	push   $0x2257
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

00000c48 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c48:	55                   	push   %ebp
     c49:	89 e5                	mov    %esp,%ebp
     c4b:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c4e:	8b 45 08             	mov    0x8(%ebp),%eax
     c51:	8b 40 0c             	mov    0xc(%eax),%eax
     c54:	89 c2                	mov    %eax,%edx
     c56:	c1 ea 1f             	shr    $0x1f,%edx
     c59:	01 d0                	add    %edx,%eax
     c5b:	d1 f8                	sar    %eax
     c5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c60:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c63:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c67:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c6a:	8b 45 10             	mov    0x10(%ebp),%eax
     c6d:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c70:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c73:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c77:	0f 89 98 00 00 00    	jns    d15 <APDrawPoint+0xcd>
        i = 0;
     c7d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c84:	e9 8c 00 00 00       	jmp    d15 <APDrawPoint+0xcd>
    {
        j = x - off;
     c89:	8b 45 0c             	mov    0xc(%ebp),%eax
     c8c:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c8f:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     c92:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     c96:	79 69                	jns    d01 <APDrawPoint+0xb9>
            j = 0;
     c98:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     c9f:	eb 60                	jmp    d01 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     ca1:	ff 75 fc             	pushl  -0x4(%ebp)
     ca4:	ff 75 f8             	pushl  -0x8(%ebp)
     ca7:	ff 75 08             	pushl  0x8(%ebp)
     caa:	e8 fd fb ff ff       	call   8ac <APGetIndex>
     caf:	83 c4 0c             	add    $0xc,%esp
     cb2:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     cb5:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cb9:	74 55                	je     d10 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cbb:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     cbf:	74 67                	je     d28 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     cc1:	ff 75 10             	pushl  0x10(%ebp)
     cc4:	ff 75 0c             	pushl  0xc(%ebp)
     cc7:	ff 75 fc             	pushl  -0x4(%ebp)
     cca:	ff 75 f8             	pushl  -0x8(%ebp)
     ccd:	e8 a1 fb ff ff       	call   873 <distance_2>
     cd2:	83 c4 10             	add    $0x10,%esp
     cd5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     cd8:	7f 23                	jg     cfd <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     cda:	8b 45 08             	mov    0x8(%ebp),%eax
     cdd:	8b 48 18             	mov    0x18(%eax),%ecx
     ce0:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ce3:	89 d0                	mov    %edx,%eax
     ce5:	01 c0                	add    %eax,%eax
     ce7:	01 d0                	add    %edx,%eax
     ce9:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     cec:	8b 45 08             	mov    0x8(%ebp),%eax
     cef:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     cf3:	66 89 0a             	mov    %cx,(%edx)
     cf6:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     cfa:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     cfd:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d01:	8b 55 0c             	mov    0xc(%ebp),%edx
     d04:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d07:	01 d0                	add    %edx,%eax
     d09:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d0c:	7d 93                	jge    ca1 <APDrawPoint+0x59>
     d0e:	eb 01                	jmp    d11 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d10:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d11:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d15:	8b 55 10             	mov    0x10(%ebp),%edx
     d18:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d1b:	01 d0                	add    %edx,%eax
     d1d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d20:	0f 8d 63 ff ff ff    	jge    c89 <APDrawPoint+0x41>
     d26:	eb 01                	jmp    d29 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d28:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d29:	c9                   	leave  
     d2a:	c3                   	ret    

00000d2b <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d2b:	55                   	push   %ebp
     d2c:	89 e5                	mov    %esp,%ebp
     d2e:	53                   	push   %ebx
     d2f:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d32:	8b 45 0c             	mov    0xc(%ebp),%eax
     d35:	3b 45 14             	cmp    0x14(%ebp),%eax
     d38:	0f 85 80 00 00 00    	jne    dbe <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d3e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d42:	0f 88 9d 02 00 00    	js     fe5 <APDrawLine+0x2ba>
     d48:	8b 45 08             	mov    0x8(%ebp),%eax
     d4b:	8b 00                	mov    (%eax),%eax
     d4d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d50:	0f 8e 8f 02 00 00    	jle    fe5 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d56:	8b 45 10             	mov    0x10(%ebp),%eax
     d59:	3b 45 18             	cmp    0x18(%ebp),%eax
     d5c:	7e 12                	jle    d70 <APDrawLine+0x45>
        {
            int tmp = y2;
     d5e:	8b 45 18             	mov    0x18(%ebp),%eax
     d61:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d64:	8b 45 10             	mov    0x10(%ebp),%eax
     d67:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d6a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d6d:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d70:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d74:	79 07                	jns    d7d <APDrawLine+0x52>
     d76:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d7d:	8b 45 08             	mov    0x8(%ebp),%eax
     d80:	8b 40 04             	mov    0x4(%eax),%eax
     d83:	3b 45 18             	cmp    0x18(%ebp),%eax
     d86:	7d 0c                	jge    d94 <APDrawLine+0x69>
     d88:	8b 45 08             	mov    0x8(%ebp),%eax
     d8b:	8b 40 04             	mov    0x4(%eax),%eax
     d8e:	83 e8 01             	sub    $0x1,%eax
     d91:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     d94:	8b 45 10             	mov    0x10(%ebp),%eax
     d97:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d9a:	eb 15                	jmp    db1 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     d9c:	ff 75 f4             	pushl  -0xc(%ebp)
     d9f:	ff 75 0c             	pushl  0xc(%ebp)
     da2:	ff 75 08             	pushl  0x8(%ebp)
     da5:	e8 9e fe ff ff       	call   c48 <APDrawPoint>
     daa:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     dad:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     db1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     db4:	3b 45 18             	cmp    0x18(%ebp),%eax
     db7:	7e e3                	jle    d9c <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     db9:	e9 2b 02 00 00       	jmp    fe9 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     dbe:	8b 45 10             	mov    0x10(%ebp),%eax
     dc1:	3b 45 18             	cmp    0x18(%ebp),%eax
     dc4:	75 7f                	jne    e45 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     dc6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dca:	0f 88 18 02 00 00    	js     fe8 <APDrawLine+0x2bd>
     dd0:	8b 45 08             	mov    0x8(%ebp),%eax
     dd3:	8b 40 04             	mov    0x4(%eax),%eax
     dd6:	3b 45 10             	cmp    0x10(%ebp),%eax
     dd9:	0f 8e 09 02 00 00    	jle    fe8 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     ddf:	8b 45 0c             	mov    0xc(%ebp),%eax
     de2:	3b 45 14             	cmp    0x14(%ebp),%eax
     de5:	7e 12                	jle    df9 <APDrawLine+0xce>
        {
            int tmp = x2;
     de7:	8b 45 14             	mov    0x14(%ebp),%eax
     dea:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     ded:	8b 45 0c             	mov    0xc(%ebp),%eax
     df0:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     df3:	8b 45 d8             	mov    -0x28(%ebp),%eax
     df6:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     df9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     dfd:	79 07                	jns    e06 <APDrawLine+0xdb>
     dff:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e06:	8b 45 08             	mov    0x8(%ebp),%eax
     e09:	8b 00                	mov    (%eax),%eax
     e0b:	3b 45 14             	cmp    0x14(%ebp),%eax
     e0e:	7d 0b                	jge    e1b <APDrawLine+0xf0>
     e10:	8b 45 08             	mov    0x8(%ebp),%eax
     e13:	8b 00                	mov    (%eax),%eax
     e15:	83 e8 01             	sub    $0x1,%eax
     e18:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e1b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e21:	eb 15                	jmp    e38 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e23:	ff 75 10             	pushl  0x10(%ebp)
     e26:	ff 75 f0             	pushl  -0x10(%ebp)
     e29:	ff 75 08             	pushl  0x8(%ebp)
     e2c:	e8 17 fe ff ff       	call   c48 <APDrawPoint>
     e31:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e34:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e38:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e3b:	3b 45 14             	cmp    0x14(%ebp),%eax
     e3e:	7e e3                	jle    e23 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e40:	e9 a4 01 00 00       	jmp    fe9 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e45:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e4c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e53:	8b 45 0c             	mov    0xc(%ebp),%eax
     e56:	2b 45 14             	sub    0x14(%ebp),%eax
     e59:	50                   	push   %eax
     e5a:	e8 3d fa ff ff       	call   89c <abs_int>
     e5f:	83 c4 04             	add    $0x4,%esp
     e62:	89 c3                	mov    %eax,%ebx
     e64:	8b 45 10             	mov    0x10(%ebp),%eax
     e67:	2b 45 18             	sub    0x18(%ebp),%eax
     e6a:	50                   	push   %eax
     e6b:	e8 2c fa ff ff       	call   89c <abs_int>
     e70:	83 c4 04             	add    $0x4,%esp
     e73:	39 c3                	cmp    %eax,%ebx
     e75:	0f 8e b5 00 00 00    	jle    f30 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e7b:	8b 45 10             	mov    0x10(%ebp),%eax
     e7e:	2b 45 18             	sub    0x18(%ebp),%eax
     e81:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e84:	db 45 b0             	fildl  -0x50(%ebp)
     e87:	8b 45 0c             	mov    0xc(%ebp),%eax
     e8a:	2b 45 14             	sub    0x14(%ebp),%eax
     e8d:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e90:	db 45 b0             	fildl  -0x50(%ebp)
     e93:	de f9                	fdivrp %st,%st(1)
     e95:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     e98:	8b 45 14             	mov    0x14(%ebp),%eax
     e9b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e9e:	7e 0e                	jle    eae <APDrawLine+0x183>
        {
            s = x1;
     ea0:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea3:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     ea6:	8b 45 14             	mov    0x14(%ebp),%eax
     ea9:	89 45 e8             	mov    %eax,-0x18(%ebp)
     eac:	eb 0c                	jmp    eba <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     eae:	8b 45 14             	mov    0x14(%ebp),%eax
     eb1:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     eb4:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb7:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     eba:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ebe:	79 07                	jns    ec7 <APDrawLine+0x19c>
     ec0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     ec7:	8b 45 08             	mov    0x8(%ebp),%eax
     eca:	8b 00                	mov    (%eax),%eax
     ecc:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ecf:	7f 0b                	jg     edc <APDrawLine+0x1b1>
     ed1:	8b 45 08             	mov    0x8(%ebp),%eax
     ed4:	8b 00                	mov    (%eax),%eax
     ed6:	83 e8 01             	sub    $0x1,%eax
     ed9:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     edc:	8b 45 ec             	mov    -0x14(%ebp),%eax
     edf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     ee2:	eb 3f                	jmp    f23 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     ee4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ee7:	2b 45 0c             	sub    0xc(%ebp),%eax
     eea:	89 45 b0             	mov    %eax,-0x50(%ebp)
     eed:	db 45 b0             	fildl  -0x50(%ebp)
     ef0:	dc 4d d0             	fmull  -0x30(%ebp)
     ef3:	db 45 10             	fildl  0x10(%ebp)
     ef6:	de c1                	faddp  %st,%st(1)
     ef8:	d9 7d b6             	fnstcw -0x4a(%ebp)
     efb:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     eff:	b4 0c                	mov    $0xc,%ah
     f01:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f05:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f08:	db 5d cc             	fistpl -0x34(%ebp)
     f0b:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f0e:	ff 75 cc             	pushl  -0x34(%ebp)
     f11:	ff 75 e4             	pushl  -0x1c(%ebp)
     f14:	ff 75 08             	pushl  0x8(%ebp)
     f17:	e8 2c fd ff ff       	call   c48 <APDrawPoint>
     f1c:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f1f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f26:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f29:	7e b9                	jle    ee4 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f2b:	e9 b9 00 00 00       	jmp    fe9 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f30:	8b 45 0c             	mov    0xc(%ebp),%eax
     f33:	2b 45 14             	sub    0x14(%ebp),%eax
     f36:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f39:	db 45 b0             	fildl  -0x50(%ebp)
     f3c:	8b 45 10             	mov    0x10(%ebp),%eax
     f3f:	2b 45 18             	sub    0x18(%ebp),%eax
     f42:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f45:	db 45 b0             	fildl  -0x50(%ebp)
     f48:	de f9                	fdivrp %st,%st(1)
     f4a:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f4d:	8b 45 10             	mov    0x10(%ebp),%eax
     f50:	3b 45 18             	cmp    0x18(%ebp),%eax
     f53:	7e 0e                	jle    f63 <APDrawLine+0x238>
    {
        s = y2;
     f55:	8b 45 18             	mov    0x18(%ebp),%eax
     f58:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f5b:	8b 45 10             	mov    0x10(%ebp),%eax
     f5e:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f61:	eb 0c                	jmp    f6f <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f63:	8b 45 10             	mov    0x10(%ebp),%eax
     f66:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f69:	8b 45 18             	mov    0x18(%ebp),%eax
     f6c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f6f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f73:	79 07                	jns    f7c <APDrawLine+0x251>
     f75:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f7c:	8b 45 08             	mov    0x8(%ebp),%eax
     f7f:	8b 40 04             	mov    0x4(%eax),%eax
     f82:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f85:	7f 0c                	jg     f93 <APDrawLine+0x268>
     f87:	8b 45 08             	mov    0x8(%ebp),%eax
     f8a:	8b 40 04             	mov    0x4(%eax),%eax
     f8d:	83 e8 01             	sub    $0x1,%eax
     f90:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     f93:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f96:	89 45 e0             	mov    %eax,-0x20(%ebp)
     f99:	eb 3f                	jmp    fda <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     f9b:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f9e:	2b 45 10             	sub    0x10(%ebp),%eax
     fa1:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fa4:	db 45 b0             	fildl  -0x50(%ebp)
     fa7:	dc 4d c0             	fmull  -0x40(%ebp)
     faa:	db 45 0c             	fildl  0xc(%ebp)
     fad:	de c1                	faddp  %st,%st(1)
     faf:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fb2:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fb6:	b4 0c                	mov    $0xc,%ah
     fb8:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fbc:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fbf:	db 5d bc             	fistpl -0x44(%ebp)
     fc2:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     fc5:	ff 75 e0             	pushl  -0x20(%ebp)
     fc8:	ff 75 bc             	pushl  -0x44(%ebp)
     fcb:	ff 75 08             	pushl  0x8(%ebp)
     fce:	e8 75 fc ff ff       	call   c48 <APDrawPoint>
     fd3:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     fd6:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     fda:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fdd:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fe0:	7e b9                	jle    f9b <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     fe2:	90                   	nop
     fe3:	eb 04                	jmp    fe9 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     fe5:	90                   	nop
     fe6:	eb 01                	jmp    fe9 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     fe8:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     fe9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fec:	c9                   	leave  
     fed:	c3                   	ret    

00000fee <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     fee:	55                   	push   %ebp
     fef:	89 e5                	mov    %esp,%ebp
     ff1:	53                   	push   %ebx
     ff2:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
     ff5:	8b 55 10             	mov    0x10(%ebp),%edx
     ff8:	8b 45 18             	mov    0x18(%ebp),%eax
     ffb:	01 d0                	add    %edx,%eax
     ffd:	83 e8 01             	sub    $0x1,%eax
    1000:	83 ec 04             	sub    $0x4,%esp
    1003:	50                   	push   %eax
    1004:	ff 75 0c             	pushl  0xc(%ebp)
    1007:	ff 75 10             	pushl  0x10(%ebp)
    100a:	ff 75 0c             	pushl  0xc(%ebp)
    100d:	ff 75 08             	pushl  0x8(%ebp)
    1010:	e8 16 fd ff ff       	call   d2b <APDrawLine>
    1015:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1018:	8b 55 0c             	mov    0xc(%ebp),%edx
    101b:	8b 45 14             	mov    0x14(%ebp),%eax
    101e:	01 d0                	add    %edx,%eax
    1020:	83 e8 01             	sub    $0x1,%eax
    1023:	83 ec 04             	sub    $0x4,%esp
    1026:	ff 75 10             	pushl  0x10(%ebp)
    1029:	50                   	push   %eax
    102a:	ff 75 10             	pushl  0x10(%ebp)
    102d:	ff 75 0c             	pushl  0xc(%ebp)
    1030:	ff 75 08             	pushl  0x8(%ebp)
    1033:	e8 f3 fc ff ff       	call   d2b <APDrawLine>
    1038:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    103b:	8b 55 10             	mov    0x10(%ebp),%edx
    103e:	8b 45 18             	mov    0x18(%ebp),%eax
    1041:	01 d0                	add    %edx,%eax
    1043:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1046:	8b 55 0c             	mov    0xc(%ebp),%edx
    1049:	8b 45 14             	mov    0x14(%ebp),%eax
    104c:	01 d0                	add    %edx,%eax
    104e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1051:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1054:	8b 45 14             	mov    0x14(%ebp),%eax
    1057:	01 d8                	add    %ebx,%eax
    1059:	83 e8 01             	sub    $0x1,%eax
    105c:	83 ec 04             	sub    $0x4,%esp
    105f:	51                   	push   %ecx
    1060:	52                   	push   %edx
    1061:	ff 75 10             	pushl  0x10(%ebp)
    1064:	50                   	push   %eax
    1065:	ff 75 08             	pushl  0x8(%ebp)
    1068:	e8 be fc ff ff       	call   d2b <APDrawLine>
    106d:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1070:	8b 55 10             	mov    0x10(%ebp),%edx
    1073:	8b 45 18             	mov    0x18(%ebp),%eax
    1076:	01 d0                	add    %edx,%eax
    1078:	8d 48 ff             	lea    -0x1(%eax),%ecx
    107b:	8b 55 0c             	mov    0xc(%ebp),%edx
    107e:	8b 45 14             	mov    0x14(%ebp),%eax
    1081:	01 d0                	add    %edx,%eax
    1083:	8d 50 ff             	lea    -0x1(%eax),%edx
    1086:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1089:	8b 45 18             	mov    0x18(%ebp),%eax
    108c:	01 d8                	add    %ebx,%eax
    108e:	83 e8 01             	sub    $0x1,%eax
    1091:	83 ec 04             	sub    $0x4,%esp
    1094:	51                   	push   %ecx
    1095:	52                   	push   %edx
    1096:	50                   	push   %eax
    1097:	ff 75 0c             	pushl  0xc(%ebp)
    109a:	ff 75 08             	pushl  0x8(%ebp)
    109d:	e8 89 fc ff ff       	call   d2b <APDrawLine>
    10a2:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10a5:	8b 55 0c             	mov    0xc(%ebp),%edx
    10a8:	8b 45 14             	mov    0x14(%ebp),%eax
    10ab:	01 d0                	add    %edx,%eax
    10ad:	8d 50 ff             	lea    -0x1(%eax),%edx
    10b0:	8b 45 08             	mov    0x8(%ebp),%eax
    10b3:	8b 40 0c             	mov    0xc(%eax),%eax
    10b6:	89 c1                	mov    %eax,%ecx
    10b8:	c1 e9 1f             	shr    $0x1f,%ecx
    10bb:	01 c8                	add    %ecx,%eax
    10bd:	d1 f8                	sar    %eax
    10bf:	29 c2                	sub    %eax,%edx
    10c1:	89 d0                	mov    %edx,%eax
    10c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10c6:	8b 55 10             	mov    0x10(%ebp),%edx
    10c9:	8b 45 18             	mov    0x18(%ebp),%eax
    10cc:	01 d0                	add    %edx,%eax
    10ce:	8d 50 ff             	lea    -0x1(%eax),%edx
    10d1:	8b 45 08             	mov    0x8(%ebp),%eax
    10d4:	8b 40 0c             	mov    0xc(%eax),%eax
    10d7:	89 c1                	mov    %eax,%ecx
    10d9:	c1 e9 1f             	shr    $0x1f,%ecx
    10dc:	01 c8                	add    %ecx,%eax
    10de:	d1 f8                	sar    %eax
    10e0:	29 c2                	sub    %eax,%edx
    10e2:	89 d0                	mov    %edx,%eax
    10e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    10e7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ea:	8b 40 0c             	mov    0xc(%eax),%eax
    10ed:	89 c2                	mov    %eax,%edx
    10ef:	c1 ea 1f             	shr    $0x1f,%edx
    10f2:	01 d0                	add    %edx,%eax
    10f4:	d1 f8                	sar    %eax
    10f6:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    10f9:	8b 45 08             	mov    0x8(%ebp),%eax
    10fc:	8b 40 0c             	mov    0xc(%eax),%eax
    10ff:	89 c2                	mov    %eax,%edx
    1101:	c1 ea 1f             	shr    $0x1f,%edx
    1104:	01 d0                	add    %edx,%eax
    1106:	d1 f8                	sar    %eax
    1108:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    110b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    110f:	0f 88 d8 00 00 00    	js     11ed <APDrawRect+0x1ff>
    1115:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1119:	0f 88 ce 00 00 00    	js     11ed <APDrawRect+0x1ff>
    111f:	8b 45 08             	mov    0x8(%ebp),%eax
    1122:	8b 00                	mov    (%eax),%eax
    1124:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1127:	0f 8e c0 00 00 00    	jle    11ed <APDrawRect+0x1ff>
    112d:	8b 45 08             	mov    0x8(%ebp),%eax
    1130:	8b 40 04             	mov    0x4(%eax),%eax
    1133:	3b 45 10             	cmp    0x10(%ebp),%eax
    1136:	0f 8e b1 00 00 00    	jle    11ed <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    113c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1140:	79 07                	jns    1149 <APDrawRect+0x15b>
    1142:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1149:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    114d:	79 07                	jns    1156 <APDrawRect+0x168>
    114f:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1156:	8b 45 08             	mov    0x8(%ebp),%eax
    1159:	8b 00                	mov    (%eax),%eax
    115b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    115e:	7f 0b                	jg     116b <APDrawRect+0x17d>
    1160:	8b 45 08             	mov    0x8(%ebp),%eax
    1163:	8b 00                	mov    (%eax),%eax
    1165:	83 e8 01             	sub    $0x1,%eax
    1168:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    116b:	8b 45 08             	mov    0x8(%ebp),%eax
    116e:	8b 40 04             	mov    0x4(%eax),%eax
    1171:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1174:	7f 0c                	jg     1182 <APDrawRect+0x194>
    1176:	8b 45 08             	mov    0x8(%ebp),%eax
    1179:	8b 40 04             	mov    0x4(%eax),%eax
    117c:	83 e8 01             	sub    $0x1,%eax
    117f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1182:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1189:	8b 45 0c             	mov    0xc(%ebp),%eax
    118c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    118f:	eb 52                	jmp    11e3 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1191:	8b 45 10             	mov    0x10(%ebp),%eax
    1194:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1197:	eb 3e                	jmp    11d7 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1199:	83 ec 04             	sub    $0x4,%esp
    119c:	ff 75 e8             	pushl  -0x18(%ebp)
    119f:	ff 75 ec             	pushl  -0x14(%ebp)
    11a2:	ff 75 08             	pushl  0x8(%ebp)
    11a5:	e8 02 f7 ff ff       	call   8ac <APGetIndex>
    11aa:	83 c4 10             	add    $0x10,%esp
    11ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11b0:	8b 45 08             	mov    0x8(%ebp),%eax
    11b3:	8b 48 18             	mov    0x18(%eax),%ecx
    11b6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11b9:	89 d0                	mov    %edx,%eax
    11bb:	01 c0                	add    %eax,%eax
    11bd:	01 d0                	add    %edx,%eax
    11bf:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11c2:	8b 45 08             	mov    0x8(%ebp),%eax
    11c5:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11c9:	66 89 0a             	mov    %cx,(%edx)
    11cc:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    11d0:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    11d3:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11d7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11da:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11dd:	7e ba                	jle    1199 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11df:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    11e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11e6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11e9:	7e a6                	jle    1191 <APDrawRect+0x1a3>
    11eb:	eb 01                	jmp    11ee <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    11ed:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    11ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11f1:	c9                   	leave  
    11f2:	c3                   	ret    

000011f3 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    11f3:	55                   	push   %ebp
    11f4:	89 e5                	mov    %esp,%ebp
}
    11f6:	90                   	nop
    11f7:	5d                   	pop    %ebp
    11f8:	c3                   	ret    

000011f9 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    11f9:	55                   	push   %ebp
    11fa:	89 e5                	mov    %esp,%ebp
    11fc:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    11ff:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1203:	0f 88 8e 01 00 00    	js     1397 <APDcCopy+0x19e>
    1209:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    120d:	0f 88 84 01 00 00    	js     1397 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1213:	8b 55 0c             	mov    0xc(%ebp),%edx
    1216:	8b 45 20             	mov    0x20(%ebp),%eax
    1219:	01 d0                	add    %edx,%eax
    121b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    121e:	8b 55 10             	mov    0x10(%ebp),%edx
    1221:	8b 45 24             	mov    0x24(%ebp),%eax
    1224:	01 d0                	add    %edx,%eax
    1226:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1229:	8b 55 18             	mov    0x18(%ebp),%edx
    122c:	8b 45 20             	mov    0x20(%ebp),%eax
    122f:	01 d0                	add    %edx,%eax
    1231:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1234:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1237:	8b 45 24             	mov    0x24(%ebp),%eax
    123a:	01 d0                	add    %edx,%eax
    123c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    123f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1243:	0f 88 51 01 00 00    	js     139a <APDcCopy+0x1a1>
    1249:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    124d:	0f 88 47 01 00 00    	js     139a <APDcCopy+0x1a1>
    1253:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1257:	0f 88 3d 01 00 00    	js     139a <APDcCopy+0x1a1>
    125d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1261:	0f 88 33 01 00 00    	js     139a <APDcCopy+0x1a1>
    1267:	8b 45 14             	mov    0x14(%ebp),%eax
    126a:	8b 00                	mov    (%eax),%eax
    126c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    126f:	0f 8c 25 01 00 00    	jl     139a <APDcCopy+0x1a1>
    1275:	8b 45 14             	mov    0x14(%ebp),%eax
    1278:	8b 40 04             	mov    0x4(%eax),%eax
    127b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    127e:	0f 8c 16 01 00 00    	jl     139a <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1284:	8b 45 08             	mov    0x8(%ebp),%eax
    1287:	8b 00                	mov    (%eax),%eax
    1289:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    128c:	7f 0b                	jg     1299 <APDcCopy+0xa0>
    128e:	8b 45 08             	mov    0x8(%ebp),%eax
    1291:	8b 00                	mov    (%eax),%eax
    1293:	83 e8 01             	sub    $0x1,%eax
    1296:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1299:	8b 45 08             	mov    0x8(%ebp),%eax
    129c:	8b 40 04             	mov    0x4(%eax),%eax
    129f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12a2:	7f 0c                	jg     12b0 <APDcCopy+0xb7>
    12a4:	8b 45 08             	mov    0x8(%ebp),%eax
    12a7:	8b 40 04             	mov    0x4(%eax),%eax
    12aa:	83 e8 01             	sub    $0x1,%eax
    12ad:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    12b0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12b7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    12be:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12c5:	e9 bc 00 00 00       	jmp    1386 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12ca:	8b 45 08             	mov    0x8(%ebp),%eax
    12cd:	8b 00                	mov    (%eax),%eax
    12cf:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12d2:	8b 55 10             	mov    0x10(%ebp),%edx
    12d5:	01 ca                	add    %ecx,%edx
    12d7:	0f af d0             	imul   %eax,%edx
    12da:	8b 45 0c             	mov    0xc(%ebp),%eax
    12dd:	01 d0                	add    %edx,%eax
    12df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    12e2:	8b 45 14             	mov    0x14(%ebp),%eax
    12e5:	8b 00                	mov    (%eax),%eax
    12e7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12ea:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12ed:	01 ca                	add    %ecx,%edx
    12ef:	0f af d0             	imul   %eax,%edx
    12f2:	8b 45 18             	mov    0x18(%ebp),%eax
    12f5:	01 d0                	add    %edx,%eax
    12f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    12fa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1301:	eb 74                	jmp    1377 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1303:	8b 45 14             	mov    0x14(%ebp),%eax
    1306:	8b 50 18             	mov    0x18(%eax),%edx
    1309:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    130c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    130f:	01 c8                	add    %ecx,%eax
    1311:	89 c1                	mov    %eax,%ecx
    1313:	89 c8                	mov    %ecx,%eax
    1315:	01 c0                	add    %eax,%eax
    1317:	01 c8                	add    %ecx,%eax
    1319:	01 d0                	add    %edx,%eax
    131b:	0f b7 10             	movzwl (%eax),%edx
    131e:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1322:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1326:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1329:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    132d:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1331:	38 c2                	cmp    %al,%dl
    1333:	75 18                	jne    134d <APDcCopy+0x154>
    1335:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1339:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    133d:	38 c2                	cmp    %al,%dl
    133f:	75 0c                	jne    134d <APDcCopy+0x154>
    1341:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1345:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1349:	38 c2                	cmp    %al,%dl
    134b:	74 26                	je     1373 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    134d:	8b 45 08             	mov    0x8(%ebp),%eax
    1350:	8b 50 18             	mov    0x18(%eax),%edx
    1353:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1356:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1359:	01 c8                	add    %ecx,%eax
    135b:	89 c1                	mov    %eax,%ecx
    135d:	89 c8                	mov    %ecx,%eax
    135f:	01 c0                	add    %eax,%eax
    1361:	01 c8                	add    %ecx,%eax
    1363:	01 d0                	add    %edx,%eax
    1365:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1369:	66 89 10             	mov    %dx,(%eax)
    136c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1370:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1373:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1377:	8b 45 fc             	mov    -0x4(%ebp),%eax
    137a:	2b 45 0c             	sub    0xc(%ebp),%eax
    137d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1380:	7d 81                	jge    1303 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1382:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1386:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1389:	2b 45 10             	sub    0x10(%ebp),%eax
    138c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    138f:	0f 8d 35 ff ff ff    	jge    12ca <APDcCopy+0xd1>
    1395:	eb 04                	jmp    139b <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1397:	90                   	nop
    1398:	eb 01                	jmp    139b <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    139a:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    139b:	c9                   	leave  
    139c:	c3                   	ret    

0000139d <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    139d:	55                   	push   %ebp
    139e:	89 e5                	mov    %esp,%ebp
    13a0:	83 ec 1c             	sub    $0x1c,%esp
    13a3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    13a6:	8b 55 10             	mov    0x10(%ebp),%edx
    13a9:	8b 45 14             	mov    0x14(%ebp),%eax
    13ac:	88 4d ec             	mov    %cl,-0x14(%ebp)
    13af:	88 55 e8             	mov    %dl,-0x18(%ebp)
    13b2:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    13b5:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13b9:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13bc:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13c0:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13c3:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13c7:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13ca:	8b 45 08             	mov    0x8(%ebp),%eax
    13cd:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13d1:	66 89 10             	mov    %dx,(%eax)
    13d4:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13d8:	88 50 02             	mov    %dl,0x2(%eax)
}
    13db:	8b 45 08             	mov    0x8(%ebp),%eax
    13de:	c9                   	leave  
    13df:	c2 04 00             	ret    $0x4

000013e2 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    13e2:	55                   	push   %ebp
    13e3:	89 e5                	mov    %esp,%ebp
    13e5:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13e8:	8b 45 08             	mov    0x8(%ebp),%eax
    13eb:	8b 00                	mov    (%eax),%eax
    13ed:	83 ec 08             	sub    $0x8,%esp
    13f0:	8d 55 0c             	lea    0xc(%ebp),%edx
    13f3:	52                   	push   %edx
    13f4:	50                   	push   %eax
    13f5:	e8 77 ef ff ff       	call   371 <sendMessage>
    13fa:	83 c4 10             	add    $0x10,%esp
}
    13fd:	90                   	nop
    13fe:	c9                   	leave  
    13ff:	c3                   	ret    

00001400 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1400:	55                   	push   %ebp
    1401:	89 e5                	mov    %esp,%ebp
    1403:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1406:	83 ec 0c             	sub    $0xc,%esp
    1409:	68 98 00 00 00       	push   $0x98
    140e:	e8 38 f3 ff ff       	call   74b <malloc>
    1413:	83 c4 10             	add    $0x10,%esp
    1416:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1419:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    141d:	75 15                	jne    1434 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    141f:	83 ec 04             	sub    $0x4,%esp
    1422:	ff 75 08             	pushl  0x8(%ebp)
    1425:	68 68 22 00 00       	push   $0x2268
    142a:	6a 01                	push   $0x1
    142c:	e8 47 f0 ff ff       	call   478 <printf>
    1431:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1434:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1437:	05 84 00 00 00       	add    $0x84,%eax
    143c:	83 ec 08             	sub    $0x8,%esp
    143f:	ff 75 08             	pushl  0x8(%ebp)
    1442:	50                   	push   %eax
    1443:	e8 50 ec ff ff       	call   98 <strcpy>
    1448:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    144b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    144e:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1455:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1458:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    145f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1462:	8b 40 3c             	mov    0x3c(%eax),%eax
    1465:	89 c2                	mov    %eax,%edx
    1467:	8b 45 f4             	mov    -0xc(%ebp),%eax
    146a:	8b 40 40             	mov    0x40(%eax),%eax
    146d:	0f af d0             	imul   %eax,%edx
    1470:	89 d0                	mov    %edx,%eax
    1472:	01 c0                	add    %eax,%eax
    1474:	01 d0                	add    %edx,%eax
    1476:	83 ec 0c             	sub    $0xc,%esp
    1479:	50                   	push   %eax
    147a:	e8 cc f2 ff ff       	call   74b <malloc>
    147f:	83 c4 10             	add    $0x10,%esp
    1482:	89 c2                	mov    %eax,%edx
    1484:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1487:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    148a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    148d:	8b 40 54             	mov    0x54(%eax),%eax
    1490:	85 c0                	test   %eax,%eax
    1492:	75 15                	jne    14a9 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1494:	83 ec 04             	sub    $0x4,%esp
    1497:	ff 75 08             	pushl  0x8(%ebp)
    149a:	68 88 22 00 00       	push   $0x2288
    149f:	6a 01                	push   $0x1
    14a1:	e8 d2 ef ff ff       	call   478 <printf>
    14a6:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ac:	8b 40 3c             	mov    0x3c(%eax),%eax
    14af:	89 c2                	mov    %eax,%edx
    14b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b4:	8b 40 40             	mov    0x40(%eax),%eax
    14b7:	0f af d0             	imul   %eax,%edx
    14ba:	89 d0                	mov    %edx,%eax
    14bc:	01 c0                	add    %eax,%eax
    14be:	01 c2                	add    %eax,%edx
    14c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c3:	8b 40 54             	mov    0x54(%eax),%eax
    14c6:	83 ec 04             	sub    $0x4,%esp
    14c9:	52                   	push   %edx
    14ca:	68 ff ff ff 00       	push   $0xffffff
    14cf:	50                   	push   %eax
    14d0:	e8 59 ec ff ff       	call   12e <memset>
    14d5:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14db:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    14e2:	e8 62 ee ff ff       	call   349 <getpid>
    14e7:	89 c2                	mov    %eax,%edx
    14e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ec:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f2:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14fc:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1503:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1506:	8b 40 58             	mov    0x58(%eax),%eax
    1509:	89 c2                	mov    %eax,%edx
    150b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150e:	8b 40 5c             	mov    0x5c(%eax),%eax
    1511:	0f af d0             	imul   %eax,%edx
    1514:	89 d0                	mov    %edx,%eax
    1516:	01 c0                	add    %eax,%eax
    1518:	01 d0                	add    %edx,%eax
    151a:	83 ec 0c             	sub    $0xc,%esp
    151d:	50                   	push   %eax
    151e:	e8 28 f2 ff ff       	call   74b <malloc>
    1523:	83 c4 10             	add    $0x10,%esp
    1526:	89 c2                	mov    %eax,%edx
    1528:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152b:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    152e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1531:	8b 40 70             	mov    0x70(%eax),%eax
    1534:	85 c0                	test   %eax,%eax
    1536:	75 15                	jne    154d <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1538:	83 ec 04             	sub    $0x4,%esp
    153b:	ff 75 08             	pushl  0x8(%ebp)
    153e:	68 ac 22 00 00       	push   $0x22ac
    1543:	6a 01                	push   $0x1
    1545:	e8 2e ef ff ff       	call   478 <printf>
    154a:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    154d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1550:	8b 40 3c             	mov    0x3c(%eax),%eax
    1553:	89 c2                	mov    %eax,%edx
    1555:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1558:	8b 40 40             	mov    0x40(%eax),%eax
    155b:	0f af d0             	imul   %eax,%edx
    155e:	89 d0                	mov    %edx,%eax
    1560:	01 c0                	add    %eax,%eax
    1562:	01 c2                	add    %eax,%edx
    1564:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1567:	8b 40 54             	mov    0x54(%eax),%eax
    156a:	83 ec 04             	sub    $0x4,%esp
    156d:	52                   	push   %edx
    156e:	68 ff 00 00 00       	push   $0xff
    1573:	50                   	push   %eax
    1574:	e8 b5 eb ff ff       	call   12e <memset>
    1579:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    157c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1582:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1585:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1589:	74 49                	je     15d4 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    158b:	8b 45 10             	mov    0x10(%ebp),%eax
    158e:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1594:	83 ec 0c             	sub    $0xc,%esp
    1597:	50                   	push   %eax
    1598:	e8 ae f1 ff ff       	call   74b <malloc>
    159d:	83 c4 10             	add    $0x10,%esp
    15a0:	89 c2                	mov    %eax,%edx
    15a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a5:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    15a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ab:	8b 55 10             	mov    0x10(%ebp),%edx
    15ae:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    15b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b4:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    15bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15be:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    15c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c8:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    15cf:	e9 8d 00 00 00       	jmp    1661 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d7:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e1:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15eb:	8b 40 20             	mov    0x20(%eax),%eax
    15ee:	89 c2                	mov    %eax,%edx
    15f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f3:	8b 40 24             	mov    0x24(%eax),%eax
    15f6:	0f af d0             	imul   %eax,%edx
    15f9:	89 d0                	mov    %edx,%eax
    15fb:	01 c0                	add    %eax,%eax
    15fd:	01 d0                	add    %edx,%eax
    15ff:	83 ec 0c             	sub    $0xc,%esp
    1602:	50                   	push   %eax
    1603:	e8 43 f1 ff ff       	call   74b <malloc>
    1608:	83 c4 10             	add    $0x10,%esp
    160b:	89 c2                	mov    %eax,%edx
    160d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1610:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1613:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1616:	8b 40 38             	mov    0x38(%eax),%eax
    1619:	85 c0                	test   %eax,%eax
    161b:	75 15                	jne    1632 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    161d:	83 ec 04             	sub    $0x4,%esp
    1620:	ff 75 08             	pushl  0x8(%ebp)
    1623:	68 d4 22 00 00       	push   $0x22d4
    1628:	6a 01                	push   $0x1
    162a:	e8 49 ee ff ff       	call   478 <printf>
    162f:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1632:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1635:	8b 40 20             	mov    0x20(%eax),%eax
    1638:	89 c2                	mov    %eax,%edx
    163a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163d:	8b 40 24             	mov    0x24(%eax),%eax
    1640:	0f af d0             	imul   %eax,%edx
    1643:	89 d0                	mov    %edx,%eax
    1645:	01 c0                	add    %eax,%eax
    1647:	01 c2                	add    %eax,%edx
    1649:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164c:	8b 40 38             	mov    0x38(%eax),%eax
    164f:	83 ec 04             	sub    $0x4,%esp
    1652:	52                   	push   %edx
    1653:	68 ff ff ff 00       	push   $0xffffff
    1658:	50                   	push   %eax
    1659:	e8 d0 ea ff ff       	call   12e <memset>
    165e:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1661:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1664:	c9                   	leave  
    1665:	c3                   	ret    

00001666 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1666:	55                   	push   %ebp
    1667:	89 e5                	mov    %esp,%ebp
    1669:	57                   	push   %edi
    166a:	56                   	push   %esi
    166b:	53                   	push   %ebx
    166c:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    166f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1672:	83 f8 03             	cmp    $0x3,%eax
    1675:	74 02                	je     1679 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1677:	eb 7c                	jmp    16f5 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1679:	8b 45 08             	mov    0x8(%ebp),%eax
    167c:	8b 58 1c             	mov    0x1c(%eax),%ebx
    167f:	8b 45 08             	mov    0x8(%ebp),%eax
    1682:	8b 48 18             	mov    0x18(%eax),%ecx
    1685:	8b 45 08             	mov    0x8(%ebp),%eax
    1688:	8b 50 5c             	mov    0x5c(%eax),%edx
    168b:	8b 45 08             	mov    0x8(%ebp),%eax
    168e:	8b 40 58             	mov    0x58(%eax),%eax
    1691:	8b 75 08             	mov    0x8(%ebp),%esi
    1694:	83 c6 58             	add    $0x58,%esi
    1697:	83 ec 04             	sub    $0x4,%esp
    169a:	53                   	push   %ebx
    169b:	51                   	push   %ecx
    169c:	6a 00                	push   $0x0
    169e:	52                   	push   %edx
    169f:	50                   	push   %eax
    16a0:	6a 00                	push   $0x0
    16a2:	6a 00                	push   $0x0
    16a4:	56                   	push   %esi
    16a5:	6a 00                	push   $0x0
    16a7:	6a 00                	push   $0x0
    16a9:	ff 75 08             	pushl  0x8(%ebp)
    16ac:	e8 b8 ec ff ff       	call   369 <paintWindow>
    16b1:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    16b4:	8b 45 08             	mov    0x8(%ebp),%eax
    16b7:	8b 70 1c             	mov    0x1c(%eax),%esi
    16ba:	8b 45 08             	mov    0x8(%ebp),%eax
    16bd:	8b 58 18             	mov    0x18(%eax),%ebx
    16c0:	8b 45 08             	mov    0x8(%ebp),%eax
    16c3:	8b 48 08             	mov    0x8(%eax),%ecx
    16c6:	8b 45 08             	mov    0x8(%ebp),%eax
    16c9:	8b 50 40             	mov    0x40(%eax),%edx
    16cc:	8b 45 08             	mov    0x8(%ebp),%eax
    16cf:	8b 40 3c             	mov    0x3c(%eax),%eax
    16d2:	8b 7d 08             	mov    0x8(%ebp),%edi
    16d5:	83 c7 3c             	add    $0x3c,%edi
    16d8:	83 ec 04             	sub    $0x4,%esp
    16db:	56                   	push   %esi
    16dc:	53                   	push   %ebx
    16dd:	51                   	push   %ecx
    16de:	52                   	push   %edx
    16df:	50                   	push   %eax
    16e0:	6a 00                	push   $0x0
    16e2:	6a 00                	push   $0x0
    16e4:	57                   	push   %edi
    16e5:	6a 32                	push   $0x32
    16e7:	6a 00                	push   $0x0
    16e9:	ff 75 08             	pushl  0x8(%ebp)
    16ec:	e8 78 ec ff ff       	call   369 <paintWindow>
    16f1:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    16f4:	90                   	nop
        default: break;
            
            
    }
    return False;
    16f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    16fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16fd:	5b                   	pop    %ebx
    16fe:	5e                   	pop    %esi
    16ff:	5f                   	pop    %edi
    1700:	5d                   	pop    %ebp
    1701:	c3                   	ret    

00001702 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1702:	55                   	push   %ebp
    1703:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1705:	8b 45 0c             	mov    0xc(%ebp),%eax
    1708:	8b 50 08             	mov    0x8(%eax),%edx
    170b:	8b 45 08             	mov    0x8(%ebp),%eax
    170e:	8b 00                	mov    (%eax),%eax
    1710:	39 c2                	cmp    %eax,%edx
    1712:	74 07                	je     171b <APPreJudge+0x19>
        return False;
    1714:	b8 00 00 00 00       	mov    $0x0,%eax
    1719:	eb 05                	jmp    1720 <APPreJudge+0x1e>
    return True;
    171b:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1720:	5d                   	pop    %ebp
    1721:	c3                   	ret    

00001722 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1722:	55                   	push   %ebp
    1723:	89 e5                	mov    %esp,%ebp
    1725:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1728:	8b 45 08             	mov    0x8(%ebp),%eax
    172b:	8b 55 0c             	mov    0xc(%ebp),%edx
    172e:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1734:	83 ec 0c             	sub    $0xc,%esp
    1737:	ff 75 08             	pushl  0x8(%ebp)
    173a:	e8 42 ec ff ff       	call   381 <registWindow>
    173f:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1742:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1749:	8b 45 08             	mov    0x8(%ebp),%eax
    174c:	8b 00                	mov    (%eax),%eax
    174e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1751:	ff 75 f4             	pushl  -0xc(%ebp)
    1754:	ff 75 f0             	pushl  -0x10(%ebp)
    1757:	ff 75 ec             	pushl  -0x14(%ebp)
    175a:	ff 75 08             	pushl  0x8(%ebp)
    175d:	e8 80 fc ff ff       	call   13e2 <APSendMessage>
    1762:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1765:	83 ec 0c             	sub    $0xc,%esp
    1768:	ff 75 08             	pushl  0x8(%ebp)
    176b:	e8 09 ec ff ff       	call   379 <getMessage>
    1770:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1773:	8b 45 08             	mov    0x8(%ebp),%eax
    1776:	83 c0 74             	add    $0x74,%eax
    1779:	83 ec 08             	sub    $0x8,%esp
    177c:	50                   	push   %eax
    177d:	ff 75 08             	pushl  0x8(%ebp)
    1780:	e8 7d ff ff ff       	call   1702 <APPreJudge>
    1785:	83 c4 10             	add    $0x10,%esp
    1788:	84 c0                	test   %al,%al
    178a:	74 1b                	je     17a7 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    178c:	8b 45 08             	mov    0x8(%ebp),%eax
    178f:	ff 70 7c             	pushl  0x7c(%eax)
    1792:	ff 70 78             	pushl  0x78(%eax)
    1795:	ff 70 74             	pushl  0x74(%eax)
    1798:	ff 75 08             	pushl  0x8(%ebp)
    179b:	8b 45 0c             	mov    0xc(%ebp),%eax
    179e:	ff d0                	call   *%eax
    17a0:	83 c4 10             	add    $0x10,%esp
    17a3:	84 c0                	test   %al,%al
    17a5:	75 0c                	jne    17b3 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    17a7:	8b 45 08             	mov    0x8(%ebp),%eax
    17aa:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    17b1:	eb b2                	jmp    1765 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    17b3:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    17b4:	90                   	nop
    17b5:	c9                   	leave  
    17b6:	c3                   	ret    

000017b7 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    17b7:	55                   	push   %ebp
    17b8:	89 e5                	mov    %esp,%ebp
    17ba:	57                   	push   %edi
    17bb:	56                   	push   %esi
    17bc:	53                   	push   %ebx
    17bd:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    17c0:	a1 5c 29 00 00       	mov    0x295c,%eax
    17c5:	85 c0                	test   %eax,%eax
    17c7:	0f 85 2c 02 00 00    	jne    19f9 <APGridPaint+0x242>
    {
        iconReady = 1;
    17cd:	c7 05 5c 29 00 00 01 	movl   $0x1,0x295c
    17d4:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    17d7:	8d 45 98             	lea    -0x68(%ebp),%eax
    17da:	83 ec 08             	sub    $0x8,%esp
    17dd:	68 fb 22 00 00       	push   $0x22fb
    17e2:	50                   	push   %eax
    17e3:	e8 16 f1 ff ff       	call   8fe <APLoadBitmap>
    17e8:	83 c4 0c             	add    $0xc,%esp
    17eb:	8b 45 98             	mov    -0x68(%ebp),%eax
    17ee:	a3 80 29 00 00       	mov    %eax,0x2980
    17f3:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17f6:	a3 84 29 00 00       	mov    %eax,0x2984
    17fb:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17fe:	a3 88 29 00 00       	mov    %eax,0x2988
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1803:	83 ec 04             	sub    $0x4,%esp
    1806:	ff 35 88 29 00 00    	pushl  0x2988
    180c:	ff 35 84 29 00 00    	pushl  0x2984
    1812:	ff 35 80 29 00 00    	pushl  0x2980
    1818:	e8 1b f3 ff ff       	call   b38 <APCreateCompatibleDCFromBitmap>
    181d:	83 c4 10             	add    $0x10,%esp
    1820:	a3 8c 29 00 00       	mov    %eax,0x298c
        grid_river = APLoadBitmap ("grid_river.bmp");
    1825:	8d 45 98             	lea    -0x68(%ebp),%eax
    1828:	83 ec 08             	sub    $0x8,%esp
    182b:	68 09 23 00 00       	push   $0x2309
    1830:	50                   	push   %eax
    1831:	e8 c8 f0 ff ff       	call   8fe <APLoadBitmap>
    1836:	83 c4 0c             	add    $0xc,%esp
    1839:	8b 45 98             	mov    -0x68(%ebp),%eax
    183c:	a3 bc 29 00 00       	mov    %eax,0x29bc
    1841:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1844:	a3 c0 29 00 00       	mov    %eax,0x29c0
    1849:	8b 45 a0             	mov    -0x60(%ebp),%eax
    184c:	a3 c4 29 00 00       	mov    %eax,0x29c4
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1851:	83 ec 04             	sub    $0x4,%esp
    1854:	ff 35 c4 29 00 00    	pushl  0x29c4
    185a:	ff 35 c0 29 00 00    	pushl  0x29c0
    1860:	ff 35 bc 29 00 00    	pushl  0x29bc
    1866:	e8 cd f2 ff ff       	call   b38 <APCreateCompatibleDCFromBitmap>
    186b:	83 c4 10             	add    $0x10,%esp
    186e:	a3 ac 29 00 00       	mov    %eax,0x29ac
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1873:	8d 45 98             	lea    -0x68(%ebp),%eax
    1876:	83 ec 08             	sub    $0x8,%esp
    1879:	68 18 23 00 00       	push   $0x2318
    187e:	50                   	push   %eax
    187f:	e8 7a f0 ff ff       	call   8fe <APLoadBitmap>
    1884:	83 c4 0c             	add    $0xc,%esp
    1887:	8b 45 98             	mov    -0x68(%ebp),%eax
    188a:	a3 b0 29 00 00       	mov    %eax,0x29b0
    188f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1892:	a3 b4 29 00 00       	mov    %eax,0x29b4
    1897:	8b 45 a0             	mov    -0x60(%ebp),%eax
    189a:	a3 b8 29 00 00       	mov    %eax,0x29b8
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    189f:	83 ec 04             	sub    $0x4,%esp
    18a2:	ff 35 b8 29 00 00    	pushl  0x29b8
    18a8:	ff 35 b4 29 00 00    	pushl  0x29b4
    18ae:	ff 35 b0 29 00 00    	pushl  0x29b0
    18b4:	e8 7f f2 ff ff       	call   b38 <APCreateCompatibleDCFromBitmap>
    18b9:	83 c4 10             	add    $0x10,%esp
    18bc:	a3 60 29 00 00       	mov    %eax,0x2960
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    18c1:	8d 45 98             	lea    -0x68(%ebp),%eax
    18c4:	83 ec 08             	sub    $0x8,%esp
    18c7:	68 27 23 00 00       	push   $0x2327
    18cc:	50                   	push   %eax
    18cd:	e8 2c f0 ff ff       	call   8fe <APLoadBitmap>
    18d2:	83 c4 0c             	add    $0xc,%esp
    18d5:	8b 45 98             	mov    -0x68(%ebp),%eax
    18d8:	a3 94 29 00 00       	mov    %eax,0x2994
    18dd:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18e0:	a3 98 29 00 00       	mov    %eax,0x2998
    18e5:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18e8:	a3 9c 29 00 00       	mov    %eax,0x299c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    18ed:	83 ec 04             	sub    $0x4,%esp
    18f0:	ff 35 9c 29 00 00    	pushl  0x299c
    18f6:	ff 35 98 29 00 00    	pushl  0x2998
    18fc:	ff 35 94 29 00 00    	pushl  0x2994
    1902:	e8 31 f2 ff ff       	call   b38 <APCreateCompatibleDCFromBitmap>
    1907:	83 c4 10             	add    $0x10,%esp
    190a:	a3 c8 29 00 00       	mov    %eax,0x29c8
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    190f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1912:	83 ec 08             	sub    $0x8,%esp
    1915:	68 35 23 00 00       	push   $0x2335
    191a:	50                   	push   %eax
    191b:	e8 de ef ff ff       	call   8fe <APLoadBitmap>
    1920:	83 c4 0c             	add    $0xc,%esp
    1923:	8b 45 98             	mov    -0x68(%ebp),%eax
    1926:	a3 70 29 00 00       	mov    %eax,0x2970
    192b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    192e:	a3 74 29 00 00       	mov    %eax,0x2974
    1933:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1936:	a3 78 29 00 00       	mov    %eax,0x2978
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    193b:	83 ec 04             	sub    $0x4,%esp
    193e:	ff 35 78 29 00 00    	pushl  0x2978
    1944:	ff 35 74 29 00 00    	pushl  0x2974
    194a:	ff 35 70 29 00 00    	pushl  0x2970
    1950:	e8 e3 f1 ff ff       	call   b38 <APCreateCompatibleDCFromBitmap>
    1955:	83 c4 10             	add    $0x10,%esp
    1958:	a3 90 29 00 00       	mov    %eax,0x2990
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    195d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1960:	83 ec 08             	sub    $0x8,%esp
    1963:	68 45 23 00 00       	push   $0x2345
    1968:	50                   	push   %eax
    1969:	e8 90 ef ff ff       	call   8fe <APLoadBitmap>
    196e:	83 c4 0c             	add    $0xc,%esp
    1971:	8b 45 98             	mov    -0x68(%ebp),%eax
    1974:	a3 64 29 00 00       	mov    %eax,0x2964
    1979:	8b 45 9c             	mov    -0x64(%ebp),%eax
    197c:	a3 68 29 00 00       	mov    %eax,0x2968
    1981:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1984:	a3 6c 29 00 00       	mov    %eax,0x296c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1989:	83 ec 04             	sub    $0x4,%esp
    198c:	ff 35 6c 29 00 00    	pushl  0x296c
    1992:	ff 35 68 29 00 00    	pushl  0x2968
    1998:	ff 35 64 29 00 00    	pushl  0x2964
    199e:	e8 95 f1 ff ff       	call   b38 <APCreateCompatibleDCFromBitmap>
    19a3:	83 c4 10             	add    $0x10,%esp
    19a6:	a3 7c 29 00 00       	mov    %eax,0x297c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    19ab:	8d 45 98             	lea    -0x68(%ebp),%eax
    19ae:	83 ec 08             	sub    $0x8,%esp
    19b1:	68 57 23 00 00       	push   $0x2357
    19b6:	50                   	push   %eax
    19b7:	e8 42 ef ff ff       	call   8fe <APLoadBitmap>
    19bc:	83 c4 0c             	add    $0xc,%esp
    19bf:	8b 45 98             	mov    -0x68(%ebp),%eax
    19c2:	a3 a0 29 00 00       	mov    %eax,0x29a0
    19c7:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19ca:	a3 a4 29 00 00       	mov    %eax,0x29a4
    19cf:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19d2:	a3 a8 29 00 00       	mov    %eax,0x29a8
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    19d7:	83 ec 04             	sub    $0x4,%esp
    19da:	ff 35 a8 29 00 00    	pushl  0x29a8
    19e0:	ff 35 a4 29 00 00    	pushl  0x29a4
    19e6:	ff 35 a0 29 00 00    	pushl  0x29a0
    19ec:	e8 47 f1 ff ff       	call   b38 <APCreateCompatibleDCFromBitmap>
    19f1:	83 c4 10             	add    $0x10,%esp
    19f4:	a3 cc 29 00 00       	mov    %eax,0x29cc
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    19f9:	8b 45 08             	mov    0x8(%ebp),%eax
    19fc:	8b 40 08             	mov    0x8(%eax),%eax
    19ff:	85 c0                	test   %eax,%eax
    1a01:	75 17                	jne    1a1a <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1a03:	83 ec 08             	sub    $0x8,%esp
    1a06:	68 68 23 00 00       	push   $0x2368
    1a0b:	6a 01                	push   $0x1
    1a0d:	e8 66 ea ff ff       	call   478 <printf>
    1a12:	83 c4 10             	add    $0x10,%esp
        return;
    1a15:	e9 a0 04 00 00       	jmp    1eba <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1a1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1d:	8b 40 10             	mov    0x10(%eax),%eax
    1a20:	85 c0                	test   %eax,%eax
    1a22:	7e 10                	jle    1a34 <APGridPaint+0x27d>
    1a24:	8b 45 08             	mov    0x8(%ebp),%eax
    1a27:	8b 50 14             	mov    0x14(%eax),%edx
    1a2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2d:	8b 40 10             	mov    0x10(%eax),%eax
    1a30:	39 c2                	cmp    %eax,%edx
    1a32:	7c 17                	jl     1a4b <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1a34:	83 ec 08             	sub    $0x8,%esp
    1a37:	68 8e 23 00 00       	push   $0x238e
    1a3c:	6a 01                	push   $0x1
    1a3e:	e8 35 ea ff ff       	call   478 <printf>
    1a43:	83 c4 10             	add    $0x10,%esp
        return;
    1a46:	e9 6f 04 00 00       	jmp    1eba <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1a4b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4e:	8b 40 14             	mov    0x14(%eax),%eax
    1a51:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a57:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a5a:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a5d:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a60:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a67:	e9 96 03 00 00       	jmp    1e02 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a6c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a73:	e9 7c 03 00 00       	jmp    1df4 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a78:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a7b:	c1 e0 04             	shl    $0x4,%eax
    1a7e:	89 c2                	mov    %eax,%edx
    1a80:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a83:	01 c2                	add    %eax,%edx
    1a85:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a88:	01 d0                	add    %edx,%eax
    1a8a:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a90:	8b 40 0c             	mov    0xc(%eax),%eax
    1a93:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a96:	c1 e2 02             	shl    $0x2,%edx
    1a99:	01 d0                	add    %edx,%eax
    1a9b:	8b 00                	mov    (%eax),%eax
    1a9d:	83 f8 07             	cmp    $0x7,%eax
    1aa0:	0f 87 49 03 00 00    	ja     1def <APGridPaint+0x638>
    1aa6:	8b 04 85 a4 23 00 00 	mov    0x23a4(,%eax,4),%eax
    1aad:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1aaf:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1ab2:	6a 0c                	push   $0xc
    1ab4:	6a 0c                	push   $0xc
    1ab6:	6a 0c                	push   $0xc
    1ab8:	50                   	push   %eax
    1ab9:	e8 df f8 ff ff       	call   139d <RGB>
    1abe:	83 c4 0c             	add    $0xc,%esp
    1ac1:	8b 1d 8c 29 00 00    	mov    0x298c,%ebx
    1ac7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1aca:	6b c8 32             	imul   $0x32,%eax,%ecx
    1acd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ad0:	6b c0 32             	imul   $0x32,%eax,%eax
    1ad3:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ad6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad9:	8d 78 3c             	lea    0x3c(%eax),%edi
    1adc:	83 ec 0c             	sub    $0xc,%esp
    1adf:	83 ec 04             	sub    $0x4,%esp
    1ae2:	89 e0                	mov    %esp,%eax
    1ae4:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1ae8:	66 89 30             	mov    %si,(%eax)
    1aeb:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1aef:	88 50 02             	mov    %dl,0x2(%eax)
    1af2:	6a 32                	push   $0x32
    1af4:	6a 32                	push   $0x32
    1af6:	6a 00                	push   $0x0
    1af8:	6a 00                	push   $0x0
    1afa:	53                   	push   %ebx
    1afb:	51                   	push   %ecx
    1afc:	ff 75 94             	pushl  -0x6c(%ebp)
    1aff:	57                   	push   %edi
    1b00:	e8 f4 f6 ff ff       	call   11f9 <APDcCopy>
    1b05:	83 c4 30             	add    $0x30,%esp
                    break;
    1b08:	e9 e3 02 00 00       	jmp    1df0 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1b0d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b10:	6a 69                	push   $0x69
    1b12:	6a 69                	push   $0x69
    1b14:	6a 69                	push   $0x69
    1b16:	50                   	push   %eax
    1b17:	e8 81 f8 ff ff       	call   139d <RGB>
    1b1c:	83 c4 0c             	add    $0xc,%esp
    1b1f:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b23:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1b27:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b2b:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1b2e:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1b35:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b38:	6a 69                	push   $0x69
    1b3a:	6a 69                	push   $0x69
    1b3c:	6a 69                	push   $0x69
    1b3e:	50                   	push   %eax
    1b3f:	e8 59 f8 ff ff       	call   139d <RGB>
    1b44:	83 c4 0c             	add    $0xc,%esp
    1b47:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b4b:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1b4f:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b53:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b56:	8b 45 08             	mov    0x8(%ebp),%eax
    1b59:	8d 50 3c             	lea    0x3c(%eax),%edx
    1b5c:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b5f:	ff 75 b0             	pushl  -0x50(%ebp)
    1b62:	ff 75 ac             	pushl  -0x54(%ebp)
    1b65:	52                   	push   %edx
    1b66:	50                   	push   %eax
    1b67:	e8 61 f0 ff ff       	call   bcd <APSetPen>
    1b6c:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b72:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1b75:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b78:	83 ec 04             	sub    $0x4,%esp
    1b7b:	83 ec 04             	sub    $0x4,%esp
    1b7e:	89 e0                	mov    %esp,%eax
    1b80:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1b84:	66 89 08             	mov    %cx,(%eax)
    1b87:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1b8b:	88 48 02             	mov    %cl,0x2(%eax)
    1b8e:	53                   	push   %ebx
    1b8f:	52                   	push   %edx
    1b90:	e8 71 f0 ff ff       	call   c06 <APSetBrush>
    1b95:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b98:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b9b:	6b d0 32             	imul   $0x32,%eax,%edx
    1b9e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ba1:	6b c0 32             	imul   $0x32,%eax,%eax
    1ba4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1ba7:	83 c1 3c             	add    $0x3c,%ecx
    1baa:	83 ec 0c             	sub    $0xc,%esp
    1bad:	6a 32                	push   $0x32
    1baf:	6a 32                	push   $0x32
    1bb1:	52                   	push   %edx
    1bb2:	50                   	push   %eax
    1bb3:	51                   	push   %ecx
    1bb4:	e8 35 f4 ff ff       	call   fee <APDrawRect>
    1bb9:	83 c4 20             	add    $0x20,%esp
                    break;
    1bbc:	e9 2f 02 00 00       	jmp    1df0 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bc1:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1bc4:	6a 0c                	push   $0xc
    1bc6:	6a 0c                	push   $0xc
    1bc8:	6a 0c                	push   $0xc
    1bca:	50                   	push   %eax
    1bcb:	e8 cd f7 ff ff       	call   139d <RGB>
    1bd0:	83 c4 0c             	add    $0xc,%esp
    1bd3:	8b 1d cc 29 00 00    	mov    0x29cc,%ebx
    1bd9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bdc:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bdf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1be2:	6b c0 32             	imul   $0x32,%eax,%eax
    1be5:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1be8:	8b 45 08             	mov    0x8(%ebp),%eax
    1beb:	8d 78 3c             	lea    0x3c(%eax),%edi
    1bee:	83 ec 0c             	sub    $0xc,%esp
    1bf1:	83 ec 04             	sub    $0x4,%esp
    1bf4:	89 e0                	mov    %esp,%eax
    1bf6:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1bfa:	66 89 30             	mov    %si,(%eax)
    1bfd:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1c01:	88 50 02             	mov    %dl,0x2(%eax)
    1c04:	6a 32                	push   $0x32
    1c06:	6a 32                	push   $0x32
    1c08:	6a 00                	push   $0x0
    1c0a:	6a 00                	push   $0x0
    1c0c:	53                   	push   %ebx
    1c0d:	51                   	push   %ecx
    1c0e:	ff 75 94             	pushl  -0x6c(%ebp)
    1c11:	57                   	push   %edi
    1c12:	e8 e2 f5 ff ff       	call   11f9 <APDcCopy>
    1c17:	83 c4 30             	add    $0x30,%esp
                    break;
    1c1a:	e9 d1 01 00 00       	jmp    1df0 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c1f:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1c22:	6a 0c                	push   $0xc
    1c24:	6a 0c                	push   $0xc
    1c26:	6a 0c                	push   $0xc
    1c28:	50                   	push   %eax
    1c29:	e8 6f f7 ff ff       	call   139d <RGB>
    1c2e:	83 c4 0c             	add    $0xc,%esp
    1c31:	8b 1d ac 29 00 00    	mov    0x29ac,%ebx
    1c37:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c3a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c3d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c40:	6b c0 32             	imul   $0x32,%eax,%eax
    1c43:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c46:	8b 45 08             	mov    0x8(%ebp),%eax
    1c49:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c4c:	83 ec 0c             	sub    $0xc,%esp
    1c4f:	83 ec 04             	sub    $0x4,%esp
    1c52:	89 e0                	mov    %esp,%eax
    1c54:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1c58:	66 89 30             	mov    %si,(%eax)
    1c5b:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c5f:	88 50 02             	mov    %dl,0x2(%eax)
    1c62:	6a 32                	push   $0x32
    1c64:	6a 32                	push   $0x32
    1c66:	6a 00                	push   $0x0
    1c68:	6a 00                	push   $0x0
    1c6a:	53                   	push   %ebx
    1c6b:	51                   	push   %ecx
    1c6c:	ff 75 94             	pushl  -0x6c(%ebp)
    1c6f:	57                   	push   %edi
    1c70:	e8 84 f5 ff ff       	call   11f9 <APDcCopy>
    1c75:	83 c4 30             	add    $0x30,%esp
                    break;
    1c78:	e9 73 01 00 00       	jmp    1df0 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c7d:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c80:	6a 0c                	push   $0xc
    1c82:	6a 0c                	push   $0xc
    1c84:	6a 0c                	push   $0xc
    1c86:	50                   	push   %eax
    1c87:	e8 11 f7 ff ff       	call   139d <RGB>
    1c8c:	83 c4 0c             	add    $0xc,%esp
    1c8f:	8b 1d 90 29 00 00    	mov    0x2990,%ebx
    1c95:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c98:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c9b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c9e:	6b c0 32             	imul   $0x32,%eax,%eax
    1ca1:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ca4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca7:	8d 78 3c             	lea    0x3c(%eax),%edi
    1caa:	83 ec 0c             	sub    $0xc,%esp
    1cad:	83 ec 04             	sub    $0x4,%esp
    1cb0:	89 e0                	mov    %esp,%eax
    1cb2:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1cb6:	66 89 30             	mov    %si,(%eax)
    1cb9:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1cbd:	88 50 02             	mov    %dl,0x2(%eax)
    1cc0:	6a 32                	push   $0x32
    1cc2:	6a 32                	push   $0x32
    1cc4:	6a 00                	push   $0x0
    1cc6:	6a 00                	push   $0x0
    1cc8:	53                   	push   %ebx
    1cc9:	51                   	push   %ecx
    1cca:	ff 75 94             	pushl  -0x6c(%ebp)
    1ccd:	57                   	push   %edi
    1cce:	e8 26 f5 ff ff       	call   11f9 <APDcCopy>
    1cd3:	83 c4 30             	add    $0x30,%esp
                    break;
    1cd6:	e9 15 01 00 00       	jmp    1df0 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cdb:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1cde:	6a 0c                	push   $0xc
    1ce0:	6a 0c                	push   $0xc
    1ce2:	6a 0c                	push   $0xc
    1ce4:	50                   	push   %eax
    1ce5:	e8 b3 f6 ff ff       	call   139d <RGB>
    1cea:	83 c4 0c             	add    $0xc,%esp
    1ced:	8b 1d c8 29 00 00    	mov    0x29c8,%ebx
    1cf3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cf6:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cf9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cfc:	6b c0 32             	imul   $0x32,%eax,%eax
    1cff:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d02:	8b 45 08             	mov    0x8(%ebp),%eax
    1d05:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d08:	83 ec 0c             	sub    $0xc,%esp
    1d0b:	83 ec 04             	sub    $0x4,%esp
    1d0e:	89 e0                	mov    %esp,%eax
    1d10:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1d14:	66 89 30             	mov    %si,(%eax)
    1d17:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1d1b:	88 50 02             	mov    %dl,0x2(%eax)
    1d1e:	6a 32                	push   $0x32
    1d20:	6a 32                	push   $0x32
    1d22:	6a 00                	push   $0x0
    1d24:	6a 00                	push   $0x0
    1d26:	53                   	push   %ebx
    1d27:	51                   	push   %ecx
    1d28:	ff 75 94             	pushl  -0x6c(%ebp)
    1d2b:	57                   	push   %edi
    1d2c:	e8 c8 f4 ff ff       	call   11f9 <APDcCopy>
    1d31:	83 c4 30             	add    $0x30,%esp
                    break;
    1d34:	e9 b7 00 00 00       	jmp    1df0 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d39:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1d3c:	6a 0c                	push   $0xc
    1d3e:	6a 0c                	push   $0xc
    1d40:	6a 0c                	push   $0xc
    1d42:	50                   	push   %eax
    1d43:	e8 55 f6 ff ff       	call   139d <RGB>
    1d48:	83 c4 0c             	add    $0xc,%esp
    1d4b:	8b 1d 60 29 00 00    	mov    0x2960,%ebx
    1d51:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d54:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d57:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d5a:	6b c0 32             	imul   $0x32,%eax,%eax
    1d5d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d60:	8b 45 08             	mov    0x8(%ebp),%eax
    1d63:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d66:	83 ec 0c             	sub    $0xc,%esp
    1d69:	83 ec 04             	sub    $0x4,%esp
    1d6c:	89 e0                	mov    %esp,%eax
    1d6e:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d72:	66 89 30             	mov    %si,(%eax)
    1d75:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d79:	88 50 02             	mov    %dl,0x2(%eax)
    1d7c:	6a 32                	push   $0x32
    1d7e:	6a 32                	push   $0x32
    1d80:	6a 00                	push   $0x0
    1d82:	6a 00                	push   $0x0
    1d84:	53                   	push   %ebx
    1d85:	51                   	push   %ecx
    1d86:	ff 75 94             	pushl  -0x6c(%ebp)
    1d89:	57                   	push   %edi
    1d8a:	e8 6a f4 ff ff       	call   11f9 <APDcCopy>
    1d8f:	83 c4 30             	add    $0x30,%esp
                    break;
    1d92:	eb 5c                	jmp    1df0 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d94:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d97:	6a 0c                	push   $0xc
    1d99:	6a 0c                	push   $0xc
    1d9b:	6a 0c                	push   $0xc
    1d9d:	50                   	push   %eax
    1d9e:	e8 fa f5 ff ff       	call   139d <RGB>
    1da3:	83 c4 0c             	add    $0xc,%esp
    1da6:	8b 1d 7c 29 00 00    	mov    0x297c,%ebx
    1dac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1daf:	6b c8 32             	imul   $0x32,%eax,%ecx
    1db2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1db5:	6b c0 32             	imul   $0x32,%eax,%eax
    1db8:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dbb:	8b 45 08             	mov    0x8(%ebp),%eax
    1dbe:	8d 78 3c             	lea    0x3c(%eax),%edi
    1dc1:	83 ec 0c             	sub    $0xc,%esp
    1dc4:	83 ec 04             	sub    $0x4,%esp
    1dc7:	89 e0                	mov    %esp,%eax
    1dc9:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1dcd:	66 89 30             	mov    %si,(%eax)
    1dd0:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1dd4:	88 50 02             	mov    %dl,0x2(%eax)
    1dd7:	6a 32                	push   $0x32
    1dd9:	6a 32                	push   $0x32
    1ddb:	6a 00                	push   $0x0
    1ddd:	6a 00                	push   $0x0
    1ddf:	53                   	push   %ebx
    1de0:	51                   	push   %ecx
    1de1:	ff 75 94             	pushl  -0x6c(%ebp)
    1de4:	57                   	push   %edi
    1de5:	e8 0f f4 ff ff       	call   11f9 <APDcCopy>
    1dea:	83 c4 30             	add    $0x30,%esp
                    break;
    1ded:	eb 01                	jmp    1df0 <APGridPaint+0x639>
                default: break;
    1def:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1df0:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1df4:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1df8:	0f 8e 7a fc ff ff    	jle    1a78 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1dfe:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e02:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1e06:	0f 8e 60 fc ff ff    	jle    1a6c <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1e0c:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e0f:	68 cd 00 00 00       	push   $0xcd
    1e14:	6a 74                	push   $0x74
    1e16:	6a 18                	push   $0x18
    1e18:	50                   	push   %eax
    1e19:	e8 7f f5 ff ff       	call   139d <RGB>
    1e1e:	83 c4 0c             	add    $0xc,%esp
    1e21:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e25:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1e29:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e2d:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1e30:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1e37:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e3a:	68 cd 00 00 00       	push   $0xcd
    1e3f:	6a 74                	push   $0x74
    1e41:	6a 18                	push   $0x18
    1e43:	50                   	push   %eax
    1e44:	e8 54 f5 ff ff       	call   139d <RGB>
    1e49:	83 c4 0c             	add    $0xc,%esp
    1e4c:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e50:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1e54:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e58:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1e5b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e5e:	8d 50 58             	lea    0x58(%eax),%edx
    1e61:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e64:	ff 75 bc             	pushl  -0x44(%ebp)
    1e67:	ff 75 b8             	pushl  -0x48(%ebp)
    1e6a:	52                   	push   %edx
    1e6b:	50                   	push   %eax
    1e6c:	e8 5c ed ff ff       	call   bcd <APSetPen>
    1e71:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1e74:	8b 45 08             	mov    0x8(%ebp),%eax
    1e77:	8d 58 58             	lea    0x58(%eax),%ebx
    1e7a:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e7d:	83 ec 04             	sub    $0x4,%esp
    1e80:	83 ec 04             	sub    $0x4,%esp
    1e83:	89 e0                	mov    %esp,%eax
    1e85:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1e89:	66 89 08             	mov    %cx,(%eax)
    1e8c:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1e90:	88 48 02             	mov    %cl,0x2(%eax)
    1e93:	53                   	push   %ebx
    1e94:	52                   	push   %edx
    1e95:	e8 6c ed ff ff       	call   c06 <APSetBrush>
    1e9a:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1e9d:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea0:	83 c0 58             	add    $0x58,%eax
    1ea3:	83 ec 0c             	sub    $0xc,%esp
    1ea6:	6a 32                	push   $0x32
    1ea8:	68 20 03 00 00       	push   $0x320
    1ead:	6a 00                	push   $0x0
    1eaf:	6a 00                	push   $0x0
    1eb1:	50                   	push   %eax
    1eb2:	e8 37 f1 ff ff       	call   fee <APDrawRect>
    1eb7:	83 c4 20             	add    $0x20,%esp
}
    1eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1ebd:	5b                   	pop    %ebx
    1ebe:	5e                   	pop    %esi
    1ebf:	5f                   	pop    %edi
    1ec0:	5d                   	pop    %ebp
    1ec1:	c3                   	ret    

00001ec2 <random>:
//

#include "APLib.h"

int random(int seed)
{
    1ec2:	55                   	push   %ebp
    1ec3:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1ec5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1ec9:	7e 08                	jle    1ed3 <random+0x11>
{
rand_num = seed;
    1ecb:	8b 45 08             	mov    0x8(%ebp),%eax
    1ece:	a3 38 29 00 00       	mov    %eax,0x2938
}
rand_num *= 3;
    1ed3:	8b 15 38 29 00 00    	mov    0x2938,%edx
    1ed9:	89 d0                	mov    %edx,%eax
    1edb:	01 c0                	add    %eax,%eax
    1edd:	01 d0                	add    %edx,%eax
    1edf:	a3 38 29 00 00       	mov    %eax,0x2938
if (rand_num < 0)
    1ee4:	a1 38 29 00 00       	mov    0x2938,%eax
    1ee9:	85 c0                	test   %eax,%eax
    1eeb:	79 0c                	jns    1ef9 <random+0x37>
{
rand_num *= (-1);
    1eed:	a1 38 29 00 00       	mov    0x2938,%eax
    1ef2:	f7 d8                	neg    %eax
    1ef4:	a3 38 29 00 00       	mov    %eax,0x2938
}
return rand_num % 997;
    1ef9:	8b 0d 38 29 00 00    	mov    0x2938,%ecx
    1eff:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1f04:	89 c8                	mov    %ecx,%eax
    1f06:	f7 ea                	imul   %edx
    1f08:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1f0b:	c1 f8 09             	sar    $0x9,%eax
    1f0e:	89 c2                	mov    %eax,%edx
    1f10:	89 c8                	mov    %ecx,%eax
    1f12:	c1 f8 1f             	sar    $0x1f,%eax
    1f15:	29 c2                	sub    %eax,%edx
    1f17:	89 d0                	mov    %edx,%eax
    1f19:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1f1f:	29 c1                	sub    %eax,%ecx
    1f21:	89 c8                	mov    %ecx,%eax
}
    1f23:	5d                   	pop    %ebp
    1f24:	c3                   	ret    

00001f25 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1f25:	55                   	push   %ebp
    1f26:	89 e5                	mov    %esp,%ebp
    1f28:	53                   	push   %ebx
    1f29:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1f2c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1f33:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1f37:	74 17                	je     1f50 <sprintint+0x2b>
    1f39:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1f3d:	79 11                	jns    1f50 <sprintint+0x2b>
        neg = 1;
    1f3f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1f46:	8b 45 10             	mov    0x10(%ebp),%eax
    1f49:	f7 d8                	neg    %eax
    1f4b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f4e:	eb 06                	jmp    1f56 <sprintint+0x31>
    } else {
        x = xx;
    1f50:	8b 45 10             	mov    0x10(%ebp),%eax
    1f53:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1f56:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1f5d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1f60:	8d 41 01             	lea    0x1(%ecx),%eax
    1f63:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1f66:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f69:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f6c:	ba 00 00 00 00       	mov    $0x0,%edx
    1f71:	f7 f3                	div    %ebx
    1f73:	89 d0                	mov    %edx,%eax
    1f75:	0f b6 80 3c 29 00 00 	movzbl 0x293c(%eax),%eax
    1f7c:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1f80:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f83:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f86:	ba 00 00 00 00       	mov    $0x0,%edx
    1f8b:	f7 f3                	div    %ebx
    1f8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f90:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f94:	75 c7                	jne    1f5d <sprintint+0x38>
    if(neg)
    1f96:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f9a:	74 0e                	je     1faa <sprintint+0x85>
        buf[i++] = '-';
    1f9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f9f:	8d 50 01             	lea    0x1(%eax),%edx
    1fa2:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1fa5:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1faa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fad:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1fb0:	eb 1b                	jmp    1fcd <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1fb2:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fb5:	8b 00                	mov    (%eax),%eax
    1fb7:	8d 48 01             	lea    0x1(%eax),%ecx
    1fba:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fbd:	89 0a                	mov    %ecx,(%edx)
    1fbf:	89 c2                	mov    %eax,%edx
    1fc1:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc4:	01 d0                	add    %edx,%eax
    1fc6:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1fc9:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1fcd:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1fd1:	7f df                	jg     1fb2 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fd3:	eb 21                	jmp    1ff6 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1fd5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fd8:	8b 00                	mov    (%eax),%eax
    1fda:	8d 48 01             	lea    0x1(%eax),%ecx
    1fdd:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fe0:	89 0a                	mov    %ecx,(%edx)
    1fe2:	89 c2                	mov    %eax,%edx
    1fe4:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe7:	01 c2                	add    %eax,%edx
    1fe9:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1fec:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fef:	01 c8                	add    %ecx,%eax
    1ff1:	0f b6 00             	movzbl (%eax),%eax
    1ff4:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1ff6:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1ffa:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1ffe:	79 d5                	jns    1fd5 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2000:	90                   	nop
    2001:	83 c4 20             	add    $0x20,%esp
    2004:	5b                   	pop    %ebx
    2005:	5d                   	pop    %ebp
    2006:	c3                   	ret    

00002007 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2007:	55                   	push   %ebp
    2008:	89 e5                	mov    %esp,%ebp
    200a:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    200d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2014:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    201b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2022:	8d 45 0c             	lea    0xc(%ebp),%eax
    2025:	83 c0 04             	add    $0x4,%eax
    2028:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    202b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2032:	e9 d9 01 00 00       	jmp    2210 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2037:	8b 55 0c             	mov    0xc(%ebp),%edx
    203a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    203d:	01 d0                	add    %edx,%eax
    203f:	0f b6 00             	movzbl (%eax),%eax
    2042:	0f be c0             	movsbl %al,%eax
    2045:	25 ff 00 00 00       	and    $0xff,%eax
    204a:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    204d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2051:	75 2c                	jne    207f <sprintf+0x78>
            if(c == '%'){
    2053:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2057:	75 0c                	jne    2065 <sprintf+0x5e>
                state = '%';
    2059:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2060:	e9 a7 01 00 00       	jmp    220c <sprintf+0x205>
            } else {
                dst[j++] = c;
    2065:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2068:	8d 50 01             	lea    0x1(%eax),%edx
    206b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    206e:	89 c2                	mov    %eax,%edx
    2070:	8b 45 08             	mov    0x8(%ebp),%eax
    2073:	01 d0                	add    %edx,%eax
    2075:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2078:	88 10                	mov    %dl,(%eax)
    207a:	e9 8d 01 00 00       	jmp    220c <sprintf+0x205>
            }
        } else if(state == '%'){
    207f:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2083:	0f 85 83 01 00 00    	jne    220c <sprintf+0x205>
            if(c == 'd'){
    2089:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    208d:	75 4c                	jne    20db <sprintf+0xd4>
                buf[bi] = '\0';
    208f:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2092:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2095:	01 d0                	add    %edx,%eax
    2097:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    209a:	83 ec 0c             	sub    $0xc,%esp
    209d:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20a0:	50                   	push   %eax
    20a1:	e8 91 e1 ff ff       	call   237 <atoi>
    20a6:	83 c4 10             	add    $0x10,%esp
    20a9:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    20ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    20b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20b6:	8b 00                	mov    (%eax),%eax
    20b8:	83 ec 08             	sub    $0x8,%esp
    20bb:	ff 75 d8             	pushl  -0x28(%ebp)
    20be:	6a 01                	push   $0x1
    20c0:	6a 0a                	push   $0xa
    20c2:	50                   	push   %eax
    20c3:	8d 45 c8             	lea    -0x38(%ebp),%eax
    20c6:	50                   	push   %eax
    20c7:	ff 75 08             	pushl  0x8(%ebp)
    20ca:	e8 56 fe ff ff       	call   1f25 <sprintint>
    20cf:	83 c4 20             	add    $0x20,%esp
                ap++;
    20d2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    20d6:	e9 2a 01 00 00       	jmp    2205 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    20db:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    20df:	74 06                	je     20e7 <sprintf+0xe0>
    20e1:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    20e5:	75 4c                	jne    2133 <sprintf+0x12c>
                buf[bi] = '\0';
    20e7:	8d 55 ce             	lea    -0x32(%ebp),%edx
    20ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20ed:	01 d0                	add    %edx,%eax
    20ef:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    20f2:	83 ec 0c             	sub    $0xc,%esp
    20f5:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20f8:	50                   	push   %eax
    20f9:	e8 39 e1 ff ff       	call   237 <atoi>
    20fe:	83 c4 10             	add    $0x10,%esp
    2101:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2104:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    210b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    210e:	8b 00                	mov    (%eax),%eax
    2110:	83 ec 08             	sub    $0x8,%esp
    2113:	ff 75 dc             	pushl  -0x24(%ebp)
    2116:	6a 00                	push   $0x0
    2118:	6a 10                	push   $0x10
    211a:	50                   	push   %eax
    211b:	8d 45 c8             	lea    -0x38(%ebp),%eax
    211e:	50                   	push   %eax
    211f:	ff 75 08             	pushl  0x8(%ebp)
    2122:	e8 fe fd ff ff       	call   1f25 <sprintint>
    2127:	83 c4 20             	add    $0x20,%esp
                ap++;
    212a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    212e:	e9 d2 00 00 00       	jmp    2205 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2133:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2137:	75 46                	jne    217f <sprintf+0x178>
                s = (char*)*ap;
    2139:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    213c:	8b 00                	mov    (%eax),%eax
    213e:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2141:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2145:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2149:	75 25                	jne    2170 <sprintf+0x169>
                    s = "(null)";
    214b:	c7 45 f4 c4 23 00 00 	movl   $0x23c4,-0xc(%ebp)
                while(*s != 0){
    2152:	eb 1c                	jmp    2170 <sprintf+0x169>
                    dst[j++] = *s;
    2154:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2157:	8d 50 01             	lea    0x1(%eax),%edx
    215a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    215d:	89 c2                	mov    %eax,%edx
    215f:	8b 45 08             	mov    0x8(%ebp),%eax
    2162:	01 c2                	add    %eax,%edx
    2164:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2167:	0f b6 00             	movzbl (%eax),%eax
    216a:	88 02                	mov    %al,(%edx)
                    s++;
    216c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2170:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2173:	0f b6 00             	movzbl (%eax),%eax
    2176:	84 c0                	test   %al,%al
    2178:	75 da                	jne    2154 <sprintf+0x14d>
    217a:	e9 86 00 00 00       	jmp    2205 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    217f:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2183:	75 1d                	jne    21a2 <sprintf+0x19b>
                dst[j++] = *ap;
    2185:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2188:	8d 50 01             	lea    0x1(%eax),%edx
    218b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    218e:	89 c2                	mov    %eax,%edx
    2190:	8b 45 08             	mov    0x8(%ebp),%eax
    2193:	01 c2                	add    %eax,%edx
    2195:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2198:	8b 00                	mov    (%eax),%eax
    219a:	88 02                	mov    %al,(%edx)
                ap++;
    219c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    21a0:	eb 63                	jmp    2205 <sprintf+0x1fe>
            } else if(c == '%'){
    21a2:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    21a6:	75 17                	jne    21bf <sprintf+0x1b8>
                dst[j++] = c;
    21a8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21ab:	8d 50 01             	lea    0x1(%eax),%edx
    21ae:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21b1:	89 c2                	mov    %eax,%edx
    21b3:	8b 45 08             	mov    0x8(%ebp),%eax
    21b6:	01 d0                	add    %edx,%eax
    21b8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21bb:	88 10                	mov    %dl,(%eax)
    21bd:	eb 46                	jmp    2205 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    21bf:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    21c3:	7e 18                	jle    21dd <sprintf+0x1d6>
    21c5:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    21c9:	7f 12                	jg     21dd <sprintf+0x1d6>
            {
                buf[bi++] = c;
    21cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21ce:	8d 50 01             	lea    0x1(%eax),%edx
    21d1:	89 55 f0             	mov    %edx,-0x10(%ebp)
    21d4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21d7:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    21db:	eb 2f                	jmp    220c <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    21dd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21e0:	8d 50 01             	lea    0x1(%eax),%edx
    21e3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21e6:	89 c2                	mov    %eax,%edx
    21e8:	8b 45 08             	mov    0x8(%ebp),%eax
    21eb:	01 d0                	add    %edx,%eax
    21ed:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    21f0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21f3:	8d 50 01             	lea    0x1(%eax),%edx
    21f6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21f9:	89 c2                	mov    %eax,%edx
    21fb:	8b 45 08             	mov    0x8(%ebp),%eax
    21fe:	01 d0                	add    %edx,%eax
    2200:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2203:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2205:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    220c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2210:	8b 55 0c             	mov    0xc(%ebp),%edx
    2213:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2216:	01 d0                	add    %edx,%eax
    2218:	0f b6 00             	movzbl (%eax),%eax
    221b:	84 c0                	test   %al,%al
    221d:	0f 85 14 fe ff ff    	jne    2037 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2223:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2226:	8d 50 01             	lea    0x1(%eax),%edx
    2229:	89 55 c8             	mov    %edx,-0x38(%ebp)
    222c:	89 c2                	mov    %eax,%edx
    222e:	8b 45 08             	mov    0x8(%ebp),%eax
    2231:	01 d0                	add    %edx,%eax
    2233:	c6 00 00             	movb   $0x0,(%eax)
}
    2236:	90                   	nop
    2237:	c9                   	leave  
    2238:	c3                   	ret    
