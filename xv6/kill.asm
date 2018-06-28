
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
      1c:	68 ac 1e 00 00       	push   $0x1eac
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
     404:	0f b6 80 30 25 00 00 	movzbl 0x2530(%eax),%eax
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
     542:	c7 45 f4 c0 1e 00 00 	movl   $0x1ec0,-0xc(%ebp)
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
     608:	a1 60 25 00 00       	mov    0x2560,%eax
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
     6d3:	a3 60 25 00 00       	mov    %eax,0x2560
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
     734:	a1 60 25 00 00       	mov    0x2560,%eax
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
     750:	a1 60 25 00 00       	mov    0x2560,%eax
     755:	89 45 f0             	mov    %eax,-0x10(%ebp)
     758:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     75c:	75 23                	jne    781 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     75e:	c7 45 f0 58 25 00 00 	movl   $0x2558,-0x10(%ebp)
     765:	8b 45 f0             	mov    -0x10(%ebp),%eax
     768:	a3 60 25 00 00       	mov    %eax,0x2560
     76d:	a1 60 25 00 00       	mov    0x2560,%eax
     772:	a3 58 25 00 00       	mov    %eax,0x2558
    base.s.size = 0;
     777:	c7 05 5c 25 00 00 00 	movl   $0x0,0x255c
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
     7d4:	a3 60 25 00 00       	mov    %eax,0x2560
      return (void*)(p + 1);
     7d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7dc:	83 c0 08             	add    $0x8,%eax
     7df:	eb 3b                	jmp    81c <malloc+0xe1>
    }
    if(p == freep)
     7e1:	a1 60 25 00 00       	mov    0x2560,%eax
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
     8f1:	56                   	push   %esi
     8f2:	53                   	push   %ebx
     8f3:	83 ec 70             	sub    $0x70,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     8f6:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     8fd:	8b 45 cc             	mov    -0x34(%ebp),%eax
     900:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     903:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     90a:	83 ec 08             	sub    $0x8,%esp
     90d:	6a 00                	push   $0x0
     90f:	ff 75 0c             	pushl  0xc(%ebp)
     912:	e8 f2 f9 ff ff       	call   309 <open>
     917:	83 c4 10             	add    $0x10,%esp
     91a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     91d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     921:	79 2e                	jns    951 <APLoadBitmap+0x63>
    {
        printf(1, "Cannot open %s\n", filename);
     923:	83 ec 04             	sub    $0x4,%esp
     926:	ff 75 0c             	pushl  0xc(%ebp)
     929:	68 c8 1e 00 00       	push   $0x1ec8
     92e:	6a 01                	push   $0x1
     930:	e8 33 fb ff ff       	call   468 <printf>
     935:	83 c4 10             	add    $0x10,%esp
        return bmp;
     938:	8b 45 08             	mov    0x8(%ebp),%eax
     93b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     93e:	89 10                	mov    %edx,(%eax)
     940:	8b 55 cc             	mov    -0x34(%ebp),%edx
     943:	89 50 04             	mov    %edx,0x4(%eax)
     946:	8b 55 d0             	mov    -0x30(%ebp),%edx
     949:	89 50 08             	mov    %edx,0x8(%eax)
     94c:	e9 1b 02 00 00       	jmp    b6c <APLoadBitmap+0x27e>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     951:	83 ec 04             	sub    $0x4,%esp
     954:	6a 10                	push   $0x10
     956:	8d 45 b8             	lea    -0x48(%ebp),%eax
     959:	50                   	push   %eax
     95a:	ff 75 ec             	pushl  -0x14(%ebp)
     95d:	e8 7f f9 ff ff       	call   2e1 <read>
     962:	83 c4 10             	add    $0x10,%esp
    printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
     965:	0f b7 45 c2          	movzwl -0x3e(%ebp),%eax
     969:	0f b7 f0             	movzwl %ax,%esi
     96c:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
     970:	0f b7 d8             	movzwl %ax,%ebx
     973:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
     976:	8b 55 bc             	mov    -0x44(%ebp),%edx
     979:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
     97d:	0f b7 c0             	movzwl %ax,%eax
     980:	83 ec 04             	sub    $0x4,%esp
     983:	56                   	push   %esi
     984:	53                   	push   %ebx
     985:	51                   	push   %ecx
     986:	52                   	push   %edx
     987:	50                   	push   %eax
     988:	68 d8 1e 00 00       	push   $0x1ed8
     98d:	6a 01                	push   $0x1
     98f:	e8 d4 fa ff ff       	call   468 <printf>
     994:	83 c4 20             	add    $0x20,%esp
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     997:	83 ec 04             	sub    $0x4,%esp
     99a:	6a 28                	push   $0x28
     99c:	8d 45 90             	lea    -0x70(%ebp),%eax
     99f:	50                   	push   %eax
     9a0:	ff 75 ec             	pushl  -0x14(%ebp)
     9a3:	e8 39 f9 ff ff       	call   2e1 <read>
     9a8:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     9ab:	8b 45 94             	mov    -0x6c(%ebp),%eax
     9ae:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     9b1:	8b 45 98             	mov    -0x68(%ebp),%eax
     9b4:	89 45 cc             	mov    %eax,-0x34(%ebp)
    printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
     9b7:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9ba:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9bd:	52                   	push   %edx
     9be:	50                   	push   %eax
     9bf:	68 e8 1e 00 00       	push   $0x1ee8
     9c4:	6a 01                	push   $0x1
     9c6:	e8 9d fa ff ff       	call   468 <printf>
     9cb:	83 c4 10             	add    $0x10,%esp
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     9ce:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9d1:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9d4:	0f af d0             	imul   %eax,%edx
     9d7:	89 d0                	mov    %edx,%eax
     9d9:	01 c0                	add    %eax,%eax
     9db:	01 d0                	add    %edx,%eax
     9dd:	83 ec 0c             	sub    $0xc,%esp
     9e0:	50                   	push   %eax
     9e1:	e8 55 fd ff ff       	call   73b <malloc>
     9e6:	83 c4 10             	add    $0x10,%esp
     9e9:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9ec:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     9f0:	0f b7 c0             	movzwl %ax,%eax
     9f3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9f6:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9fc:	0f af c2             	imul   %edx,%eax
     9ff:	83 c0 1f             	add    $0x1f,%eax
     a02:	c1 e8 05             	shr    $0x5,%eax
     a05:	c1 e0 02             	shl    $0x2,%eax
     a08:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     a0b:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a0e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a11:	0f af c2             	imul   %edx,%eax
     a14:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     a17:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a1a:	83 ec 0c             	sub    $0xc,%esp
     a1d:	50                   	push   %eax
     a1e:	e8 18 fd ff ff       	call   73b <malloc>
     a23:	83 c4 10             	add    $0x10,%esp
     a26:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a29:	83 ec 04             	sub    $0x4,%esp
     a2c:	ff 75 e0             	pushl  -0x20(%ebp)
     a2f:	ff 75 dc             	pushl  -0x24(%ebp)
     a32:	ff 75 ec             	pushl  -0x14(%ebp)
     a35:	e8 a7 f8 ff ff       	call   2e1 <read>
     a3a:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a3d:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     a41:	66 c1 e8 03          	shr    $0x3,%ax
     a45:	0f b7 c0             	movzwl %ax,%eax
     a48:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a4b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a52:	e9 e5 00 00 00       	jmp    b3c <APLoadBitmap+0x24e>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a57:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a5d:	29 c2                	sub    %eax,%edx
     a5f:	89 d0                	mov    %edx,%eax
     a61:	8d 50 ff             	lea    -0x1(%eax),%edx
     a64:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a67:	0f af c2             	imul   %edx,%eax
     a6a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a6d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a74:	e9 b1 00 00 00       	jmp    b2a <APLoadBitmap+0x23c>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a79:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a7c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a82:	01 c8                	add    %ecx,%eax
     a84:	89 c1                	mov    %eax,%ecx
     a86:	89 c8                	mov    %ecx,%eax
     a88:	01 c0                	add    %eax,%eax
     a8a:	01 c8                	add    %ecx,%eax
     a8c:	01 c2                	add    %eax,%edx
     a8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a91:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a95:	89 c1                	mov    %eax,%ecx
     a97:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a9a:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a9e:	01 c1                	add    %eax,%ecx
     aa0:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aa3:	01 c8                	add    %ecx,%eax
     aa5:	8d 48 ff             	lea    -0x1(%eax),%ecx
     aa8:	8b 45 dc             	mov    -0x24(%ebp),%eax
     aab:	01 c8                	add    %ecx,%eax
     aad:	0f b6 00             	movzbl (%eax),%eax
     ab0:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     ab3:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ab6:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ab9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     abc:	01 c8                	add    %ecx,%eax
     abe:	89 c1                	mov    %eax,%ecx
     ac0:	89 c8                	mov    %ecx,%eax
     ac2:	01 c0                	add    %eax,%eax
     ac4:	01 c8                	add    %ecx,%eax
     ac6:	01 c2                	add    %eax,%edx
     ac8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     acb:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     acf:	89 c1                	mov    %eax,%ecx
     ad1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ad4:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ad8:	01 c1                	add    %eax,%ecx
     ada:	8b 45 d8             	mov    -0x28(%ebp),%eax
     add:	01 c8                	add    %ecx,%eax
     adf:	8d 48 fe             	lea    -0x2(%eax),%ecx
     ae2:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ae5:	01 c8                	add    %ecx,%eax
     ae7:	0f b6 00             	movzbl (%eax),%eax
     aea:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     aed:	8b 55 d0             	mov    -0x30(%ebp),%edx
     af0:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     af3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     af6:	01 c8                	add    %ecx,%eax
     af8:	89 c1                	mov    %eax,%ecx
     afa:	89 c8                	mov    %ecx,%eax
     afc:	01 c0                	add    %eax,%eax
     afe:	01 c8                	add    %ecx,%eax
     b00:	01 c2                	add    %eax,%edx
     b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b05:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b09:	89 c1                	mov    %eax,%ecx
     b0b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b0e:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b12:	01 c1                	add    %eax,%ecx
     b14:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b17:	01 c8                	add    %ecx,%eax
     b19:	8d 48 fd             	lea    -0x3(%eax),%ecx
     b1c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b1f:	01 c8                	add    %ecx,%eax
     b21:	0f b6 00             	movzbl (%eax),%eax
     b24:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     b26:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b2a:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b30:	39 c2                	cmp    %eax,%edx
     b32:	0f 87 41 ff ff ff    	ja     a79 <APLoadBitmap+0x18b>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b38:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b3c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b42:	39 c2                	cmp    %eax,%edx
     b44:	0f 87 0d ff ff ff    	ja     a57 <APLoadBitmap+0x169>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b4a:	83 ec 0c             	sub    $0xc,%esp
     b4d:	ff 75 ec             	pushl  -0x14(%ebp)
     b50:	e8 9c f7 ff ff       	call   2f1 <close>
     b55:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b58:	8b 45 08             	mov    0x8(%ebp),%eax
     b5b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b5e:	89 10                	mov    %edx,(%eax)
     b60:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b63:	89 50 04             	mov    %edx,0x4(%eax)
     b66:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b69:	89 50 08             	mov    %edx,0x8(%eax)
}
     b6c:	8b 45 08             	mov    0x8(%ebp),%eax
     b6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
     b72:	5b                   	pop    %ebx
     b73:	5e                   	pop    %esi
     b74:	5d                   	pop    %ebp
     b75:	c2 04 00             	ret    $0x4

