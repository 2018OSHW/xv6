
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
      1c:	68 ac 20 00 00       	push   $0x20ac
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
     404:	0f b6 80 4c 27 00 00 	movzbl 0x274c(%eax),%eax
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
     542:	c7 45 f4 c0 20 00 00 	movl   $0x20c0,-0xc(%ebp)
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
     608:	a1 7c 27 00 00       	mov    0x277c,%eax
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
     6d3:	a3 7c 27 00 00       	mov    %eax,0x277c
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
     734:	a1 7c 27 00 00       	mov    0x277c,%eax
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
     750:	a1 7c 27 00 00       	mov    0x277c,%eax
     755:	89 45 f0             	mov    %eax,-0x10(%ebp)
     758:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     75c:	75 23                	jne    781 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     75e:	c7 45 f0 74 27 00 00 	movl   $0x2774,-0x10(%ebp)
     765:	8b 45 f0             	mov    -0x10(%ebp),%eax
     768:	a3 7c 27 00 00       	mov    %eax,0x277c
     76d:	a1 7c 27 00 00       	mov    0x277c,%eax
     772:	a3 74 27 00 00       	mov    %eax,0x2774
    base.s.size = 0;
     777:	c7 05 78 27 00 00 00 	movl   $0x0,0x2778
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
     7d4:	a3 7c 27 00 00       	mov    %eax,0x277c
      return (void*)(p + 1);
     7d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7dc:	83 c0 08             	add    $0x8,%eax
     7df:	eb 3b                	jmp    81c <malloc+0xe1>
    }
    if(p == freep)
     7e1:	a1 7c 27 00 00       	mov    0x277c,%eax
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
     927:	68 c7 20 00 00       	push   $0x20c7
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

000011e3 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    11e3:	55                   	push   %ebp
    11e4:	89 e5                	mov    %esp,%ebp
    11e6:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    11e9:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    11ed:	0f 88 8e 01 00 00    	js     1381 <APDcCopy+0x19e>
    11f3:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    11f7:	0f 88 84 01 00 00    	js     1381 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    11fd:	8b 55 0c             	mov    0xc(%ebp),%edx
    1200:	8b 45 20             	mov    0x20(%ebp),%eax
    1203:	01 d0                	add    %edx,%eax
    1205:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1208:	8b 55 10             	mov    0x10(%ebp),%edx
    120b:	8b 45 24             	mov    0x24(%ebp),%eax
    120e:	01 d0                	add    %edx,%eax
    1210:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1213:	8b 55 18             	mov    0x18(%ebp),%edx
    1216:	8b 45 20             	mov    0x20(%ebp),%eax
    1219:	01 d0                	add    %edx,%eax
    121b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    121e:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1221:	8b 45 24             	mov    0x24(%ebp),%eax
    1224:	01 d0                	add    %edx,%eax
    1226:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1229:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    122d:	0f 88 51 01 00 00    	js     1384 <APDcCopy+0x1a1>
    1233:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1237:	0f 88 47 01 00 00    	js     1384 <APDcCopy+0x1a1>
    123d:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1241:	0f 88 3d 01 00 00    	js     1384 <APDcCopy+0x1a1>
    1247:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    124b:	0f 88 33 01 00 00    	js     1384 <APDcCopy+0x1a1>
    1251:	8b 45 14             	mov    0x14(%ebp),%eax
    1254:	8b 00                	mov    (%eax),%eax
    1256:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1259:	0f 8c 25 01 00 00    	jl     1384 <APDcCopy+0x1a1>
    125f:	8b 45 14             	mov    0x14(%ebp),%eax
    1262:	8b 40 04             	mov    0x4(%eax),%eax
    1265:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1268:	0f 8c 16 01 00 00    	jl     1384 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    126e:	8b 45 08             	mov    0x8(%ebp),%eax
    1271:	8b 00                	mov    (%eax),%eax
    1273:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1276:	7f 0b                	jg     1283 <APDcCopy+0xa0>
    1278:	8b 45 08             	mov    0x8(%ebp),%eax
    127b:	8b 00                	mov    (%eax),%eax
    127d:	83 e8 01             	sub    $0x1,%eax
    1280:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1283:	8b 45 08             	mov    0x8(%ebp),%eax
    1286:	8b 40 04             	mov    0x4(%eax),%eax
    1289:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    128c:	7f 0c                	jg     129a <APDcCopy+0xb7>
    128e:	8b 45 08             	mov    0x8(%ebp),%eax
    1291:	8b 40 04             	mov    0x4(%eax),%eax
    1294:	83 e8 01             	sub    $0x1,%eax
    1297:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    129a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12a1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    12a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12af:	e9 bc 00 00 00       	jmp    1370 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12b4:	8b 45 08             	mov    0x8(%ebp),%eax
    12b7:	8b 00                	mov    (%eax),%eax
    12b9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12bc:	8b 55 10             	mov    0x10(%ebp),%edx
    12bf:	01 ca                	add    %ecx,%edx
    12c1:	0f af d0             	imul   %eax,%edx
    12c4:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c7:	01 d0                	add    %edx,%eax
    12c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    12cc:	8b 45 14             	mov    0x14(%ebp),%eax
    12cf:	8b 00                	mov    (%eax),%eax
    12d1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12d4:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12d7:	01 ca                	add    %ecx,%edx
    12d9:	0f af d0             	imul   %eax,%edx
    12dc:	8b 45 18             	mov    0x18(%ebp),%eax
    12df:	01 d0                	add    %edx,%eax
    12e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    12e4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12eb:	eb 74                	jmp    1361 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    12ed:	8b 45 14             	mov    0x14(%ebp),%eax
    12f0:	8b 50 18             	mov    0x18(%eax),%edx
    12f3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12f9:	01 c8                	add    %ecx,%eax
    12fb:	89 c1                	mov    %eax,%ecx
    12fd:	89 c8                	mov    %ecx,%eax
    12ff:	01 c0                	add    %eax,%eax
    1301:	01 c8                	add    %ecx,%eax
    1303:	01 d0                	add    %edx,%eax
    1305:	0f b7 10             	movzwl (%eax),%edx
    1308:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    130c:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1310:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1313:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1317:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    131b:	38 c2                	cmp    %al,%dl
    131d:	75 18                	jne    1337 <APDcCopy+0x154>
    131f:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1323:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1327:	38 c2                	cmp    %al,%dl
    1329:	75 0c                	jne    1337 <APDcCopy+0x154>
    132b:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    132f:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1333:	38 c2                	cmp    %al,%dl
    1335:	74 26                	je     135d <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1337:	8b 45 08             	mov    0x8(%ebp),%eax
    133a:	8b 50 18             	mov    0x18(%eax),%edx
    133d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1340:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1343:	01 c8                	add    %ecx,%eax
    1345:	89 c1                	mov    %eax,%ecx
    1347:	89 c8                	mov    %ecx,%eax
    1349:	01 c0                	add    %eax,%eax
    134b:	01 c8                	add    %ecx,%eax
    134d:	01 d0                	add    %edx,%eax
    134f:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1353:	66 89 10             	mov    %dx,(%eax)
    1356:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    135a:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    135d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1361:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1364:	2b 45 0c             	sub    0xc(%ebp),%eax
    1367:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    136a:	7d 81                	jge    12ed <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    136c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1370:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1373:	2b 45 10             	sub    0x10(%ebp),%eax
    1376:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1379:	0f 8d 35 ff ff ff    	jge    12b4 <APDcCopy+0xd1>
    137f:	eb 04                	jmp    1385 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1381:	90                   	nop
    1382:	eb 01                	jmp    1385 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1384:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1385:	c9                   	leave  
    1386:	c3                   	ret    

