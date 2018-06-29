
_ln：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	53                   	push   %ebx
       e:	51                   	push   %ecx
       f:	89 cb                	mov    %ecx,%ebx
  if(argc != 3){
      11:	83 3b 03             	cmpl   $0x3,(%ebx)
      14:	74 17                	je     2d <main+0x2d>
    printf(2, "Usage: ln old new\n");
      16:	83 ec 08             	sub    $0x8,%esp
      19:	68 a4 24 00 00       	push   $0x24a4
      1e:	6a 02                	push   $0x2
      20:	e8 65 04 00 00       	call   48a <printf>
      25:	83 c4 10             	add    $0x10,%esp
    exit();
      28:	e8 9e 02 00 00       	call   2cb <exit>
  }
  if(link(argv[1], argv[2]) < 0)
      2d:	8b 43 04             	mov    0x4(%ebx),%eax
      30:	83 c0 08             	add    $0x8,%eax
      33:	8b 10                	mov    (%eax),%edx
      35:	8b 43 04             	mov    0x4(%ebx),%eax
      38:	83 c0 04             	add    $0x4,%eax
      3b:	8b 00                	mov    (%eax),%eax
      3d:	83 ec 08             	sub    $0x8,%esp
      40:	52                   	push   %edx
      41:	50                   	push   %eax
      42:	e8 e4 02 00 00       	call   32b <link>
      47:	83 c4 10             	add    $0x10,%esp
      4a:	85 c0                	test   %eax,%eax
      4c:	79 21                	jns    6f <main+0x6f>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
      4e:	8b 43 04             	mov    0x4(%ebx),%eax
      51:	83 c0 08             	add    $0x8,%eax
      54:	8b 10                	mov    (%eax),%edx
      56:	8b 43 04             	mov    0x4(%ebx),%eax
      59:	83 c0 04             	add    $0x4,%eax
      5c:	8b 00                	mov    (%eax),%eax
      5e:	52                   	push   %edx
      5f:	50                   	push   %eax
      60:	68 b7 24 00 00       	push   $0x24b7
      65:	6a 02                	push   $0x2
      67:	e8 1e 04 00 00       	call   48a <printf>
      6c:	83 c4 10             	add    $0x10,%esp
  exit();
      6f:	e8 57 02 00 00       	call   2cb <exit>

00000074 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
      74:	55                   	push   %ebp
      75:	89 e5                	mov    %esp,%ebp
      77:	57                   	push   %edi
      78:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      79:	8b 4d 08             	mov    0x8(%ebp),%ecx
      7c:	8b 55 10             	mov    0x10(%ebp),%edx
      7f:	8b 45 0c             	mov    0xc(%ebp),%eax
      82:	89 cb                	mov    %ecx,%ebx
      84:	89 df                	mov    %ebx,%edi
      86:	89 d1                	mov    %edx,%ecx
      88:	fc                   	cld    
      89:	f3 aa                	rep stos %al,%es:(%edi)
      8b:	89 ca                	mov    %ecx,%edx
      8d:	89 fb                	mov    %edi,%ebx
      8f:	89 5d 08             	mov    %ebx,0x8(%ebp)
      92:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      95:	90                   	nop
      96:	5b                   	pop    %ebx
      97:	5f                   	pop    %edi
      98:	5d                   	pop    %ebp
      99:	c3                   	ret    

0000009a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      9a:	55                   	push   %ebp
      9b:	89 e5                	mov    %esp,%ebp
      9d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      a0:	8b 45 08             	mov    0x8(%ebp),%eax
      a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      a6:	90                   	nop
      a7:	8b 45 08             	mov    0x8(%ebp),%eax
      aa:	8d 50 01             	lea    0x1(%eax),%edx
      ad:	89 55 08             	mov    %edx,0x8(%ebp)
      b0:	8b 55 0c             	mov    0xc(%ebp),%edx
      b3:	8d 4a 01             	lea    0x1(%edx),%ecx
      b6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
      b9:	0f b6 12             	movzbl (%edx),%edx
      bc:	88 10                	mov    %dl,(%eax)
      be:	0f b6 00             	movzbl (%eax),%eax
      c1:	84 c0                	test   %al,%al
      c3:	75 e2                	jne    a7 <strcpy+0xd>
    ;
  return os;
      c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      c8:	c9                   	leave  
      c9:	c3                   	ret    

000000ca <strcmp>:

int
strcmp(const char *p, const char *q)
{
      ca:	55                   	push   %ebp
      cb:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      cd:	eb 08                	jmp    d7 <strcmp+0xd>
    p++, q++;
      cf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      d3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
      d7:	8b 45 08             	mov    0x8(%ebp),%eax
      da:	0f b6 00             	movzbl (%eax),%eax
      dd:	84 c0                	test   %al,%al
      df:	74 10                	je     f1 <strcmp+0x27>
      e1:	8b 45 08             	mov    0x8(%ebp),%eax
      e4:	0f b6 10             	movzbl (%eax),%edx
      e7:	8b 45 0c             	mov    0xc(%ebp),%eax
      ea:	0f b6 00             	movzbl (%eax),%eax
      ed:	38 c2                	cmp    %al,%dl
      ef:	74 de                	je     cf <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
      f1:	8b 45 08             	mov    0x8(%ebp),%eax
      f4:	0f b6 00             	movzbl (%eax),%eax
      f7:	0f b6 d0             	movzbl %al,%edx
      fa:	8b 45 0c             	mov    0xc(%ebp),%eax
      fd:	0f b6 00             	movzbl (%eax),%eax
     100:	0f b6 c0             	movzbl %al,%eax
     103:	29 c2                	sub    %eax,%edx
     105:	89 d0                	mov    %edx,%eax
}
     107:	5d                   	pop    %ebp
     108:	c3                   	ret    

00000109 <strlen>:

uint
strlen(char *s)
{
     109:	55                   	push   %ebp
     10a:	89 e5                	mov    %esp,%ebp
     10c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     10f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     116:	eb 04                	jmp    11c <strlen+0x13>
     118:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     11c:	8b 55 fc             	mov    -0x4(%ebp),%edx
     11f:	8b 45 08             	mov    0x8(%ebp),%eax
     122:	01 d0                	add    %edx,%eax
     124:	0f b6 00             	movzbl (%eax),%eax
     127:	84 c0                	test   %al,%al
     129:	75 ed                	jne    118 <strlen+0xf>
    ;
  return n;
     12b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     12e:	c9                   	leave  
     12f:	c3                   	ret    

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     133:	8b 45 10             	mov    0x10(%ebp),%eax
     136:	50                   	push   %eax
     137:	ff 75 0c             	pushl  0xc(%ebp)
     13a:	ff 75 08             	pushl  0x8(%ebp)
     13d:	e8 32 ff ff ff       	call   74 <stosb>
     142:	83 c4 0c             	add    $0xc,%esp
  return dst;
     145:	8b 45 08             	mov    0x8(%ebp),%eax
}
     148:	c9                   	leave  
     149:	c3                   	ret    

0000014a <strchr>:

char*
strchr(const char *s, char c)
{
     14a:	55                   	push   %ebp
     14b:	89 e5                	mov    %esp,%ebp
     14d:	83 ec 04             	sub    $0x4,%esp
     150:	8b 45 0c             	mov    0xc(%ebp),%eax
     153:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     156:	eb 14                	jmp    16c <strchr+0x22>
    if(*s == c)
     158:	8b 45 08             	mov    0x8(%ebp),%eax
     15b:	0f b6 00             	movzbl (%eax),%eax
     15e:	3a 45 fc             	cmp    -0x4(%ebp),%al
     161:	75 05                	jne    168 <strchr+0x1e>
      return (char*)s;
     163:	8b 45 08             	mov    0x8(%ebp),%eax
     166:	eb 13                	jmp    17b <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     168:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     16c:	8b 45 08             	mov    0x8(%ebp),%eax
     16f:	0f b6 00             	movzbl (%eax),%eax
     172:	84 c0                	test   %al,%al
     174:	75 e2                	jne    158 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     176:	b8 00 00 00 00       	mov    $0x0,%eax
}
     17b:	c9                   	leave  
     17c:	c3                   	ret    

0000017d <gets>:

char*
gets(char *buf, int max)
{
     17d:	55                   	push   %ebp
     17e:	89 e5                	mov    %esp,%ebp
     180:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     183:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     18a:	eb 42                	jmp    1ce <gets+0x51>
    cc = read(0, &c, 1);
     18c:	83 ec 04             	sub    $0x4,%esp
     18f:	6a 01                	push   $0x1
     191:	8d 45 ef             	lea    -0x11(%ebp),%eax
     194:	50                   	push   %eax
     195:	6a 00                	push   $0x0
     197:	e8 47 01 00 00       	call   2e3 <read>
     19c:	83 c4 10             	add    $0x10,%esp
     19f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     1a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1a6:	7e 33                	jle    1db <gets+0x5e>
      break;
    buf[i++] = c;
     1a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1ab:	8d 50 01             	lea    0x1(%eax),%edx
     1ae:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1b1:	89 c2                	mov    %eax,%edx
     1b3:	8b 45 08             	mov    0x8(%ebp),%eax
     1b6:	01 c2                	add    %eax,%edx
     1b8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1bc:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1be:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1c2:	3c 0a                	cmp    $0xa,%al
     1c4:	74 16                	je     1dc <gets+0x5f>
     1c6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1ca:	3c 0d                	cmp    $0xd,%al
     1cc:	74 0e                	je     1dc <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1d1:	83 c0 01             	add    $0x1,%eax
     1d4:	3b 45 0c             	cmp    0xc(%ebp),%eax
     1d7:	7c b3                	jl     18c <gets+0xf>
     1d9:	eb 01                	jmp    1dc <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     1db:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     1dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
     1df:	8b 45 08             	mov    0x8(%ebp),%eax
     1e2:	01 d0                	add    %edx,%eax
     1e4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     1e7:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1ea:	c9                   	leave  
     1eb:	c3                   	ret    

000001ec <stat>:

int
stat(char *n, struct stat *st)
{
     1ec:	55                   	push   %ebp
     1ed:	89 e5                	mov    %esp,%ebp
     1ef:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     1f2:	83 ec 08             	sub    $0x8,%esp
     1f5:	6a 00                	push   $0x0
     1f7:	ff 75 08             	pushl  0x8(%ebp)
     1fa:	e8 0c 01 00 00       	call   30b <open>
     1ff:	83 c4 10             	add    $0x10,%esp
     202:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     205:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     209:	79 07                	jns    212 <stat+0x26>
    return -1;
     20b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     210:	eb 25                	jmp    237 <stat+0x4b>
  r = fstat(fd, st);
     212:	83 ec 08             	sub    $0x8,%esp
     215:	ff 75 0c             	pushl  0xc(%ebp)
     218:	ff 75 f4             	pushl  -0xc(%ebp)
     21b:	e8 03 01 00 00       	call   323 <fstat>
     220:	83 c4 10             	add    $0x10,%esp
     223:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     226:	83 ec 0c             	sub    $0xc,%esp
     229:	ff 75 f4             	pushl  -0xc(%ebp)
     22c:	e8 c2 00 00 00       	call   2f3 <close>
     231:	83 c4 10             	add    $0x10,%esp
  return r;
     234:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     237:	c9                   	leave  
     238:	c3                   	ret    

00000239 <atoi>:

int
atoi(const char *s)
{
     239:	55                   	push   %ebp
     23a:	89 e5                	mov    %esp,%ebp
     23c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     23f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     246:	eb 25                	jmp    26d <atoi+0x34>
    n = n*10 + *s++ - '0';
     248:	8b 55 fc             	mov    -0x4(%ebp),%edx
     24b:	89 d0                	mov    %edx,%eax
     24d:	c1 e0 02             	shl    $0x2,%eax
     250:	01 d0                	add    %edx,%eax
     252:	01 c0                	add    %eax,%eax
     254:	89 c1                	mov    %eax,%ecx
     256:	8b 45 08             	mov    0x8(%ebp),%eax
     259:	8d 50 01             	lea    0x1(%eax),%edx
     25c:	89 55 08             	mov    %edx,0x8(%ebp)
     25f:	0f b6 00             	movzbl (%eax),%eax
     262:	0f be c0             	movsbl %al,%eax
     265:	01 c8                	add    %ecx,%eax
     267:	83 e8 30             	sub    $0x30,%eax
     26a:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     26d:	8b 45 08             	mov    0x8(%ebp),%eax
     270:	0f b6 00             	movzbl (%eax),%eax
     273:	3c 2f                	cmp    $0x2f,%al
     275:	7e 0a                	jle    281 <atoi+0x48>
     277:	8b 45 08             	mov    0x8(%ebp),%eax
     27a:	0f b6 00             	movzbl (%eax),%eax
     27d:	3c 39                	cmp    $0x39,%al
     27f:	7e c7                	jle    248 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     281:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     284:	c9                   	leave  
     285:	c3                   	ret    

00000286 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     286:	55                   	push   %ebp
     287:	89 e5                	mov    %esp,%ebp
     289:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     28c:	8b 45 08             	mov    0x8(%ebp),%eax
     28f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     292:	8b 45 0c             	mov    0xc(%ebp),%eax
     295:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     298:	eb 17                	jmp    2b1 <memmove+0x2b>
    *dst++ = *src++;
     29a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     29d:	8d 50 01             	lea    0x1(%eax),%edx
     2a0:	89 55 fc             	mov    %edx,-0x4(%ebp)
     2a3:	8b 55 f8             	mov    -0x8(%ebp),%edx
     2a6:	8d 4a 01             	lea    0x1(%edx),%ecx
     2a9:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     2ac:	0f b6 12             	movzbl (%edx),%edx
     2af:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     2b1:	8b 45 10             	mov    0x10(%ebp),%eax
     2b4:	8d 50 ff             	lea    -0x1(%eax),%edx
     2b7:	89 55 10             	mov    %edx,0x10(%ebp)
     2ba:	85 c0                	test   %eax,%eax
     2bc:	7f dc                	jg     29a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     2be:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2c1:	c9                   	leave  
     2c2:	c3                   	ret    

000002c3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2c3:	b8 01 00 00 00       	mov    $0x1,%eax
     2c8:	cd 40                	int    $0x40
     2ca:	c3                   	ret    

000002cb <exit>:
SYSCALL(exit)
     2cb:	b8 02 00 00 00       	mov    $0x2,%eax
     2d0:	cd 40                	int    $0x40
     2d2:	c3                   	ret    

000002d3 <wait>:
SYSCALL(wait)
     2d3:	b8 03 00 00 00       	mov    $0x3,%eax
     2d8:	cd 40                	int    $0x40
     2da:	c3                   	ret    

000002db <pipe>:
SYSCALL(pipe)
     2db:	b8 04 00 00 00       	mov    $0x4,%eax
     2e0:	cd 40                	int    $0x40
     2e2:	c3                   	ret    

000002e3 <read>:
SYSCALL(read)
     2e3:	b8 05 00 00 00       	mov    $0x5,%eax
     2e8:	cd 40                	int    $0x40
     2ea:	c3                   	ret    

000002eb <write>:
SYSCALL(write)
     2eb:	b8 10 00 00 00       	mov    $0x10,%eax
     2f0:	cd 40                	int    $0x40
     2f2:	c3                   	ret    

000002f3 <close>:
SYSCALL(close)
     2f3:	b8 15 00 00 00       	mov    $0x15,%eax
     2f8:	cd 40                	int    $0x40
     2fa:	c3                   	ret    

000002fb <kill>:
SYSCALL(kill)
     2fb:	b8 06 00 00 00       	mov    $0x6,%eax
     300:	cd 40                	int    $0x40
     302:	c3                   	ret    

00000303 <exec>:
SYSCALL(exec)
     303:	b8 07 00 00 00       	mov    $0x7,%eax
     308:	cd 40                	int    $0x40
     30a:	c3                   	ret    

0000030b <open>:
SYSCALL(open)
     30b:	b8 0f 00 00 00       	mov    $0xf,%eax
     310:	cd 40                	int    $0x40
     312:	c3                   	ret    

00000313 <mknod>:
SYSCALL(mknod)
     313:	b8 11 00 00 00       	mov    $0x11,%eax
     318:	cd 40                	int    $0x40
     31a:	c3                   	ret    

0000031b <unlink>:
SYSCALL(unlink)
     31b:	b8 12 00 00 00       	mov    $0x12,%eax
     320:	cd 40                	int    $0x40
     322:	c3                   	ret    

00000323 <fstat>:
SYSCALL(fstat)
     323:	b8 08 00 00 00       	mov    $0x8,%eax
     328:	cd 40                	int    $0x40
     32a:	c3                   	ret    

0000032b <link>:
SYSCALL(link)
     32b:	b8 13 00 00 00       	mov    $0x13,%eax
     330:	cd 40                	int    $0x40
     332:	c3                   	ret    

00000333 <mkdir>:
SYSCALL(mkdir)
     333:	b8 14 00 00 00       	mov    $0x14,%eax
     338:	cd 40                	int    $0x40
     33a:	c3                   	ret    

0000033b <chdir>:
SYSCALL(chdir)
     33b:	b8 09 00 00 00       	mov    $0x9,%eax
     340:	cd 40                	int    $0x40
     342:	c3                   	ret    

00000343 <dup>:
SYSCALL(dup)
     343:	b8 0a 00 00 00       	mov    $0xa,%eax
     348:	cd 40                	int    $0x40
     34a:	c3                   	ret    

0000034b <getpid>:
SYSCALL(getpid)
     34b:	b8 0b 00 00 00       	mov    $0xb,%eax
     350:	cd 40                	int    $0x40
     352:	c3                   	ret    

00000353 <sbrk>:
SYSCALL(sbrk)
     353:	b8 0c 00 00 00       	mov    $0xc,%eax
     358:	cd 40                	int    $0x40
     35a:	c3                   	ret    

0000035b <sleep>:
SYSCALL(sleep)
     35b:	b8 0d 00 00 00       	mov    $0xd,%eax
     360:	cd 40                	int    $0x40
     362:	c3                   	ret    

00000363 <uptime>:
SYSCALL(uptime)
     363:	b8 0e 00 00 00       	mov    $0xe,%eax
     368:	cd 40                	int    $0x40
     36a:	c3                   	ret    

0000036b <paintWindow>:

SYSCALL(paintWindow)
     36b:	b8 16 00 00 00       	mov    $0x16,%eax
     370:	cd 40                	int    $0x40
     372:	c3                   	ret    

00000373 <sendMessage>:
SYSCALL(sendMessage)
     373:	b8 17 00 00 00       	mov    $0x17,%eax
     378:	cd 40                	int    $0x40
     37a:	c3                   	ret    

0000037b <getMessage>:
SYSCALL(getMessage)
     37b:	b8 19 00 00 00       	mov    $0x19,%eax
     380:	cd 40                	int    $0x40
     382:	c3                   	ret    

00000383 <registWindow>:
SYSCALL(registWindow)
     383:	b8 18 00 00 00       	mov    $0x18,%eax
     388:	cd 40                	int    $0x40
     38a:	c3                   	ret    

0000038b <changePosition>:
SYSCALL(changePosition)
     38b:	b8 1a 00 00 00       	mov    $0x1a,%eax
     390:	cd 40                	int    $0x40
     392:	c3                   	ret    

00000393 <setupTimer>:
SYSCALL(setupTimer)
     393:	b8 1b 00 00 00       	mov    $0x1b,%eax
     398:	cd 40                	int    $0x40
     39a:	c3                   	ret    

0000039b <deleteTimer>:
SYSCALL(deleteTimer)
     39b:	b8 1c 00 00 00       	mov    $0x1c,%eax
     3a0:	cd 40                	int    $0x40
     3a2:	c3                   	ret    

000003a3 <getCurrentTime>:
SYSCALL(getCurrentTime)
     3a3:	b8 1d 00 00 00       	mov    $0x1d,%eax
     3a8:	cd 40                	int    $0x40
     3aa:	c3                   	ret    

000003ab <removeWindow>:
SYSCALL(removeWindow)
     3ab:	b8 1e 00 00 00       	mov    $0x1e,%eax
     3b0:	cd 40                	int    $0x40
     3b2:	c3                   	ret    

000003b3 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3b3:	55                   	push   %ebp
     3b4:	89 e5                	mov    %esp,%ebp
     3b6:	83 ec 18             	sub    $0x18,%esp
     3b9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3bc:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3bf:	83 ec 04             	sub    $0x4,%esp
     3c2:	6a 01                	push   $0x1
     3c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3c7:	50                   	push   %eax
     3c8:	ff 75 08             	pushl  0x8(%ebp)
     3cb:	e8 1b ff ff ff       	call   2eb <write>
     3d0:	83 c4 10             	add    $0x10,%esp
}
     3d3:	90                   	nop
     3d4:	c9                   	leave  
     3d5:	c3                   	ret    

000003d6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3d6:	55                   	push   %ebp
     3d7:	89 e5                	mov    %esp,%ebp
     3d9:	53                   	push   %ebx
     3da:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3dd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3e4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3e8:	74 17                	je     401 <printint+0x2b>
     3ea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3ee:	79 11                	jns    401 <printint+0x2b>
    neg = 1;
     3f0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3f7:	8b 45 0c             	mov    0xc(%ebp),%eax
     3fa:	f7 d8                	neg    %eax
     3fc:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3ff:	eb 06                	jmp    407 <printint+0x31>
  } else {
    x = xx;
     401:	8b 45 0c             	mov    0xc(%ebp),%eax
     404:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     407:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     40e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     411:	8d 41 01             	lea    0x1(%ecx),%eax
     414:	89 45 f4             	mov    %eax,-0xc(%ebp)
     417:	8b 5d 10             	mov    0x10(%ebp),%ebx
     41a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     41d:	ba 00 00 00 00       	mov    $0x0,%edx
     422:	f7 f3                	div    %ebx
     424:	89 d0                	mov    %edx,%eax
     426:	0f b6 80 e0 2b 00 00 	movzbl 0x2be0(%eax),%eax
     42d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     431:	8b 5d 10             	mov    0x10(%ebp),%ebx
     434:	8b 45 ec             	mov    -0x14(%ebp),%eax
     437:	ba 00 00 00 00       	mov    $0x0,%edx
     43c:	f7 f3                	div    %ebx
     43e:	89 45 ec             	mov    %eax,-0x14(%ebp)
     441:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     445:	75 c7                	jne    40e <printint+0x38>
  if(neg)
     447:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     44b:	74 2d                	je     47a <printint+0xa4>
    buf[i++] = '-';
     44d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     450:	8d 50 01             	lea    0x1(%eax),%edx
     453:	89 55 f4             	mov    %edx,-0xc(%ebp)
     456:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     45b:	eb 1d                	jmp    47a <printint+0xa4>
    putc(fd, buf[i]);
     45d:	8d 55 dc             	lea    -0x24(%ebp),%edx
     460:	8b 45 f4             	mov    -0xc(%ebp),%eax
     463:	01 d0                	add    %edx,%eax
     465:	0f b6 00             	movzbl (%eax),%eax
     468:	0f be c0             	movsbl %al,%eax
     46b:	83 ec 08             	sub    $0x8,%esp
     46e:	50                   	push   %eax
     46f:	ff 75 08             	pushl  0x8(%ebp)
     472:	e8 3c ff ff ff       	call   3b3 <putc>
     477:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     47a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     47e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     482:	79 d9                	jns    45d <printint+0x87>
    putc(fd, buf[i]);
}
     484:	90                   	nop
     485:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     488:	c9                   	leave  
     489:	c3                   	ret    

0000048a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     48a:	55                   	push   %ebp
     48b:	89 e5                	mov    %esp,%ebp
     48d:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     490:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     497:	8d 45 0c             	lea    0xc(%ebp),%eax
     49a:	83 c0 04             	add    $0x4,%eax
     49d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     4a0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4a7:	e9 59 01 00 00       	jmp    605 <printf+0x17b>
    c = fmt[i] & 0xff;
     4ac:	8b 55 0c             	mov    0xc(%ebp),%edx
     4af:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4b2:	01 d0                	add    %edx,%eax
     4b4:	0f b6 00             	movzbl (%eax),%eax
     4b7:	0f be c0             	movsbl %al,%eax
     4ba:	25 ff 00 00 00       	and    $0xff,%eax
     4bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4c2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4c6:	75 2c                	jne    4f4 <printf+0x6a>
      if(c == '%'){
     4c8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4cc:	75 0c                	jne    4da <printf+0x50>
        state = '%';
     4ce:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4d5:	e9 27 01 00 00       	jmp    601 <printf+0x177>
      } else {
        putc(fd, c);
     4da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4dd:	0f be c0             	movsbl %al,%eax
     4e0:	83 ec 08             	sub    $0x8,%esp
     4e3:	50                   	push   %eax
     4e4:	ff 75 08             	pushl  0x8(%ebp)
     4e7:	e8 c7 fe ff ff       	call   3b3 <putc>
     4ec:	83 c4 10             	add    $0x10,%esp
     4ef:	e9 0d 01 00 00       	jmp    601 <printf+0x177>
      }
    } else if(state == '%'){
     4f4:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4f8:	0f 85 03 01 00 00    	jne    601 <printf+0x177>
      if(c == 'd'){
     4fe:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     502:	75 1e                	jne    522 <printf+0x98>
        printint(fd, *ap, 10, 1);
     504:	8b 45 e8             	mov    -0x18(%ebp),%eax
     507:	8b 00                	mov    (%eax),%eax
     509:	6a 01                	push   $0x1
     50b:	6a 0a                	push   $0xa
     50d:	50                   	push   %eax
     50e:	ff 75 08             	pushl  0x8(%ebp)
     511:	e8 c0 fe ff ff       	call   3d6 <printint>
     516:	83 c4 10             	add    $0x10,%esp
        ap++;
     519:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     51d:	e9 d8 00 00 00       	jmp    5fa <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     522:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     526:	74 06                	je     52e <printf+0xa4>
     528:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     52c:	75 1e                	jne    54c <printf+0xc2>
        printint(fd, *ap, 16, 0);
     52e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     531:	8b 00                	mov    (%eax),%eax
     533:	6a 00                	push   $0x0
     535:	6a 10                	push   $0x10
     537:	50                   	push   %eax
     538:	ff 75 08             	pushl  0x8(%ebp)
     53b:	e8 96 fe ff ff       	call   3d6 <printint>
     540:	83 c4 10             	add    $0x10,%esp
        ap++;
     543:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     547:	e9 ae 00 00 00       	jmp    5fa <printf+0x170>
      } else if(c == 's'){
     54c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     550:	75 43                	jne    595 <printf+0x10b>
        s = (char*)*ap;
     552:	8b 45 e8             	mov    -0x18(%ebp),%eax
     555:	8b 00                	mov    (%eax),%eax
     557:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     55a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     55e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     562:	75 25                	jne    589 <printf+0xff>
          s = "(null)";
     564:	c7 45 f4 cb 24 00 00 	movl   $0x24cb,-0xc(%ebp)
        while(*s != 0){
     56b:	eb 1c                	jmp    589 <printf+0xff>
          putc(fd, *s);
     56d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     570:	0f b6 00             	movzbl (%eax),%eax
     573:	0f be c0             	movsbl %al,%eax
     576:	83 ec 08             	sub    $0x8,%esp
     579:	50                   	push   %eax
     57a:	ff 75 08             	pushl  0x8(%ebp)
     57d:	e8 31 fe ff ff       	call   3b3 <putc>
     582:	83 c4 10             	add    $0x10,%esp
          s++;
     585:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     589:	8b 45 f4             	mov    -0xc(%ebp),%eax
     58c:	0f b6 00             	movzbl (%eax),%eax
     58f:	84 c0                	test   %al,%al
     591:	75 da                	jne    56d <printf+0xe3>
     593:	eb 65                	jmp    5fa <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     595:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     599:	75 1d                	jne    5b8 <printf+0x12e>
        putc(fd, *ap);
     59b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     59e:	8b 00                	mov    (%eax),%eax
     5a0:	0f be c0             	movsbl %al,%eax
     5a3:	83 ec 08             	sub    $0x8,%esp
     5a6:	50                   	push   %eax
     5a7:	ff 75 08             	pushl  0x8(%ebp)
     5aa:	e8 04 fe ff ff       	call   3b3 <putc>
     5af:	83 c4 10             	add    $0x10,%esp
        ap++;
     5b2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5b6:	eb 42                	jmp    5fa <printf+0x170>
      } else if(c == '%'){
     5b8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5bc:	75 17                	jne    5d5 <printf+0x14b>
        putc(fd, c);
     5be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5c1:	0f be c0             	movsbl %al,%eax
     5c4:	83 ec 08             	sub    $0x8,%esp
     5c7:	50                   	push   %eax
     5c8:	ff 75 08             	pushl  0x8(%ebp)
     5cb:	e8 e3 fd ff ff       	call   3b3 <putc>
     5d0:	83 c4 10             	add    $0x10,%esp
     5d3:	eb 25                	jmp    5fa <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5d5:	83 ec 08             	sub    $0x8,%esp
     5d8:	6a 25                	push   $0x25
     5da:	ff 75 08             	pushl  0x8(%ebp)
     5dd:	e8 d1 fd ff ff       	call   3b3 <putc>
     5e2:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5e8:	0f be c0             	movsbl %al,%eax
     5eb:	83 ec 08             	sub    $0x8,%esp
     5ee:	50                   	push   %eax
     5ef:	ff 75 08             	pushl  0x8(%ebp)
     5f2:	e8 bc fd ff ff       	call   3b3 <putc>
     5f7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5fa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     601:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     605:	8b 55 0c             	mov    0xc(%ebp),%edx
     608:	8b 45 f0             	mov    -0x10(%ebp),%eax
     60b:	01 d0                	add    %edx,%eax
     60d:	0f b6 00             	movzbl (%eax),%eax
     610:	84 c0                	test   %al,%al
     612:	0f 85 94 fe ff ff    	jne    4ac <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     618:	90                   	nop
     619:	c9                   	leave  
     61a:	c3                   	ret    

0000061b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     61b:	55                   	push   %ebp
     61c:	89 e5                	mov    %esp,%ebp
     61e:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     621:	8b 45 08             	mov    0x8(%ebp),%eax
     624:	83 e8 08             	sub    $0x8,%eax
     627:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     62a:	a1 40 68 00 00       	mov    0x6840,%eax
     62f:	89 45 fc             	mov    %eax,-0x4(%ebp)
     632:	eb 24                	jmp    658 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     634:	8b 45 fc             	mov    -0x4(%ebp),%eax
     637:	8b 00                	mov    (%eax),%eax
     639:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     63c:	77 12                	ja     650 <free+0x35>
     63e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     641:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     644:	77 24                	ja     66a <free+0x4f>
     646:	8b 45 fc             	mov    -0x4(%ebp),%eax
     649:	8b 00                	mov    (%eax),%eax
     64b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     64e:	77 1a                	ja     66a <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     650:	8b 45 fc             	mov    -0x4(%ebp),%eax
     653:	8b 00                	mov    (%eax),%eax
     655:	89 45 fc             	mov    %eax,-0x4(%ebp)
     658:	8b 45 f8             	mov    -0x8(%ebp),%eax
     65b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     65e:	76 d4                	jbe    634 <free+0x19>
     660:	8b 45 fc             	mov    -0x4(%ebp),%eax
     663:	8b 00                	mov    (%eax),%eax
     665:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     668:	76 ca                	jbe    634 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     66a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     66d:	8b 40 04             	mov    0x4(%eax),%eax
     670:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     677:	8b 45 f8             	mov    -0x8(%ebp),%eax
     67a:	01 c2                	add    %eax,%edx
     67c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67f:	8b 00                	mov    (%eax),%eax
     681:	39 c2                	cmp    %eax,%edx
     683:	75 24                	jne    6a9 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     685:	8b 45 f8             	mov    -0x8(%ebp),%eax
     688:	8b 50 04             	mov    0x4(%eax),%edx
     68b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68e:	8b 00                	mov    (%eax),%eax
     690:	8b 40 04             	mov    0x4(%eax),%eax
     693:	01 c2                	add    %eax,%edx
     695:	8b 45 f8             	mov    -0x8(%ebp),%eax
     698:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69e:	8b 00                	mov    (%eax),%eax
     6a0:	8b 10                	mov    (%eax),%edx
     6a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a5:	89 10                	mov    %edx,(%eax)
     6a7:	eb 0a                	jmp    6b3 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ac:	8b 10                	mov    (%eax),%edx
     6ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b1:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b6:	8b 40 04             	mov    0x4(%eax),%eax
     6b9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c3:	01 d0                	add    %edx,%eax
     6c5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6c8:	75 20                	jne    6ea <free+0xcf>
    p->s.size += bp->s.size;
     6ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cd:	8b 50 04             	mov    0x4(%eax),%edx
     6d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6d3:	8b 40 04             	mov    0x4(%eax),%eax
     6d6:	01 c2                	add    %eax,%edx
     6d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6db:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6de:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6e1:	8b 10                	mov    (%eax),%edx
     6e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e6:	89 10                	mov    %edx,(%eax)
     6e8:	eb 08                	jmp    6f2 <free+0xd7>
  } else
    p->s.ptr = bp;
     6ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ed:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6f0:	89 10                	mov    %edx,(%eax)
  freep = p;
     6f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f5:	a3 40 68 00 00       	mov    %eax,0x6840
}
     6fa:	90                   	nop
     6fb:	c9                   	leave  
     6fc:	c3                   	ret    

000006fd <morecore>:

static Header*
morecore(uint nu)
{
     6fd:	55                   	push   %ebp
     6fe:	89 e5                	mov    %esp,%ebp
     700:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     703:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     70a:	77 07                	ja     713 <morecore+0x16>
    nu = 4096;
     70c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     713:	8b 45 08             	mov    0x8(%ebp),%eax
     716:	c1 e0 03             	shl    $0x3,%eax
     719:	83 ec 0c             	sub    $0xc,%esp
     71c:	50                   	push   %eax
     71d:	e8 31 fc ff ff       	call   353 <sbrk>
     722:	83 c4 10             	add    $0x10,%esp
     725:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     728:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     72c:	75 07                	jne    735 <morecore+0x38>
    return 0;
     72e:	b8 00 00 00 00       	mov    $0x0,%eax
     733:	eb 26                	jmp    75b <morecore+0x5e>
  hp = (Header*)p;
     735:	8b 45 f4             	mov    -0xc(%ebp),%eax
     738:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     73b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     73e:	8b 55 08             	mov    0x8(%ebp),%edx
     741:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     744:	8b 45 f0             	mov    -0x10(%ebp),%eax
     747:	83 c0 08             	add    $0x8,%eax
     74a:	83 ec 0c             	sub    $0xc,%esp
     74d:	50                   	push   %eax
     74e:	e8 c8 fe ff ff       	call   61b <free>
     753:	83 c4 10             	add    $0x10,%esp
  return freep;
     756:	a1 40 68 00 00       	mov    0x6840,%eax
}
     75b:	c9                   	leave  
     75c:	c3                   	ret    

0000075d <malloc>:

void*
malloc(uint nbytes)
{
     75d:	55                   	push   %ebp
     75e:	89 e5                	mov    %esp,%ebp
     760:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     763:	8b 45 08             	mov    0x8(%ebp),%eax
     766:	83 c0 07             	add    $0x7,%eax
     769:	c1 e8 03             	shr    $0x3,%eax
     76c:	83 c0 01             	add    $0x1,%eax
     76f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     772:	a1 40 68 00 00       	mov    0x6840,%eax
     777:	89 45 f0             	mov    %eax,-0x10(%ebp)
     77a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     77e:	75 23                	jne    7a3 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     780:	c7 45 f0 38 68 00 00 	movl   $0x6838,-0x10(%ebp)
     787:	8b 45 f0             	mov    -0x10(%ebp),%eax
     78a:	a3 40 68 00 00       	mov    %eax,0x6840
     78f:	a1 40 68 00 00       	mov    0x6840,%eax
     794:	a3 38 68 00 00       	mov    %eax,0x6838
    base.s.size = 0;
     799:	c7 05 3c 68 00 00 00 	movl   $0x0,0x683c
     7a0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7a6:	8b 00                	mov    (%eax),%eax
     7a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ae:	8b 40 04             	mov    0x4(%eax),%eax
     7b1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7b4:	72 4d                	jb     803 <malloc+0xa6>
      if(p->s.size == nunits)
     7b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b9:	8b 40 04             	mov    0x4(%eax),%eax
     7bc:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7bf:	75 0c                	jne    7cd <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c4:	8b 10                	mov    (%eax),%edx
     7c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7c9:	89 10                	mov    %edx,(%eax)
     7cb:	eb 26                	jmp    7f3 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d0:	8b 40 04             	mov    0x4(%eax),%eax
     7d3:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7d6:	89 c2                	mov    %eax,%edx
     7d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7db:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7de:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e1:	8b 40 04             	mov    0x4(%eax),%eax
     7e4:	c1 e0 03             	shl    $0x3,%eax
     7e7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ed:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7f0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7f6:	a3 40 68 00 00       	mov    %eax,0x6840
      return (void*)(p + 1);
     7fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7fe:	83 c0 08             	add    $0x8,%eax
     801:	eb 3b                	jmp    83e <malloc+0xe1>
    }
    if(p == freep)
     803:	a1 40 68 00 00       	mov    0x6840,%eax
     808:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     80b:	75 1e                	jne    82b <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     80d:	83 ec 0c             	sub    $0xc,%esp
     810:	ff 75 ec             	pushl  -0x14(%ebp)
     813:	e8 e5 fe ff ff       	call   6fd <morecore>
     818:	83 c4 10             	add    $0x10,%esp
     81b:	89 45 f4             	mov    %eax,-0xc(%ebp)
     81e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     822:	75 07                	jne    82b <malloc+0xce>
        return 0;
     824:	b8 00 00 00 00       	mov    $0x0,%eax
     829:	eb 13                	jmp    83e <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     82b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     82e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     831:	8b 45 f4             	mov    -0xc(%ebp),%eax
     834:	8b 00                	mov    (%eax),%eax
     836:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     839:	e9 6d ff ff ff       	jmp    7ab <malloc+0x4e>
}
     83e:	c9                   	leave  
     83f:	c3                   	ret    