00000b78 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b78:	55                   	push   %ebp
     b79:	89 e5                	mov    %esp,%ebp
     b7b:	53                   	push   %ebx
     b7c:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b7f:	83 ec 0c             	sub    $0xc,%esp
     b82:	6a 1c                	push   $0x1c
     b84:	e8 b2 fb ff ff       	call   73b <malloc>
     b89:	83 c4 10             	add    $0x10,%esp
     b8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b92:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b99:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b9c:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b9f:	6a 0c                	push   $0xc
     ba1:	6a 0c                	push   $0xc
     ba3:	6a 0c                	push   $0xc
     ba5:	50                   	push   %eax
     ba6:	e8 73 fc ff ff       	call   81e <RGB>
     bab:	83 c4 0c             	add    $0xc,%esp
     bae:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     bb2:	66 89 43 13          	mov    %ax,0x13(%ebx)
     bb6:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     bba:	88 43 15             	mov    %al,0x15(%ebx)
     bbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc0:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bc3:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     bc7:	66 89 48 10          	mov    %cx,0x10(%eax)
     bcb:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     bcf:	88 50 12             	mov    %dl,0x12(%eax)
     bd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bd8:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     bdc:	66 89 48 08          	mov    %cx,0x8(%eax)
     be0:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     be4:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     be7:	8b 45 08             	mov    0x8(%ebp),%eax
     bea:	89 c2                	mov    %eax,%edx
     bec:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bef:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     bf1:	8b 45 0c             	mov    0xc(%ebp),%eax
     bf4:	89 c2                	mov    %eax,%edx
     bf6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bf9:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bfc:	8b 55 10             	mov    0x10(%ebp),%edx
     bff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c02:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "%d %d\n", hdc->size.cx, hdc->size.cy);
    return hdc;
     c05:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c08:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c0b:	c9                   	leave  
     c0c:	c3                   	ret    

00000c0d <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     c0d:	55                   	push   %ebp
     c0e:	89 e5                	mov    %esp,%ebp
     c10:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     c13:	8b 45 0c             	mov    0xc(%ebp),%eax
     c16:	8b 50 08             	mov    0x8(%eax),%edx
     c19:	89 55 f8             	mov    %edx,-0x8(%ebp)
     c1c:	8b 40 0c             	mov    0xc(%eax),%eax
     c1f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     c22:	8b 45 0c             	mov    0xc(%ebp),%eax
     c25:	8b 55 10             	mov    0x10(%ebp),%edx
     c28:	89 50 08             	mov    %edx,0x8(%eax)
     c2b:	8b 55 14             	mov    0x14(%ebp),%edx
     c2e:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c31:	8b 45 08             	mov    0x8(%ebp),%eax
     c34:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c37:	89 10                	mov    %edx,(%eax)
     c39:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c3c:	89 50 04             	mov    %edx,0x4(%eax)
}
     c3f:	8b 45 08             	mov    0x8(%ebp),%eax
     c42:	c9                   	leave  
     c43:	c2 04 00             	ret    $0x4

00000c46 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c46:	55                   	push   %ebp
     c47:	89 e5                	mov    %esp,%ebp
     c49:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c4c:	8b 45 0c             	mov    0xc(%ebp),%eax
     c4f:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c53:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c57:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c5b:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c5e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c61:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c65:	66 89 50 10          	mov    %dx,0x10(%eax)
     c69:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c6d:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c70:	8b 45 08             	mov    0x8(%ebp),%eax
     c73:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c77:	66 89 10             	mov    %dx,(%eax)
     c7a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c7e:	88 50 02             	mov    %dl,0x2(%eax)
}
     c81:	8b 45 08             	mov    0x8(%ebp),%eax
     c84:	c9                   	leave  
     c85:	c2 04 00             	ret    $0x4