00001387 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1387:	55                   	push   %ebp
    1388:	89 e5                	mov    %esp,%ebp
    138a:	83 ec 1c             	sub    $0x1c,%esp
    138d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1390:	8b 55 10             	mov    0x10(%ebp),%edx
    1393:	8b 45 14             	mov    0x14(%ebp),%eax
    1396:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1399:	88 55 e8             	mov    %dl,-0x18(%ebp)
    139c:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    139f:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13a3:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13a6:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13aa:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13ad:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13b1:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13b4:	8b 45 08             	mov    0x8(%ebp),%eax
    13b7:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13bb:	66 89 10             	mov    %dx,(%eax)
    13be:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13c2:	88 50 02             	mov    %dl,0x2(%eax)
}
    13c5:	8b 45 08             	mov    0x8(%ebp),%eax
    13c8:	c9                   	leave  
    13c9:	c2 04 00             	ret    $0x4

000013cc <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    13cc:	55                   	push   %ebp
    13cd:	89 e5                	mov    %esp,%ebp
    13cf:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13d2:	8b 45 08             	mov    0x8(%ebp),%eax
    13d5:	8b 00                	mov    (%eax),%eax
    13d7:	83 ec 08             	sub    $0x8,%esp
    13da:	8d 55 0c             	lea    0xc(%ebp),%edx
    13dd:	52                   	push   %edx
    13de:	50                   	push   %eax
    13df:	e8 95 ef ff ff       	call   379 <sendMessage>
    13e4:	83 c4 10             	add    $0x10,%esp
}
    13e7:	90                   	nop
    13e8:	c9                   	leave  
    13e9:	c3                   	ret    

000013ea <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    13ea:	55                   	push   %ebp
    13eb:	89 e5                	mov    %esp,%ebp
    13ed:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    13f0:	83 ec 0c             	sub    $0xc,%esp
    13f3:	68 90 00 00 00       	push   $0x90
    13f8:	e8 3e f3 ff ff       	call   73b <malloc>
    13fd:	83 c4 10             	add    $0x10,%esp
    1400:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1403:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1407:	75 15                	jne    141e <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1409:	83 ec 04             	sub    $0x4,%esp
    140c:	ff 75 08             	pushl  0x8(%ebp)
    140f:	68 d8 20 00 00       	push   $0x20d8
    1414:	6a 01                	push   $0x1
    1416:	e8 4d f0 ff ff       	call   468 <printf>
    141b:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    141e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1421:	83 c0 7c             	add    $0x7c,%eax
    1424:	83 ec 08             	sub    $0x8,%esp
    1427:	ff 75 08             	pushl  0x8(%ebp)
    142a:	50                   	push   %eax
    142b:	e8 68 ec ff ff       	call   98 <strcpy>
    1430:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1433:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1436:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    143d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1440:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1447:	8b 45 f4             	mov    -0xc(%ebp),%eax
    144a:	8b 40 34             	mov    0x34(%eax),%eax
    144d:	89 c2                	mov    %eax,%edx
    144f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1452:	8b 40 38             	mov    0x38(%eax),%eax
    1455:	0f af d0             	imul   %eax,%edx
    1458:	89 d0                	mov    %edx,%eax
    145a:	01 c0                	add    %eax,%eax
    145c:	01 d0                	add    %edx,%eax
    145e:	83 ec 0c             	sub    $0xc,%esp
    1461:	50                   	push   %eax
    1462:	e8 d4 f2 ff ff       	call   73b <malloc>
    1467:	83 c4 10             	add    $0x10,%esp
    146a:	89 c2                	mov    %eax,%edx
    146c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    146f:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1472:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1475:	8b 40 4c             	mov    0x4c(%eax),%eax
    1478:	85 c0                	test   %eax,%eax
    147a:	75 15                	jne    1491 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    147c:	83 ec 04             	sub    $0x4,%esp
    147f:	ff 75 08             	pushl  0x8(%ebp)
    1482:	68 f8 20 00 00       	push   $0x20f8
    1487:	6a 01                	push   $0x1
    1489:	e8 da ef ff ff       	call   468 <printf>
    148e:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1491:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1494:	8b 40 34             	mov    0x34(%eax),%eax
    1497:	89 c2                	mov    %eax,%edx
    1499:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149c:	8b 40 38             	mov    0x38(%eax),%eax
    149f:	0f af d0             	imul   %eax,%edx
    14a2:	89 d0                	mov    %edx,%eax
    14a4:	01 c0                	add    %eax,%eax
    14a6:	01 c2                	add    %eax,%edx
    14a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ab:	8b 40 4c             	mov    0x4c(%eax),%eax
    14ae:	83 ec 04             	sub    $0x4,%esp
    14b1:	52                   	push   %edx
    14b2:	68 ff ff ff 00       	push   $0xffffff
    14b7:	50                   	push   %eax
    14b8:	e8 71 ec ff ff       	call   12e <memset>
    14bd:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c3:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    14ca:	e8 7a ee ff ff       	call   349 <getpid>
    14cf:	89 c2                	mov    %eax,%edx
    14d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d4:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14da:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e4:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    14eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ee:	8b 40 50             	mov    0x50(%eax),%eax
    14f1:	89 c2                	mov    %eax,%edx
    14f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f6:	8b 40 54             	mov    0x54(%eax),%eax
    14f9:	0f af d0             	imul   %eax,%edx
    14fc:	89 d0                	mov    %edx,%eax
    14fe:	01 c0                	add    %eax,%eax
    1500:	01 d0                	add    %edx,%eax
    1502:	83 ec 0c             	sub    $0xc,%esp
    1505:	50                   	push   %eax
    1506:	e8 30 f2 ff ff       	call   73b <malloc>
    150b:	83 c4 10             	add    $0x10,%esp
    150e:	89 c2                	mov    %eax,%edx
    1510:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1513:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    1516:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1519:	8b 40 68             	mov    0x68(%eax),%eax
    151c:	85 c0                	test   %eax,%eax
    151e:	75 15                	jne    1535 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1520:	83 ec 04             	sub    $0x4,%esp
    1523:	ff 75 08             	pushl  0x8(%ebp)
    1526:	68 1c 21 00 00       	push   $0x211c
    152b:	6a 01                	push   $0x1
    152d:	e8 36 ef ff ff       	call   468 <printf>
    1532:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1535:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1538:	8b 40 34             	mov    0x34(%eax),%eax
    153b:	89 c2                	mov    %eax,%edx
    153d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1540:	8b 40 38             	mov    0x38(%eax),%eax
    1543:	0f af d0             	imul   %eax,%edx
    1546:	89 d0                	mov    %edx,%eax
    1548:	01 c0                	add    %eax,%eax
    154a:	01 c2                	add    %eax,%edx
    154c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154f:	8b 40 4c             	mov    0x4c(%eax),%eax
    1552:	83 ec 04             	sub    $0x4,%esp
    1555:	52                   	push   %edx
    1556:	68 ff 00 00 00       	push   $0xff
    155b:	50                   	push   %eax
    155c:	e8 cd eb ff ff       	call   12e <memset>
    1561:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1564:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1567:	8b 55 0c             	mov    0xc(%ebp),%edx
    156a:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    156d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1571:	74 35                	je     15a8 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1573:	8b 45 10             	mov    0x10(%ebp),%eax
    1576:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    157c:	83 ec 0c             	sub    $0xc,%esp
    157f:	50                   	push   %eax
    1580:	e8 b6 f1 ff ff       	call   73b <malloc>
    1585:	83 c4 10             	add    $0x10,%esp
    1588:	89 c2                	mov    %eax,%edx
    158a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158d:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1590:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1593:	8b 55 10             	mov    0x10(%ebp),%edx
    1596:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1599:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159c:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    15a3:	e9 8d 00 00 00       	jmp    1635 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ab:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b5:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bf:	8b 40 18             	mov    0x18(%eax),%eax
    15c2:	89 c2                	mov    %eax,%edx
    15c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c7:	8b 40 1c             	mov    0x1c(%eax),%eax
    15ca:	0f af d0             	imul   %eax,%edx
    15cd:	89 d0                	mov    %edx,%eax
    15cf:	01 c0                	add    %eax,%eax
    15d1:	01 d0                	add    %edx,%eax
    15d3:	83 ec 0c             	sub    $0xc,%esp
    15d6:	50                   	push   %eax
    15d7:	e8 5f f1 ff ff       	call   73b <malloc>
    15dc:	83 c4 10             	add    $0x10,%esp
    15df:	89 c2                	mov    %eax,%edx
    15e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e4:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    15e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ea:	8b 40 30             	mov    0x30(%eax),%eax
    15ed:	85 c0                	test   %eax,%eax
    15ef:	75 15                	jne    1606 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    15f1:	83 ec 04             	sub    $0x4,%esp
    15f4:	ff 75 08             	pushl  0x8(%ebp)
    15f7:	68 44 21 00 00       	push   $0x2144
    15fc:	6a 01                	push   $0x1
    15fe:	e8 65 ee ff ff       	call   468 <printf>
    1603:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1606:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1609:	8b 40 18             	mov    0x18(%eax),%eax
    160c:	89 c2                	mov    %eax,%edx
    160e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1611:	8b 40 1c             	mov    0x1c(%eax),%eax
    1614:	0f af d0             	imul   %eax,%edx
    1617:	89 d0                	mov    %edx,%eax
    1619:	01 c0                	add    %eax,%eax
    161b:	01 c2                	add    %eax,%edx
    161d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1620:	8b 40 30             	mov    0x30(%eax),%eax
    1623:	83 ec 04             	sub    $0x4,%esp
    1626:	52                   	push   %edx
    1627:	68 ff ff ff 00       	push   $0xffffff
    162c:	50                   	push   %eax
    162d:	e8 fc ea ff ff       	call   12e <memset>
    1632:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1635:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1638:	c9                   	leave  
    1639:	c3                   	ret    