00000840 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     840:	55                   	push   %ebp
     841:	89 e5                	mov    %esp,%ebp
     843:	83 ec 1c             	sub    $0x1c,%esp
     846:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     849:	8b 55 10             	mov    0x10(%ebp),%edx
     84c:	8b 45 14             	mov    0x14(%ebp),%eax
     84f:	88 4d ec             	mov    %cl,-0x14(%ebp)
     852:	88 55 e8             	mov    %dl,-0x18(%ebp)
     855:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     858:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     85c:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     85f:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     863:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     866:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     86a:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     86d:	8b 45 08             	mov    0x8(%ebp),%eax
     870:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     874:	66 89 10             	mov    %dx,(%eax)
     877:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     87b:	88 50 02             	mov    %dl,0x2(%eax)
}
     87e:	8b 45 08             	mov    0x8(%ebp),%eax
     881:	c9                   	leave  
     882:	c2 04 00             	ret    $0x4

00000885 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     885:	55                   	push   %ebp
     886:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     888:	8b 45 08             	mov    0x8(%ebp),%eax
     88b:	2b 45 10             	sub    0x10(%ebp),%eax
     88e:	89 c2                	mov    %eax,%edx
     890:	8b 45 08             	mov    0x8(%ebp),%eax
     893:	2b 45 10             	sub    0x10(%ebp),%eax
     896:	0f af d0             	imul   %eax,%edx
     899:	8b 45 0c             	mov    0xc(%ebp),%eax
     89c:	2b 45 14             	sub    0x14(%ebp),%eax
     89f:	89 c1                	mov    %eax,%ecx
     8a1:	8b 45 0c             	mov    0xc(%ebp),%eax
     8a4:	2b 45 14             	sub    0x14(%ebp),%eax
     8a7:	0f af c1             	imul   %ecx,%eax
     8aa:	01 d0                	add    %edx,%eax
}
     8ac:	5d                   	pop    %ebp
     8ad:	c3                   	ret    

000008ae <abs_int>:

static inline int abs_int(int x)
{
     8ae:	55                   	push   %ebp
     8af:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     8b1:	8b 45 08             	mov    0x8(%ebp),%eax
     8b4:	99                   	cltd   
     8b5:	89 d0                	mov    %edx,%eax
     8b7:	33 45 08             	xor    0x8(%ebp),%eax
     8ba:	29 d0                	sub    %edx,%eax
}
     8bc:	5d                   	pop    %ebp
     8bd:	c3                   	ret    

000008be <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     8be:	55                   	push   %ebp
     8bf:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     8c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8c5:	79 07                	jns    8ce <APGetIndex+0x10>
        return X_SMALLER;
     8c7:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8cc:	eb 40                	jmp    90e <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8ce:	8b 45 08             	mov    0x8(%ebp),%eax
     8d1:	8b 00                	mov    (%eax),%eax
     8d3:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8d6:	7f 07                	jg     8df <APGetIndex+0x21>
        return X_BIGGER;
     8d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8dd:	eb 2f                	jmp    90e <APGetIndex+0x50>
    if (y < 0)
     8df:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8e3:	79 07                	jns    8ec <APGetIndex+0x2e>
        return Y_SMALLER;
     8e5:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8ea:	eb 22                	jmp    90e <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8ec:	8b 45 08             	mov    0x8(%ebp),%eax
     8ef:	8b 40 04             	mov    0x4(%eax),%eax
     8f2:	3b 45 10             	cmp    0x10(%ebp),%eax
     8f5:	7f 07                	jg     8fe <APGetIndex+0x40>
        return Y_BIGGER;
     8f7:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8fc:	eb 10                	jmp    90e <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8fe:	8b 45 08             	mov    0x8(%ebp),%eax
     901:	8b 00                	mov    (%eax),%eax
     903:	0f af 45 10          	imul   0x10(%ebp),%eax
     907:	89 c2                	mov    %eax,%edx
     909:	8b 45 0c             	mov    0xc(%ebp),%eax
     90c:	01 d0                	add    %edx,%eax
}
     90e:	5d                   	pop    %ebp
     90f:	c3                   	ret    

00000910 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     916:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     91d:	8b 45 cc             	mov    -0x34(%ebp),%eax
     920:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     923:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     92a:	83 ec 08             	sub    $0x8,%esp
     92d:	6a 00                	push   $0x0
     92f:	ff 75 0c             	pushl  0xc(%ebp)
     932:	e8 d4 f9 ff ff       	call   30b <open>
     937:	83 c4 10             	add    $0x10,%esp
     93a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     93d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     941:	79 2e                	jns    971 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     943:	83 ec 04             	sub    $0x4,%esp
     946:	ff 75 0c             	pushl  0xc(%ebp)
     949:	68 d2 24 00 00       	push   $0x24d2
     94e:	6a 01                	push   $0x1
     950:	e8 35 fb ff ff       	call   48a <printf>
     955:	83 c4 10             	add    $0x10,%esp
        return bmp;
     958:	8b 45 08             	mov    0x8(%ebp),%eax
     95b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     95e:	89 10                	mov    %edx,(%eax)
     960:	8b 55 cc             	mov    -0x34(%ebp),%edx
     963:	89 50 04             	mov    %edx,0x4(%eax)
     966:	8b 55 d0             	mov    -0x30(%ebp),%edx
     969:	89 50 08             	mov    %edx,0x8(%eax)
     96c:	e9 d2 01 00 00       	jmp    b43 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     971:	83 ec 04             	sub    $0x4,%esp
     974:	6a 0e                	push   $0xe
     976:	8d 45 ba             	lea    -0x46(%ebp),%eax
     979:	50                   	push   %eax
     97a:	ff 75 ec             	pushl  -0x14(%ebp)
     97d:	e8 61 f9 ff ff       	call   2e3 <read>
     982:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     985:	83 ec 04             	sub    $0x4,%esp
     988:	6a 28                	push   $0x28
     98a:	8d 45 92             	lea    -0x6e(%ebp),%eax
     98d:	50                   	push   %eax
     98e:	ff 75 ec             	pushl  -0x14(%ebp)
     991:	e8 4d f9 ff ff       	call   2e3 <read>
     996:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     999:	8b 45 96             	mov    -0x6a(%ebp),%eax
     99c:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     99f:	8b 45 9a             	mov    -0x66(%ebp),%eax
     9a2:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     9a5:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9a8:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9ab:	0f af d0             	imul   %eax,%edx
     9ae:	89 d0                	mov    %edx,%eax
     9b0:	01 c0                	add    %eax,%eax
     9b2:	01 d0                	add    %edx,%eax
     9b4:	83 ec 0c             	sub    $0xc,%esp
     9b7:	50                   	push   %eax
     9b8:	e8 a0 fd ff ff       	call   75d <malloc>
     9bd:	83 c4 10             	add    $0x10,%esp
     9c0:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9c3:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9c7:	0f b7 c0             	movzwl %ax,%eax
     9ca:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9cd:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9d0:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9d3:	0f af c2             	imul   %edx,%eax
     9d6:	83 c0 1f             	add    $0x1f,%eax
     9d9:	c1 e8 05             	shr    $0x5,%eax
     9dc:	c1 e0 02             	shl    $0x2,%eax
     9df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9e2:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9e8:	0f af c2             	imul   %edx,%eax
     9eb:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9f1:	83 ec 0c             	sub    $0xc,%esp
     9f4:	50                   	push   %eax
     9f5:	e8 63 fd ff ff       	call   75d <malloc>
     9fa:	83 c4 10             	add    $0x10,%esp
     9fd:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a00:	83 ec 04             	sub    $0x4,%esp
     a03:	ff 75 e0             	pushl  -0x20(%ebp)
     a06:	ff 75 dc             	pushl  -0x24(%ebp)
     a09:	ff 75 ec             	pushl  -0x14(%ebp)
     a0c:	e8 d2 f8 ff ff       	call   2e3 <read>
     a11:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a14:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a18:	66 c1 e8 03          	shr    $0x3,%ax
     a1c:	0f b7 c0             	movzwl %ax,%eax
     a1f:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a29:	e9 e5 00 00 00       	jmp    b13 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a2e:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a31:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a34:	29 c2                	sub    %eax,%edx
     a36:	89 d0                	mov    %edx,%eax
     a38:	8d 50 ff             	lea    -0x1(%eax),%edx
     a3b:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a3e:	0f af c2             	imul   %edx,%eax
     a41:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a44:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a4b:	e9 b1 00 00 00       	jmp    b01 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a50:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a53:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a56:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a59:	01 c8                	add    %ecx,%eax
     a5b:	89 c1                	mov    %eax,%ecx
     a5d:	89 c8                	mov    %ecx,%eax
     a5f:	01 c0                	add    %eax,%eax
     a61:	01 c8                	add    %ecx,%eax
     a63:	01 c2                	add    %eax,%edx
     a65:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a68:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a6c:	89 c1                	mov    %eax,%ecx
     a6e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a71:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a75:	01 c1                	add    %eax,%ecx
     a77:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a7a:	01 c8                	add    %ecx,%eax
     a7c:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a7f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a82:	01 c8                	add    %ecx,%eax
     a84:	0f b6 00             	movzbl (%eax),%eax
     a87:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a8a:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a8d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a90:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a93:	01 c8                	add    %ecx,%eax
     a95:	89 c1                	mov    %eax,%ecx
     a97:	89 c8                	mov    %ecx,%eax
     a99:	01 c0                	add    %eax,%eax
     a9b:	01 c8                	add    %ecx,%eax
     a9d:	01 c2                	add    %eax,%edx
     a9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa2:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     aa6:	89 c1                	mov    %eax,%ecx
     aa8:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aab:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     aaf:	01 c1                	add    %eax,%ecx
     ab1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ab4:	01 c8                	add    %ecx,%eax
     ab6:	8d 48 fe             	lea    -0x2(%eax),%ecx
     ab9:	8b 45 dc             	mov    -0x24(%ebp),%eax
     abc:	01 c8                	add    %ecx,%eax
     abe:	0f b6 00             	movzbl (%eax),%eax
     ac1:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     ac4:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ac7:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     aca:	8b 45 f0             	mov    -0x10(%ebp),%eax
     acd:	01 c8                	add    %ecx,%eax
     acf:	89 c1                	mov    %eax,%ecx
     ad1:	89 c8                	mov    %ecx,%eax
     ad3:	01 c0                	add    %eax,%eax
     ad5:	01 c8                	add    %ecx,%eax
     ad7:	01 c2                	add    %eax,%edx
     ad9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     adc:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ae0:	89 c1                	mov    %eax,%ecx
     ae2:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ae5:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ae9:	01 c1                	add    %eax,%ecx
     aeb:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aee:	01 c8                	add    %ecx,%eax
     af0:	8d 48 fd             	lea    -0x3(%eax),%ecx
     af3:	8b 45 dc             	mov    -0x24(%ebp),%eax
     af6:	01 c8                	add    %ecx,%eax
     af8:	0f b6 00             	movzbl (%eax),%eax
     afb:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     afd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b01:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b04:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b07:	39 c2                	cmp    %eax,%edx
     b09:	0f 87 41 ff ff ff    	ja     a50 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b0f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b13:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b16:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b19:	39 c2                	cmp    %eax,%edx
     b1b:	0f 87 0d ff ff ff    	ja     a2e <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b21:	83 ec 0c             	sub    $0xc,%esp
     b24:	ff 75 ec             	pushl  -0x14(%ebp)
     b27:	e8 c7 f7 ff ff       	call   2f3 <close>
     b2c:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b2f:	8b 45 08             	mov    0x8(%ebp),%eax
     b32:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b35:	89 10                	mov    %edx,(%eax)
     b37:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b3a:	89 50 04             	mov    %edx,0x4(%eax)
     b3d:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b40:	89 50 08             	mov    %edx,0x8(%eax)
}
     b43:	8b 45 08             	mov    0x8(%ebp),%eax
     b46:	c9                   	leave  
     b47:	c2 04 00             	ret    $0x4

00000b4a <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b4a:	55                   	push   %ebp
     b4b:	89 e5                	mov    %esp,%ebp
     b4d:	53                   	push   %ebx
     b4e:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b51:	83 ec 0c             	sub    $0xc,%esp
     b54:	6a 1c                	push   $0x1c
     b56:	e8 02 fc ff ff       	call   75d <malloc>
     b5b:	83 c4 10             	add    $0x10,%esp
     b5e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b61:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b64:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b6b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b6e:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b71:	6a 0c                	push   $0xc
     b73:	6a 0c                	push   $0xc
     b75:	6a 0c                	push   $0xc
     b77:	50                   	push   %eax
     b78:	e8 c3 fc ff ff       	call   840 <RGB>
     b7d:	83 c4 0c             	add    $0xc,%esp
     b80:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b84:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b88:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b8c:	88 43 15             	mov    %al,0x15(%ebx)
     b8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b92:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b95:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b99:	66 89 48 10          	mov    %cx,0x10(%eax)
     b9d:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     ba1:	88 50 12             	mov    %dl,0x12(%eax)
     ba4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba7:	8b 55 f4             	mov    -0xc(%ebp),%edx
     baa:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     bae:	66 89 48 08          	mov    %cx,0x8(%eax)
     bb2:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     bb6:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     bb9:	8b 45 08             	mov    0x8(%ebp),%eax
     bbc:	89 c2                	mov    %eax,%edx
     bbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc1:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     bc3:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc6:	89 c2                	mov    %eax,%edx
     bc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bcb:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bce:	8b 55 10             	mov    0x10(%ebp),%edx
     bd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd4:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     bd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bdd:	c9                   	leave  
     bde:	c3                   	ret    

00000bdf <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     bdf:	55                   	push   %ebp
     be0:	89 e5                	mov    %esp,%ebp
     be2:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     be5:	8b 45 0c             	mov    0xc(%ebp),%eax
     be8:	8b 50 08             	mov    0x8(%eax),%edx
     beb:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bee:	8b 40 0c             	mov    0xc(%eax),%eax
     bf1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     bf4:	8b 45 0c             	mov    0xc(%ebp),%eax
     bf7:	8b 55 10             	mov    0x10(%ebp),%edx
     bfa:	89 50 08             	mov    %edx,0x8(%eax)
     bfd:	8b 55 14             	mov    0x14(%ebp),%edx
     c00:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c03:	8b 45 08             	mov    0x8(%ebp),%eax
     c06:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c09:	89 10                	mov    %edx,(%eax)
     c0b:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c0e:	89 50 04             	mov    %edx,0x4(%eax)
}
     c11:	8b 45 08             	mov    0x8(%ebp),%eax
     c14:	c9                   	leave  
     c15:	c2 04 00             	ret    $0x4

00000c18 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c18:	55                   	push   %ebp
     c19:	89 e5                	mov    %esp,%ebp
     c1b:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c1e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c21:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c25:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c29:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c2d:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c30:	8b 45 0c             	mov    0xc(%ebp),%eax
     c33:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c37:	66 89 50 10          	mov    %dx,0x10(%eax)
     c3b:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c3f:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c42:	8b 45 08             	mov    0x8(%ebp),%eax
     c45:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c49:	66 89 10             	mov    %dx,(%eax)
     c4c:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c50:	88 50 02             	mov    %dl,0x2(%eax)
}
     c53:	8b 45 08             	mov    0x8(%ebp),%eax
     c56:	c9                   	leave  
     c57:	c2 04 00             	ret    $0x4

00000c5a <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     c5a:	55                   	push   %ebp
     c5b:	89 e5                	mov    %esp,%ebp
     c5d:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     c60:	8b 45 0c             	mov    0xc(%ebp),%eax
     c63:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     c67:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c6b:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     c6f:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     c72:	8b 45 0c             	mov    0xc(%ebp),%eax
     c75:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c79:	66 89 50 13          	mov    %dx,0x13(%eax)
     c7d:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c81:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     c84:	8b 45 08             	mov    0x8(%ebp),%eax
     c87:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c8b:	66 89 10             	mov    %dx,(%eax)
     c8e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c92:	88 50 02             	mov    %dl,0x2(%eax)
}
     c95:	8b 45 08             	mov    0x8(%ebp),%eax
     c98:	c9                   	leave  
     c99:	c2 04 00             	ret    $0x4