00000c88 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c88:	55                   	push   %ebp
     c89:	89 e5                	mov    %esp,%ebp
     c8b:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c8e:	8b 45 08             	mov    0x8(%ebp),%eax
     c91:	8b 40 0c             	mov    0xc(%eax),%eax
     c94:	89 c2                	mov    %eax,%edx
     c96:	c1 ea 1f             	shr    $0x1f,%edx
     c99:	01 d0                	add    %edx,%eax
     c9b:	d1 f8                	sar    %eax
     c9d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     ca0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca3:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     ca7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     caa:	8b 45 10             	mov    0x10(%ebp),%eax
     cad:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cb0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     cb3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     cb7:	0f 89 98 00 00 00    	jns    d55 <APDrawPoint+0xcd>
        i = 0;
     cbd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     cc4:	e9 8c 00 00 00       	jmp    d55 <APDrawPoint+0xcd>
    {
        j = x - off;
     cc9:	8b 45 0c             	mov    0xc(%ebp),%eax
     ccc:	2b 45 f4             	sub    -0xc(%ebp),%eax
     ccf:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     cd2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     cd6:	79 69                	jns    d41 <APDrawPoint+0xb9>
            j = 0;
     cd8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     cdf:	eb 60                	jmp    d41 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     ce1:	ff 75 fc             	pushl  -0x4(%ebp)
     ce4:	ff 75 f8             	pushl  -0x8(%ebp)
     ce7:	ff 75 08             	pushl  0x8(%ebp)
     cea:	e8 ad fb ff ff       	call   89c <APGetIndex>
     cef:	83 c4 0c             	add    $0xc,%esp
     cf2:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     cf5:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cf9:	74 55                	je     d50 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cfb:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     cff:	74 67                	je     d68 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d01:	ff 75 10             	pushl  0x10(%ebp)
     d04:	ff 75 0c             	pushl  0xc(%ebp)
     d07:	ff 75 fc             	pushl  -0x4(%ebp)
     d0a:	ff 75 f8             	pushl  -0x8(%ebp)
     d0d:	e8 51 fb ff ff       	call   863 <distance_2>
     d12:	83 c4 10             	add    $0x10,%esp
     d15:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d18:	7f 23                	jg     d3d <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d1a:	8b 45 08             	mov    0x8(%ebp),%eax
     d1d:	8b 48 18             	mov    0x18(%eax),%ecx
     d20:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d23:	89 d0                	mov    %edx,%eax
     d25:	01 c0                	add    %eax,%eax
     d27:	01 d0                	add    %edx,%eax
     d29:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d2c:	8b 45 08             	mov    0x8(%ebp),%eax
     d2f:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d33:	66 89 0a             	mov    %cx,(%edx)
     d36:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d3a:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d3d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d41:	8b 55 0c             	mov    0xc(%ebp),%edx
     d44:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d47:	01 d0                	add    %edx,%eax
     d49:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d4c:	7d 93                	jge    ce1 <APDrawPoint+0x59>
     d4e:	eb 01                	jmp    d51 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d50:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d51:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d55:	8b 55 10             	mov    0x10(%ebp),%edx
     d58:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d5b:	01 d0                	add    %edx,%eax
     d5d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d60:	0f 8d 63 ff ff ff    	jge    cc9 <APDrawPoint+0x41>
     d66:	eb 01                	jmp    d69 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d68:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d69:	c9                   	leave  
     d6a:	c3                   	ret    

00000d6b <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d6b:	55                   	push   %ebp
     d6c:	89 e5                	mov    %esp,%ebp
     d6e:	53                   	push   %ebx
     d6f:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d72:	8b 45 0c             	mov    0xc(%ebp),%eax
     d75:	3b 45 14             	cmp    0x14(%ebp),%eax
     d78:	0f 85 80 00 00 00    	jne    dfe <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d7e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d82:	0f 88 9d 02 00 00    	js     1025 <APDrawLine+0x2ba>
     d88:	8b 45 08             	mov    0x8(%ebp),%eax
     d8b:	8b 00                	mov    (%eax),%eax
     d8d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d90:	0f 8e 8f 02 00 00    	jle    1025 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d96:	8b 45 10             	mov    0x10(%ebp),%eax
     d99:	3b 45 18             	cmp    0x18(%ebp),%eax
     d9c:	7e 12                	jle    db0 <APDrawLine+0x45>
        {
            int tmp = y2;
     d9e:	8b 45 18             	mov    0x18(%ebp),%eax
     da1:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     da4:	8b 45 10             	mov    0x10(%ebp),%eax
     da7:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     daa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dad:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     db0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     db4:	79 07                	jns    dbd <APDrawLine+0x52>
     db6:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     dbd:	8b 45 08             	mov    0x8(%ebp),%eax
     dc0:	8b 40 04             	mov    0x4(%eax),%eax
     dc3:	3b 45 18             	cmp    0x18(%ebp),%eax
     dc6:	7d 0c                	jge    dd4 <APDrawLine+0x69>
     dc8:	8b 45 08             	mov    0x8(%ebp),%eax
     dcb:	8b 40 04             	mov    0x4(%eax),%eax
     dce:	83 e8 01             	sub    $0x1,%eax
     dd1:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     dd4:	8b 45 10             	mov    0x10(%ebp),%eax
     dd7:	89 45 f4             	mov    %eax,-0xc(%ebp)
     dda:	eb 15                	jmp    df1 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     ddc:	ff 75 f4             	pushl  -0xc(%ebp)
     ddf:	ff 75 0c             	pushl  0xc(%ebp)
     de2:	ff 75 08             	pushl  0x8(%ebp)
     de5:	e8 9e fe ff ff       	call   c88 <APDrawPoint>
     dea:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     ded:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     df1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df4:	3b 45 18             	cmp    0x18(%ebp),%eax
     df7:	7e e3                	jle    ddc <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     df9:	e9 2b 02 00 00       	jmp    1029 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     dfe:	8b 45 10             	mov    0x10(%ebp),%eax
     e01:	3b 45 18             	cmp    0x18(%ebp),%eax
     e04:	75 7f                	jne    e85 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e06:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e0a:	0f 88 18 02 00 00    	js     1028 <APDrawLine+0x2bd>
     e10:	8b 45 08             	mov    0x8(%ebp),%eax
     e13:	8b 40 04             	mov    0x4(%eax),%eax
     e16:	3b 45 10             	cmp    0x10(%ebp),%eax
     e19:	0f 8e 09 02 00 00    	jle    1028 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e1f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e22:	3b 45 14             	cmp    0x14(%ebp),%eax
     e25:	7e 12                	jle    e39 <APDrawLine+0xce>
        {
            int tmp = x2;
     e27:	8b 45 14             	mov    0x14(%ebp),%eax
     e2a:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e2d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e30:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e33:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e36:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e39:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e3d:	79 07                	jns    e46 <APDrawLine+0xdb>
     e3f:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e46:	8b 45 08             	mov    0x8(%ebp),%eax
     e49:	8b 00                	mov    (%eax),%eax
     e4b:	3b 45 14             	cmp    0x14(%ebp),%eax
     e4e:	7d 0b                	jge    e5b <APDrawLine+0xf0>
     e50:	8b 45 08             	mov    0x8(%ebp),%eax
     e53:	8b 00                	mov    (%eax),%eax
     e55:	83 e8 01             	sub    $0x1,%eax
     e58:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e5b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e5e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e61:	eb 15                	jmp    e78 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e63:	ff 75 10             	pushl  0x10(%ebp)
     e66:	ff 75 f0             	pushl  -0x10(%ebp)
     e69:	ff 75 08             	pushl  0x8(%ebp)
     e6c:	e8 17 fe ff ff       	call   c88 <APDrawPoint>
     e71:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e74:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e78:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e7b:	3b 45 14             	cmp    0x14(%ebp),%eax
     e7e:	7e e3                	jle    e63 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e80:	e9 a4 01 00 00       	jmp    1029 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e85:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e8c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e93:	8b 45 0c             	mov    0xc(%ebp),%eax
     e96:	2b 45 14             	sub    0x14(%ebp),%eax
     e99:	50                   	push   %eax
     e9a:	e8 ed f9 ff ff       	call   88c <abs_int>
     e9f:	83 c4 04             	add    $0x4,%esp
     ea2:	89 c3                	mov    %eax,%ebx
     ea4:	8b 45 10             	mov    0x10(%ebp),%eax
     ea7:	2b 45 18             	sub    0x18(%ebp),%eax
     eaa:	50                   	push   %eax
     eab:	e8 dc f9 ff ff       	call   88c <abs_int>
     eb0:	83 c4 04             	add    $0x4,%esp
     eb3:	39 c3                	cmp    %eax,%ebx
     eb5:	0f 8e b5 00 00 00    	jle    f70 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     ebb:	8b 45 10             	mov    0x10(%ebp),%eax
     ebe:	2b 45 18             	sub    0x18(%ebp),%eax
     ec1:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ec4:	db 45 b0             	fildl  -0x50(%ebp)
     ec7:	8b 45 0c             	mov    0xc(%ebp),%eax
     eca:	2b 45 14             	sub    0x14(%ebp),%eax
     ecd:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ed0:	db 45 b0             	fildl  -0x50(%ebp)
     ed3:	de f9                	fdivrp %st,%st(1)
     ed5:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     ed8:	8b 45 14             	mov    0x14(%ebp),%eax
     edb:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ede:	7e 0e                	jle    eee <APDrawLine+0x183>
        {
            s = x1;
     ee0:	8b 45 0c             	mov    0xc(%ebp),%eax
     ee3:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     ee6:	8b 45 14             	mov    0x14(%ebp),%eax
     ee9:	89 45 e8             	mov    %eax,-0x18(%ebp)
     eec:	eb 0c                	jmp    efa <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     eee:	8b 45 14             	mov    0x14(%ebp),%eax
     ef1:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     ef4:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef7:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     efa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     efe:	79 07                	jns    f07 <APDrawLine+0x19c>
     f00:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f07:	8b 45 08             	mov    0x8(%ebp),%eax
     f0a:	8b 00                	mov    (%eax),%eax
     f0c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f0f:	7f 0b                	jg     f1c <APDrawLine+0x1b1>
     f11:	8b 45 08             	mov    0x8(%ebp),%eax
     f14:	8b 00                	mov    (%eax),%eax
     f16:	83 e8 01             	sub    $0x1,%eax
     f19:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f1c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f1f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f22:	eb 3f                	jmp    f63 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f24:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f27:	2b 45 0c             	sub    0xc(%ebp),%eax
     f2a:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f2d:	db 45 b0             	fildl  -0x50(%ebp)
     f30:	dc 4d d0             	fmull  -0x30(%ebp)
     f33:	db 45 10             	fildl  0x10(%ebp)
     f36:	de c1                	faddp  %st,%st(1)
     f38:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f3b:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f3f:	b4 0c                	mov    $0xc,%ah
     f41:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f45:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f48:	db 5d cc             	fistpl -0x34(%ebp)
     f4b:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f4e:	ff 75 cc             	pushl  -0x34(%ebp)
     f51:	ff 75 e4             	pushl  -0x1c(%ebp)
     f54:	ff 75 08             	pushl  0x8(%ebp)
     f57:	e8 2c fd ff ff       	call   c88 <APDrawPoint>
     f5c:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f5f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f63:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f66:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f69:	7e b9                	jle    f24 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f6b:	e9 b9 00 00 00       	jmp    1029 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f70:	8b 45 0c             	mov    0xc(%ebp),%eax
     f73:	2b 45 14             	sub    0x14(%ebp),%eax
     f76:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f79:	db 45 b0             	fildl  -0x50(%ebp)
     f7c:	8b 45 10             	mov    0x10(%ebp),%eax
     f7f:	2b 45 18             	sub    0x18(%ebp),%eax
     f82:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f85:	db 45 b0             	fildl  -0x50(%ebp)
     f88:	de f9                	fdivrp %st,%st(1)
     f8a:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f8d:	8b 45 10             	mov    0x10(%ebp),%eax
     f90:	3b 45 18             	cmp    0x18(%ebp),%eax
     f93:	7e 0e                	jle    fa3 <APDrawLine+0x238>
    {
        s = y2;
     f95:	8b 45 18             	mov    0x18(%ebp),%eax
     f98:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f9b:	8b 45 10             	mov    0x10(%ebp),%eax
     f9e:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fa1:	eb 0c                	jmp    faf <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     fa3:	8b 45 10             	mov    0x10(%ebp),%eax
     fa6:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     fa9:	8b 45 18             	mov    0x18(%ebp),%eax
     fac:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     faf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fb3:	79 07                	jns    fbc <APDrawLine+0x251>
     fb5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     fbc:	8b 45 08             	mov    0x8(%ebp),%eax
     fbf:	8b 40 04             	mov    0x4(%eax),%eax
     fc2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fc5:	7f 0c                	jg     fd3 <APDrawLine+0x268>
     fc7:	8b 45 08             	mov    0x8(%ebp),%eax
     fca:	8b 40 04             	mov    0x4(%eax),%eax
     fcd:	83 e8 01             	sub    $0x1,%eax
     fd0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     fd3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fd6:	89 45 e0             	mov    %eax,-0x20(%ebp)
     fd9:	eb 3f                	jmp    101a <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     fdb:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fde:	2b 45 10             	sub    0x10(%ebp),%eax
     fe1:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fe4:	db 45 b0             	fildl  -0x50(%ebp)
     fe7:	dc 4d c0             	fmull  -0x40(%ebp)
     fea:	db 45 0c             	fildl  0xc(%ebp)
     fed:	de c1                	faddp  %st,%st(1)
     fef:	d9 7d b6             	fnstcw -0x4a(%ebp)
     ff2:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     ff6:	b4 0c                	mov    $0xc,%ah
     ff8:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     ffc:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fff:	db 5d bc             	fistpl -0x44(%ebp)
    1002:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1005:	ff 75 e0             	pushl  -0x20(%ebp)
    1008:	ff 75 bc             	pushl  -0x44(%ebp)
    100b:	ff 75 08             	pushl  0x8(%ebp)
    100e:	e8 75 fc ff ff       	call   c88 <APDrawPoint>
    1013:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1016:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    101a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    101d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1020:	7e b9                	jle    fdb <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1022:	90                   	nop
    1023:	eb 04                	jmp    1029 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1025:	90                   	nop
    1026:	eb 01                	jmp    1029 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1028:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1029:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    102c:	c9                   	leave  
    102d:	c3                   	ret    

0000102e <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    102e:	55                   	push   %ebp
    102f:	89 e5                	mov    %esp,%ebp
    1031:	53                   	push   %ebx
    1032:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1035:	8b 55 10             	mov    0x10(%ebp),%edx
    1038:	8b 45 18             	mov    0x18(%ebp),%eax
    103b:	01 d0                	add    %edx,%eax
    103d:	83 e8 01             	sub    $0x1,%eax
    1040:	83 ec 04             	sub    $0x4,%esp
    1043:	50                   	push   %eax
    1044:	ff 75 0c             	pushl  0xc(%ebp)
    1047:	ff 75 10             	pushl  0x10(%ebp)
    104a:	ff 75 0c             	pushl  0xc(%ebp)
    104d:	ff 75 08             	pushl  0x8(%ebp)
    1050:	e8 16 fd ff ff       	call   d6b <APDrawLine>
    1055:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1058:	8b 55 0c             	mov    0xc(%ebp),%edx
    105b:	8b 45 14             	mov    0x14(%ebp),%eax
    105e:	01 d0                	add    %edx,%eax
    1060:	83 e8 01             	sub    $0x1,%eax
    1063:	83 ec 04             	sub    $0x4,%esp
    1066:	ff 75 10             	pushl  0x10(%ebp)
    1069:	50                   	push   %eax
    106a:	ff 75 10             	pushl  0x10(%ebp)
    106d:	ff 75 0c             	pushl  0xc(%ebp)
    1070:	ff 75 08             	pushl  0x8(%ebp)
    1073:	e8 f3 fc ff ff       	call   d6b <APDrawLine>
    1078:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    107b:	8b 55 10             	mov    0x10(%ebp),%edx
    107e:	8b 45 18             	mov    0x18(%ebp),%eax
    1081:	01 d0                	add    %edx,%eax
    1083:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1086:	8b 55 0c             	mov    0xc(%ebp),%edx
    1089:	8b 45 14             	mov    0x14(%ebp),%eax
    108c:	01 d0                	add    %edx,%eax
    108e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1091:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1094:	8b 45 14             	mov    0x14(%ebp),%eax
    1097:	01 d8                	add    %ebx,%eax
    1099:	83 e8 01             	sub    $0x1,%eax
    109c:	83 ec 04             	sub    $0x4,%esp
    109f:	51                   	push   %ecx
    10a0:	52                   	push   %edx
    10a1:	ff 75 10             	pushl  0x10(%ebp)
    10a4:	50                   	push   %eax
    10a5:	ff 75 08             	pushl  0x8(%ebp)
    10a8:	e8 be fc ff ff       	call   d6b <APDrawLine>
    10ad:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10b0:	8b 55 10             	mov    0x10(%ebp),%edx
    10b3:	8b 45 18             	mov    0x18(%ebp),%eax
    10b6:	01 d0                	add    %edx,%eax
    10b8:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10bb:	8b 55 0c             	mov    0xc(%ebp),%edx
    10be:	8b 45 14             	mov    0x14(%ebp),%eax
    10c1:	01 d0                	add    %edx,%eax
    10c3:	8d 50 ff             	lea    -0x1(%eax),%edx
    10c6:	8b 5d 10             	mov    0x10(%ebp),%ebx
    10c9:	8b 45 18             	mov    0x18(%ebp),%eax
    10cc:	01 d8                	add    %ebx,%eax
    10ce:	83 e8 01             	sub    $0x1,%eax
    10d1:	83 ec 04             	sub    $0x4,%esp
    10d4:	51                   	push   %ecx
    10d5:	52                   	push   %edx
    10d6:	50                   	push   %eax
    10d7:	ff 75 0c             	pushl  0xc(%ebp)
    10da:	ff 75 08             	pushl  0x8(%ebp)
    10dd:	e8 89 fc ff ff       	call   d6b <APDrawLine>
    10e2:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10e5:	8b 55 0c             	mov    0xc(%ebp),%edx
    10e8:	8b 45 14             	mov    0x14(%ebp),%eax
    10eb:	01 d0                	add    %edx,%eax
    10ed:	8d 50 ff             	lea    -0x1(%eax),%edx
    10f0:	8b 45 08             	mov    0x8(%ebp),%eax
    10f3:	8b 40 0c             	mov    0xc(%eax),%eax
    10f6:	89 c1                	mov    %eax,%ecx
    10f8:	c1 e9 1f             	shr    $0x1f,%ecx
    10fb:	01 c8                	add    %ecx,%eax
    10fd:	d1 f8                	sar    %eax
    10ff:	29 c2                	sub    %eax,%edx
    1101:	89 d0                	mov    %edx,%eax
    1103:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1106:	8b 55 10             	mov    0x10(%ebp),%edx
    1109:	8b 45 18             	mov    0x18(%ebp),%eax
    110c:	01 d0                	add    %edx,%eax
    110e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1111:	8b 45 08             	mov    0x8(%ebp),%eax
    1114:	8b 40 0c             	mov    0xc(%eax),%eax
    1117:	89 c1                	mov    %eax,%ecx
    1119:	c1 e9 1f             	shr    $0x1f,%ecx
    111c:	01 c8                	add    %ecx,%eax
    111e:	d1 f8                	sar    %eax
    1120:	29 c2                	sub    %eax,%edx
    1122:	89 d0                	mov    %edx,%eax
    1124:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1127:	8b 45 08             	mov    0x8(%ebp),%eax
    112a:	8b 40 0c             	mov    0xc(%eax),%eax
    112d:	89 c2                	mov    %eax,%edx
    112f:	c1 ea 1f             	shr    $0x1f,%edx
    1132:	01 d0                	add    %edx,%eax
    1134:	d1 f8                	sar    %eax
    1136:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1139:	8b 45 08             	mov    0x8(%ebp),%eax
    113c:	8b 40 0c             	mov    0xc(%eax),%eax
    113f:	89 c2                	mov    %eax,%edx
    1141:	c1 ea 1f             	shr    $0x1f,%edx
    1144:	01 d0                	add    %edx,%eax
    1146:	d1 f8                	sar    %eax
    1148:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    114b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    114f:	0f 88 d8 00 00 00    	js     122d <APDrawRect+0x1ff>
    1155:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1159:	0f 88 ce 00 00 00    	js     122d <APDrawRect+0x1ff>
    115f:	8b 45 08             	mov    0x8(%ebp),%eax
    1162:	8b 00                	mov    (%eax),%eax
    1164:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1167:	0f 8e c0 00 00 00    	jle    122d <APDrawRect+0x1ff>
    116d:	8b 45 08             	mov    0x8(%ebp),%eax
    1170:	8b 40 04             	mov    0x4(%eax),%eax
    1173:	3b 45 10             	cmp    0x10(%ebp),%eax
    1176:	0f 8e b1 00 00 00    	jle    122d <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    117c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1180:	79 07                	jns    1189 <APDrawRect+0x15b>
    1182:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1189:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    118d:	79 07                	jns    1196 <APDrawRect+0x168>
    118f:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1196:	8b 45 08             	mov    0x8(%ebp),%eax
    1199:	8b 00                	mov    (%eax),%eax
    119b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    119e:	7f 0b                	jg     11ab <APDrawRect+0x17d>
    11a0:	8b 45 08             	mov    0x8(%ebp),%eax
    11a3:	8b 00                	mov    (%eax),%eax
    11a5:	83 e8 01             	sub    $0x1,%eax
    11a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    11ab:	8b 45 08             	mov    0x8(%ebp),%eax
    11ae:	8b 40 04             	mov    0x4(%eax),%eax
    11b1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11b4:	7f 0c                	jg     11c2 <APDrawRect+0x194>
    11b6:	8b 45 08             	mov    0x8(%ebp),%eax
    11b9:	8b 40 04             	mov    0x4(%eax),%eax
    11bc:	83 e8 01             	sub    $0x1,%eax
    11bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    11c2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    11cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11cf:	eb 52                	jmp    1223 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    11d1:	8b 45 10             	mov    0x10(%ebp),%eax
    11d4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11d7:	eb 3e                	jmp    1217 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    11d9:	83 ec 04             	sub    $0x4,%esp
    11dc:	ff 75 e8             	pushl  -0x18(%ebp)
    11df:	ff 75 ec             	pushl  -0x14(%ebp)
    11e2:	ff 75 08             	pushl  0x8(%ebp)
    11e5:	e8 b2 f6 ff ff       	call   89c <APGetIndex>
    11ea:	83 c4 10             	add    $0x10,%esp
    11ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11f0:	8b 45 08             	mov    0x8(%ebp),%eax
    11f3:	8b 48 18             	mov    0x18(%eax),%ecx
    11f6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11f9:	89 d0                	mov    %edx,%eax
    11fb:	01 c0                	add    %eax,%eax
    11fd:	01 d0                	add    %edx,%eax
    11ff:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1202:	8b 45 08             	mov    0x8(%ebp),%eax
    1205:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1209:	66 89 0a             	mov    %cx,(%edx)
    120c:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1210:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1213:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1217:	8b 45 e8             	mov    -0x18(%ebp),%eax
    121a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    121d:	7e ba                	jle    11d9 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    121f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1223:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1226:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1229:	7e a6                	jle    11d1 <APDrawRect+0x1a3>
    122b:	eb 01                	jmp    122e <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    122d:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    122e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1231:	c9                   	leave  
    1232:	c3                   	ret    

00001233 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1233:	55                   	push   %ebp
    1234:	89 e5                	mov    %esp,%ebp
    1236:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1239:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    123d:	0f 88 8e 01 00 00    	js     13d1 <APDcCopy+0x19e>
    1243:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1247:	0f 88 84 01 00 00    	js     13d1 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    124d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1250:	8b 45 20             	mov    0x20(%ebp),%eax
    1253:	01 d0                	add    %edx,%eax
    1255:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1258:	8b 55 10             	mov    0x10(%ebp),%edx
    125b:	8b 45 24             	mov    0x24(%ebp),%eax
    125e:	01 d0                	add    %edx,%eax
    1260:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w, y_r = y + h;
    1263:	8b 55 18             	mov    0x18(%ebp),%edx
    1266:	8b 45 20             	mov    0x20(%ebp),%eax
    1269:	01 d0                	add    %edx,%eax
    126b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    126e:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1271:	8b 45 24             	mov    0x24(%ebp),%eax
    1274:	01 d0                	add    %edx,%eax
    1276:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
    1279:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    127d:	0f 88 51 01 00 00    	js     13d4 <APDcCopy+0x1a1>
    1283:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1287:	0f 88 47 01 00 00    	js     13d4 <APDcCopy+0x1a1>
    128d:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1291:	0f 88 3d 01 00 00    	js     13d4 <APDcCopy+0x1a1>
    1297:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    129b:	0f 88 33 01 00 00    	js     13d4 <APDcCopy+0x1a1>
    12a1:	8b 45 14             	mov    0x14(%ebp),%eax
    12a4:	8b 00                	mov    (%eax),%eax
    12a6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    12a9:	0f 8e 25 01 00 00    	jle    13d4 <APDcCopy+0x1a1>
    12af:	8b 45 14             	mov    0x14(%ebp),%eax
    12b2:	8b 40 04             	mov    0x4(%eax),%eax
    12b5:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12b8:	0f 8e 16 01 00 00    	jle    13d4 <APDcCopy+0x1a1>
        return;
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    12be:	8b 45 08             	mov    0x8(%ebp),%eax
    12c1:	8b 00                	mov    (%eax),%eax
    12c3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    12c6:	7d 0b                	jge    12d3 <APDcCopy+0xa0>
    12c8:	8b 45 08             	mov    0x8(%ebp),%eax
    12cb:	8b 00                	mov    (%eax),%eax
    12cd:	83 e8 01             	sub    $0x1,%eax
    12d0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    12d3:	8b 45 08             	mov    0x8(%ebp),%eax
    12d6:	8b 40 04             	mov    0x4(%eax),%eax
    12d9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12dc:	7d 0c                	jge    12ea <APDcCopy+0xb7>
    12de:	8b 45 08             	mov    0x8(%ebp),%eax
    12e1:	8b 40 04             	mov    0x4(%eax),%eax
    12e4:	83 e8 01             	sub    $0x1,%eax
    12e7:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    12ea:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12f1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j < wy_r - wy; j++)
    12f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12ff:	e9 bc 00 00 00       	jmp    13c0 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1304:	8b 45 08             	mov    0x8(%ebp),%eax
    1307:	8b 00                	mov    (%eax),%eax
    1309:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    130c:	8b 55 10             	mov    0x10(%ebp),%edx
    130f:	01 ca                	add    %ecx,%edx
    1311:	0f af d0             	imul   %eax,%edx
    1314:	8b 45 0c             	mov    0xc(%ebp),%eax
    1317:	01 d0                	add    %edx,%eax
    1319:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    131c:	8b 45 14             	mov    0x14(%ebp),%eax
    131f:	8b 00                	mov    (%eax),%eax
    1321:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1324:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1327:	01 ca                	add    %ecx,%edx
    1329:	0f af d0             	imul   %eax,%edx
    132c:	8b 45 18             	mov    0x18(%ebp),%eax
    132f:	01 d0                	add    %edx,%eax
    1331:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i < wx_r - wx; i++)
    1334:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    133b:	eb 74                	jmp    13b1 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    133d:	8b 45 14             	mov    0x14(%ebp),%eax
    1340:	8b 50 18             	mov    0x18(%eax),%edx
    1343:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1346:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1349:	01 c8                	add    %ecx,%eax
    134b:	89 c1                	mov    %eax,%ecx
    134d:	89 c8                	mov    %ecx,%eax
    134f:	01 c0                	add    %eax,%eax
    1351:	01 c8                	add    %ecx,%eax
    1353:	01 d0                	add    %edx,%eax
    1355:	0f b7 10             	movzwl (%eax),%edx
    1358:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    135c:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1360:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1363:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1367:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    136b:	38 c2                	cmp    %al,%dl
    136d:	75 18                	jne    1387 <APDcCopy+0x154>
    136f:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1373:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1377:	38 c2                	cmp    %al,%dl
    1379:	75 0c                	jne    1387 <APDcCopy+0x154>
    137b:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    137f:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1383:	38 c2                	cmp    %al,%dl
    1385:	74 26                	je     13ad <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1387:	8b 45 08             	mov    0x8(%ebp),%eax
    138a:	8b 50 18             	mov    0x18(%eax),%edx
    138d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1390:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1393:	01 c8                	add    %ecx,%eax
    1395:	89 c1                	mov    %eax,%ecx
    1397:	89 c8                	mov    %ecx,%eax
    1399:	01 c0                	add    %eax,%eax
    139b:	01 c8                	add    %ecx,%eax
    139d:	01 d0                	add    %edx,%eax
    139f:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    13a3:	66 89 10             	mov    %dx,(%eax)
    13a6:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13aa:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i < wx_r - wx; i++)
    13ad:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    13b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13b4:	2b 45 0c             	sub    0xc(%ebp),%eax
    13b7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    13ba:	7f 81                	jg     133d <APDcCopy+0x10a>
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    13bc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    13c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13c3:	2b 45 10             	sub    0x10(%ebp),%eax
    13c6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    13c9:	0f 8f 35 ff ff ff    	jg     1304 <APDcCopy+0xd1>
    13cf:	eb 04                	jmp    13d5 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    13d1:	90                   	nop
    13d2:	eb 01                	jmp    13d5 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w, y_r = y + h;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
        return;
    13d4:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    13d5:	c9                   	leave  
    13d6:	c3                   	ret    

000013d7 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    13d7:	55                   	push   %ebp
    13d8:	89 e5                	mov    %esp,%ebp
    13da:	83 ec 1c             	sub    $0x1c,%esp
    13dd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    13e0:	8b 55 10             	mov    0x10(%ebp),%edx
    13e3:	8b 45 14             	mov    0x14(%ebp),%eax
    13e6:	88 4d ec             	mov    %cl,-0x14(%ebp)
    13e9:	88 55 e8             	mov    %dl,-0x18(%ebp)
    13ec:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    13ef:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13f3:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13f6:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13fa:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13fd:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1401:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1404:	8b 45 08             	mov    0x8(%ebp),%eax
    1407:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    140b:	66 89 10             	mov    %dx,(%eax)
    140e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1412:	88 50 02             	mov    %dl,0x2(%eax)
}
    1415:	8b 45 08             	mov    0x8(%ebp),%eax
    1418:	c9                   	leave  
    1419:	c2 04 00             	ret    $0x4

0000141c <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    141c:	55                   	push   %ebp
    141d:	89 e5                	mov    %esp,%ebp
    141f:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1422:	8b 45 08             	mov    0x8(%ebp),%eax
    1425:	8b 00                	mov    (%eax),%eax
    1427:	83 ec 08             	sub    $0x8,%esp
    142a:	8d 55 0c             	lea    0xc(%ebp),%edx
    142d:	52                   	push   %edx
    142e:	50                   	push   %eax
    142f:	e8 45 ef ff ff       	call   379 <sendMessage>
    1434:	83 c4 10             	add    $0x10,%esp
}
    1437:	90                   	nop
    1438:	c9                   	leave  
    1439:	c3                   	ret    