0000163a <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    163a:	55                   	push   %ebp
    163b:	89 e5                	mov    %esp,%ebp
    163d:	53                   	push   %ebx
    163e:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1641:	8b 45 0c             	mov    0xc(%ebp),%eax
    1644:	83 f8 03             	cmp    $0x3,%eax
    1647:	74 02                	je     164b <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1649:	eb 33                	jmp    167e <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    164b:	8b 45 08             	mov    0x8(%ebp),%eax
    164e:	8b 48 08             	mov    0x8(%eax),%ecx
    1651:	8b 45 08             	mov    0x8(%ebp),%eax
    1654:	8b 50 38             	mov    0x38(%eax),%edx
    1657:	8b 45 08             	mov    0x8(%ebp),%eax
    165a:	8b 40 34             	mov    0x34(%eax),%eax
    165d:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1660:	83 c3 34             	add    $0x34,%ebx
    1663:	83 ec 0c             	sub    $0xc,%esp
    1666:	51                   	push   %ecx
    1667:	52                   	push   %edx
    1668:	50                   	push   %eax
    1669:	6a 00                	push   $0x0
    166b:	6a 00                	push   $0x0
    166d:	53                   	push   %ebx
    166e:	6a 32                	push   $0x32
    1670:	6a 00                	push   $0x0
    1672:	ff 75 08             	pushl  0x8(%ebp)
    1675:	e8 ef ec ff ff       	call   369 <paintWindow>
    167a:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    167d:	90                   	nop
        default: break;
            
            
    }
    return False;
    167e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1683:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1686:	c9                   	leave  
    1687:	c3                   	ret    

00001688 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1688:	55                   	push   %ebp
    1689:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    168b:	8b 45 0c             	mov    0xc(%ebp),%eax
    168e:	8b 50 08             	mov    0x8(%eax),%edx
    1691:	8b 45 08             	mov    0x8(%ebp),%eax
    1694:	8b 00                	mov    (%eax),%eax
    1696:	39 c2                	cmp    %eax,%edx
    1698:	74 07                	je     16a1 <APPreJudge+0x19>
        return False;
    169a:	b8 00 00 00 00       	mov    $0x0,%eax
    169f:	eb 05                	jmp    16a6 <APPreJudge+0x1e>
    return True;
    16a1:	b8 01 00 00 00       	mov    $0x1,%eax
}
    16a6:	5d                   	pop    %ebp
    16a7:	c3                   	ret    

000016a8 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    16a8:	55                   	push   %ebp
    16a9:	89 e5                	mov    %esp,%ebp
    16ab:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    16ae:	8b 45 08             	mov    0x8(%ebp),%eax
    16b1:	8b 55 0c             	mov    0xc(%ebp),%edx
    16b4:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    16b7:	83 ec 0c             	sub    $0xc,%esp
    16ba:	ff 75 08             	pushl  0x8(%ebp)
    16bd:	e8 c7 ec ff ff       	call   389 <registWindow>
    16c2:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    16c5:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    16cc:	8b 45 08             	mov    0x8(%ebp),%eax
    16cf:	8b 00                	mov    (%eax),%eax
    16d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    16d4:	ff 75 f4             	pushl  -0xc(%ebp)
    16d7:	ff 75 f0             	pushl  -0x10(%ebp)
    16da:	ff 75 ec             	pushl  -0x14(%ebp)
    16dd:	ff 75 08             	pushl  0x8(%ebp)
    16e0:	e8 e7 fc ff ff       	call   13cc <APSendMessage>
    16e5:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    16e8:	83 ec 0c             	sub    $0xc,%esp
    16eb:	ff 75 08             	pushl  0x8(%ebp)
    16ee:	e8 8e ec ff ff       	call   381 <getMessage>
    16f3:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    16f6:	8b 45 08             	mov    0x8(%ebp),%eax
    16f9:	83 c0 6c             	add    $0x6c,%eax
    16fc:	83 ec 08             	sub    $0x8,%esp
    16ff:	50                   	push   %eax
    1700:	ff 75 08             	pushl  0x8(%ebp)
    1703:	e8 80 ff ff ff       	call   1688 <APPreJudge>
    1708:	83 c4 10             	add    $0x10,%esp
    170b:	84 c0                	test   %al,%al
    170d:	74 1b                	je     172a <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    170f:	8b 45 08             	mov    0x8(%ebp),%eax
    1712:	ff 70 74             	pushl  0x74(%eax)
    1715:	ff 70 70             	pushl  0x70(%eax)
    1718:	ff 70 6c             	pushl  0x6c(%eax)
    171b:	ff 75 08             	pushl  0x8(%ebp)
    171e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1721:	ff d0                	call   *%eax
    1723:	83 c4 10             	add    $0x10,%esp
    1726:	84 c0                	test   %al,%al
    1728:	75 0c                	jne    1736 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    172a:	8b 45 08             	mov    0x8(%ebp),%eax
    172d:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1734:	eb b2                	jmp    16e8 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1736:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1737:	90                   	nop
    1738:	c9                   	leave  
    1739:	c3                   	ret    