00000c9c <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c9c:	55                   	push   %ebp
     c9d:	89 e5                	mov    %esp,%ebp
     c9f:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     ca2:	8b 45 08             	mov    0x8(%ebp),%eax
     ca5:	8b 40 0c             	mov    0xc(%eax),%eax
     ca8:	89 c2                	mov    %eax,%edx
     caa:	c1 ea 1f             	shr    $0x1f,%edx
     cad:	01 d0                	add    %edx,%eax
     caf:	d1 f8                	sar    %eax
     cb1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     cb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cb7:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     cbb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     cbe:	8b 45 10             	mov    0x10(%ebp),%eax
     cc1:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cc4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     cc7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     ccb:	0f 89 98 00 00 00    	jns    d69 <APDrawPoint+0xcd>
        i = 0;
     cd1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     cd8:	e9 8c 00 00 00       	jmp    d69 <APDrawPoint+0xcd>
    {
        j = x - off;
     cdd:	8b 45 0c             	mov    0xc(%ebp),%eax
     ce0:	2b 45 f4             	sub    -0xc(%ebp),%eax
     ce3:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     ce6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     cea:	79 69                	jns    d55 <APDrawPoint+0xb9>
            j = 0;
     cec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     cf3:	eb 60                	jmp    d55 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     cf5:	ff 75 fc             	pushl  -0x4(%ebp)
     cf8:	ff 75 f8             	pushl  -0x8(%ebp)
     cfb:	ff 75 08             	pushl  0x8(%ebp)
     cfe:	e8 bb fb ff ff       	call   8be <APGetIndex>
     d03:	83 c4 0c             	add    $0xc,%esp
     d06:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d09:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d0d:	74 55                	je     d64 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d0f:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d13:	74 67                	je     d7c <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d15:	ff 75 10             	pushl  0x10(%ebp)
     d18:	ff 75 0c             	pushl  0xc(%ebp)
     d1b:	ff 75 fc             	pushl  -0x4(%ebp)
     d1e:	ff 75 f8             	pushl  -0x8(%ebp)
     d21:	e8 5f fb ff ff       	call   885 <distance_2>
     d26:	83 c4 10             	add    $0x10,%esp
     d29:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d2c:	7f 23                	jg     d51 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d2e:	8b 45 08             	mov    0x8(%ebp),%eax
     d31:	8b 48 18             	mov    0x18(%eax),%ecx
     d34:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d37:	89 d0                	mov    %edx,%eax
     d39:	01 c0                	add    %eax,%eax
     d3b:	01 d0                	add    %edx,%eax
     d3d:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d40:	8b 45 08             	mov    0x8(%ebp),%eax
     d43:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d47:	66 89 0a             	mov    %cx,(%edx)
     d4a:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d4e:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d51:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d55:	8b 55 0c             	mov    0xc(%ebp),%edx
     d58:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d5b:	01 d0                	add    %edx,%eax
     d5d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d60:	7d 93                	jge    cf5 <APDrawPoint+0x59>
     d62:	eb 01                	jmp    d65 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d64:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d65:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d69:	8b 55 10             	mov    0x10(%ebp),%edx
     d6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d6f:	01 d0                	add    %edx,%eax
     d71:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d74:	0f 8d 63 ff ff ff    	jge    cdd <APDrawPoint+0x41>
     d7a:	eb 01                	jmp    d7d <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d7c:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d7d:	c9                   	leave  
     d7e:	c3                   	ret    

00000d7f <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d7f:	55                   	push   %ebp
     d80:	89 e5                	mov    %esp,%ebp
     d82:	53                   	push   %ebx
     d83:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d86:	8b 45 0c             	mov    0xc(%ebp),%eax
     d89:	3b 45 14             	cmp    0x14(%ebp),%eax
     d8c:	0f 85 80 00 00 00    	jne    e12 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d92:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d96:	0f 88 9d 02 00 00    	js     1039 <APDrawLine+0x2ba>
     d9c:	8b 45 08             	mov    0x8(%ebp),%eax
     d9f:	8b 00                	mov    (%eax),%eax
     da1:	3b 45 0c             	cmp    0xc(%ebp),%eax
     da4:	0f 8e 8f 02 00 00    	jle    1039 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     daa:	8b 45 10             	mov    0x10(%ebp),%eax
     dad:	3b 45 18             	cmp    0x18(%ebp),%eax
     db0:	7e 12                	jle    dc4 <APDrawLine+0x45>
        {
            int tmp = y2;
     db2:	8b 45 18             	mov    0x18(%ebp),%eax
     db5:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     db8:	8b 45 10             	mov    0x10(%ebp),%eax
     dbb:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     dbe:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dc1:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     dc4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dc8:	79 07                	jns    dd1 <APDrawLine+0x52>
     dca:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     dd1:	8b 45 08             	mov    0x8(%ebp),%eax
     dd4:	8b 40 04             	mov    0x4(%eax),%eax
     dd7:	3b 45 18             	cmp    0x18(%ebp),%eax
     dda:	7d 0c                	jge    de8 <APDrawLine+0x69>
     ddc:	8b 45 08             	mov    0x8(%ebp),%eax
     ddf:	8b 40 04             	mov    0x4(%eax),%eax
     de2:	83 e8 01             	sub    $0x1,%eax
     de5:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     de8:	8b 45 10             	mov    0x10(%ebp),%eax
     deb:	89 45 f4             	mov    %eax,-0xc(%ebp)
     dee:	eb 15                	jmp    e05 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     df0:	ff 75 f4             	pushl  -0xc(%ebp)
     df3:	ff 75 0c             	pushl  0xc(%ebp)
     df6:	ff 75 08             	pushl  0x8(%ebp)
     df9:	e8 9e fe ff ff       	call   c9c <APDrawPoint>
     dfe:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e01:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e05:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e08:	3b 45 18             	cmp    0x18(%ebp),%eax
     e0b:	7e e3                	jle    df0 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e0d:	e9 2b 02 00 00       	jmp    103d <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e12:	8b 45 10             	mov    0x10(%ebp),%eax
     e15:	3b 45 18             	cmp    0x18(%ebp),%eax
     e18:	75 7f                	jne    e99 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e1a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e1e:	0f 88 18 02 00 00    	js     103c <APDrawLine+0x2bd>
     e24:	8b 45 08             	mov    0x8(%ebp),%eax
     e27:	8b 40 04             	mov    0x4(%eax),%eax
     e2a:	3b 45 10             	cmp    0x10(%ebp),%eax
     e2d:	0f 8e 09 02 00 00    	jle    103c <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e33:	8b 45 0c             	mov    0xc(%ebp),%eax
     e36:	3b 45 14             	cmp    0x14(%ebp),%eax
     e39:	7e 12                	jle    e4d <APDrawLine+0xce>
        {
            int tmp = x2;
     e3b:	8b 45 14             	mov    0x14(%ebp),%eax
     e3e:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e41:	8b 45 0c             	mov    0xc(%ebp),%eax
     e44:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e47:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e4a:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e4d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e51:	79 07                	jns    e5a <APDrawLine+0xdb>
     e53:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e5a:	8b 45 08             	mov    0x8(%ebp),%eax
     e5d:	8b 00                	mov    (%eax),%eax
     e5f:	3b 45 14             	cmp    0x14(%ebp),%eax
     e62:	7d 0b                	jge    e6f <APDrawLine+0xf0>
     e64:	8b 45 08             	mov    0x8(%ebp),%eax
     e67:	8b 00                	mov    (%eax),%eax
     e69:	83 e8 01             	sub    $0x1,%eax
     e6c:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e6f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e72:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e75:	eb 15                	jmp    e8c <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e77:	ff 75 10             	pushl  0x10(%ebp)
     e7a:	ff 75 f0             	pushl  -0x10(%ebp)
     e7d:	ff 75 08             	pushl  0x8(%ebp)
     e80:	e8 17 fe ff ff       	call   c9c <APDrawPoint>
     e85:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e88:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e8f:	3b 45 14             	cmp    0x14(%ebp),%eax
     e92:	7e e3                	jle    e77 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e94:	e9 a4 01 00 00       	jmp    103d <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e99:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     ea0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     ea7:	8b 45 0c             	mov    0xc(%ebp),%eax
     eaa:	2b 45 14             	sub    0x14(%ebp),%eax
     ead:	50                   	push   %eax
     eae:	e8 fb f9 ff ff       	call   8ae <abs_int>
     eb3:	83 c4 04             	add    $0x4,%esp
     eb6:	89 c3                	mov    %eax,%ebx
     eb8:	8b 45 10             	mov    0x10(%ebp),%eax
     ebb:	2b 45 18             	sub    0x18(%ebp),%eax
     ebe:	50                   	push   %eax
     ebf:	e8 ea f9 ff ff       	call   8ae <abs_int>
     ec4:	83 c4 04             	add    $0x4,%esp
     ec7:	39 c3                	cmp    %eax,%ebx
     ec9:	0f 8e b5 00 00 00    	jle    f84 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     ecf:	8b 45 10             	mov    0x10(%ebp),%eax
     ed2:	2b 45 18             	sub    0x18(%ebp),%eax
     ed5:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ed8:	db 45 b0             	fildl  -0x50(%ebp)
     edb:	8b 45 0c             	mov    0xc(%ebp),%eax
     ede:	2b 45 14             	sub    0x14(%ebp),%eax
     ee1:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ee4:	db 45 b0             	fildl  -0x50(%ebp)
     ee7:	de f9                	fdivrp %st,%st(1)
     ee9:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     eec:	8b 45 14             	mov    0x14(%ebp),%eax
     eef:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ef2:	7e 0e                	jle    f02 <APDrawLine+0x183>
        {
            s = x1;
     ef4:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef7:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     efa:	8b 45 14             	mov    0x14(%ebp),%eax
     efd:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f00:	eb 0c                	jmp    f0e <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f02:	8b 45 14             	mov    0x14(%ebp),%eax
     f05:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f08:	8b 45 0c             	mov    0xc(%ebp),%eax
     f0b:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f0e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f12:	79 07                	jns    f1b <APDrawLine+0x19c>
     f14:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f1b:	8b 45 08             	mov    0x8(%ebp),%eax
     f1e:	8b 00                	mov    (%eax),%eax
     f20:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f23:	7f 0b                	jg     f30 <APDrawLine+0x1b1>
     f25:	8b 45 08             	mov    0x8(%ebp),%eax
     f28:	8b 00                	mov    (%eax),%eax
     f2a:	83 e8 01             	sub    $0x1,%eax
     f2d:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f30:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f33:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f36:	eb 3f                	jmp    f77 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f38:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f3b:	2b 45 0c             	sub    0xc(%ebp),%eax
     f3e:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f41:	db 45 b0             	fildl  -0x50(%ebp)
     f44:	dc 4d d0             	fmull  -0x30(%ebp)
     f47:	db 45 10             	fildl  0x10(%ebp)
     f4a:	de c1                	faddp  %st,%st(1)
     f4c:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f4f:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f53:	b4 0c                	mov    $0xc,%ah
     f55:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f59:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f5c:	db 5d cc             	fistpl -0x34(%ebp)
     f5f:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f62:	ff 75 cc             	pushl  -0x34(%ebp)
     f65:	ff 75 e4             	pushl  -0x1c(%ebp)
     f68:	ff 75 08             	pushl  0x8(%ebp)
     f6b:	e8 2c fd ff ff       	call   c9c <APDrawPoint>
     f70:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f73:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f77:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f7a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f7d:	7e b9                	jle    f38 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f7f:	e9 b9 00 00 00       	jmp    103d <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f84:	8b 45 0c             	mov    0xc(%ebp),%eax
     f87:	2b 45 14             	sub    0x14(%ebp),%eax
     f8a:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f8d:	db 45 b0             	fildl  -0x50(%ebp)
     f90:	8b 45 10             	mov    0x10(%ebp),%eax
     f93:	2b 45 18             	sub    0x18(%ebp),%eax
     f96:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f99:	db 45 b0             	fildl  -0x50(%ebp)
     f9c:	de f9                	fdivrp %st,%st(1)
     f9e:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     fa1:	8b 45 10             	mov    0x10(%ebp),%eax
     fa4:	3b 45 18             	cmp    0x18(%ebp),%eax
     fa7:	7e 0e                	jle    fb7 <APDrawLine+0x238>
    {
        s = y2;
     fa9:	8b 45 18             	mov    0x18(%ebp),%eax
     fac:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     faf:	8b 45 10             	mov    0x10(%ebp),%eax
     fb2:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fb5:	eb 0c                	jmp    fc3 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     fb7:	8b 45 10             	mov    0x10(%ebp),%eax
     fba:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     fbd:	8b 45 18             	mov    0x18(%ebp),%eax
     fc0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     fc3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fc7:	79 07                	jns    fd0 <APDrawLine+0x251>
     fc9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     fd0:	8b 45 08             	mov    0x8(%ebp),%eax
     fd3:	8b 40 04             	mov    0x4(%eax),%eax
     fd6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fd9:	7f 0c                	jg     fe7 <APDrawLine+0x268>
     fdb:	8b 45 08             	mov    0x8(%ebp),%eax
     fde:	8b 40 04             	mov    0x4(%eax),%eax
     fe1:	83 e8 01             	sub    $0x1,%eax
     fe4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     fe7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fea:	89 45 e0             	mov    %eax,-0x20(%ebp)
     fed:	eb 3f                	jmp    102e <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     fef:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ff2:	2b 45 10             	sub    0x10(%ebp),%eax
     ff5:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ff8:	db 45 b0             	fildl  -0x50(%ebp)
     ffb:	dc 4d c0             	fmull  -0x40(%ebp)
     ffe:	db 45 0c             	fildl  0xc(%ebp)
    1001:	de c1                	faddp  %st,%st(1)
    1003:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1006:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    100a:	b4 0c                	mov    $0xc,%ah
    100c:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1010:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1013:	db 5d bc             	fistpl -0x44(%ebp)
    1016:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1019:	ff 75 e0             	pushl  -0x20(%ebp)
    101c:	ff 75 bc             	pushl  -0x44(%ebp)
    101f:	ff 75 08             	pushl  0x8(%ebp)
    1022:	e8 75 fc ff ff       	call   c9c <APDrawPoint>
    1027:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    102a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    102e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1031:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1034:	7e b9                	jle    fef <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1036:	90                   	nop
    1037:	eb 04                	jmp    103d <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1039:	90                   	nop
    103a:	eb 01                	jmp    103d <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    103c:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    103d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1040:	c9                   	leave  
    1041:	c3                   	ret    

00001042 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1042:	55                   	push   %ebp
    1043:	89 e5                	mov    %esp,%ebp
    1045:	53                   	push   %ebx
    1046:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1049:	8b 55 10             	mov    0x10(%ebp),%edx
    104c:	8b 45 18             	mov    0x18(%ebp),%eax
    104f:	01 d0                	add    %edx,%eax
    1051:	83 e8 01             	sub    $0x1,%eax
    1054:	83 ec 04             	sub    $0x4,%esp
    1057:	50                   	push   %eax
    1058:	ff 75 0c             	pushl  0xc(%ebp)
    105b:	ff 75 10             	pushl  0x10(%ebp)
    105e:	ff 75 0c             	pushl  0xc(%ebp)
    1061:	ff 75 08             	pushl  0x8(%ebp)
    1064:	e8 16 fd ff ff       	call   d7f <APDrawLine>
    1069:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    106c:	8b 55 0c             	mov    0xc(%ebp),%edx
    106f:	8b 45 14             	mov    0x14(%ebp),%eax
    1072:	01 d0                	add    %edx,%eax
    1074:	83 e8 01             	sub    $0x1,%eax
    1077:	83 ec 04             	sub    $0x4,%esp
    107a:	ff 75 10             	pushl  0x10(%ebp)
    107d:	50                   	push   %eax
    107e:	ff 75 10             	pushl  0x10(%ebp)
    1081:	ff 75 0c             	pushl  0xc(%ebp)
    1084:	ff 75 08             	pushl  0x8(%ebp)
    1087:	e8 f3 fc ff ff       	call   d7f <APDrawLine>
    108c:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    108f:	8b 55 10             	mov    0x10(%ebp),%edx
    1092:	8b 45 18             	mov    0x18(%ebp),%eax
    1095:	01 d0                	add    %edx,%eax
    1097:	8d 48 ff             	lea    -0x1(%eax),%ecx
    109a:	8b 55 0c             	mov    0xc(%ebp),%edx
    109d:	8b 45 14             	mov    0x14(%ebp),%eax
    10a0:	01 d0                	add    %edx,%eax
    10a2:	8d 50 ff             	lea    -0x1(%eax),%edx
    10a5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10a8:	8b 45 14             	mov    0x14(%ebp),%eax
    10ab:	01 d8                	add    %ebx,%eax
    10ad:	83 e8 01             	sub    $0x1,%eax
    10b0:	83 ec 04             	sub    $0x4,%esp
    10b3:	51                   	push   %ecx
    10b4:	52                   	push   %edx
    10b5:	ff 75 10             	pushl  0x10(%ebp)
    10b8:	50                   	push   %eax
    10b9:	ff 75 08             	pushl  0x8(%ebp)
    10bc:	e8 be fc ff ff       	call   d7f <APDrawLine>
    10c1:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10c4:	8b 55 10             	mov    0x10(%ebp),%edx
    10c7:	8b 45 18             	mov    0x18(%ebp),%eax
    10ca:	01 d0                	add    %edx,%eax
    10cc:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10cf:	8b 55 0c             	mov    0xc(%ebp),%edx
    10d2:	8b 45 14             	mov    0x14(%ebp),%eax
    10d5:	01 d0                	add    %edx,%eax
    10d7:	8d 50 ff             	lea    -0x1(%eax),%edx
    10da:	8b 5d 10             	mov    0x10(%ebp),%ebx
    10dd:	8b 45 18             	mov    0x18(%ebp),%eax
    10e0:	01 d8                	add    %ebx,%eax
    10e2:	83 e8 01             	sub    $0x1,%eax
    10e5:	83 ec 04             	sub    $0x4,%esp
    10e8:	51                   	push   %ecx
    10e9:	52                   	push   %edx
    10ea:	50                   	push   %eax
    10eb:	ff 75 0c             	pushl  0xc(%ebp)
    10ee:	ff 75 08             	pushl  0x8(%ebp)
    10f1:	e8 89 fc ff ff       	call   d7f <APDrawLine>
    10f6:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10f9:	8b 55 0c             	mov    0xc(%ebp),%edx
    10fc:	8b 45 14             	mov    0x14(%ebp),%eax
    10ff:	01 d0                	add    %edx,%eax
    1101:	8d 50 ff             	lea    -0x1(%eax),%edx
    1104:	8b 45 08             	mov    0x8(%ebp),%eax
    1107:	8b 40 0c             	mov    0xc(%eax),%eax
    110a:	89 c1                	mov    %eax,%ecx
    110c:	c1 e9 1f             	shr    $0x1f,%ecx
    110f:	01 c8                	add    %ecx,%eax
    1111:	d1 f8                	sar    %eax
    1113:	29 c2                	sub    %eax,%edx
    1115:	89 d0                	mov    %edx,%eax
    1117:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    111a:	8b 55 10             	mov    0x10(%ebp),%edx
    111d:	8b 45 18             	mov    0x18(%ebp),%eax
    1120:	01 d0                	add    %edx,%eax
    1122:	8d 50 ff             	lea    -0x1(%eax),%edx
    1125:	8b 45 08             	mov    0x8(%ebp),%eax
    1128:	8b 40 0c             	mov    0xc(%eax),%eax
    112b:	89 c1                	mov    %eax,%ecx
    112d:	c1 e9 1f             	shr    $0x1f,%ecx
    1130:	01 c8                	add    %ecx,%eax
    1132:	d1 f8                	sar    %eax
    1134:	29 c2                	sub    %eax,%edx
    1136:	89 d0                	mov    %edx,%eax
    1138:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    113b:	8b 45 08             	mov    0x8(%ebp),%eax
    113e:	8b 40 0c             	mov    0xc(%eax),%eax
    1141:	89 c2                	mov    %eax,%edx
    1143:	c1 ea 1f             	shr    $0x1f,%edx
    1146:	01 d0                	add    %edx,%eax
    1148:	d1 f8                	sar    %eax
    114a:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    114d:	8b 45 08             	mov    0x8(%ebp),%eax
    1150:	8b 40 0c             	mov    0xc(%eax),%eax
    1153:	89 c2                	mov    %eax,%edx
    1155:	c1 ea 1f             	shr    $0x1f,%edx
    1158:	01 d0                	add    %edx,%eax
    115a:	d1 f8                	sar    %eax
    115c:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    115f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1163:	0f 88 d8 00 00 00    	js     1241 <APDrawRect+0x1ff>
    1169:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    116d:	0f 88 ce 00 00 00    	js     1241 <APDrawRect+0x1ff>
    1173:	8b 45 08             	mov    0x8(%ebp),%eax
    1176:	8b 00                	mov    (%eax),%eax
    1178:	3b 45 0c             	cmp    0xc(%ebp),%eax
    117b:	0f 8e c0 00 00 00    	jle    1241 <APDrawRect+0x1ff>
    1181:	8b 45 08             	mov    0x8(%ebp),%eax
    1184:	8b 40 04             	mov    0x4(%eax),%eax
    1187:	3b 45 10             	cmp    0x10(%ebp),%eax
    118a:	0f 8e b1 00 00 00    	jle    1241 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1190:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1194:	79 07                	jns    119d <APDrawRect+0x15b>
    1196:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    119d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    11a1:	79 07                	jns    11aa <APDrawRect+0x168>
    11a3:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    11aa:	8b 45 08             	mov    0x8(%ebp),%eax
    11ad:	8b 00                	mov    (%eax),%eax
    11af:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11b2:	7f 0b                	jg     11bf <APDrawRect+0x17d>
    11b4:	8b 45 08             	mov    0x8(%ebp),%eax
    11b7:	8b 00                	mov    (%eax),%eax
    11b9:	83 e8 01             	sub    $0x1,%eax
    11bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    11bf:	8b 45 08             	mov    0x8(%ebp),%eax
    11c2:	8b 40 04             	mov    0x4(%eax),%eax
    11c5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11c8:	7f 0c                	jg     11d6 <APDrawRect+0x194>
    11ca:	8b 45 08             	mov    0x8(%ebp),%eax
    11cd:	8b 40 04             	mov    0x4(%eax),%eax
    11d0:	83 e8 01             	sub    $0x1,%eax
    11d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    11d6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11dd:	8b 45 0c             	mov    0xc(%ebp),%eax
    11e0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11e3:	eb 52                	jmp    1237 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    11e5:	8b 45 10             	mov    0x10(%ebp),%eax
    11e8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11eb:	eb 3e                	jmp    122b <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    11ed:	83 ec 04             	sub    $0x4,%esp
    11f0:	ff 75 e8             	pushl  -0x18(%ebp)
    11f3:	ff 75 ec             	pushl  -0x14(%ebp)
    11f6:	ff 75 08             	pushl  0x8(%ebp)
    11f9:	e8 c0 f6 ff ff       	call   8be <APGetIndex>
    11fe:	83 c4 10             	add    $0x10,%esp
    1201:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1204:	8b 45 08             	mov    0x8(%ebp),%eax
    1207:	8b 48 18             	mov    0x18(%eax),%ecx
    120a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    120d:	89 d0                	mov    %edx,%eax
    120f:	01 c0                	add    %eax,%eax
    1211:	01 d0                	add    %edx,%eax
    1213:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1216:	8b 45 08             	mov    0x8(%ebp),%eax
    1219:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    121d:	66 89 0a             	mov    %cx,(%edx)
    1220:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1224:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1227:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    122b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    122e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1231:	7e ba                	jle    11ed <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1233:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1237:	8b 45 ec             	mov    -0x14(%ebp),%eax
    123a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    123d:	7e a6                	jle    11e5 <APDrawRect+0x1a3>
    123f:	eb 01                	jmp    1242 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1241:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1242:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1245:	c9                   	leave  
    1246:	c3                   	ret    

00001247 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1247:	55                   	push   %ebp
    1248:	89 e5                	mov    %esp,%ebp
    124a:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    124d:	83 ec 0c             	sub    $0xc,%esp
    1250:	ff 75 0c             	pushl  0xc(%ebp)
    1253:	e8 b1 ee ff ff       	call   109 <strlen>
    1258:	83 c4 10             	add    $0x10,%esp
    125b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    125e:	8b 45 08             	mov    0x8(%ebp),%eax
    1261:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1265:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1269:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    126d:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1270:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1277:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    127e:	e9 bc 00 00 00       	jmp    133f <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1283:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1286:	8b 45 0c             	mov    0xc(%ebp),%eax
    1289:	01 d0                	add    %edx,%eax
    128b:	0f b6 00             	movzbl (%eax),%eax
    128e:	0f be c0             	movsbl %al,%eax
    1291:	83 e8 20             	sub    $0x20,%eax
    1294:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1297:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    129b:	0f 87 9a 00 00 00    	ja     133b <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    12a1:	8b 45 08             	mov    0x8(%ebp),%eax
    12a4:	8b 00                	mov    (%eax),%eax
    12a6:	0f af 45 14          	imul   0x14(%ebp),%eax
    12aa:	89 c2                	mov    %eax,%edx
    12ac:	8b 45 10             	mov    0x10(%ebp),%eax
    12af:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    12b2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12b5:	89 d0                	mov    %edx,%eax
    12b7:	c1 e0 03             	shl    $0x3,%eax
    12ba:	01 d0                	add    %edx,%eax
    12bc:	01 c8                	add    %ecx,%eax
    12be:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    12c1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    12c8:	eb 6b                	jmp    1335 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    12ca:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    12d1:	eb 50                	jmp    1323 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    12d3:	8b 55 ec             	mov    -0x14(%ebp),%edx
    12d6:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12d9:	89 d0                	mov    %edx,%eax
    12db:	c1 e0 03             	shl    $0x3,%eax
    12de:	01 d0                	add    %edx,%eax
    12e0:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    12e6:	01 c2                	add    %eax,%edx
    12e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12eb:	01 d0                	add    %edx,%eax
    12ed:	05 00 2c 00 00       	add    $0x2c00,%eax
    12f2:	0f b6 00             	movzbl (%eax),%eax
    12f5:	84 c0                	test   %al,%al
    12f7:	74 26                	je     131f <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    12f9:	8b 45 08             	mov    0x8(%ebp),%eax
    12fc:	8b 50 18             	mov    0x18(%eax),%edx
    12ff:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1302:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1305:	01 c8                	add    %ecx,%eax
    1307:	89 c1                	mov    %eax,%ecx
    1309:	89 c8                	mov    %ecx,%eax
    130b:	01 c0                	add    %eax,%eax
    130d:	01 c8                	add    %ecx,%eax
    130f:	01 d0                	add    %edx,%eax
    1311:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1315:	66 89 10             	mov    %dx,(%eax)
    1318:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    131c:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    131f:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1323:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1327:	7e aa                	jle    12d3 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1329:	8b 45 08             	mov    0x8(%ebp),%eax
    132c:	8b 00                	mov    (%eax),%eax
    132e:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1331:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1335:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1339:	7e 8f                	jle    12ca <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    133b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    133f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1342:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1345:	0f 82 38 ff ff ff    	jb     1283 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    134b:	90                   	nop
    134c:	c9                   	leave  
    134d:	c3                   	ret    

0000134e <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    134e:	55                   	push   %ebp
    134f:	89 e5                	mov    %esp,%ebp
    1351:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1354:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1358:	0f 88 8e 01 00 00    	js     14ec <APDcCopy+0x19e>
    135e:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1362:	0f 88 84 01 00 00    	js     14ec <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1368:	8b 55 0c             	mov    0xc(%ebp),%edx
    136b:	8b 45 20             	mov    0x20(%ebp),%eax
    136e:	01 d0                	add    %edx,%eax
    1370:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1373:	8b 55 10             	mov    0x10(%ebp),%edx
    1376:	8b 45 24             	mov    0x24(%ebp),%eax
    1379:	01 d0                	add    %edx,%eax
    137b:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    137e:	8b 55 18             	mov    0x18(%ebp),%edx
    1381:	8b 45 20             	mov    0x20(%ebp),%eax
    1384:	01 d0                	add    %edx,%eax
    1386:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1389:	8b 55 1c             	mov    0x1c(%ebp),%edx
    138c:	8b 45 24             	mov    0x24(%ebp),%eax
    138f:	01 d0                	add    %edx,%eax
    1391:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1394:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1398:	0f 88 51 01 00 00    	js     14ef <APDcCopy+0x1a1>
    139e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    13a2:	0f 88 47 01 00 00    	js     14ef <APDcCopy+0x1a1>
    13a8:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    13ac:	0f 88 3d 01 00 00    	js     14ef <APDcCopy+0x1a1>
    13b2:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    13b6:	0f 88 33 01 00 00    	js     14ef <APDcCopy+0x1a1>
    13bc:	8b 45 14             	mov    0x14(%ebp),%eax
    13bf:	8b 00                	mov    (%eax),%eax
    13c1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13c4:	0f 8c 25 01 00 00    	jl     14ef <APDcCopy+0x1a1>
    13ca:	8b 45 14             	mov    0x14(%ebp),%eax
    13cd:	8b 40 04             	mov    0x4(%eax),%eax
    13d0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    13d3:	0f 8c 16 01 00 00    	jl     14ef <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    13d9:	8b 45 08             	mov    0x8(%ebp),%eax
    13dc:	8b 00                	mov    (%eax),%eax
    13de:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    13e1:	7f 0b                	jg     13ee <APDcCopy+0xa0>
    13e3:	8b 45 08             	mov    0x8(%ebp),%eax
    13e6:	8b 00                	mov    (%eax),%eax
    13e8:	83 e8 01             	sub    $0x1,%eax
    13eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    13ee:	8b 45 08             	mov    0x8(%ebp),%eax
    13f1:	8b 40 04             	mov    0x4(%eax),%eax
    13f4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13f7:	7f 0c                	jg     1405 <APDcCopy+0xb7>
    13f9:	8b 45 08             	mov    0x8(%ebp),%eax
    13fc:	8b 40 04             	mov    0x4(%eax),%eax
    13ff:	83 e8 01             	sub    $0x1,%eax
    1402:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1405:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    140c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1413:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    141a:	e9 bc 00 00 00       	jmp    14db <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    141f:	8b 45 08             	mov    0x8(%ebp),%eax
    1422:	8b 00                	mov    (%eax),%eax
    1424:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1427:	8b 55 10             	mov    0x10(%ebp),%edx
    142a:	01 ca                	add    %ecx,%edx
    142c:	0f af d0             	imul   %eax,%edx
    142f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1432:	01 d0                	add    %edx,%eax
    1434:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1437:	8b 45 14             	mov    0x14(%ebp),%eax
    143a:	8b 00                	mov    (%eax),%eax
    143c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    143f:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1442:	01 ca                	add    %ecx,%edx
    1444:	0f af d0             	imul   %eax,%edx
    1447:	8b 45 18             	mov    0x18(%ebp),%eax
    144a:	01 d0                	add    %edx,%eax
    144c:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    144f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1456:	eb 74                	jmp    14cc <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1458:	8b 45 14             	mov    0x14(%ebp),%eax
    145b:	8b 50 18             	mov    0x18(%eax),%edx
    145e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1461:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1464:	01 c8                	add    %ecx,%eax
    1466:	89 c1                	mov    %eax,%ecx
    1468:	89 c8                	mov    %ecx,%eax
    146a:	01 c0                	add    %eax,%eax
    146c:	01 c8                	add    %ecx,%eax
    146e:	01 d0                	add    %edx,%eax
    1470:	0f b7 10             	movzwl (%eax),%edx
    1473:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1477:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    147b:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    147e:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1482:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1486:	38 c2                	cmp    %al,%dl
    1488:	75 18                	jne    14a2 <APDcCopy+0x154>
    148a:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    148e:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1492:	38 c2                	cmp    %al,%dl
    1494:	75 0c                	jne    14a2 <APDcCopy+0x154>
    1496:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    149a:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    149e:	38 c2                	cmp    %al,%dl
    14a0:	74 26                	je     14c8 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    14a2:	8b 45 08             	mov    0x8(%ebp),%eax
    14a5:	8b 50 18             	mov    0x18(%eax),%edx
    14a8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    14ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14ae:	01 c8                	add    %ecx,%eax
    14b0:	89 c1                	mov    %eax,%ecx
    14b2:	89 c8                	mov    %ecx,%eax
    14b4:	01 c0                	add    %eax,%eax
    14b6:	01 c8                	add    %ecx,%eax
    14b8:	01 d0                	add    %edx,%eax
    14ba:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    14be:	66 89 10             	mov    %dx,(%eax)
    14c1:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    14c5:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    14c8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14cf:	2b 45 0c             	sub    0xc(%ebp),%eax
    14d2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14d5:	7d 81                	jge    1458 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    14d7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14db:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14de:	2b 45 10             	sub    0x10(%ebp),%eax
    14e1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14e4:	0f 8d 35 ff ff ff    	jge    141f <APDcCopy+0xd1>
    14ea:	eb 04                	jmp    14f0 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    14ec:	90                   	nop
    14ed:	eb 01                	jmp    14f0 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    14ef:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    14f0:	c9                   	leave  
    14f1:	c3                   	ret    

000014f2 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    14f2:	55                   	push   %ebp
    14f3:	89 e5                	mov    %esp,%ebp
    14f5:	83 ec 1c             	sub    $0x1c,%esp
    14f8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    14fb:	8b 55 10             	mov    0x10(%ebp),%edx
    14fe:	8b 45 14             	mov    0x14(%ebp),%eax
    1501:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1504:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1507:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    150a:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    150e:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1511:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1515:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1518:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    151c:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    151f:	8b 45 08             	mov    0x8(%ebp),%eax
    1522:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1526:	66 89 10             	mov    %dx,(%eax)
    1529:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    152d:	88 50 02             	mov    %dl,0x2(%eax)
}
    1530:	8b 45 08             	mov    0x8(%ebp),%eax
    1533:	c9                   	leave  
    1534:	c2 04 00             	ret    $0x4

00001537 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1537:	55                   	push   %ebp
    1538:	89 e5                	mov    %esp,%ebp
    153a:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    153d:	8b 45 08             	mov    0x8(%ebp),%eax
    1540:	8b 00                	mov    (%eax),%eax
    1542:	83 ec 08             	sub    $0x8,%esp
    1545:	8d 55 0c             	lea    0xc(%ebp),%edx
    1548:	52                   	push   %edx
    1549:	50                   	push   %eax
    154a:	e8 24 ee ff ff       	call   373 <sendMessage>
    154f:	83 c4 10             	add    $0x10,%esp
}
    1552:	90                   	nop
    1553:	c9                   	leave  
    1554:	c3                   	ret    

00001555 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1555:	55                   	push   %ebp
    1556:	89 e5                	mov    %esp,%ebp
    1558:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    155b:	83 ec 0c             	sub    $0xc,%esp
    155e:	68 98 00 00 00       	push   $0x98
    1563:	e8 f5 f1 ff ff       	call   75d <malloc>
    1568:	83 c4 10             	add    $0x10,%esp
    156b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    156e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1572:	75 15                	jne    1589 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1574:	83 ec 04             	sub    $0x4,%esp
    1577:	ff 75 08             	pushl  0x8(%ebp)
    157a:	68 e4 24 00 00       	push   $0x24e4
    157f:	6a 01                	push   $0x1
    1581:	e8 04 ef ff ff       	call   48a <printf>
    1586:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1589:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158c:	05 84 00 00 00       	add    $0x84,%eax
    1591:	83 ec 08             	sub    $0x8,%esp
    1594:	ff 75 08             	pushl  0x8(%ebp)
    1597:	50                   	push   %eax
    1598:	e8 fd ea ff ff       	call   9a <strcpy>
    159d:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    15a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a3:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    15aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ad:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b7:	8b 40 3c             	mov    0x3c(%eax),%eax
    15ba:	89 c2                	mov    %eax,%edx
    15bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bf:	8b 40 40             	mov    0x40(%eax),%eax
    15c2:	0f af d0             	imul   %eax,%edx
    15c5:	89 d0                	mov    %edx,%eax
    15c7:	01 c0                	add    %eax,%eax
    15c9:	01 d0                	add    %edx,%eax
    15cb:	83 ec 0c             	sub    $0xc,%esp
    15ce:	50                   	push   %eax
    15cf:	e8 89 f1 ff ff       	call   75d <malloc>
    15d4:	83 c4 10             	add    $0x10,%esp
    15d7:	89 c2                	mov    %eax,%edx
    15d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15dc:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    15df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e2:	8b 40 54             	mov    0x54(%eax),%eax
    15e5:	85 c0                	test   %eax,%eax
    15e7:	75 15                	jne    15fe <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    15e9:	83 ec 04             	sub    $0x4,%esp
    15ec:	ff 75 08             	pushl  0x8(%ebp)
    15ef:	68 04 25 00 00       	push   $0x2504
    15f4:	6a 01                	push   $0x1
    15f6:	e8 8f ee ff ff       	call   48a <printf>
    15fb:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1601:	8b 40 3c             	mov    0x3c(%eax),%eax
    1604:	89 c2                	mov    %eax,%edx
    1606:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1609:	8b 40 40             	mov    0x40(%eax),%eax
    160c:	0f af d0             	imul   %eax,%edx
    160f:	89 d0                	mov    %edx,%eax
    1611:	01 c0                	add    %eax,%eax
    1613:	01 c2                	add    %eax,%edx
    1615:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1618:	8b 40 54             	mov    0x54(%eax),%eax
    161b:	83 ec 04             	sub    $0x4,%esp
    161e:	52                   	push   %edx
    161f:	68 ff ff ff 00       	push   $0xffffff
    1624:	50                   	push   %eax
    1625:	e8 06 eb ff ff       	call   130 <memset>
    162a:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    162d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1630:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1637:	e8 0f ed ff ff       	call   34b <getpid>
    163c:	89 c2                	mov    %eax,%edx
    163e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1641:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1644:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1647:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    164e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1651:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1658:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165b:	8b 40 58             	mov    0x58(%eax),%eax
    165e:	89 c2                	mov    %eax,%edx
    1660:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1663:	8b 40 5c             	mov    0x5c(%eax),%eax
    1666:	0f af d0             	imul   %eax,%edx
    1669:	89 d0                	mov    %edx,%eax
    166b:	01 c0                	add    %eax,%eax
    166d:	01 d0                	add    %edx,%eax
    166f:	83 ec 0c             	sub    $0xc,%esp
    1672:	50                   	push   %eax
    1673:	e8 e5 f0 ff ff       	call   75d <malloc>
    1678:	83 c4 10             	add    $0x10,%esp
    167b:	89 c2                	mov    %eax,%edx
    167d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1680:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1683:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1686:	8b 40 70             	mov    0x70(%eax),%eax
    1689:	85 c0                	test   %eax,%eax
    168b:	75 15                	jne    16a2 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    168d:	83 ec 04             	sub    $0x4,%esp
    1690:	ff 75 08             	pushl  0x8(%ebp)
    1693:	68 28 25 00 00       	push   $0x2528
    1698:	6a 01                	push   $0x1
    169a:	e8 eb ed ff ff       	call   48a <printf>
    169f:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    16a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a5:	8b 40 3c             	mov    0x3c(%eax),%eax
    16a8:	89 c2                	mov    %eax,%edx
    16aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ad:	8b 40 40             	mov    0x40(%eax),%eax
    16b0:	0f af d0             	imul   %eax,%edx
    16b3:	89 d0                	mov    %edx,%eax
    16b5:	01 c0                	add    %eax,%eax
    16b7:	01 c2                	add    %eax,%edx
    16b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16bc:	8b 40 54             	mov    0x54(%eax),%eax
    16bf:	83 ec 04             	sub    $0x4,%esp
    16c2:	52                   	push   %edx
    16c3:	68 ff 00 00 00       	push   $0xff
    16c8:	50                   	push   %eax
    16c9:	e8 62 ea ff ff       	call   130 <memset>
    16ce:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    16d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d4:	8b 55 0c             	mov    0xc(%ebp),%edx
    16d7:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    16da:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16de:	74 49                	je     1729 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    16e0:	8b 45 10             	mov    0x10(%ebp),%eax
    16e3:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    16e9:	83 ec 0c             	sub    $0xc,%esp
    16ec:	50                   	push   %eax
    16ed:	e8 6b f0 ff ff       	call   75d <malloc>
    16f2:	83 c4 10             	add    $0x10,%esp
    16f5:	89 c2                	mov    %eax,%edx
    16f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fa:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    16fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1700:	8b 55 10             	mov    0x10(%ebp),%edx
    1703:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1706:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1709:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1710:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1713:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    171a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1724:	e9 8d 00 00 00       	jmp    17b6 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1729:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172c:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1733:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1736:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    173d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1740:	8b 40 20             	mov    0x20(%eax),%eax
    1743:	89 c2                	mov    %eax,%edx
    1745:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1748:	8b 40 24             	mov    0x24(%eax),%eax
    174b:	0f af d0             	imul   %eax,%edx
    174e:	89 d0                	mov    %edx,%eax
    1750:	01 c0                	add    %eax,%eax
    1752:	01 d0                	add    %edx,%eax
    1754:	83 ec 0c             	sub    $0xc,%esp
    1757:	50                   	push   %eax
    1758:	e8 00 f0 ff ff       	call   75d <malloc>
    175d:	83 c4 10             	add    $0x10,%esp
    1760:	89 c2                	mov    %eax,%edx
    1762:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1765:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1768:	8b 45 f4             	mov    -0xc(%ebp),%eax
    176b:	8b 40 38             	mov    0x38(%eax),%eax
    176e:	85 c0                	test   %eax,%eax
    1770:	75 15                	jne    1787 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1772:	83 ec 04             	sub    $0x4,%esp
    1775:	ff 75 08             	pushl  0x8(%ebp)
    1778:	68 50 25 00 00       	push   $0x2550
    177d:	6a 01                	push   $0x1
    177f:	e8 06 ed ff ff       	call   48a <printf>
    1784:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1787:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178a:	8b 40 20             	mov    0x20(%eax),%eax
    178d:	89 c2                	mov    %eax,%edx
    178f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1792:	8b 40 24             	mov    0x24(%eax),%eax
    1795:	0f af d0             	imul   %eax,%edx
    1798:	89 d0                	mov    %edx,%eax
    179a:	01 c0                	add    %eax,%eax
    179c:	01 c2                	add    %eax,%edx
    179e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a1:	8b 40 38             	mov    0x38(%eax),%eax
    17a4:	83 ec 04             	sub    $0x4,%esp
    17a7:	52                   	push   %edx
    17a8:	68 ff ff ff 00       	push   $0xffffff
    17ad:	50                   	push   %eax
    17ae:	e8 7d e9 ff ff       	call   130 <memset>
    17b3:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    17b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    17b9:	c9                   	leave  
    17ba:	c3                   	ret    

000017bb <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    17bb:	55                   	push   %ebp
    17bc:	89 e5                	mov    %esp,%ebp
    17be:	57                   	push   %edi
    17bf:	56                   	push   %esi
    17c0:	53                   	push   %ebx
    17c1:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    17c4:	8b 45 0c             	mov    0xc(%ebp),%eax
    17c7:	83 f8 03             	cmp    $0x3,%eax
    17ca:	74 02                	je     17ce <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    17cc:	eb 7c                	jmp    184a <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    17ce:	8b 45 08             	mov    0x8(%ebp),%eax
    17d1:	8b 58 1c             	mov    0x1c(%eax),%ebx
    17d4:	8b 45 08             	mov    0x8(%ebp),%eax
    17d7:	8b 48 18             	mov    0x18(%eax),%ecx
    17da:	8b 45 08             	mov    0x8(%ebp),%eax
    17dd:	8b 50 5c             	mov    0x5c(%eax),%edx
    17e0:	8b 45 08             	mov    0x8(%ebp),%eax
    17e3:	8b 40 58             	mov    0x58(%eax),%eax
    17e6:	8b 75 08             	mov    0x8(%ebp),%esi
    17e9:	83 c6 58             	add    $0x58,%esi
    17ec:	83 ec 04             	sub    $0x4,%esp
    17ef:	53                   	push   %ebx
    17f0:	51                   	push   %ecx
    17f1:	6a 00                	push   $0x0
    17f3:	52                   	push   %edx
    17f4:	50                   	push   %eax
    17f5:	6a 00                	push   $0x0
    17f7:	6a 00                	push   $0x0
    17f9:	56                   	push   %esi
    17fa:	6a 00                	push   $0x0
    17fc:	6a 00                	push   $0x0
    17fe:	ff 75 08             	pushl  0x8(%ebp)
    1801:	e8 65 eb ff ff       	call   36b <paintWindow>
    1806:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1809:	8b 45 08             	mov    0x8(%ebp),%eax
    180c:	8b 70 1c             	mov    0x1c(%eax),%esi
    180f:	8b 45 08             	mov    0x8(%ebp),%eax
    1812:	8b 58 18             	mov    0x18(%eax),%ebx
    1815:	8b 45 08             	mov    0x8(%ebp),%eax
    1818:	8b 48 08             	mov    0x8(%eax),%ecx
    181b:	8b 45 08             	mov    0x8(%ebp),%eax
    181e:	8b 50 40             	mov    0x40(%eax),%edx
    1821:	8b 45 08             	mov    0x8(%ebp),%eax
    1824:	8b 40 3c             	mov    0x3c(%eax),%eax
    1827:	8b 7d 08             	mov    0x8(%ebp),%edi
    182a:	83 c7 3c             	add    $0x3c,%edi
    182d:	83 ec 04             	sub    $0x4,%esp
    1830:	56                   	push   %esi
    1831:	53                   	push   %ebx
    1832:	51                   	push   %ecx
    1833:	52                   	push   %edx
    1834:	50                   	push   %eax
    1835:	6a 00                	push   $0x0
    1837:	6a 00                	push   $0x0
    1839:	57                   	push   %edi
    183a:	6a 32                	push   $0x32
    183c:	6a 00                	push   $0x0
    183e:	ff 75 08             	pushl  0x8(%ebp)
    1841:	e8 25 eb ff ff       	call   36b <paintWindow>
    1846:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1849:	90                   	nop
        default: break;
            
            
    }
    return False;
    184a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    184f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1852:	5b                   	pop    %ebx
    1853:	5e                   	pop    %esi
    1854:	5f                   	pop    %edi
    1855:	5d                   	pop    %ebp
    1856:	c3                   	ret    

00001857 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1857:	55                   	push   %ebp
    1858:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    185a:	8b 45 0c             	mov    0xc(%ebp),%eax
    185d:	8b 50 08             	mov    0x8(%eax),%edx
    1860:	8b 45 08             	mov    0x8(%ebp),%eax
    1863:	8b 00                	mov    (%eax),%eax
    1865:	39 c2                	cmp    %eax,%edx
    1867:	74 07                	je     1870 <APPreJudge+0x19>
        return False;
    1869:	b8 00 00 00 00       	mov    $0x0,%eax
    186e:	eb 05                	jmp    1875 <APPreJudge+0x1e>
    return True;
    1870:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1875:	5d                   	pop    %ebp
    1876:	c3                   	ret    

00001877 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1877:	55                   	push   %ebp
    1878:	89 e5                	mov    %esp,%ebp
    187a:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    187d:	8b 45 08             	mov    0x8(%ebp),%eax
    1880:	8b 55 0c             	mov    0xc(%ebp),%edx
    1883:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1889:	83 ec 0c             	sub    $0xc,%esp
    188c:	ff 75 08             	pushl  0x8(%ebp)
    188f:	e8 ef ea ff ff       	call   383 <registWindow>
    1894:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1897:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    189e:	8b 45 08             	mov    0x8(%ebp),%eax
    18a1:	8b 00                	mov    (%eax),%eax
    18a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    18a6:	ff 75 f4             	pushl  -0xc(%ebp)
    18a9:	ff 75 f0             	pushl  -0x10(%ebp)
    18ac:	ff 75 ec             	pushl  -0x14(%ebp)
    18af:	ff 75 08             	pushl  0x8(%ebp)
    18b2:	e8 80 fc ff ff       	call   1537 <APSendMessage>
    18b7:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    18ba:	83 ec 0c             	sub    $0xc,%esp
    18bd:	ff 75 08             	pushl  0x8(%ebp)
    18c0:	e8 b6 ea ff ff       	call   37b <getMessage>
    18c5:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    18c8:	8b 45 08             	mov    0x8(%ebp),%eax
    18cb:	83 c0 74             	add    $0x74,%eax
    18ce:	83 ec 08             	sub    $0x8,%esp
    18d1:	50                   	push   %eax
    18d2:	ff 75 08             	pushl  0x8(%ebp)
    18d5:	e8 7d ff ff ff       	call   1857 <APPreJudge>
    18da:	83 c4 10             	add    $0x10,%esp
    18dd:	84 c0                	test   %al,%al
    18df:	74 1b                	je     18fc <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    18e1:	8b 45 08             	mov    0x8(%ebp),%eax
    18e4:	ff 70 7c             	pushl  0x7c(%eax)
    18e7:	ff 70 78             	pushl  0x78(%eax)
    18ea:	ff 70 74             	pushl  0x74(%eax)
    18ed:	ff 75 08             	pushl  0x8(%ebp)
    18f0:	8b 45 0c             	mov    0xc(%ebp),%eax
    18f3:	ff d0                	call   *%eax
    18f5:	83 c4 10             	add    $0x10,%esp
    18f8:	84 c0                	test   %al,%al
    18fa:	75 0c                	jne    1908 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    18fc:	8b 45 08             	mov    0x8(%ebp),%eax
    18ff:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1906:	eb b2                	jmp    18ba <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1908:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1909:	90                   	nop
    190a:	c9                   	leave  
    190b:	c3                   	ret    

0000190c <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    190c:	55                   	push   %ebp
    190d:	89 e5                	mov    %esp,%ebp
    190f:	57                   	push   %edi
    1910:	56                   	push   %esi
    1911:	53                   	push   %ebx
    1912:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    1915:	a1 44 68 00 00       	mov    0x6844,%eax
    191a:	85 c0                	test   %eax,%eax
    191c:	0f 85 7a 02 00 00    	jne    1b9c <APGridPaint+0x290>
    {
        iconReady = 1;
    1922:	c7 05 44 68 00 00 01 	movl   $0x1,0x6844
    1929:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    192c:	8d 45 88             	lea    -0x78(%ebp),%eax
    192f:	83 ec 08             	sub    $0x8,%esp
    1932:	68 77 25 00 00       	push   $0x2577
    1937:	50                   	push   %eax
    1938:	e8 d3 ef ff ff       	call   910 <APLoadBitmap>
    193d:	83 c4 0c             	add    $0xc,%esp
    1940:	8b 45 88             	mov    -0x78(%ebp),%eax
    1943:	a3 68 68 00 00       	mov    %eax,0x6868
    1948:	8b 45 8c             	mov    -0x74(%ebp),%eax
    194b:	a3 6c 68 00 00       	mov    %eax,0x686c
    1950:	8b 45 90             	mov    -0x70(%ebp),%eax
    1953:	a3 70 68 00 00       	mov    %eax,0x6870
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1958:	83 ec 04             	sub    $0x4,%esp
    195b:	ff 35 70 68 00 00    	pushl  0x6870
    1961:	ff 35 6c 68 00 00    	pushl  0x686c
    1967:	ff 35 68 68 00 00    	pushl  0x6868
    196d:	e8 d8 f1 ff ff       	call   b4a <APCreateCompatibleDCFromBitmap>
    1972:	83 c4 10             	add    $0x10,%esp
    1975:	a3 74 68 00 00       	mov    %eax,0x6874
        grid_river = APLoadBitmap ("grid_river.bmp");
    197a:	8d 45 88             	lea    -0x78(%ebp),%eax
    197d:	83 ec 08             	sub    $0x8,%esp
    1980:	68 85 25 00 00       	push   $0x2585
    1985:	50                   	push   %eax
    1986:	e8 85 ef ff ff       	call   910 <APLoadBitmap>
    198b:	83 c4 0c             	add    $0xc,%esp
    198e:	8b 45 88             	mov    -0x78(%ebp),%eax
    1991:	a3 b0 68 00 00       	mov    %eax,0x68b0
    1996:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1999:	a3 b4 68 00 00       	mov    %eax,0x68b4
    199e:	8b 45 90             	mov    -0x70(%ebp),%eax
    19a1:	a3 b8 68 00 00       	mov    %eax,0x68b8
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    19a6:	83 ec 04             	sub    $0x4,%esp
    19a9:	ff 35 b8 68 00 00    	pushl  0x68b8
    19af:	ff 35 b4 68 00 00    	pushl  0x68b4
    19b5:	ff 35 b0 68 00 00    	pushl  0x68b0
    19bb:	e8 8a f1 ff ff       	call   b4a <APCreateCompatibleDCFromBitmap>
    19c0:	83 c4 10             	add    $0x10,%esp
    19c3:	a3 a0 68 00 00       	mov    %eax,0x68a0
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    19c8:	8d 45 88             	lea    -0x78(%ebp),%eax
    19cb:	83 ec 08             	sub    $0x8,%esp
    19ce:	68 94 25 00 00       	push   $0x2594
    19d3:	50                   	push   %eax
    19d4:	e8 37 ef ff ff       	call   910 <APLoadBitmap>
    19d9:	83 c4 0c             	add    $0xc,%esp
    19dc:	8b 45 88             	mov    -0x78(%ebp),%eax
    19df:	a3 a4 68 00 00       	mov    %eax,0x68a4
    19e4:	8b 45 8c             	mov    -0x74(%ebp),%eax
    19e7:	a3 a8 68 00 00       	mov    %eax,0x68a8
    19ec:	8b 45 90             	mov    -0x70(%ebp),%eax
    19ef:	a3 ac 68 00 00       	mov    %eax,0x68ac
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    19f4:	83 ec 04             	sub    $0x4,%esp
    19f7:	ff 35 ac 68 00 00    	pushl  0x68ac
    19fd:	ff 35 a8 68 00 00    	pushl  0x68a8
    1a03:	ff 35 a4 68 00 00    	pushl  0x68a4
    1a09:	e8 3c f1 ff ff       	call   b4a <APCreateCompatibleDCFromBitmap>
    1a0e:	83 c4 10             	add    $0x10,%esp
    1a11:	a3 48 68 00 00       	mov    %eax,0x6848
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1a16:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a19:	83 ec 08             	sub    $0x8,%esp
    1a1c:	68 a3 25 00 00       	push   $0x25a3
    1a21:	50                   	push   %eax
    1a22:	e8 e9 ee ff ff       	call   910 <APLoadBitmap>
    1a27:	83 c4 0c             	add    $0xc,%esp
    1a2a:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a2d:	a3 7c 68 00 00       	mov    %eax,0x687c
    1a32:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a35:	a3 80 68 00 00       	mov    %eax,0x6880
    1a3a:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a3d:	a3 84 68 00 00       	mov    %eax,0x6884
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1a42:	83 ec 04             	sub    $0x4,%esp
    1a45:	ff 35 84 68 00 00    	pushl  0x6884
    1a4b:	ff 35 80 68 00 00    	pushl  0x6880
    1a51:	ff 35 7c 68 00 00    	pushl  0x687c
    1a57:	e8 ee f0 ff ff       	call   b4a <APCreateCompatibleDCFromBitmap>
    1a5c:	83 c4 10             	add    $0x10,%esp
    1a5f:	a3 c0 68 00 00       	mov    %eax,0x68c0
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1a64:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a67:	83 ec 08             	sub    $0x8,%esp
    1a6a:	68 b1 25 00 00       	push   $0x25b1
    1a6f:	50                   	push   %eax
    1a70:	e8 9b ee ff ff       	call   910 <APLoadBitmap>
    1a75:	83 c4 0c             	add    $0xc,%esp
    1a78:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a7b:	a3 58 68 00 00       	mov    %eax,0x6858
    1a80:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a83:	a3 5c 68 00 00       	mov    %eax,0x685c
    1a88:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a8b:	a3 60 68 00 00       	mov    %eax,0x6860
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1a90:	83 ec 04             	sub    $0x4,%esp
    1a93:	ff 35 60 68 00 00    	pushl  0x6860
    1a99:	ff 35 5c 68 00 00    	pushl  0x685c
    1a9f:	ff 35 58 68 00 00    	pushl  0x6858
    1aa5:	e8 a0 f0 ff ff       	call   b4a <APCreateCompatibleDCFromBitmap>
    1aaa:	83 c4 10             	add    $0x10,%esp
    1aad:	a3 78 68 00 00       	mov    %eax,0x6878
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1ab2:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ab5:	83 ec 08             	sub    $0x8,%esp
    1ab8:	68 c1 25 00 00       	push   $0x25c1
    1abd:	50                   	push   %eax
    1abe:	e8 4d ee ff ff       	call   910 <APLoadBitmap>
    1ac3:	83 c4 0c             	add    $0xc,%esp
    1ac6:	8b 45 88             	mov    -0x78(%ebp),%eax
    1ac9:	a3 4c 68 00 00       	mov    %eax,0x684c
    1ace:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1ad1:	a3 50 68 00 00       	mov    %eax,0x6850
    1ad6:	8b 45 90             	mov    -0x70(%ebp),%eax
    1ad9:	a3 54 68 00 00       	mov    %eax,0x6854
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1ade:	83 ec 04             	sub    $0x4,%esp
    1ae1:	ff 35 54 68 00 00    	pushl  0x6854
    1ae7:	ff 35 50 68 00 00    	pushl  0x6850
    1aed:	ff 35 4c 68 00 00    	pushl  0x684c
    1af3:	e8 52 f0 ff ff       	call   b4a <APCreateCompatibleDCFromBitmap>
    1af8:	83 c4 10             	add    $0x10,%esp
    1afb:	a3 64 68 00 00       	mov    %eax,0x6864
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1b00:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b03:	83 ec 08             	sub    $0x8,%esp
    1b06:	68 d3 25 00 00       	push   $0x25d3
    1b0b:	50                   	push   %eax
    1b0c:	e8 ff ed ff ff       	call   910 <APLoadBitmap>
    1b11:	83 c4 0c             	add    $0xc,%esp
    1b14:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b17:	a3 94 68 00 00       	mov    %eax,0x6894
    1b1c:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b1f:	a3 98 68 00 00       	mov    %eax,0x6898
    1b24:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b27:	a3 9c 68 00 00       	mov    %eax,0x689c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1b2c:	83 ec 04             	sub    $0x4,%esp
    1b2f:	ff 35 9c 68 00 00    	pushl  0x689c
    1b35:	ff 35 98 68 00 00    	pushl  0x6898
    1b3b:	ff 35 94 68 00 00    	pushl  0x6894
    1b41:	e8 04 f0 ff ff       	call   b4a <APCreateCompatibleDCFromBitmap>
    1b46:	83 c4 10             	add    $0x10,%esp
    1b49:	a3 c4 68 00 00       	mov    %eax,0x68c4
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    1b4e:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b51:	83 ec 08             	sub    $0x8,%esp
    1b54:	68 e2 25 00 00       	push   $0x25e2
    1b59:	50                   	push   %eax
    1b5a:	e8 b1 ed ff ff       	call   910 <APLoadBitmap>
    1b5f:	83 c4 0c             	add    $0xc,%esp
    1b62:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b65:	a3 88 68 00 00       	mov    %eax,0x6888
    1b6a:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b6d:	a3 8c 68 00 00       	mov    %eax,0x688c
    1b72:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b75:	a3 90 68 00 00       	mov    %eax,0x6890
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    1b7a:	83 ec 04             	sub    $0x4,%esp
    1b7d:	ff 35 90 68 00 00    	pushl  0x6890
    1b83:	ff 35 8c 68 00 00    	pushl  0x688c
    1b89:	ff 35 88 68 00 00    	pushl  0x6888
    1b8f:	e8 b6 ef ff ff       	call   b4a <APCreateCompatibleDCFromBitmap>
    1b94:	83 c4 10             	add    $0x10,%esp
    1b97:	a3 bc 68 00 00       	mov    %eax,0x68bc
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1b9c:	8b 45 08             	mov    0x8(%ebp),%eax
    1b9f:	8b 40 08             	mov    0x8(%eax),%eax
    1ba2:	85 c0                	test   %eax,%eax
    1ba4:	75 17                	jne    1bbd <APGridPaint+0x2b1>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1ba6:	83 ec 08             	sub    $0x8,%esp
    1ba9:	68 f4 25 00 00       	push   $0x25f4
    1bae:	6a 01                	push   $0x1
    1bb0:	e8 d5 e8 ff ff       	call   48a <printf>
    1bb5:	83 c4 10             	add    $0x10,%esp
        return;
    1bb8:	e9 65 05 00 00       	jmp    2122 <APGridPaint+0x816>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1bbd:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc0:	8b 40 10             	mov    0x10(%eax),%eax
    1bc3:	85 c0                	test   %eax,%eax
    1bc5:	7e 10                	jle    1bd7 <APGridPaint+0x2cb>
    1bc7:	8b 45 08             	mov    0x8(%ebp),%eax
    1bca:	8b 50 14             	mov    0x14(%eax),%edx
    1bcd:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd0:	8b 40 10             	mov    0x10(%eax),%eax
    1bd3:	39 c2                	cmp    %eax,%edx
    1bd5:	7c 17                	jl     1bee <APGridPaint+0x2e2>
    {
        printf(1,"Grid mode page error!");
    1bd7:	83 ec 08             	sub    $0x8,%esp
    1bda:	68 1a 26 00 00       	push   $0x261a
    1bdf:	6a 01                	push   $0x1
    1be1:	e8 a4 e8 ff ff       	call   48a <printf>
    1be6:	83 c4 10             	add    $0x10,%esp
        return;
    1be9:	e9 34 05 00 00       	jmp    2122 <APGridPaint+0x816>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1bee:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf1:	8b 40 14             	mov    0x14(%eax),%eax
    1bf4:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1bfa:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1bfd:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1c00:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1c03:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1c0a:	e9 f4 03 00 00       	jmp    2003 <APGridPaint+0x6f7>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1c0f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1c16:	e9 da 03 00 00       	jmp    1ff5 <APGridPaint+0x6e9>
        {
            index = start + GRID_W_NUMBER * j + i;
    1c1b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c1e:	c1 e0 04             	shl    $0x4,%eax
    1c21:	89 c2                	mov    %eax,%edx
    1c23:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1c26:	01 c2                	add    %eax,%edx
    1c28:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c2b:	01 d0                	add    %edx,%eax
    1c2d:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1c30:	8b 45 08             	mov    0x8(%ebp),%eax
    1c33:	8b 40 0c             	mov    0xc(%eax),%eax
    1c36:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1c39:	c1 e2 02             	shl    $0x2,%edx
    1c3c:	01 d0                	add    %edx,%eax
    1c3e:	8b 00                	mov    (%eax),%eax
    1c40:	83 f8 0a             	cmp    $0xa,%eax
    1c43:	0f 87 a7 03 00 00    	ja     1ff0 <APGridPaint+0x6e4>
    1c49:	8b 04 85 30 26 00 00 	mov    0x2630(,%eax,4),%eax
    1c50:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c52:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1c55:	6a 0c                	push   $0xc
    1c57:	6a 0c                	push   $0xc
    1c59:	6a 0c                	push   $0xc
    1c5b:	50                   	push   %eax
    1c5c:	e8 91 f8 ff ff       	call   14f2 <RGB>
    1c61:	83 c4 0c             	add    $0xc,%esp
    1c64:	8b 1d 74 68 00 00    	mov    0x6874,%ebx
    1c6a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c6d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c70:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c73:	6b c0 32             	imul   $0x32,%eax,%eax
    1c76:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1c79:	8b 45 08             	mov    0x8(%ebp),%eax
    1c7c:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c7f:	83 ec 0c             	sub    $0xc,%esp
    1c82:	83 ec 04             	sub    $0x4,%esp
    1c85:	89 e0                	mov    %esp,%eax
    1c87:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    1c8b:	66 89 30             	mov    %si,(%eax)
    1c8e:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    1c92:	88 50 02             	mov    %dl,0x2(%eax)
    1c95:	6a 32                	push   $0x32
    1c97:	6a 32                	push   $0x32
    1c99:	6a 00                	push   $0x0
    1c9b:	6a 00                	push   $0x0
    1c9d:	53                   	push   %ebx
    1c9e:	51                   	push   %ecx
    1c9f:	ff 75 84             	pushl  -0x7c(%ebp)
    1ca2:	57                   	push   %edi
    1ca3:	e8 a6 f6 ff ff       	call   134e <APDcCopy>
    1ca8:	83 c4 30             	add    $0x30,%esp
                    break;
    1cab:	e9 41 03 00 00       	jmp    1ff1 <APGridPaint+0x6e5>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1cb0:	8d 45 88             	lea    -0x78(%ebp),%eax
    1cb3:	6a 69                	push   $0x69
    1cb5:	6a 69                	push   $0x69
    1cb7:	6a 69                	push   $0x69
    1cb9:	50                   	push   %eax
    1cba:	e8 33 f8 ff ff       	call   14f2 <RGB>
    1cbf:	83 c4 0c             	add    $0xc,%esp
    1cc2:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1cc6:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1cca:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1cce:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1cd1:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1cd8:	8d 45 88             	lea    -0x78(%ebp),%eax
    1cdb:	6a 69                	push   $0x69
    1cdd:	6a 69                	push   $0x69
    1cdf:	6a 69                	push   $0x69
    1ce1:	50                   	push   %eax
    1ce2:	e8 0b f8 ff ff       	call   14f2 <RGB>
    1ce7:	83 c4 0c             	add    $0xc,%esp
    1cea:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1cee:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1cf2:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1cf6:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1cf9:	8b 45 08             	mov    0x8(%ebp),%eax
    1cfc:	8d 50 3c             	lea    0x3c(%eax),%edx
    1cff:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d02:	ff 75 ac             	pushl  -0x54(%ebp)
    1d05:	ff 75 a8             	pushl  -0x58(%ebp)
    1d08:	52                   	push   %edx
    1d09:	50                   	push   %eax
    1d0a:	e8 d0 ee ff ff       	call   bdf <APSetPen>
    1d0f:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1d12:	8b 45 08             	mov    0x8(%ebp),%eax
    1d15:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1d18:	8d 55 88             	lea    -0x78(%ebp),%edx
    1d1b:	83 ec 04             	sub    $0x4,%esp
    1d1e:	83 ec 04             	sub    $0x4,%esp
    1d21:	89 e0                	mov    %esp,%eax
    1d23:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1d27:	66 89 08             	mov    %cx,(%eax)
    1d2a:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    1d2e:	88 48 02             	mov    %cl,0x2(%eax)
    1d31:	53                   	push   %ebx
    1d32:	52                   	push   %edx
    1d33:	e8 e0 ee ff ff       	call   c18 <APSetBrush>
    1d38:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1d3b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d3e:	6b d0 32             	imul   $0x32,%eax,%edx
    1d41:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d44:	6b c0 32             	imul   $0x32,%eax,%eax
    1d47:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1d4a:	83 c1 3c             	add    $0x3c,%ecx
    1d4d:	83 ec 0c             	sub    $0xc,%esp
    1d50:	6a 32                	push   $0x32
    1d52:	6a 32                	push   $0x32
    1d54:	52                   	push   %edx
    1d55:	50                   	push   %eax
    1d56:	51                   	push   %ecx
    1d57:	e8 e6 f2 ff ff       	call   1042 <APDrawRect>
    1d5c:	83 c4 20             	add    $0x20,%esp
                    break;
    1d5f:	e9 8d 02 00 00       	jmp    1ff1 <APGridPaint+0x6e5>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d64:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1d67:	6a 0c                	push   $0xc
    1d69:	6a 0c                	push   $0xc
    1d6b:	6a 0c                	push   $0xc
    1d6d:	50                   	push   %eax
    1d6e:	e8 7f f7 ff ff       	call   14f2 <RGB>
    1d73:	83 c4 0c             	add    $0xc,%esp
    1d76:	8b 1d c4 68 00 00    	mov    0x68c4,%ebx
    1d7c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d7f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d82:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d85:	6b c0 32             	imul   $0x32,%eax,%eax
    1d88:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1d8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d8e:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d91:	83 ec 0c             	sub    $0xc,%esp
    1d94:	83 ec 04             	sub    $0x4,%esp
    1d97:	89 e0                	mov    %esp,%eax
    1d99:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1d9d:	66 89 30             	mov    %si,(%eax)
    1da0:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1da4:	88 50 02             	mov    %dl,0x2(%eax)
    1da7:	6a 32                	push   $0x32
    1da9:	6a 32                	push   $0x32
    1dab:	6a 00                	push   $0x0
    1dad:	6a 00                	push   $0x0
    1daf:	53                   	push   %ebx
    1db0:	51                   	push   %ecx
    1db1:	ff 75 84             	pushl  -0x7c(%ebp)
    1db4:	57                   	push   %edi
    1db5:	e8 94 f5 ff ff       	call   134e <APDcCopy>
    1dba:	83 c4 30             	add    $0x30,%esp
                    break;
    1dbd:	e9 2f 02 00 00       	jmp    1ff1 <APGridPaint+0x6e5>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dc2:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1dc5:	6a 0c                	push   $0xc
    1dc7:	6a 0c                	push   $0xc
    1dc9:	6a 0c                	push   $0xc
    1dcb:	50                   	push   %eax
    1dcc:	e8 21 f7 ff ff       	call   14f2 <RGB>
    1dd1:	83 c4 0c             	add    $0xc,%esp
    1dd4:	8b 1d a0 68 00 00    	mov    0x68a0,%ebx
    1dda:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ddd:	6b c8 32             	imul   $0x32,%eax,%ecx
    1de0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1de3:	6b c0 32             	imul   $0x32,%eax,%eax
    1de6:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1de9:	8b 45 08             	mov    0x8(%ebp),%eax
    1dec:	8d 78 3c             	lea    0x3c(%eax),%edi
    1def:	83 ec 0c             	sub    $0xc,%esp
    1df2:	83 ec 04             	sub    $0x4,%esp
    1df5:	89 e0                	mov    %esp,%eax
    1df7:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1dfb:	66 89 30             	mov    %si,(%eax)
    1dfe:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1e02:	88 50 02             	mov    %dl,0x2(%eax)
    1e05:	6a 32                	push   $0x32
    1e07:	6a 32                	push   $0x32
    1e09:	6a 00                	push   $0x0
    1e0b:	6a 00                	push   $0x0
    1e0d:	53                   	push   %ebx
    1e0e:	51                   	push   %ecx
    1e0f:	ff 75 84             	pushl  -0x7c(%ebp)
    1e12:	57                   	push   %edi
    1e13:	e8 36 f5 ff ff       	call   134e <APDcCopy>
    1e18:	83 c4 30             	add    $0x30,%esp
                    break;
    1e1b:	e9 d1 01 00 00       	jmp    1ff1 <APGridPaint+0x6e5>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e20:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1e23:	6a 0c                	push   $0xc
    1e25:	6a 0c                	push   $0xc
    1e27:	6a 0c                	push   $0xc
    1e29:	50                   	push   %eax
    1e2a:	e8 c3 f6 ff ff       	call   14f2 <RGB>
    1e2f:	83 c4 0c             	add    $0xc,%esp
    1e32:	8b 1d 78 68 00 00    	mov    0x6878,%ebx
    1e38:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e3b:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e3e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e41:	6b c0 32             	imul   $0x32,%eax,%eax
    1e44:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e47:	8b 45 08             	mov    0x8(%ebp),%eax
    1e4a:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e4d:	83 ec 0c             	sub    $0xc,%esp
    1e50:	83 ec 04             	sub    $0x4,%esp
    1e53:	89 e0                	mov    %esp,%eax
    1e55:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1e59:	66 89 30             	mov    %si,(%eax)
    1e5c:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1e60:	88 50 02             	mov    %dl,0x2(%eax)
    1e63:	6a 32                	push   $0x32
    1e65:	6a 32                	push   $0x32
    1e67:	6a 00                	push   $0x0
    1e69:	6a 00                	push   $0x0
    1e6b:	53                   	push   %ebx
    1e6c:	51                   	push   %ecx
    1e6d:	ff 75 84             	pushl  -0x7c(%ebp)
    1e70:	57                   	push   %edi
    1e71:	e8 d8 f4 ff ff       	call   134e <APDcCopy>
    1e76:	83 c4 30             	add    $0x30,%esp
                    break;
    1e79:	e9 73 01 00 00       	jmp    1ff1 <APGridPaint+0x6e5>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e7e:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1e81:	6a 0c                	push   $0xc
    1e83:	6a 0c                	push   $0xc
    1e85:	6a 0c                	push   $0xc
    1e87:	50                   	push   %eax
    1e88:	e8 65 f6 ff ff       	call   14f2 <RGB>
    1e8d:	83 c4 0c             	add    $0xc,%esp
    1e90:	8b 1d c0 68 00 00    	mov    0x68c0,%ebx
    1e96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e99:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e9c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e9f:	6b c0 32             	imul   $0x32,%eax,%eax
    1ea2:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1ea5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea8:	8d 78 3c             	lea    0x3c(%eax),%edi
    1eab:	83 ec 0c             	sub    $0xc,%esp
    1eae:	83 ec 04             	sub    $0x4,%esp
    1eb1:	89 e0                	mov    %esp,%eax
    1eb3:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1eb7:	66 89 30             	mov    %si,(%eax)
    1eba:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1ebe:	88 50 02             	mov    %dl,0x2(%eax)
    1ec1:	6a 32                	push   $0x32
    1ec3:	6a 32                	push   $0x32
    1ec5:	6a 00                	push   $0x0
    1ec7:	6a 00                	push   $0x0
    1ec9:	53                   	push   %ebx
    1eca:	51                   	push   %ecx
    1ecb:	ff 75 84             	pushl  -0x7c(%ebp)
    1ece:	57                   	push   %edi
    1ecf:	e8 7a f4 ff ff       	call   134e <APDcCopy>
    1ed4:	83 c4 30             	add    $0x30,%esp
                    break;
    1ed7:	e9 15 01 00 00       	jmp    1ff1 <APGridPaint+0x6e5>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1edc:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1edf:	6a 0c                	push   $0xc
    1ee1:	6a 0c                	push   $0xc
    1ee3:	6a 0c                	push   $0xc
    1ee5:	50                   	push   %eax
    1ee6:	e8 07 f6 ff ff       	call   14f2 <RGB>
    1eeb:	83 c4 0c             	add    $0xc,%esp
    1eee:	8b 1d 48 68 00 00    	mov    0x6848,%ebx
    1ef4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ef7:	6b c8 32             	imul   $0x32,%eax,%ecx
    1efa:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1efd:	6b c0 32             	imul   $0x32,%eax,%eax
    1f00:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f03:	8b 45 08             	mov    0x8(%ebp),%eax
    1f06:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f09:	83 ec 0c             	sub    $0xc,%esp
    1f0c:	83 ec 04             	sub    $0x4,%esp
    1f0f:	89 e0                	mov    %esp,%eax
    1f11:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1f15:	66 89 30             	mov    %si,(%eax)
    1f18:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1f1c:	88 50 02             	mov    %dl,0x2(%eax)
    1f1f:	6a 32                	push   $0x32
    1f21:	6a 32                	push   $0x32
    1f23:	6a 00                	push   $0x0
    1f25:	6a 00                	push   $0x0
    1f27:	53                   	push   %ebx
    1f28:	51                   	push   %ecx
    1f29:	ff 75 84             	pushl  -0x7c(%ebp)
    1f2c:	57                   	push   %edi
    1f2d:	e8 1c f4 ff ff       	call   134e <APDcCopy>
    1f32:	83 c4 30             	add    $0x30,%esp
                    break;
    1f35:	e9 b7 00 00 00       	jmp    1ff1 <APGridPaint+0x6e5>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f3a:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1f3d:	6a 0c                	push   $0xc
    1f3f:	6a 0c                	push   $0xc
    1f41:	6a 0c                	push   $0xc
    1f43:	50                   	push   %eax
    1f44:	e8 a9 f5 ff ff       	call   14f2 <RGB>
    1f49:	83 c4 0c             	add    $0xc,%esp
    1f4c:	8b 1d 64 68 00 00    	mov    0x6864,%ebx
    1f52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f55:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f58:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f5b:	6b c0 32             	imul   $0x32,%eax,%eax
    1f5e:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f61:	8b 45 08             	mov    0x8(%ebp),%eax
    1f64:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f67:	83 ec 0c             	sub    $0xc,%esp
    1f6a:	83 ec 04             	sub    $0x4,%esp
    1f6d:	89 e0                	mov    %esp,%eax
    1f6f:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1f73:	66 89 30             	mov    %si,(%eax)
    1f76:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1f7a:	88 50 02             	mov    %dl,0x2(%eax)
    1f7d:	6a 32                	push   $0x32
    1f7f:	6a 32                	push   $0x32
    1f81:	6a 00                	push   $0x0
    1f83:	6a 00                	push   $0x0
    1f85:	53                   	push   %ebx
    1f86:	51                   	push   %ecx
    1f87:	ff 75 84             	pushl  -0x7c(%ebp)
    1f8a:	57                   	push   %edi
    1f8b:	e8 be f3 ff ff       	call   134e <APDcCopy>
    1f90:	83 c4 30             	add    $0x30,%esp
                    break;
    1f93:	eb 5c                	jmp    1ff1 <APGridPaint+0x6e5>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f95:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1f98:	6a 0c                	push   $0xc
    1f9a:	6a 0c                	push   $0xc
    1f9c:	6a 0c                	push   $0xc
    1f9e:	50                   	push   %eax
    1f9f:	e8 4e f5 ff ff       	call   14f2 <RGB>
    1fa4:	83 c4 0c             	add    $0xc,%esp
    1fa7:	8b 1d bc 68 00 00    	mov    0x68bc,%ebx
    1fad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fb0:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fb3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fb6:	6b c0 32             	imul   $0x32,%eax,%eax
    1fb9:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1fbc:	8b 45 08             	mov    0x8(%ebp),%eax
    1fbf:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fc2:	83 ec 0c             	sub    $0xc,%esp
    1fc5:	83 ec 04             	sub    $0x4,%esp
    1fc8:	89 e0                	mov    %esp,%eax
    1fca:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1fce:	66 89 30             	mov    %si,(%eax)
    1fd1:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1fd5:	88 50 02             	mov    %dl,0x2(%eax)
    1fd8:	6a 32                	push   $0x32
    1fda:	6a 32                	push   $0x32
    1fdc:	6a 00                	push   $0x0
    1fde:	6a 00                	push   $0x0
    1fe0:	53                   	push   %ebx
    1fe1:	51                   	push   %ecx
    1fe2:	ff 75 84             	pushl  -0x7c(%ebp)
    1fe5:	57                   	push   %edi
    1fe6:	e8 63 f3 ff ff       	call   134e <APDcCopy>
    1feb:	83 c4 30             	add    $0x30,%esp
                    break;
    1fee:	eb 01                	jmp    1ff1 <APGridPaint+0x6e5>
                default: break;
    1ff0:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1ff1:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1ff5:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1ff9:	0f 8e 1c fc ff ff    	jle    1c1b <APGridPaint+0x30f>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1fff:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2003:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2007:	0f 8e 02 fc ff ff    	jle    1c0f <APGridPaint+0x303>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    200d:	8d 45 88             	lea    -0x78(%ebp),%eax
    2010:	68 cd 00 00 00       	push   $0xcd
    2015:	6a 74                	push   $0x74
    2017:	6a 18                	push   $0x18
    2019:	50                   	push   %eax
    201a:	e8 d3 f4 ff ff       	call   14f2 <RGB>
    201f:	83 c4 0c             	add    $0xc,%esp
    2022:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2026:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    202a:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    202e:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    2031:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2038:	8d 45 88             	lea    -0x78(%ebp),%eax
    203b:	68 cd 00 00 00       	push   $0xcd
    2040:	6a 74                	push   $0x74
    2042:	6a 18                	push   $0x18
    2044:	50                   	push   %eax
    2045:	e8 a8 f4 ff ff       	call   14f2 <RGB>
    204a:	83 c4 0c             	add    $0xc,%esp
    204d:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2051:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    2055:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2059:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    205c:	8b 45 08             	mov    0x8(%ebp),%eax
    205f:	8d 50 58             	lea    0x58(%eax),%edx
    2062:	8d 45 88             	lea    -0x78(%ebp),%eax
    2065:	ff 75 bc             	pushl  -0x44(%ebp)
    2068:	ff 75 b8             	pushl  -0x48(%ebp)
    206b:	52                   	push   %edx
    206c:	50                   	push   %eax
    206d:	e8 6d eb ff ff       	call   bdf <APSetPen>
    2072:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2075:	8b 45 08             	mov    0x8(%ebp),%eax
    2078:	8d 58 58             	lea    0x58(%eax),%ebx
    207b:	8d 55 88             	lea    -0x78(%ebp),%edx
    207e:	83 ec 04             	sub    $0x4,%esp
    2081:	83 ec 04             	sub    $0x4,%esp
    2084:	89 e0                	mov    %esp,%eax
    2086:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    208a:	66 89 08             	mov    %cx,(%eax)
    208d:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    2091:	88 48 02             	mov    %cl,0x2(%eax)
    2094:	53                   	push   %ebx
    2095:	52                   	push   %edx
    2096:	e8 7d eb ff ff       	call   c18 <APSetBrush>
    209b:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    209e:	8b 45 08             	mov    0x8(%ebp),%eax
    20a1:	83 c0 58             	add    $0x58,%eax
    20a4:	83 ec 0c             	sub    $0xc,%esp
    20a7:	6a 32                	push   $0x32
    20a9:	68 20 03 00 00       	push   $0x320
    20ae:	6a 00                	push   $0x0
    20b0:	6a 00                	push   $0x0
    20b2:	50                   	push   %eax
    20b3:	e8 8a ef ff ff       	call   1042 <APDrawRect>
    20b8:	83 c4 20             	add    $0x20,%esp


    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    20bb:	8d 45 88             	lea    -0x78(%ebp),%eax
    20be:	6a 08                	push   $0x8
    20c0:	6a 08                	push   $0x8
    20c2:	6a 08                	push   $0x8
    20c4:	50                   	push   %eax
    20c5:	e8 28 f4 ff ff       	call   14f2 <RGB>
    20ca:	83 c4 0c             	add    $0xc,%esp
    20cd:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    20d1:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    20d5:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    20d9:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    20dc:	8b 45 08             	mov    0x8(%ebp),%eax
    20df:	8d 58 58             	lea    0x58(%eax),%ebx
    20e2:	8d 55 88             	lea    -0x78(%ebp),%edx
    20e5:	83 ec 04             	sub    $0x4,%esp
    20e8:	83 ec 04             	sub    $0x4,%esp
    20eb:	89 e0                	mov    %esp,%eax
    20ed:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    20f1:	66 89 08             	mov    %cx,(%eax)
    20f4:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    20f8:	88 48 02             	mov    %cl,0x2(%eax)
    20fb:	53                   	push   %ebx
    20fc:	52                   	push   %edx
    20fd:	e8 58 eb ff ff       	call   c5a <APSetFont>
    2102:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    2105:	8b 45 08             	mov    0x8(%ebp),%eax
    2108:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    210e:	8b 45 08             	mov    0x8(%ebp),%eax
    2111:	83 c0 58             	add    $0x58,%eax
    2114:	6a 14                	push   $0x14
    2116:	6a 14                	push   $0x14
    2118:	52                   	push   %edx
    2119:	50                   	push   %eax
    211a:	e8 28 f1 ff ff       	call   1247 <APDrawText>
    211f:	83 c4 10             	add    $0x10,%esp
    
}
    2122:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2125:	5b                   	pop    %ebx
    2126:	5e                   	pop    %esi
    2127:	5f                   	pop    %edi
    2128:	5d                   	pop    %ebp
    2129:	c3                   	ret    

0000212a <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    212a:	55                   	push   %ebp
    212b:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    212d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2131:	7e 08                	jle    213b <random+0x11>
{
rand_num = seed;
    2133:	8b 45 08             	mov    0x8(%ebp),%eax
    2136:	a3 20 68 00 00       	mov    %eax,0x6820
}
rand_num *= 3;
    213b:	8b 15 20 68 00 00    	mov    0x6820,%edx
    2141:	89 d0                	mov    %edx,%eax
    2143:	01 c0                	add    %eax,%eax
    2145:	01 d0                	add    %edx,%eax
    2147:	a3 20 68 00 00       	mov    %eax,0x6820
if (rand_num < 0)
    214c:	a1 20 68 00 00       	mov    0x6820,%eax
    2151:	85 c0                	test   %eax,%eax
    2153:	79 0c                	jns    2161 <random+0x37>
{
rand_num *= (-1);
    2155:	a1 20 68 00 00       	mov    0x6820,%eax
    215a:	f7 d8                	neg    %eax
    215c:	a3 20 68 00 00       	mov    %eax,0x6820
}
return rand_num % 997;
    2161:	8b 0d 20 68 00 00    	mov    0x6820,%ecx
    2167:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    216c:	89 c8                	mov    %ecx,%eax
    216e:	f7 ea                	imul   %edx
    2170:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2173:	c1 f8 09             	sar    $0x9,%eax
    2176:	89 c2                	mov    %eax,%edx
    2178:	89 c8                	mov    %ecx,%eax
    217a:	c1 f8 1f             	sar    $0x1f,%eax
    217d:	29 c2                	sub    %eax,%edx
    217f:	89 d0                	mov    %edx,%eax
    2181:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2187:	29 c1                	sub    %eax,%ecx
    2189:	89 c8                	mov    %ecx,%eax
}
    218b:	5d                   	pop    %ebp
    218c:	c3                   	ret    

0000218d <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    218d:	55                   	push   %ebp
    218e:	89 e5                	mov    %esp,%ebp
    2190:	53                   	push   %ebx
    2191:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2194:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    219b:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    219f:	74 17                	je     21b8 <sprintint+0x2b>
    21a1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    21a5:	79 11                	jns    21b8 <sprintint+0x2b>
        neg = 1;
    21a7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    21ae:	8b 45 10             	mov    0x10(%ebp),%eax
    21b1:	f7 d8                	neg    %eax
    21b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    21b6:	eb 06                	jmp    21be <sprintint+0x31>
    } else {
        x = xx;
    21b8:	8b 45 10             	mov    0x10(%ebp),%eax
    21bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    21be:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    21c5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    21c8:	8d 41 01             	lea    0x1(%ecx),%eax
    21cb:	89 45 f8             	mov    %eax,-0x8(%ebp)
    21ce:	8b 5d 14             	mov    0x14(%ebp),%ebx
    21d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21d4:	ba 00 00 00 00       	mov    $0x0,%edx
    21d9:	f7 f3                	div    %ebx
    21db:	89 d0                	mov    %edx,%eax
    21dd:	0f b6 80 24 68 00 00 	movzbl 0x6824(%eax),%eax
    21e4:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    21e8:	8b 5d 14             	mov    0x14(%ebp),%ebx
    21eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21ee:	ba 00 00 00 00       	mov    $0x0,%edx
    21f3:	f7 f3                	div    %ebx
    21f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    21f8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    21fc:	75 c7                	jne    21c5 <sprintint+0x38>
    if(neg)
    21fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2202:	74 0e                	je     2212 <sprintint+0x85>
        buf[i++] = '-';
    2204:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2207:	8d 50 01             	lea    0x1(%eax),%edx
    220a:	89 55 f8             	mov    %edx,-0x8(%ebp)
    220d:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2212:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2215:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2218:	eb 1b                	jmp    2235 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    221a:	8b 45 0c             	mov    0xc(%ebp),%eax
    221d:	8b 00                	mov    (%eax),%eax
    221f:	8d 48 01             	lea    0x1(%eax),%ecx
    2222:	8b 55 0c             	mov    0xc(%ebp),%edx
    2225:	89 0a                	mov    %ecx,(%edx)
    2227:	89 c2                	mov    %eax,%edx
    2229:	8b 45 08             	mov    0x8(%ebp),%eax
    222c:	01 d0                	add    %edx,%eax
    222e:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2231:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2235:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2239:	7f df                	jg     221a <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    223b:	eb 21                	jmp    225e <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    223d:	8b 45 0c             	mov    0xc(%ebp),%eax
    2240:	8b 00                	mov    (%eax),%eax
    2242:	8d 48 01             	lea    0x1(%eax),%ecx
    2245:	8b 55 0c             	mov    0xc(%ebp),%edx
    2248:	89 0a                	mov    %ecx,(%edx)
    224a:	89 c2                	mov    %eax,%edx
    224c:	8b 45 08             	mov    0x8(%ebp),%eax
    224f:	01 c2                	add    %eax,%edx
    2251:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2254:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2257:	01 c8                	add    %ecx,%eax
    2259:	0f b6 00             	movzbl (%eax),%eax
    225c:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    225e:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2262:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2266:	79 d5                	jns    223d <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2268:	90                   	nop
    2269:	83 c4 20             	add    $0x20,%esp
    226c:	5b                   	pop    %ebx
    226d:	5d                   	pop    %ebp
    226e:	c3                   	ret    

0000226f <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    226f:	55                   	push   %ebp
    2270:	89 e5                	mov    %esp,%ebp
    2272:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2275:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    227c:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2283:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    228a:	8d 45 0c             	lea    0xc(%ebp),%eax
    228d:	83 c0 04             	add    $0x4,%eax
    2290:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2293:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    229a:	e9 d9 01 00 00       	jmp    2478 <sprintf+0x209>
        c = fmt[i] & 0xff;
    229f:	8b 55 0c             	mov    0xc(%ebp),%edx
    22a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    22a5:	01 d0                	add    %edx,%eax
    22a7:	0f b6 00             	movzbl (%eax),%eax
    22aa:	0f be c0             	movsbl %al,%eax
    22ad:	25 ff 00 00 00       	and    $0xff,%eax
    22b2:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    22b5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    22b9:	75 2c                	jne    22e7 <sprintf+0x78>
            if(c == '%'){
    22bb:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    22bf:	75 0c                	jne    22cd <sprintf+0x5e>
                state = '%';
    22c1:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    22c8:	e9 a7 01 00 00       	jmp    2474 <sprintf+0x205>
            } else {
                dst[j++] = c;
    22cd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22d0:	8d 50 01             	lea    0x1(%eax),%edx
    22d3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22d6:	89 c2                	mov    %eax,%edx
    22d8:	8b 45 08             	mov    0x8(%ebp),%eax
    22db:	01 d0                	add    %edx,%eax
    22dd:	8b 55 e0             	mov    -0x20(%ebp),%edx
    22e0:	88 10                	mov    %dl,(%eax)
    22e2:	e9 8d 01 00 00       	jmp    2474 <sprintf+0x205>
            }
        } else if(state == '%'){
    22e7:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    22eb:	0f 85 83 01 00 00    	jne    2474 <sprintf+0x205>
            if(c == 'd'){
    22f1:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    22f5:	75 4c                	jne    2343 <sprintf+0xd4>
                buf[bi] = '\0';
    22f7:	8d 55 ce             	lea    -0x32(%ebp),%edx
    22fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22fd:	01 d0                	add    %edx,%eax
    22ff:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2302:	83 ec 0c             	sub    $0xc,%esp
    2305:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2308:	50                   	push   %eax
    2309:	e8 2b df ff ff       	call   239 <atoi>
    230e:	83 c4 10             	add    $0x10,%esp
    2311:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2314:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    231b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    231e:	8b 00                	mov    (%eax),%eax
    2320:	83 ec 08             	sub    $0x8,%esp
    2323:	ff 75 d8             	pushl  -0x28(%ebp)
    2326:	6a 01                	push   $0x1
    2328:	6a 0a                	push   $0xa
    232a:	50                   	push   %eax
    232b:	8d 45 c8             	lea    -0x38(%ebp),%eax
    232e:	50                   	push   %eax
    232f:	ff 75 08             	pushl  0x8(%ebp)
    2332:	e8 56 fe ff ff       	call   218d <sprintint>
    2337:	83 c4 20             	add    $0x20,%esp
                ap++;
    233a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    233e:	e9 2a 01 00 00       	jmp    246d <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2343:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2347:	74 06                	je     234f <sprintf+0xe0>
    2349:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    234d:	75 4c                	jne    239b <sprintf+0x12c>
                buf[bi] = '\0';
    234f:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2352:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2355:	01 d0                	add    %edx,%eax
    2357:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    235a:	83 ec 0c             	sub    $0xc,%esp
    235d:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2360:	50                   	push   %eax
    2361:	e8 d3 de ff ff       	call   239 <atoi>
    2366:	83 c4 10             	add    $0x10,%esp
    2369:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    236c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2373:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2376:	8b 00                	mov    (%eax),%eax
    2378:	83 ec 08             	sub    $0x8,%esp
    237b:	ff 75 dc             	pushl  -0x24(%ebp)
    237e:	6a 00                	push   $0x0
    2380:	6a 10                	push   $0x10
    2382:	50                   	push   %eax
    2383:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2386:	50                   	push   %eax
    2387:	ff 75 08             	pushl  0x8(%ebp)
    238a:	e8 fe fd ff ff       	call   218d <sprintint>
    238f:	83 c4 20             	add    $0x20,%esp
                ap++;
    2392:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2396:	e9 d2 00 00 00       	jmp    246d <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    239b:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    239f:	75 46                	jne    23e7 <sprintf+0x178>
                s = (char*)*ap;
    23a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23a4:	8b 00                	mov    (%eax),%eax
    23a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    23a9:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    23ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    23b1:	75 25                	jne    23d8 <sprintf+0x169>
                    s = "(null)";
    23b3:	c7 45 f4 5c 26 00 00 	movl   $0x265c,-0xc(%ebp)
                while(*s != 0){
    23ba:	eb 1c                	jmp    23d8 <sprintf+0x169>
                    dst[j++] = *s;
    23bc:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23bf:	8d 50 01             	lea    0x1(%eax),%edx
    23c2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23c5:	89 c2                	mov    %eax,%edx
    23c7:	8b 45 08             	mov    0x8(%ebp),%eax
    23ca:	01 c2                	add    %eax,%edx
    23cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23cf:	0f b6 00             	movzbl (%eax),%eax
    23d2:	88 02                	mov    %al,(%edx)
                    s++;
    23d4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    23d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23db:	0f b6 00             	movzbl (%eax),%eax
    23de:	84 c0                	test   %al,%al
    23e0:	75 da                	jne    23bc <sprintf+0x14d>
    23e2:	e9 86 00 00 00       	jmp    246d <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    23e7:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    23eb:	75 1d                	jne    240a <sprintf+0x19b>
                dst[j++] = *ap;
    23ed:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23f0:	8d 50 01             	lea    0x1(%eax),%edx
    23f3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23f6:	89 c2                	mov    %eax,%edx
    23f8:	8b 45 08             	mov    0x8(%ebp),%eax
    23fb:	01 c2                	add    %eax,%edx
    23fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2400:	8b 00                	mov    (%eax),%eax
    2402:	88 02                	mov    %al,(%edx)
                ap++;
    2404:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2408:	eb 63                	jmp    246d <sprintf+0x1fe>
            } else if(c == '%'){
    240a:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    240e:	75 17                	jne    2427 <sprintf+0x1b8>
                dst[j++] = c;
    2410:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2413:	8d 50 01             	lea    0x1(%eax),%edx
    2416:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2419:	89 c2                	mov    %eax,%edx
    241b:	8b 45 08             	mov    0x8(%ebp),%eax
    241e:	01 d0                	add    %edx,%eax
    2420:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2423:	88 10                	mov    %dl,(%eax)
    2425:	eb 46                	jmp    246d <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2427:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    242b:	7e 18                	jle    2445 <sprintf+0x1d6>
    242d:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2431:	7f 12                	jg     2445 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2433:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2436:	8d 50 01             	lea    0x1(%eax),%edx
    2439:	89 55 f0             	mov    %edx,-0x10(%ebp)
    243c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    243f:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2443:	eb 2f                	jmp    2474 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2445:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2448:	8d 50 01             	lea    0x1(%eax),%edx
    244b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    244e:	89 c2                	mov    %eax,%edx
    2450:	8b 45 08             	mov    0x8(%ebp),%eax
    2453:	01 d0                	add    %edx,%eax
    2455:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2458:	8b 45 c8             	mov    -0x38(%ebp),%eax
    245b:	8d 50 01             	lea    0x1(%eax),%edx
    245e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2461:	89 c2                	mov    %eax,%edx
    2463:	8b 45 08             	mov    0x8(%ebp),%eax
    2466:	01 d0                	add    %edx,%eax
    2468:	8b 55 e0             	mov    -0x20(%ebp),%edx
    246b:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    246d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2474:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2478:	8b 55 0c             	mov    0xc(%ebp),%edx
    247b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    247e:	01 d0                	add    %edx,%eax
    2480:	0f b6 00             	movzbl (%eax),%eax
    2483:	84 c0                	test   %al,%al
    2485:	0f 85 14 fe ff ff    	jne    229f <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    248b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    248e:	8d 50 01             	lea    0x1(%eax),%edx
    2491:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2494:	89 c2                	mov    %eax,%edx
    2496:	8b 45 08             	mov    0x8(%ebp),%eax
    2499:	01 d0                	add    %edx,%eax
    249b:	c6 00 00             	movb   $0x0,(%eax)
}
    249e:	90                   	nop
    249f:	c9                   	leave  
    24a0:	c3                   	ret    