0000143a <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    143a:	55                   	push   %ebp
    143b:	89 e5                	mov    %esp,%ebp
    143d:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1440:	83 ec 0c             	sub    $0xc,%esp
    1443:	68 90 00 00 00       	push   $0x90
    1448:	e8 ee f2 ff ff       	call   73b <malloc>
    144d:	83 c4 10             	add    $0x10,%esp
    1450:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1453:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1457:	75 15                	jne    146e <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1459:	83 ec 04             	sub    $0x4,%esp
    145c:	ff 75 08             	pushl  0x8(%ebp)
    145f:	68 0c 1f 00 00       	push   $0x1f0c
    1464:	6a 01                	push   $0x1
    1466:	e8 fd ef ff ff       	call   468 <printf>
    146b:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    146e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1471:	83 c0 7c             	add    $0x7c,%eax
    1474:	83 ec 08             	sub    $0x8,%esp
    1477:	ff 75 08             	pushl  0x8(%ebp)
    147a:	50                   	push   %eax
    147b:	e8 18 ec ff ff       	call   98 <strcpy>
    1480:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1483:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1486:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    148d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1490:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1497:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149a:	8b 40 34             	mov    0x34(%eax),%eax
    149d:	89 c2                	mov    %eax,%edx
    149f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a2:	8b 40 38             	mov    0x38(%eax),%eax
    14a5:	0f af d0             	imul   %eax,%edx
    14a8:	89 d0                	mov    %edx,%eax
    14aa:	01 c0                	add    %eax,%eax
    14ac:	01 d0                	add    %edx,%eax
    14ae:	83 ec 0c             	sub    $0xc,%esp
    14b1:	50                   	push   %eax
    14b2:	e8 84 f2 ff ff       	call   73b <malloc>
    14b7:	83 c4 10             	add    $0x10,%esp
    14ba:	89 c2                	mov    %eax,%edx
    14bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14bf:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    14c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c5:	8b 40 4c             	mov    0x4c(%eax),%eax
    14c8:	85 c0                	test   %eax,%eax
    14ca:	75 15                	jne    14e1 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    14cc:	83 ec 04             	sub    $0x4,%esp
    14cf:	ff 75 08             	pushl  0x8(%ebp)
    14d2:	68 2c 1f 00 00       	push   $0x1f2c
    14d7:	6a 01                	push   $0x1
    14d9:	e8 8a ef ff ff       	call   468 <printf>
    14de:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e4:	8b 40 34             	mov    0x34(%eax),%eax
    14e7:	89 c2                	mov    %eax,%edx
    14e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ec:	8b 40 38             	mov    0x38(%eax),%eax
    14ef:	0f af d0             	imul   %eax,%edx
    14f2:	89 d0                	mov    %edx,%eax
    14f4:	01 c0                	add    %eax,%eax
    14f6:	01 c2                	add    %eax,%edx
    14f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14fb:	8b 40 4c             	mov    0x4c(%eax),%eax
    14fe:	83 ec 04             	sub    $0x4,%esp
    1501:	52                   	push   %edx
    1502:	68 ff ff ff 00       	push   $0xffffff
    1507:	50                   	push   %eax
    1508:	e8 21 ec ff ff       	call   12e <memset>
    150d:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1510:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1513:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    151a:	e8 2a ee ff ff       	call   349 <getpid>
    151f:	89 c2                	mov    %eax,%edx
    1521:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1524:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1527:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152a:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1531:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1534:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    153b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153e:	8b 40 50             	mov    0x50(%eax),%eax
    1541:	89 c2                	mov    %eax,%edx
    1543:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1546:	8b 40 54             	mov    0x54(%eax),%eax
    1549:	0f af d0             	imul   %eax,%edx
    154c:	89 d0                	mov    %edx,%eax
    154e:	01 c0                	add    %eax,%eax
    1550:	01 d0                	add    %edx,%eax
    1552:	83 ec 0c             	sub    $0xc,%esp
    1555:	50                   	push   %eax
    1556:	e8 e0 f1 ff ff       	call   73b <malloc>
    155b:	83 c4 10             	add    $0x10,%esp
    155e:	89 c2                	mov    %eax,%edx
    1560:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1563:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    1566:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1569:	8b 40 68             	mov    0x68(%eax),%eax
    156c:	85 c0                	test   %eax,%eax
    156e:	75 15                	jne    1585 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1570:	83 ec 04             	sub    $0x4,%esp
    1573:	ff 75 08             	pushl  0x8(%ebp)
    1576:	68 50 1f 00 00       	push   $0x1f50
    157b:	6a 01                	push   $0x1
    157d:	e8 e6 ee ff ff       	call   468 <printf>
    1582:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1585:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1588:	8b 40 34             	mov    0x34(%eax),%eax
    158b:	89 c2                	mov    %eax,%edx
    158d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1590:	8b 40 38             	mov    0x38(%eax),%eax
    1593:	0f af d0             	imul   %eax,%edx
    1596:	89 d0                	mov    %edx,%eax
    1598:	01 c0                	add    %eax,%eax
    159a:	01 c2                	add    %eax,%edx
    159c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159f:	8b 40 4c             	mov    0x4c(%eax),%eax
    15a2:	83 ec 04             	sub    $0x4,%esp
    15a5:	52                   	push   %edx
    15a6:	68 ff 00 00 00       	push   $0xff
    15ab:	50                   	push   %eax
    15ac:	e8 7d eb ff ff       	call   12e <memset>
    15b1:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    15b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b7:	8b 55 0c             	mov    0xc(%ebp),%edx
    15ba:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    15bd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    15c1:	74 35                	je     15f8 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    15c3:	8b 45 10             	mov    0x10(%ebp),%eax
    15c6:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    15cc:	83 ec 0c             	sub    $0xc,%esp
    15cf:	50                   	push   %eax
    15d0:	e8 66 f1 ff ff       	call   73b <malloc>
    15d5:	83 c4 10             	add    $0x10,%esp
    15d8:	89 c2                	mov    %eax,%edx
    15da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15dd:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    15e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e3:	8b 55 10             	mov    0x10(%ebp),%edx
    15e6:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    15e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ec:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    15f3:	e9 8d 00 00 00       	jmp    1685 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15fb:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1602:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1605:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    160c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160f:	8b 40 18             	mov    0x18(%eax),%eax
    1612:	89 c2                	mov    %eax,%edx
    1614:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1617:	8b 40 1c             	mov    0x1c(%eax),%eax
    161a:	0f af d0             	imul   %eax,%edx
    161d:	89 d0                	mov    %edx,%eax
    161f:	01 c0                	add    %eax,%eax
    1621:	01 d0                	add    %edx,%eax
    1623:	83 ec 0c             	sub    $0xc,%esp
    1626:	50                   	push   %eax
    1627:	e8 0f f1 ff ff       	call   73b <malloc>
    162c:	83 c4 10             	add    $0x10,%esp
    162f:	89 c2                	mov    %eax,%edx
    1631:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1634:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    1637:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163a:	8b 40 30             	mov    0x30(%eax),%eax
    163d:	85 c0                	test   %eax,%eax
    163f:	75 15                	jne    1656 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1641:	83 ec 04             	sub    $0x4,%esp
    1644:	ff 75 08             	pushl  0x8(%ebp)
    1647:	68 78 1f 00 00       	push   $0x1f78
    164c:	6a 01                	push   $0x1
    164e:	e8 15 ee ff ff       	call   468 <printf>
    1653:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1656:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1659:	8b 40 18             	mov    0x18(%eax),%eax
    165c:	89 c2                	mov    %eax,%edx
    165e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1661:	8b 40 1c             	mov    0x1c(%eax),%eax
    1664:	0f af d0             	imul   %eax,%edx
    1667:	89 d0                	mov    %edx,%eax
    1669:	01 c0                	add    %eax,%eax
    166b:	01 c2                	add    %eax,%edx
    166d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1670:	8b 40 30             	mov    0x30(%eax),%eax
    1673:	83 ec 04             	sub    $0x4,%esp
    1676:	52                   	push   %edx
    1677:	68 ff ff ff 00       	push   $0xffffff
    167c:	50                   	push   %eax
    167d:	e8 ac ea ff ff       	call   12e <memset>
    1682:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1685:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1688:	c9                   	leave  
    1689:	c3                   	ret    