0000173a <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    173a:	55                   	push   %ebp
    173b:	89 e5                	mov    %esp,%ebp
    173d:	57                   	push   %edi
    173e:	56                   	push   %esi
    173f:	53                   	push   %ebx
    1740:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1743:	a1 80 27 00 00       	mov    0x2780,%eax
    1748:	85 c0                	test   %eax,%eax
    174a:	0f 85 2c 02 00 00    	jne    197c <APGridPaint+0x242>
    {
        iconReady = 1;
    1750:	c7 05 80 27 00 00 01 	movl   $0x1,0x2780
    1757:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    175a:	8d 45 98             	lea    -0x68(%ebp),%eax
    175d:	83 ec 08             	sub    $0x8,%esp
    1760:	68 6b 21 00 00       	push   $0x216b
    1765:	50                   	push   %eax
    1766:	e8 83 f1 ff ff       	call   8ee <APLoadBitmap>
    176b:	83 c4 0c             	add    $0xc,%esp
    176e:	8b 45 98             	mov    -0x68(%ebp),%eax
    1771:	a3 a4 27 00 00       	mov    %eax,0x27a4
    1776:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1779:	a3 a8 27 00 00       	mov    %eax,0x27a8
    177e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1781:	a3 ac 27 00 00       	mov    %eax,0x27ac
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1786:	83 ec 04             	sub    $0x4,%esp
    1789:	ff 35 ac 27 00 00    	pushl  0x27ac
    178f:	ff 35 a8 27 00 00    	pushl  0x27a8
    1795:	ff 35 a4 27 00 00    	pushl  0x27a4
    179b:	e8 88 f3 ff ff       	call   b28 <APCreateCompatibleDCFromBitmap>
    17a0:	83 c4 10             	add    $0x10,%esp
    17a3:	a3 b0 27 00 00       	mov    %eax,0x27b0
        grid_river = APLoadBitmap ("grid_river.bmp");
    17a8:	8d 45 98             	lea    -0x68(%ebp),%eax
    17ab:	83 ec 08             	sub    $0x8,%esp
    17ae:	68 79 21 00 00       	push   $0x2179
    17b3:	50                   	push   %eax
    17b4:	e8 35 f1 ff ff       	call   8ee <APLoadBitmap>
    17b9:	83 c4 0c             	add    $0xc,%esp
    17bc:	8b 45 98             	mov    -0x68(%ebp),%eax
    17bf:	a3 e0 27 00 00       	mov    %eax,0x27e0
    17c4:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17c7:	a3 e4 27 00 00       	mov    %eax,0x27e4
    17cc:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17cf:	a3 e8 27 00 00       	mov    %eax,0x27e8
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    17d4:	83 ec 04             	sub    $0x4,%esp
    17d7:	ff 35 e8 27 00 00    	pushl  0x27e8
    17dd:	ff 35 e4 27 00 00    	pushl  0x27e4
    17e3:	ff 35 e0 27 00 00    	pushl  0x27e0
    17e9:	e8 3a f3 ff ff       	call   b28 <APCreateCompatibleDCFromBitmap>
    17ee:	83 c4 10             	add    $0x10,%esp
    17f1:	a3 d0 27 00 00       	mov    %eax,0x27d0
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    17f6:	8d 45 98             	lea    -0x68(%ebp),%eax
    17f9:	83 ec 08             	sub    $0x8,%esp
    17fc:	68 88 21 00 00       	push   $0x2188
    1801:	50                   	push   %eax
    1802:	e8 e7 f0 ff ff       	call   8ee <APLoadBitmap>
    1807:	83 c4 0c             	add    $0xc,%esp
    180a:	8b 45 98             	mov    -0x68(%ebp),%eax
    180d:	a3 d4 27 00 00       	mov    %eax,0x27d4
    1812:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1815:	a3 d8 27 00 00       	mov    %eax,0x27d8
    181a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    181d:	a3 dc 27 00 00       	mov    %eax,0x27dc
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1822:	83 ec 04             	sub    $0x4,%esp
    1825:	ff 35 dc 27 00 00    	pushl  0x27dc
    182b:	ff 35 d8 27 00 00    	pushl  0x27d8
    1831:	ff 35 d4 27 00 00    	pushl  0x27d4
    1837:	e8 ec f2 ff ff       	call   b28 <APCreateCompatibleDCFromBitmap>
    183c:	83 c4 10             	add    $0x10,%esp
    183f:	a3 84 27 00 00       	mov    %eax,0x2784
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1844:	8d 45 98             	lea    -0x68(%ebp),%eax
    1847:	83 ec 08             	sub    $0x8,%esp
    184a:	68 97 21 00 00       	push   $0x2197
    184f:	50                   	push   %eax
    1850:	e8 99 f0 ff ff       	call   8ee <APLoadBitmap>
    1855:	83 c4 0c             	add    $0xc,%esp
    1858:	8b 45 98             	mov    -0x68(%ebp),%eax
    185b:	a3 b8 27 00 00       	mov    %eax,0x27b8
    1860:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1863:	a3 bc 27 00 00       	mov    %eax,0x27bc
    1868:	8b 45 a0             	mov    -0x60(%ebp),%eax
    186b:	a3 c0 27 00 00       	mov    %eax,0x27c0
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1870:	83 ec 04             	sub    $0x4,%esp
    1873:	ff 35 c0 27 00 00    	pushl  0x27c0
    1879:	ff 35 bc 27 00 00    	pushl  0x27bc
    187f:	ff 35 b8 27 00 00    	pushl  0x27b8
    1885:	e8 9e f2 ff ff       	call   b28 <APCreateCompatibleDCFromBitmap>
    188a:	83 c4 10             	add    $0x10,%esp
    188d:	a3 ec 27 00 00       	mov    %eax,0x27ec
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1892:	8d 45 98             	lea    -0x68(%ebp),%eax
    1895:	83 ec 08             	sub    $0x8,%esp
    1898:	68 a5 21 00 00       	push   $0x21a5
    189d:	50                   	push   %eax
    189e:	e8 4b f0 ff ff       	call   8ee <APLoadBitmap>
    18a3:	83 c4 0c             	add    $0xc,%esp
    18a6:	8b 45 98             	mov    -0x68(%ebp),%eax
    18a9:	a3 94 27 00 00       	mov    %eax,0x2794
    18ae:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18b1:	a3 98 27 00 00       	mov    %eax,0x2798
    18b6:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18b9:	a3 9c 27 00 00       	mov    %eax,0x279c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    18be:	83 ec 04             	sub    $0x4,%esp
    18c1:	ff 35 9c 27 00 00    	pushl  0x279c
    18c7:	ff 35 98 27 00 00    	pushl  0x2798
    18cd:	ff 35 94 27 00 00    	pushl  0x2794
    18d3:	e8 50 f2 ff ff       	call   b28 <APCreateCompatibleDCFromBitmap>
    18d8:	83 c4 10             	add    $0x10,%esp
    18db:	a3 b4 27 00 00       	mov    %eax,0x27b4
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    18e0:	8d 45 98             	lea    -0x68(%ebp),%eax
    18e3:	83 ec 08             	sub    $0x8,%esp
    18e6:	68 b5 21 00 00       	push   $0x21b5
    18eb:	50                   	push   %eax
    18ec:	e8 fd ef ff ff       	call   8ee <APLoadBitmap>
    18f1:	83 c4 0c             	add    $0xc,%esp
    18f4:	8b 45 98             	mov    -0x68(%ebp),%eax
    18f7:	a3 88 27 00 00       	mov    %eax,0x2788
    18fc:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18ff:	a3 8c 27 00 00       	mov    %eax,0x278c
    1904:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1907:	a3 90 27 00 00       	mov    %eax,0x2790
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    190c:	83 ec 04             	sub    $0x4,%esp
    190f:	ff 35 90 27 00 00    	pushl  0x2790
    1915:	ff 35 8c 27 00 00    	pushl  0x278c
    191b:	ff 35 88 27 00 00    	pushl  0x2788
    1921:	e8 02 f2 ff ff       	call   b28 <APCreateCompatibleDCFromBitmap>
    1926:	83 c4 10             	add    $0x10,%esp
    1929:	a3 a0 27 00 00       	mov    %eax,0x27a0
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    192e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1931:	83 ec 08             	sub    $0x8,%esp
    1934:	68 c7 21 00 00       	push   $0x21c7
    1939:	50                   	push   %eax
    193a:	e8 af ef ff ff       	call   8ee <APLoadBitmap>
    193f:	83 c4 0c             	add    $0xc,%esp
    1942:	8b 45 98             	mov    -0x68(%ebp),%eax
    1945:	a3 c4 27 00 00       	mov    %eax,0x27c4
    194a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    194d:	a3 c8 27 00 00       	mov    %eax,0x27c8
    1952:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1955:	a3 cc 27 00 00       	mov    %eax,0x27cc
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    195a:	83 ec 04             	sub    $0x4,%esp
    195d:	ff 35 cc 27 00 00    	pushl  0x27cc
    1963:	ff 35 c8 27 00 00    	pushl  0x27c8
    1969:	ff 35 c4 27 00 00    	pushl  0x27c4
    196f:	e8 b4 f1 ff ff       	call   b28 <APCreateCompatibleDCFromBitmap>
    1974:	83 c4 10             	add    $0x10,%esp
    1977:	a3 f0 27 00 00       	mov    %eax,0x27f0
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    197c:	8b 45 08             	mov    0x8(%ebp),%eax
    197f:	8b 40 08             	mov    0x8(%eax),%eax
    1982:	85 c0                	test   %eax,%eax
    1984:	75 17                	jne    199d <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1986:	83 ec 08             	sub    $0x8,%esp
    1989:	68 d8 21 00 00       	push   $0x21d8
    198e:	6a 01                	push   $0x1
    1990:	e8 d3 ea ff ff       	call   468 <printf>
    1995:	83 c4 10             	add    $0x10,%esp
        return;
    1998:	e9 f2 03 00 00       	jmp    1d8f <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    199d:	8b 45 08             	mov    0x8(%ebp),%eax
    19a0:	8b 40 10             	mov    0x10(%eax),%eax
    19a3:	85 c0                	test   %eax,%eax
    19a5:	7e 10                	jle    19b7 <APGridPaint+0x27d>
    19a7:	8b 45 08             	mov    0x8(%ebp),%eax
    19aa:	8b 50 14             	mov    0x14(%eax),%edx
    19ad:	8b 45 08             	mov    0x8(%ebp),%eax
    19b0:	8b 40 10             	mov    0x10(%eax),%eax
    19b3:	39 c2                	cmp    %eax,%edx
    19b5:	7c 17                	jl     19ce <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    19b7:	83 ec 08             	sub    $0x8,%esp
    19ba:	68 fe 21 00 00       	push   $0x21fe
    19bf:	6a 01                	push   $0x1
    19c1:	e8 a2 ea ff ff       	call   468 <printf>
    19c6:	83 c4 10             	add    $0x10,%esp
        return;
    19c9:	e9 c1 03 00 00       	jmp    1d8f <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    19ce:	8b 45 08             	mov    0x8(%ebp),%eax
    19d1:	8b 40 14             	mov    0x14(%eax),%eax
    19d4:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    19da:	89 45 dc             	mov    %eax,-0x24(%ebp)
    19dd:	8b 45 dc             	mov    -0x24(%ebp),%eax
    19e0:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    19e3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    19ea:	e9 96 03 00 00       	jmp    1d85 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    19ef:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    19f6:	e9 7c 03 00 00       	jmp    1d77 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    19fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19fe:	c1 e0 04             	shl    $0x4,%eax
    1a01:	89 c2                	mov    %eax,%edx
    1a03:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a06:	01 c2                	add    %eax,%edx
    1a08:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a0b:	01 d0                	add    %edx,%eax
    1a0d:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a10:	8b 45 08             	mov    0x8(%ebp),%eax
    1a13:	8b 40 0c             	mov    0xc(%eax),%eax
    1a16:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a19:	c1 e2 02             	shl    $0x2,%edx
    1a1c:	01 d0                	add    %edx,%eax
    1a1e:	8b 00                	mov    (%eax),%eax
    1a20:	83 f8 07             	cmp    $0x7,%eax
    1a23:	0f 87 49 03 00 00    	ja     1d72 <APGridPaint+0x638>
    1a29:	8b 04 85 14 22 00 00 	mov    0x2214(,%eax,4),%eax
    1a30:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1a32:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1a35:	6a 0c                	push   $0xc
    1a37:	6a 0c                	push   $0xc
    1a39:	6a 0c                	push   $0xc
    1a3b:	50                   	push   %eax
    1a3c:	e8 46 f9 ff ff       	call   1387 <RGB>
    1a41:	83 c4 0c             	add    $0xc,%esp
    1a44:	8b 1d b0 27 00 00    	mov    0x27b0,%ebx
    1a4a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a4d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1a50:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a53:	6b c0 32             	imul   $0x32,%eax,%eax
    1a56:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1a59:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5c:	8d 78 34             	lea    0x34(%eax),%edi
    1a5f:	83 ec 0c             	sub    $0xc,%esp
    1a62:	83 ec 04             	sub    $0x4,%esp
    1a65:	89 e0                	mov    %esp,%eax
    1a67:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1a6b:	66 89 30             	mov    %si,(%eax)
    1a6e:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1a72:	88 50 02             	mov    %dl,0x2(%eax)
    1a75:	6a 32                	push   $0x32
    1a77:	6a 32                	push   $0x32
    1a79:	6a 00                	push   $0x0
    1a7b:	6a 00                	push   $0x0
    1a7d:	53                   	push   %ebx
    1a7e:	51                   	push   %ecx
    1a7f:	ff 75 94             	pushl  -0x6c(%ebp)
    1a82:	57                   	push   %edi
    1a83:	e8 5b f7 ff ff       	call   11e3 <APDcCopy>
    1a88:	83 c4 30             	add    $0x30,%esp
                    break;
    1a8b:	e9 e3 02 00 00       	jmp    1d73 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1a90:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a93:	6a 69                	push   $0x69
    1a95:	6a 69                	push   $0x69
    1a97:	6a 69                	push   $0x69
    1a99:	50                   	push   %eax
    1a9a:	e8 e8 f8 ff ff       	call   1387 <RGB>
    1a9f:	83 c4 0c             	add    $0xc,%esp
    1aa2:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1aa6:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1aaa:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1aae:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1ab1:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1ab8:	8d 45 98             	lea    -0x68(%ebp),%eax
    1abb:	6a 69                	push   $0x69
    1abd:	6a 69                	push   $0x69
    1abf:	6a 69                	push   $0x69
    1ac1:	50                   	push   %eax
    1ac2:	e8 c0 f8 ff ff       	call   1387 <RGB>
    1ac7:	83 c4 0c             	add    $0xc,%esp
    1aca:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ace:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1ad2:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ad6:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1ad9:	8b 45 08             	mov    0x8(%ebp),%eax
    1adc:	8d 50 34             	lea    0x34(%eax),%edx
    1adf:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ae2:	ff 75 bc             	pushl  -0x44(%ebp)
    1ae5:	ff 75 b8             	pushl  -0x48(%ebp)
    1ae8:	52                   	push   %edx
    1ae9:	50                   	push   %eax
    1aea:	e8 ce f0 ff ff       	call   bbd <APSetPen>
    1aef:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1af2:	8b 45 08             	mov    0x8(%ebp),%eax
    1af5:	8d 58 34             	lea    0x34(%eax),%ebx
    1af8:	8d 55 98             	lea    -0x68(%ebp),%edx
    1afb:	83 ec 04             	sub    $0x4,%esp
    1afe:	83 ec 04             	sub    $0x4,%esp
    1b01:	89 e0                	mov    %esp,%eax
    1b03:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1b07:	66 89 08             	mov    %cx,(%eax)
    1b0a:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1b0e:	88 48 02             	mov    %cl,0x2(%eax)
    1b11:	53                   	push   %ebx
    1b12:	52                   	push   %edx
    1b13:	e8 de f0 ff ff       	call   bf6 <APSetBrush>
    1b18:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b1b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b1e:	6b d0 32             	imul   $0x32,%eax,%edx
    1b21:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b24:	6b c0 32             	imul   $0x32,%eax,%eax
    1b27:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b2a:	83 c1 34             	add    $0x34,%ecx
    1b2d:	83 ec 0c             	sub    $0xc,%esp
    1b30:	6a 32                	push   $0x32
    1b32:	6a 32                	push   $0x32
    1b34:	52                   	push   %edx
    1b35:	50                   	push   %eax
    1b36:	51                   	push   %ecx
    1b37:	e8 a2 f4 ff ff       	call   fde <APDrawRect>
    1b3c:	83 c4 20             	add    $0x20,%esp
                    break;
    1b3f:	e9 2f 02 00 00       	jmp    1d73 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b44:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1b47:	6a 0c                	push   $0xc
    1b49:	6a 0c                	push   $0xc
    1b4b:	6a 0c                	push   $0xc
    1b4d:	50                   	push   %eax
    1b4e:	e8 34 f8 ff ff       	call   1387 <RGB>
    1b53:	83 c4 0c             	add    $0xc,%esp
    1b56:	8b 1d f0 27 00 00    	mov    0x27f0,%ebx
    1b5c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b5f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b62:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b65:	6b c0 32             	imul   $0x32,%eax,%eax
    1b68:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6e:	8d 78 34             	lea    0x34(%eax),%edi
    1b71:	83 ec 0c             	sub    $0xc,%esp
    1b74:	83 ec 04             	sub    $0x4,%esp
    1b77:	89 e0                	mov    %esp,%eax
    1b79:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1b7d:	66 89 30             	mov    %si,(%eax)
    1b80:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1b84:	88 50 02             	mov    %dl,0x2(%eax)
    1b87:	6a 32                	push   $0x32
    1b89:	6a 32                	push   $0x32
    1b8b:	6a 00                	push   $0x0
    1b8d:	6a 00                	push   $0x0
    1b8f:	53                   	push   %ebx
    1b90:	51                   	push   %ecx
    1b91:	ff 75 94             	pushl  -0x6c(%ebp)
    1b94:	57                   	push   %edi
    1b95:	e8 49 f6 ff ff       	call   11e3 <APDcCopy>
    1b9a:	83 c4 30             	add    $0x30,%esp
                    break;
    1b9d:	e9 d1 01 00 00       	jmp    1d73 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ba2:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1ba5:	6a 0c                	push   $0xc
    1ba7:	6a 0c                	push   $0xc
    1ba9:	6a 0c                	push   $0xc
    1bab:	50                   	push   %eax
    1bac:	e8 d6 f7 ff ff       	call   1387 <RGB>
    1bb1:	83 c4 0c             	add    $0xc,%esp
    1bb4:	8b 1d d0 27 00 00    	mov    0x27d0,%ebx
    1bba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bbd:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bc0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bc3:	6b c0 32             	imul   $0x32,%eax,%eax
    1bc6:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bc9:	8b 45 08             	mov    0x8(%ebp),%eax
    1bcc:	8d 78 34             	lea    0x34(%eax),%edi
    1bcf:	83 ec 0c             	sub    $0xc,%esp
    1bd2:	83 ec 04             	sub    $0x4,%esp
    1bd5:	89 e0                	mov    %esp,%eax
    1bd7:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1bdb:	66 89 30             	mov    %si,(%eax)
    1bde:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1be2:	88 50 02             	mov    %dl,0x2(%eax)
    1be5:	6a 32                	push   $0x32
    1be7:	6a 32                	push   $0x32
    1be9:	6a 00                	push   $0x0
    1beb:	6a 00                	push   $0x0
    1bed:	53                   	push   %ebx
    1bee:	51                   	push   %ecx
    1bef:	ff 75 94             	pushl  -0x6c(%ebp)
    1bf2:	57                   	push   %edi
    1bf3:	e8 eb f5 ff ff       	call   11e3 <APDcCopy>
    1bf8:	83 c4 30             	add    $0x30,%esp
                    break;
    1bfb:	e9 73 01 00 00       	jmp    1d73 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c00:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c03:	6a 0c                	push   $0xc
    1c05:	6a 0c                	push   $0xc
    1c07:	6a 0c                	push   $0xc
    1c09:	50                   	push   %eax
    1c0a:	e8 78 f7 ff ff       	call   1387 <RGB>
    1c0f:	83 c4 0c             	add    $0xc,%esp
    1c12:	8b 1d b4 27 00 00    	mov    0x27b4,%ebx
    1c18:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c1b:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c1e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c21:	6b c0 32             	imul   $0x32,%eax,%eax
    1c24:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c27:	8b 45 08             	mov    0x8(%ebp),%eax
    1c2a:	8d 78 34             	lea    0x34(%eax),%edi
    1c2d:	83 ec 0c             	sub    $0xc,%esp
    1c30:	83 ec 04             	sub    $0x4,%esp
    1c33:	89 e0                	mov    %esp,%eax
    1c35:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1c39:	66 89 30             	mov    %si,(%eax)
    1c3c:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1c40:	88 50 02             	mov    %dl,0x2(%eax)
    1c43:	6a 32                	push   $0x32
    1c45:	6a 32                	push   $0x32
    1c47:	6a 00                	push   $0x0
    1c49:	6a 00                	push   $0x0
    1c4b:	53                   	push   %ebx
    1c4c:	51                   	push   %ecx
    1c4d:	ff 75 94             	pushl  -0x6c(%ebp)
    1c50:	57                   	push   %edi
    1c51:	e8 8d f5 ff ff       	call   11e3 <APDcCopy>
    1c56:	83 c4 30             	add    $0x30,%esp
                    break;
    1c59:	e9 15 01 00 00       	jmp    1d73 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c5e:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1c61:	6a 0c                	push   $0xc
    1c63:	6a 0c                	push   $0xc
    1c65:	6a 0c                	push   $0xc
    1c67:	50                   	push   %eax
    1c68:	e8 1a f7 ff ff       	call   1387 <RGB>
    1c6d:	83 c4 0c             	add    $0xc,%esp
    1c70:	8b 1d ec 27 00 00    	mov    0x27ec,%ebx
    1c76:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c79:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c7c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c7f:	6b c0 32             	imul   $0x32,%eax,%eax
    1c82:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c85:	8b 45 08             	mov    0x8(%ebp),%eax
    1c88:	8d 78 34             	lea    0x34(%eax),%edi
    1c8b:	83 ec 0c             	sub    $0xc,%esp
    1c8e:	83 ec 04             	sub    $0x4,%esp
    1c91:	89 e0                	mov    %esp,%eax
    1c93:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1c97:	66 89 30             	mov    %si,(%eax)
    1c9a:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1c9e:	88 50 02             	mov    %dl,0x2(%eax)
    1ca1:	6a 32                	push   $0x32
    1ca3:	6a 32                	push   $0x32
    1ca5:	6a 00                	push   $0x0
    1ca7:	6a 00                	push   $0x0
    1ca9:	53                   	push   %ebx
    1caa:	51                   	push   %ecx
    1cab:	ff 75 94             	pushl  -0x6c(%ebp)
    1cae:	57                   	push   %edi
    1caf:	e8 2f f5 ff ff       	call   11e3 <APDcCopy>
    1cb4:	83 c4 30             	add    $0x30,%esp
                    break;
    1cb7:	e9 b7 00 00 00       	jmp    1d73 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cbc:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1cbf:	6a 0c                	push   $0xc
    1cc1:	6a 0c                	push   $0xc
    1cc3:	6a 0c                	push   $0xc
    1cc5:	50                   	push   %eax
    1cc6:	e8 bc f6 ff ff       	call   1387 <RGB>
    1ccb:	83 c4 0c             	add    $0xc,%esp
    1cce:	8b 1d 84 27 00 00    	mov    0x2784,%ebx
    1cd4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cd7:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cda:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cdd:	6b c0 32             	imul   $0x32,%eax,%eax
    1ce0:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ce3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce6:	8d 78 34             	lea    0x34(%eax),%edi
    1ce9:	83 ec 0c             	sub    $0xc,%esp
    1cec:	83 ec 04             	sub    $0x4,%esp
    1cef:	89 e0                	mov    %esp,%eax
    1cf1:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1cf5:	66 89 30             	mov    %si,(%eax)
    1cf8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1cfc:	88 50 02             	mov    %dl,0x2(%eax)
    1cff:	6a 32                	push   $0x32
    1d01:	6a 32                	push   $0x32
    1d03:	6a 00                	push   $0x0
    1d05:	6a 00                	push   $0x0
    1d07:	53                   	push   %ebx
    1d08:	51                   	push   %ecx
    1d09:	ff 75 94             	pushl  -0x6c(%ebp)
    1d0c:	57                   	push   %edi
    1d0d:	e8 d1 f4 ff ff       	call   11e3 <APDcCopy>
    1d12:	83 c4 30             	add    $0x30,%esp
                    break;
    1d15:	eb 5c                	jmp    1d73 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d17:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d1a:	6a 0c                	push   $0xc
    1d1c:	6a 0c                	push   $0xc
    1d1e:	6a 0c                	push   $0xc
    1d20:	50                   	push   %eax
    1d21:	e8 61 f6 ff ff       	call   1387 <RGB>
    1d26:	83 c4 0c             	add    $0xc,%esp
    1d29:	8b 1d a0 27 00 00    	mov    0x27a0,%ebx
    1d2f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d32:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d35:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d38:	6b c0 32             	imul   $0x32,%eax,%eax
    1d3b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d41:	8d 78 34             	lea    0x34(%eax),%edi
    1d44:	83 ec 0c             	sub    $0xc,%esp
    1d47:	83 ec 04             	sub    $0x4,%esp
    1d4a:	89 e0                	mov    %esp,%eax
    1d4c:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1d50:	66 89 30             	mov    %si,(%eax)
    1d53:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1d57:	88 50 02             	mov    %dl,0x2(%eax)
    1d5a:	6a 32                	push   $0x32
    1d5c:	6a 32                	push   $0x32
    1d5e:	6a 00                	push   $0x0
    1d60:	6a 00                	push   $0x0
    1d62:	53                   	push   %ebx
    1d63:	51                   	push   %ecx
    1d64:	ff 75 94             	pushl  -0x6c(%ebp)
    1d67:	57                   	push   %edi
    1d68:	e8 76 f4 ff ff       	call   11e3 <APDcCopy>
    1d6d:	83 c4 30             	add    $0x30,%esp
                    break;
    1d70:	eb 01                	jmp    1d73 <APGridPaint+0x639>
                default: break;
    1d72:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d73:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1d77:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1d7b:	0f 8e 7a fc ff ff    	jle    19fb <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d81:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1d85:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1d89:	0f 8e 60 fc ff ff    	jle    19ef <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1d8f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1d92:	5b                   	pop    %ebx
    1d93:	5e                   	pop    %esi
    1d94:	5f                   	pop    %edi
    1d95:	5d                   	pop    %ebp
    1d96:	c3                   	ret    

00001d97 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1d97:	55                   	push   %ebp
    1d98:	89 e5                	mov    %esp,%ebp
    1d9a:	53                   	push   %ebx
    1d9b:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1d9e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1da5:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1da9:	74 17                	je     1dc2 <sprintint+0x2b>
    1dab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1daf:	79 11                	jns    1dc2 <sprintint+0x2b>
        neg = 1;
    1db1:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1db8:	8b 45 10             	mov    0x10(%ebp),%eax
    1dbb:	f7 d8                	neg    %eax
    1dbd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1dc0:	eb 06                	jmp    1dc8 <sprintint+0x31>
    } else {
        x = xx;
    1dc2:	8b 45 10             	mov    0x10(%ebp),%eax
    1dc5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1dc8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1dcf:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1dd2:	8d 41 01             	lea    0x1(%ecx),%eax
    1dd5:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1dd8:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1ddb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1dde:	ba 00 00 00 00       	mov    $0x0,%edx
    1de3:	f7 f3                	div    %ebx
    1de5:	89 d0                	mov    %edx,%eax
    1de7:	0f b6 80 60 27 00 00 	movzbl 0x2760(%eax),%eax
    1dee:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1df2:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1df5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1df8:	ba 00 00 00 00       	mov    $0x0,%edx
    1dfd:	f7 f3                	div    %ebx
    1dff:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e02:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e06:	75 c7                	jne    1dcf <sprintint+0x38>
    if(neg)
    1e08:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e0c:	74 0e                	je     1e1c <sprintint+0x85>
        buf[i++] = '-';
    1e0e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e11:	8d 50 01             	lea    0x1(%eax),%edx
    1e14:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1e17:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1e1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e1f:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1e22:	eb 1b                	jmp    1e3f <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1e24:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e27:	8b 00                	mov    (%eax),%eax
    1e29:	8d 48 01             	lea    0x1(%eax),%ecx
    1e2c:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e2f:	89 0a                	mov    %ecx,(%edx)
    1e31:	89 c2                	mov    %eax,%edx
    1e33:	8b 45 08             	mov    0x8(%ebp),%eax
    1e36:	01 d0                	add    %edx,%eax
    1e38:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1e3b:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1e3f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1e43:	7f df                	jg     1e24 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1e45:	eb 21                	jmp    1e68 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1e47:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e4a:	8b 00                	mov    (%eax),%eax
    1e4c:	8d 48 01             	lea    0x1(%eax),%ecx
    1e4f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e52:	89 0a                	mov    %ecx,(%edx)
    1e54:	89 c2                	mov    %eax,%edx
    1e56:	8b 45 08             	mov    0x8(%ebp),%eax
    1e59:	01 c2                	add    %eax,%edx
    1e5b:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1e5e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e61:	01 c8                	add    %ecx,%eax
    1e63:	0f b6 00             	movzbl (%eax),%eax
    1e66:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1e68:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1e6c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1e70:	79 d5                	jns    1e47 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1e72:	90                   	nop
    1e73:	83 c4 20             	add    $0x20,%esp
    1e76:	5b                   	pop    %ebx
    1e77:	5d                   	pop    %ebp
    1e78:	c3                   	ret    

00001e79 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1e79:	55                   	push   %ebp
    1e7a:	89 e5                	mov    %esp,%ebp
    1e7c:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1e7f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1e86:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1e8d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1e94:	8d 45 0c             	lea    0xc(%ebp),%eax
    1e97:	83 c0 04             	add    $0x4,%eax
    1e9a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1e9d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1ea4:	e9 d9 01 00 00       	jmp    2082 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1ea9:	8b 55 0c             	mov    0xc(%ebp),%edx
    1eac:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1eaf:	01 d0                	add    %edx,%eax
    1eb1:	0f b6 00             	movzbl (%eax),%eax
    1eb4:	0f be c0             	movsbl %al,%eax
    1eb7:	25 ff 00 00 00       	and    $0xff,%eax
    1ebc:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1ebf:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1ec3:	75 2c                	jne    1ef1 <sprintf+0x78>
            if(c == '%'){
    1ec5:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1ec9:	75 0c                	jne    1ed7 <sprintf+0x5e>
                state = '%';
    1ecb:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1ed2:	e9 a7 01 00 00       	jmp    207e <sprintf+0x205>
            } else {
                dst[j++] = c;
    1ed7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1eda:	8d 50 01             	lea    0x1(%eax),%edx
    1edd:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1ee0:	89 c2                	mov    %eax,%edx
    1ee2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee5:	01 d0                	add    %edx,%eax
    1ee7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1eea:	88 10                	mov    %dl,(%eax)
    1eec:	e9 8d 01 00 00       	jmp    207e <sprintf+0x205>
            }
        } else if(state == '%'){
    1ef1:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1ef5:	0f 85 83 01 00 00    	jne    207e <sprintf+0x205>
            if(c == 'd'){
    1efb:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1eff:	75 4c                	jne    1f4d <sprintf+0xd4>
                buf[bi] = '\0';
    1f01:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f04:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f07:	01 d0                	add    %edx,%eax
    1f09:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f0c:	83 ec 0c             	sub    $0xc,%esp
    1f0f:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f12:	50                   	push   %eax
    1f13:	e8 1f e3 ff ff       	call   237 <atoi>
    1f18:	83 c4 10             	add    $0x10,%esp
    1f1b:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1f1e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1f25:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f28:	8b 00                	mov    (%eax),%eax
    1f2a:	83 ec 08             	sub    $0x8,%esp
    1f2d:	ff 75 d8             	pushl  -0x28(%ebp)
    1f30:	6a 01                	push   $0x1
    1f32:	6a 0a                	push   $0xa
    1f34:	50                   	push   %eax
    1f35:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1f38:	50                   	push   %eax
    1f39:	ff 75 08             	pushl  0x8(%ebp)
    1f3c:	e8 56 fe ff ff       	call   1d97 <sprintint>
    1f41:	83 c4 20             	add    $0x20,%esp
                ap++;
    1f44:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1f48:	e9 2a 01 00 00       	jmp    2077 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1f4d:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1f51:	74 06                	je     1f59 <sprintf+0xe0>
    1f53:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1f57:	75 4c                	jne    1fa5 <sprintf+0x12c>
                buf[bi] = '\0';
    1f59:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f5f:	01 d0                	add    %edx,%eax
    1f61:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f64:	83 ec 0c             	sub    $0xc,%esp
    1f67:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f6a:	50                   	push   %eax
    1f6b:	e8 c7 e2 ff ff       	call   237 <atoi>
    1f70:	83 c4 10             	add    $0x10,%esp
    1f73:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1f76:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1f7d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f80:	8b 00                	mov    (%eax),%eax
    1f82:	83 ec 08             	sub    $0x8,%esp
    1f85:	ff 75 dc             	pushl  -0x24(%ebp)
    1f88:	6a 00                	push   $0x0
    1f8a:	6a 10                	push   $0x10
    1f8c:	50                   	push   %eax
    1f8d:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1f90:	50                   	push   %eax
    1f91:	ff 75 08             	pushl  0x8(%ebp)
    1f94:	e8 fe fd ff ff       	call   1d97 <sprintint>
    1f99:	83 c4 20             	add    $0x20,%esp
                ap++;
    1f9c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1fa0:	e9 d2 00 00 00       	jmp    2077 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1fa5:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1fa9:	75 46                	jne    1ff1 <sprintf+0x178>
                s = (char*)*ap;
    1fab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fae:	8b 00                	mov    (%eax),%eax
    1fb0:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1fb3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1fb7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fbb:	75 25                	jne    1fe2 <sprintf+0x169>
                    s = "(null)";
    1fbd:	c7 45 f4 34 22 00 00 	movl   $0x2234,-0xc(%ebp)
                while(*s != 0){
    1fc4:	eb 1c                	jmp    1fe2 <sprintf+0x169>
                    dst[j++] = *s;
    1fc6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1fc9:	8d 50 01             	lea    0x1(%eax),%edx
    1fcc:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1fcf:	89 c2                	mov    %eax,%edx
    1fd1:	8b 45 08             	mov    0x8(%ebp),%eax
    1fd4:	01 c2                	add    %eax,%edx
    1fd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fd9:	0f b6 00             	movzbl (%eax),%eax
    1fdc:	88 02                	mov    %al,(%edx)
                    s++;
    1fde:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    1fe2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fe5:	0f b6 00             	movzbl (%eax),%eax
    1fe8:	84 c0                	test   %al,%al
    1fea:	75 da                	jne    1fc6 <sprintf+0x14d>
    1fec:	e9 86 00 00 00       	jmp    2077 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    1ff1:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    1ff5:	75 1d                	jne    2014 <sprintf+0x19b>
                dst[j++] = *ap;
    1ff7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1ffa:	8d 50 01             	lea    0x1(%eax),%edx
    1ffd:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2000:	89 c2                	mov    %eax,%edx
    2002:	8b 45 08             	mov    0x8(%ebp),%eax
    2005:	01 c2                	add    %eax,%edx
    2007:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    200a:	8b 00                	mov    (%eax),%eax
    200c:	88 02                	mov    %al,(%edx)
                ap++;
    200e:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2012:	eb 63                	jmp    2077 <sprintf+0x1fe>
            } else if(c == '%'){
    2014:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2018:	75 17                	jne    2031 <sprintf+0x1b8>
                dst[j++] = c;
    201a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    201d:	8d 50 01             	lea    0x1(%eax),%edx
    2020:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2023:	89 c2                	mov    %eax,%edx
    2025:	8b 45 08             	mov    0x8(%ebp),%eax
    2028:	01 d0                	add    %edx,%eax
    202a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    202d:	88 10                	mov    %dl,(%eax)
    202f:	eb 46                	jmp    2077 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2031:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2035:	7e 18                	jle    204f <sprintf+0x1d6>
    2037:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    203b:	7f 12                	jg     204f <sprintf+0x1d6>
            {
                buf[bi++] = c;
    203d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2040:	8d 50 01             	lea    0x1(%eax),%edx
    2043:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2046:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2049:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    204d:	eb 2f                	jmp    207e <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    204f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2052:	8d 50 01             	lea    0x1(%eax),%edx
    2055:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2058:	89 c2                	mov    %eax,%edx
    205a:	8b 45 08             	mov    0x8(%ebp),%eax
    205d:	01 d0                	add    %edx,%eax
    205f:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2062:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2065:	8d 50 01             	lea    0x1(%eax),%edx
    2068:	89 55 c8             	mov    %edx,-0x38(%ebp)
    206b:	89 c2                	mov    %eax,%edx
    206d:	8b 45 08             	mov    0x8(%ebp),%eax
    2070:	01 d0                	add    %edx,%eax
    2072:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2075:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2077:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    207e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2082:	8b 55 0c             	mov    0xc(%ebp),%edx
    2085:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2088:	01 d0                	add    %edx,%eax
    208a:	0f b6 00             	movzbl (%eax),%eax
    208d:	84 c0                	test   %al,%al
    208f:	0f 85 14 fe ff ff    	jne    1ea9 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2095:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2098:	8d 50 01             	lea    0x1(%eax),%edx
    209b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    209e:	89 c2                	mov    %eax,%edx
    20a0:	8b 45 08             	mov    0x8(%ebp),%eax
    20a3:	01 d0                	add    %edx,%eax
    20a5:	c6 00 00             	movb   $0x0,(%eax)
}
    20a8:	90                   	nop
    20a9:	c9                   	leave  
    20aa:	c3                   	ret    