0000168a <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    168a:	55                   	push   %ebp
    168b:	89 e5                	mov    %esp,%ebp
    168d:	53                   	push   %ebx
    168e:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1691:	8b 45 0c             	mov    0xc(%ebp),%eax
    1694:	83 f8 03             	cmp    $0x3,%eax
    1697:	74 02                	je     169b <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1699:	eb 33                	jmp    16ce <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    169b:	8b 45 08             	mov    0x8(%ebp),%eax
    169e:	8b 48 08             	mov    0x8(%eax),%ecx
    16a1:	8b 45 08             	mov    0x8(%ebp),%eax
    16a4:	8b 50 38             	mov    0x38(%eax),%edx
    16a7:	8b 45 08             	mov    0x8(%ebp),%eax
    16aa:	8b 40 34             	mov    0x34(%eax),%eax
    16ad:	8b 5d 08             	mov    0x8(%ebp),%ebx
    16b0:	83 c3 34             	add    $0x34,%ebx
    16b3:	83 ec 0c             	sub    $0xc,%esp
    16b6:	51                   	push   %ecx
    16b7:	52                   	push   %edx
    16b8:	50                   	push   %eax
    16b9:	6a 00                	push   $0x0
    16bb:	6a 00                	push   $0x0
    16bd:	53                   	push   %ebx
    16be:	6a 32                	push   $0x32
    16c0:	6a 00                	push   $0x0
    16c2:	ff 75 08             	pushl  0x8(%ebp)
    16c5:	e8 9f ec ff ff       	call   369 <paintWindow>
    16ca:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    16cd:	90                   	nop
        default: break;
            
            
    }
    return False;
    16ce:	b8 00 00 00 00       	mov    $0x0,%eax
}
    16d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    16d6:	c9                   	leave  
    16d7:	c3                   	ret    

000016d8 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    16d8:	55                   	push   %ebp
    16d9:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    16db:	8b 45 0c             	mov    0xc(%ebp),%eax
    16de:	8b 50 08             	mov    0x8(%eax),%edx
    16e1:	8b 45 08             	mov    0x8(%ebp),%eax
    16e4:	8b 00                	mov    (%eax),%eax
    16e6:	39 c2                	cmp    %eax,%edx
    16e8:	74 07                	je     16f1 <APPreJudge+0x19>
        return False;
    16ea:	b8 00 00 00 00       	mov    $0x0,%eax
    16ef:	eb 05                	jmp    16f6 <APPreJudge+0x1e>
    return True;
    16f1:	b8 01 00 00 00       	mov    $0x1,%eax
}
    16f6:	5d                   	pop    %ebp
    16f7:	c3                   	ret    

000016f8 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    16f8:	55                   	push   %ebp
    16f9:	89 e5                	mov    %esp,%ebp
    16fb:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    16fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1701:	8b 55 0c             	mov    0xc(%ebp),%edx
    1704:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    1707:	83 ec 0c             	sub    $0xc,%esp
    170a:	ff 75 08             	pushl  0x8(%ebp)
    170d:	e8 77 ec ff ff       	call   389 <registWindow>
    1712:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1715:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    171c:	8b 45 08             	mov    0x8(%ebp),%eax
    171f:	8b 00                	mov    (%eax),%eax
    1721:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1724:	ff 75 f4             	pushl  -0xc(%ebp)
    1727:	ff 75 f0             	pushl  -0x10(%ebp)
    172a:	ff 75 ec             	pushl  -0x14(%ebp)
    172d:	ff 75 08             	pushl  0x8(%ebp)
    1730:	e8 e7 fc ff ff       	call   141c <APSendMessage>
    1735:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1738:	83 ec 0c             	sub    $0xc,%esp
    173b:	ff 75 08             	pushl  0x8(%ebp)
    173e:	e8 3e ec ff ff       	call   381 <getMessage>
    1743:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1746:	8b 45 08             	mov    0x8(%ebp),%eax
    1749:	83 c0 6c             	add    $0x6c,%eax
    174c:	83 ec 08             	sub    $0x8,%esp
    174f:	50                   	push   %eax
    1750:	ff 75 08             	pushl  0x8(%ebp)
    1753:	e8 80 ff ff ff       	call   16d8 <APPreJudge>
    1758:	83 c4 10             	add    $0x10,%esp
    175b:	84 c0                	test   %al,%al
    175d:	74 1b                	je     177a <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    175f:	8b 45 08             	mov    0x8(%ebp),%eax
    1762:	ff 70 74             	pushl  0x74(%eax)
    1765:	ff 70 70             	pushl  0x70(%eax)
    1768:	ff 70 6c             	pushl  0x6c(%eax)
    176b:	ff 75 08             	pushl  0x8(%ebp)
    176e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1771:	ff d0                	call   *%eax
    1773:	83 c4 10             	add    $0x10,%esp
    1776:	84 c0                	test   %al,%al
    1778:	75 0c                	jne    1786 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    177a:	8b 45 08             	mov    0x8(%ebp),%eax
    177d:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1784:	eb b2                	jmp    1738 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1786:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1787:	90                   	nop
    1788:	c9                   	leave  
    1789:	c3                   	ret    

0000178a <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    178a:	55                   	push   %ebp
    178b:	89 e5                	mov    %esp,%ebp
    178d:	57                   	push   %edi
    178e:	56                   	push   %esi
    178f:	53                   	push   %ebx
    1790:	83 ec 4c             	sub    $0x4c,%esp
    if (!iconReady)
    1793:	a1 64 25 00 00       	mov    0x2564,%eax
    1798:	85 c0                	test   %eax,%eax
    179a:	75 7c                	jne    1818 <APGridPaint+0x8e>
    {
        iconReady = 1;
    179c:	c7 05 64 25 00 00 01 	movl   $0x1,0x2564
    17a3:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("Snake.bmp");
    17a6:	8d 45 b8             	lea    -0x48(%ebp),%eax
    17a9:	83 ec 08             	sub    $0x8,%esp
    17ac:	68 9f 1f 00 00       	push   $0x1f9f
    17b1:	50                   	push   %eax
    17b2:	e8 37 f1 ff ff       	call   8ee <APLoadBitmap>
    17b7:	83 c4 0c             	add    $0xc,%esp
    17ba:	8b 45 b8             	mov    -0x48(%ebp),%eax
    17bd:	a3 68 25 00 00       	mov    %eax,0x2568
    17c2:	8b 45 bc             	mov    -0x44(%ebp),%eax
    17c5:	a3 6c 25 00 00       	mov    %eax,0x256c
    17ca:	8b 45 c0             	mov    -0x40(%ebp),%eax
    17cd:	a3 70 25 00 00       	mov    %eax,0x2570
        printf(1,"bitmap loaded!\n");
    17d2:	83 ec 08             	sub    $0x8,%esp
    17d5:	68 a9 1f 00 00       	push   $0x1fa9
    17da:	6a 01                	push   $0x1
    17dc:	e8 87 ec ff ff       	call   468 <printf>
    17e1:	83 c4 10             	add    $0x10,%esp
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    17e4:	83 ec 04             	sub    $0x4,%esp
    17e7:	ff 35 70 25 00 00    	pushl  0x2570
    17ed:	ff 35 6c 25 00 00    	pushl  0x256c
    17f3:	ff 35 68 25 00 00    	pushl  0x2568
    17f9:	e8 7a f3 ff ff       	call   b78 <APCreateCompatibleDCFromBitmap>
    17fe:	83 c4 10             	add    $0x10,%esp
    1801:	a3 74 25 00 00       	mov    %eax,0x2574
        printf(1,"bitmap DC created!\n");
    1806:	83 ec 08             	sub    $0x8,%esp
    1809:	68 b9 1f 00 00       	push   $0x1fb9
    180e:	6a 01                	push   $0x1
    1810:	e8 53 ec ff ff       	call   468 <printf>
    1815:	83 c4 10             	add    $0x10,%esp
    }
    
    if (!wnd->is_grid)
    1818:	8b 45 08             	mov    0x8(%ebp),%eax
    181b:	8b 40 08             	mov    0x8(%eax),%eax
    181e:	85 c0                	test   %eax,%eax
    1820:	75 17                	jne    1839 <APGridPaint+0xaf>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1822:	83 ec 08             	sub    $0x8,%esp
    1825:	68 d0 1f 00 00       	push   $0x1fd0
    182a:	6a 01                	push   $0x1
    182c:	e8 37 ec ff ff       	call   468 <printf>
    1831:	83 c4 10             	add    $0x10,%esp
        return;
    1834:	e9 55 03 00 00       	jmp    1b8e <APGridPaint+0x404>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1839:	8b 45 08             	mov    0x8(%ebp),%eax
    183c:	8b 40 10             	mov    0x10(%eax),%eax
    183f:	85 c0                	test   %eax,%eax
    1841:	7e 10                	jle    1853 <APGridPaint+0xc9>
    1843:	8b 45 08             	mov    0x8(%ebp),%eax
    1846:	8b 50 14             	mov    0x14(%eax),%edx
    1849:	8b 45 08             	mov    0x8(%ebp),%eax
    184c:	8b 40 10             	mov    0x10(%eax),%eax
    184f:	39 c2                	cmp    %eax,%edx
    1851:	7c 17                	jl     186a <APGridPaint+0xe0>
    {
        printf(1,"Grid mode page error!");
    1853:	83 ec 08             	sub    $0x8,%esp
    1856:	68 f6 1f 00 00       	push   $0x1ff6
    185b:	6a 01                	push   $0x1
    185d:	e8 06 ec ff ff       	call   468 <printf>
    1862:	83 c4 10             	add    $0x10,%esp
        return;
    1865:	e9 24 03 00 00       	jmp    1b8e <APGridPaint+0x404>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    186a:	8b 45 08             	mov    0x8(%ebp),%eax
    186d:	8b 40 14             	mov    0x14(%eax),%eax
    1870:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1876:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1879:	8b 45 dc             	mov    -0x24(%ebp),%eax
    187c:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    187f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1886:	e9 f9 02 00 00       	jmp    1b84 <APGridPaint+0x3fa>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    188b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1892:	e9 df 02 00 00       	jmp    1b76 <APGridPaint+0x3ec>
        {
            index = start + GRID_W_NUMBER * j + i;
    1897:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    189a:	c1 e0 04             	shl    $0x4,%eax
    189d:	89 c2                	mov    %eax,%edx
    189f:	8b 45 d8             	mov    -0x28(%ebp),%eax
    18a2:	01 c2                	add    %eax,%edx
    18a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    18a7:	01 d0                	add    %edx,%eax
    18a9:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    18ac:	8b 45 08             	mov    0x8(%ebp),%eax
    18af:	8b 40 0c             	mov    0xc(%eax),%eax
    18b2:	8b 55 dc             	mov    -0x24(%ebp),%edx
    18b5:	c1 e2 02             	shl    $0x2,%edx
    18b8:	01 d0                	add    %edx,%eax
    18ba:	8b 00                	mov    (%eax),%eax
    18bc:	83 f8 01             	cmp    $0x1,%eax
    18bf:	0f 84 83 00 00 00    	je     1948 <APGridPaint+0x1be>
    18c5:	83 f8 01             	cmp    $0x1,%eax
    18c8:	7f 09                	jg     18d3 <APGridPaint+0x149>
    18ca:	85 c0                	test   %eax,%eax
    18cc:	74 1c                	je     18ea <APGridPaint+0x160>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    18ce:	e9 9f 02 00 00       	jmp    1b72 <APGridPaint+0x3e8>
        for (int i = 0; i < GRID_W_NUMBER;i++)
        {
            index = start + GRID_W_NUMBER * j + i;
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    18d3:	83 f8 02             	cmp    $0x2,%eax
    18d6:	0f 84 20 01 00 00    	je     19fc <APGridPaint+0x272>
    18dc:	83 f8 03             	cmp    $0x3,%eax
    18df:	0f 84 d1 01 00 00    	je     1ab6 <APGridPaint+0x32c>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    18e5:	e9 88 02 00 00       	jmp    1b72 <APGridPaint+0x3e8>
                    pen.size = 1;
                    brush.color = RGB(0xd2,0x69,0x1e);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);*/
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    18ea:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    18ed:	6a 0c                	push   $0xc
    18ef:	6a 0c                	push   $0xc
    18f1:	6a 0c                	push   $0xc
    18f3:	50                   	push   %eax
    18f4:	e8 de fa ff ff       	call   13d7 <RGB>
    18f9:	83 c4 0c             	add    $0xc,%esp
    18fc:	8b 1d 74 25 00 00    	mov    0x2574,%ebx
    1902:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1905:	6b c8 32             	imul   $0x32,%eax,%ecx
    1908:	8b 45 e0             	mov    -0x20(%ebp),%eax
    190b:	6b c0 32             	imul   $0x32,%eax,%eax
    190e:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    1911:	8b 45 08             	mov    0x8(%ebp),%eax
    1914:	8d 78 34             	lea    0x34(%eax),%edi
    1917:	83 ec 0c             	sub    $0xc,%esp
    191a:	83 ec 04             	sub    $0x4,%esp
    191d:	89 e0                	mov    %esp,%eax
    191f:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1923:	66 89 30             	mov    %si,(%eax)
    1926:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    192a:	88 50 02             	mov    %dl,0x2(%eax)
    192d:	6a 32                	push   $0x32
    192f:	6a 32                	push   $0x32
    1931:	6a 00                	push   $0x0
    1933:	6a 00                	push   $0x0
    1935:	53                   	push   %ebx
    1936:	51                   	push   %ecx
    1937:	ff 75 b4             	pushl  -0x4c(%ebp)
    193a:	57                   	push   %edi
    193b:	e8 f3 f8 ff ff       	call   1233 <APDcCopy>
    1940:	83 c4 30             	add    $0x30,%esp
                    break;
    1943:	e9 2a 02 00 00       	jmp    1b72 <APGridPaint+0x3e8>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1948:	8d 45 b8             	lea    -0x48(%ebp),%eax
    194b:	6a 69                	push   $0x69
    194d:	6a 69                	push   $0x69
    194f:	6a 69                	push   $0x69
    1951:	50                   	push   %eax
    1952:	e8 80 fa ff ff       	call   13d7 <RGB>
    1957:	83 c4 0c             	add    $0xc,%esp
    195a:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    195e:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1962:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1966:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1969:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1970:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1973:	6a 69                	push   $0x69
    1975:	6a 69                	push   $0x69
    1977:	6a 69                	push   $0x69
    1979:	50                   	push   %eax
    197a:	e8 58 fa ff ff       	call   13d7 <RGB>
    197f:	83 c4 0c             	add    $0xc,%esp
    1982:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1986:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    198a:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    198e:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1991:	8b 45 08             	mov    0x8(%ebp),%eax
    1994:	8d 50 34             	lea    0x34(%eax),%edx
    1997:	8d 45 b8             	lea    -0x48(%ebp),%eax
    199a:	ff 75 d0             	pushl  -0x30(%ebp)
    199d:	ff 75 cc             	pushl  -0x34(%ebp)
    19a0:	52                   	push   %edx
    19a1:	50                   	push   %eax
    19a2:	e8 66 f2 ff ff       	call   c0d <APSetPen>
    19a7:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    19aa:	8b 45 08             	mov    0x8(%ebp),%eax
    19ad:	8d 58 34             	lea    0x34(%eax),%ebx
    19b0:	8d 55 b8             	lea    -0x48(%ebp),%edx
    19b3:	83 ec 04             	sub    $0x4,%esp
    19b6:	83 ec 04             	sub    $0x4,%esp
    19b9:	89 e0                	mov    %esp,%eax
    19bb:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    19bf:	66 89 08             	mov    %cx,(%eax)
    19c2:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    19c6:	88 48 02             	mov    %cl,0x2(%eax)
    19c9:	53                   	push   %ebx
    19ca:	52                   	push   %edx
    19cb:	e8 76 f2 ff ff       	call   c46 <APSetBrush>
    19d0:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    19d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19d6:	6b d0 32             	imul   $0x32,%eax,%edx
    19d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    19dc:	6b c0 32             	imul   $0x32,%eax,%eax
    19df:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19e2:	83 c1 34             	add    $0x34,%ecx
    19e5:	83 ec 0c             	sub    $0xc,%esp
    19e8:	6a 32                	push   $0x32
    19ea:	6a 32                	push   $0x32
    19ec:	52                   	push   %edx
    19ed:	50                   	push   %eax
    19ee:	51                   	push   %ecx
    19ef:	e8 3a f6 ff ff       	call   102e <APDrawRect>
    19f4:	83 c4 20             	add    $0x20,%esp
                    break;
    19f7:	e9 76 01 00 00       	jmp    1b72 <APGridPaint+0x3e8>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    pen.color = RGB(0x00,0x80,0x00);
    19fc:	8d 45 b8             	lea    -0x48(%ebp),%eax
    19ff:	6a 00                	push   $0x0
    1a01:	68 80 00 00 00       	push   $0x80
    1a06:	6a 00                	push   $0x0
    1a08:	50                   	push   %eax
    1a09:	e8 c9 f9 ff ff       	call   13d7 <RGB>
    1a0e:	83 c4 0c             	add    $0xc,%esp
    1a11:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1a15:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1a19:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1a1d:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1a20:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0x80,0x00);
    1a27:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a2a:	6a 00                	push   $0x0
    1a2c:	68 80 00 00 00       	push   $0x80
    1a31:	6a 00                	push   $0x0
    1a33:	50                   	push   %eax
    1a34:	e8 9e f9 ff ff       	call   13d7 <RGB>
    1a39:	83 c4 0c             	add    $0xc,%esp
    1a3c:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1a40:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1a44:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1a48:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1a4b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4e:	8d 50 34             	lea    0x34(%eax),%edx
    1a51:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a54:	ff 75 d0             	pushl  -0x30(%ebp)
    1a57:	ff 75 cc             	pushl  -0x34(%ebp)
    1a5a:	52                   	push   %edx
    1a5b:	50                   	push   %eax
    1a5c:	e8 ac f1 ff ff       	call   c0d <APSetPen>
    1a61:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1a64:	8b 45 08             	mov    0x8(%ebp),%eax
    1a67:	8d 58 34             	lea    0x34(%eax),%ebx
    1a6a:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1a6d:	83 ec 04             	sub    $0x4,%esp
    1a70:	83 ec 04             	sub    $0x4,%esp
    1a73:	89 e0                	mov    %esp,%eax
    1a75:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1a79:	66 89 08             	mov    %cx,(%eax)
    1a7c:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1a80:	88 48 02             	mov    %cl,0x2(%eax)
    1a83:	53                   	push   %ebx
    1a84:	52                   	push   %edx
    1a85:	e8 bc f1 ff ff       	call   c46 <APSetBrush>
    1a8a:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1a8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a90:	6b d0 32             	imul   $0x32,%eax,%edx
    1a93:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a96:	6b c0 32             	imul   $0x32,%eax,%eax
    1a99:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a9c:	83 c1 34             	add    $0x34,%ecx
    1a9f:	83 ec 0c             	sub    $0xc,%esp
    1aa2:	6a 32                	push   $0x32
    1aa4:	6a 32                	push   $0x32
    1aa6:	52                   	push   %edx
    1aa7:	50                   	push   %eax
    1aa8:	51                   	push   %ecx
    1aa9:	e8 80 f5 ff ff       	call   102e <APDrawRect>
    1aae:	83 c4 20             	add    $0x20,%esp
                    break;
    1ab1:	e9 bc 00 00 00       	jmp    1b72 <APGridPaint+0x3e8>
                case GRID_RIVER:
                    //printf(1,"Grid_River");
                    pen.color = RGB(0x00,0xbf,0xff);
    1ab6:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1ab9:	68 ff 00 00 00       	push   $0xff
    1abe:	68 bf 00 00 00       	push   $0xbf
    1ac3:	6a 00                	push   $0x0
    1ac5:	50                   	push   %eax
    1ac6:	e8 0c f9 ff ff       	call   13d7 <RGB>
    1acb:	83 c4 0c             	add    $0xc,%esp
    1ace:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1ad2:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1ad6:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1ada:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1add:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0xbf,0xff);
    1ae4:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1ae7:	68 ff 00 00 00       	push   $0xff
    1aec:	68 bf 00 00 00       	push   $0xbf
    1af1:	6a 00                	push   $0x0
    1af3:	50                   	push   %eax
    1af4:	e8 de f8 ff ff       	call   13d7 <RGB>
    1af9:	83 c4 0c             	add    $0xc,%esp
    1afc:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1b00:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1b04:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1b08:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b0e:	8d 50 34             	lea    0x34(%eax),%edx
    1b11:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b14:	ff 75 d0             	pushl  -0x30(%ebp)
    1b17:	ff 75 cc             	pushl  -0x34(%ebp)
    1b1a:	52                   	push   %edx
    1b1b:	50                   	push   %eax
    1b1c:	e8 ec f0 ff ff       	call   c0d <APSetPen>
    1b21:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b24:	8b 45 08             	mov    0x8(%ebp),%eax
    1b27:	8d 58 34             	lea    0x34(%eax),%ebx
    1b2a:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1b2d:	83 ec 04             	sub    $0x4,%esp
    1b30:	83 ec 04             	sub    $0x4,%esp
    1b33:	89 e0                	mov    %esp,%eax
    1b35:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1b39:	66 89 08             	mov    %cx,(%eax)
    1b3c:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1b40:	88 48 02             	mov    %cl,0x2(%eax)
    1b43:	53                   	push   %ebx
    1b44:	52                   	push   %edx
    1b45:	e8 fc f0 ff ff       	call   c46 <APSetBrush>
    1b4a:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
    1b4d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b50:	6b d0 32             	imul   $0x32,%eax,%edx
    1b53:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b56:	6b c0 32             	imul   $0x32,%eax,%eax
    1b59:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b5c:	83 c1 34             	add    $0x34,%ecx
    1b5f:	83 ec 0c             	sub    $0xc,%esp
    1b62:	6a 32                	push   $0x32
    1b64:	6a 32                	push   $0x32
    1b66:	52                   	push   %edx
    1b67:	50                   	push   %eax
    1b68:	51                   	push   %ecx
    1b69:	e8 c0 f4 ff ff       	call   102e <APDrawRect>
    1b6e:	83 c4 20             	add    $0x20,%esp
                    break;
    1b71:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1b72:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1b76:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1b7a:	0f 8e 17 fd ff ff    	jle    1897 <APGridPaint+0x10d>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1b80:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1b84:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1b88:	0f 8e fd fc ff ff    	jle    188b <APGridPaint+0x101>
                    break;
                default: break;
            }
        }
    }
}
    1b8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b91:	5b                   	pop    %ebx
    1b92:	5e                   	pop    %esi
    1b93:	5f                   	pop    %edi
    1b94:	5d                   	pop    %ebp
    1b95:	c3                   	ret    

00001b96 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1b96:	55                   	push   %ebp
    1b97:	89 e5                	mov    %esp,%ebp
    1b99:	53                   	push   %ebx
    1b9a:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1b9d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1ba4:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1ba8:	74 17                	je     1bc1 <sprintint+0x2b>
    1baa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1bae:	79 11                	jns    1bc1 <sprintint+0x2b>
        neg = 1;
    1bb0:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1bb7:	8b 45 10             	mov    0x10(%ebp),%eax
    1bba:	f7 d8                	neg    %eax
    1bbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1bbf:	eb 06                	jmp    1bc7 <sprintint+0x31>
    } else {
        x = xx;
    1bc1:	8b 45 10             	mov    0x10(%ebp),%eax
    1bc4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1bc7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1bce:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1bd1:	8d 41 01             	lea    0x1(%ecx),%eax
    1bd4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1bd7:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1bda:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bdd:	ba 00 00 00 00       	mov    $0x0,%edx
    1be2:	f7 f3                	div    %ebx
    1be4:	89 d0                	mov    %edx,%eax
    1be6:	0f b6 80 44 25 00 00 	movzbl 0x2544(%eax),%eax
    1bed:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1bf1:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1bf4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bf7:	ba 00 00 00 00       	mov    $0x0,%edx
    1bfc:	f7 f3                	div    %ebx
    1bfe:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1c01:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1c05:	75 c7                	jne    1bce <sprintint+0x38>
    if(neg)
    1c07:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1c0b:	74 0e                	je     1c1b <sprintint+0x85>
        buf[i++] = '-';
    1c0d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c10:	8d 50 01             	lea    0x1(%eax),%edx
    1c13:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1c16:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1c1b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c1e:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1c21:	eb 1b                	jmp    1c3e <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1c23:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c26:	8b 00                	mov    (%eax),%eax
    1c28:	8d 48 01             	lea    0x1(%eax),%ecx
    1c2b:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c2e:	89 0a                	mov    %ecx,(%edx)
    1c30:	89 c2                	mov    %eax,%edx
    1c32:	8b 45 08             	mov    0x8(%ebp),%eax
    1c35:	01 d0                	add    %edx,%eax
    1c37:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1c3a:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1c3e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1c42:	7f df                	jg     1c23 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1c44:	eb 21                	jmp    1c67 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1c46:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c49:	8b 00                	mov    (%eax),%eax
    1c4b:	8d 48 01             	lea    0x1(%eax),%ecx
    1c4e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c51:	89 0a                	mov    %ecx,(%edx)
    1c53:	89 c2                	mov    %eax,%edx
    1c55:	8b 45 08             	mov    0x8(%ebp),%eax
    1c58:	01 c2                	add    %eax,%edx
    1c5a:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1c5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c60:	01 c8                	add    %ecx,%eax
    1c62:	0f b6 00             	movzbl (%eax),%eax
    1c65:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1c67:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1c6b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1c6f:	79 d5                	jns    1c46 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1c71:	90                   	nop
    1c72:	83 c4 20             	add    $0x20,%esp
    1c75:	5b                   	pop    %ebx
    1c76:	5d                   	pop    %ebp
    1c77:	c3                   	ret    

00001c78 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1c78:	55                   	push   %ebp
    1c79:	89 e5                	mov    %esp,%ebp
    1c7b:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1c7e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1c85:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1c8c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1c93:	8d 45 0c             	lea    0xc(%ebp),%eax
    1c96:	83 c0 04             	add    $0x4,%eax
    1c99:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1c9c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1ca3:	e9 d9 01 00 00       	jmp    1e81 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1ca8:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cab:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1cae:	01 d0                	add    %edx,%eax
    1cb0:	0f b6 00             	movzbl (%eax),%eax
    1cb3:	0f be c0             	movsbl %al,%eax
    1cb6:	25 ff 00 00 00       	and    $0xff,%eax
    1cbb:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1cbe:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1cc2:	75 2c                	jne    1cf0 <sprintf+0x78>
            if(c == '%'){
    1cc4:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1cc8:	75 0c                	jne    1cd6 <sprintf+0x5e>
                state = '%';
    1cca:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1cd1:	e9 a7 01 00 00       	jmp    1e7d <sprintf+0x205>
            } else {
                dst[j++] = c;
    1cd6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1cd9:	8d 50 01             	lea    0x1(%eax),%edx
    1cdc:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1cdf:	89 c2                	mov    %eax,%edx
    1ce1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce4:	01 d0                	add    %edx,%eax
    1ce6:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1ce9:	88 10                	mov    %dl,(%eax)
    1ceb:	e9 8d 01 00 00       	jmp    1e7d <sprintf+0x205>
            }
        } else if(state == '%'){
    1cf0:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1cf4:	0f 85 83 01 00 00    	jne    1e7d <sprintf+0x205>
            if(c == 'd'){
    1cfa:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1cfe:	75 4c                	jne    1d4c <sprintf+0xd4>
                buf[bi] = '\0';
    1d00:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1d03:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d06:	01 d0                	add    %edx,%eax
    1d08:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1d0b:	83 ec 0c             	sub    $0xc,%esp
    1d0e:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1d11:	50                   	push   %eax
    1d12:	e8 20 e5 ff ff       	call   237 <atoi>
    1d17:	83 c4 10             	add    $0x10,%esp
    1d1a:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1d1d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1d24:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d27:	8b 00                	mov    (%eax),%eax
    1d29:	83 ec 08             	sub    $0x8,%esp
    1d2c:	ff 75 d8             	pushl  -0x28(%ebp)
    1d2f:	6a 01                	push   $0x1
    1d31:	6a 0a                	push   $0xa
    1d33:	50                   	push   %eax
    1d34:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1d37:	50                   	push   %eax
    1d38:	ff 75 08             	pushl  0x8(%ebp)
    1d3b:	e8 56 fe ff ff       	call   1b96 <sprintint>
    1d40:	83 c4 20             	add    $0x20,%esp
                ap++;
    1d43:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1d47:	e9 2a 01 00 00       	jmp    1e76 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1d4c:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1d50:	74 06                	je     1d58 <sprintf+0xe0>
    1d52:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1d56:	75 4c                	jne    1da4 <sprintf+0x12c>
                buf[bi] = '\0';
    1d58:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1d5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d5e:	01 d0                	add    %edx,%eax
    1d60:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1d63:	83 ec 0c             	sub    $0xc,%esp
    1d66:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1d69:	50                   	push   %eax
    1d6a:	e8 c8 e4 ff ff       	call   237 <atoi>
    1d6f:	83 c4 10             	add    $0x10,%esp
    1d72:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1d75:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1d7c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d7f:	8b 00                	mov    (%eax),%eax
    1d81:	83 ec 08             	sub    $0x8,%esp
    1d84:	ff 75 dc             	pushl  -0x24(%ebp)
    1d87:	6a 00                	push   $0x0
    1d89:	6a 10                	push   $0x10
    1d8b:	50                   	push   %eax
    1d8c:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1d8f:	50                   	push   %eax
    1d90:	ff 75 08             	pushl  0x8(%ebp)
    1d93:	e8 fe fd ff ff       	call   1b96 <sprintint>
    1d98:	83 c4 20             	add    $0x20,%esp
                ap++;
    1d9b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1d9f:	e9 d2 00 00 00       	jmp    1e76 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1da4:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1da8:	75 46                	jne    1df0 <sprintf+0x178>
                s = (char*)*ap;
    1daa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dad:	8b 00                	mov    (%eax),%eax
    1daf:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1db2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1db6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1dba:	75 25                	jne    1de1 <sprintf+0x169>
                    s = "(null)";
    1dbc:	c7 45 f4 0c 20 00 00 	movl   $0x200c,-0xc(%ebp)
                while(*s != 0){
    1dc3:	eb 1c                	jmp    1de1 <sprintf+0x169>
                    dst[j++] = *s;
    1dc5:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1dc8:	8d 50 01             	lea    0x1(%eax),%edx
    1dcb:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1dce:	89 c2                	mov    %eax,%edx
    1dd0:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd3:	01 c2                	add    %eax,%edx
    1dd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dd8:	0f b6 00             	movzbl (%eax),%eax
    1ddb:	88 02                	mov    %al,(%edx)
                    s++;
    1ddd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    1de1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1de4:	0f b6 00             	movzbl (%eax),%eax
    1de7:	84 c0                	test   %al,%al
    1de9:	75 da                	jne    1dc5 <sprintf+0x14d>
    1deb:	e9 86 00 00 00       	jmp    1e76 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    1df0:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    1df4:	75 1d                	jne    1e13 <sprintf+0x19b>
                dst[j++] = *ap;
    1df6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1df9:	8d 50 01             	lea    0x1(%eax),%edx
    1dfc:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1dff:	89 c2                	mov    %eax,%edx
    1e01:	8b 45 08             	mov    0x8(%ebp),%eax
    1e04:	01 c2                	add    %eax,%edx
    1e06:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e09:	8b 00                	mov    (%eax),%eax
    1e0b:	88 02                	mov    %al,(%edx)
                ap++;
    1e0d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1e11:	eb 63                	jmp    1e76 <sprintf+0x1fe>
            } else if(c == '%'){
    1e13:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1e17:	75 17                	jne    1e30 <sprintf+0x1b8>
                dst[j++] = c;
    1e19:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e1c:	8d 50 01             	lea    0x1(%eax),%edx
    1e1f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e22:	89 c2                	mov    %eax,%edx
    1e24:	8b 45 08             	mov    0x8(%ebp),%eax
    1e27:	01 d0                	add    %edx,%eax
    1e29:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1e2c:	88 10                	mov    %dl,(%eax)
    1e2e:	eb 46                	jmp    1e76 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    1e30:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    1e34:	7e 18                	jle    1e4e <sprintf+0x1d6>
    1e36:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    1e3a:	7f 12                	jg     1e4e <sprintf+0x1d6>
            {
                buf[bi++] = c;
    1e3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e3f:	8d 50 01             	lea    0x1(%eax),%edx
    1e42:	89 55 f0             	mov    %edx,-0x10(%ebp)
    1e45:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1e48:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    1e4c:	eb 2f                	jmp    1e7d <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    1e4e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e51:	8d 50 01             	lea    0x1(%eax),%edx
    1e54:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e57:	89 c2                	mov    %eax,%edx
    1e59:	8b 45 08             	mov    0x8(%ebp),%eax
    1e5c:	01 d0                	add    %edx,%eax
    1e5e:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    1e61:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e64:	8d 50 01             	lea    0x1(%eax),%edx
    1e67:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e6a:	89 c2                	mov    %eax,%edx
    1e6c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e6f:	01 d0                	add    %edx,%eax
    1e71:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1e74:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    1e76:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    1e7d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1e81:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e84:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e87:	01 d0                	add    %edx,%eax
    1e89:	0f b6 00             	movzbl (%eax),%eax
    1e8c:	84 c0                	test   %al,%al
    1e8e:	0f 85 14 fe ff ff    	jne    1ca8 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    1e94:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e97:	8d 50 01             	lea    0x1(%eax),%edx
    1e9a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e9d:	89 c2                	mov    %eax,%edx
    1e9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea2:	01 d0                	add    %edx,%eax
    1ea4:	c6 00 00             	movb   $0x0,(%eax)
}
    1ea7:	90                   	nop
    1ea8:	c9                   	leave  
    1ea9:	c3                   	ret    
