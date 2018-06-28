
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
      19:	68 b0 20 00 00       	push   $0x20b0
      1e:	6a 02                	push   $0x2
      20:	e8 45 04 00 00       	call   46a <printf>
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
      60:	68 c3 20 00 00       	push   $0x20c3
      65:	6a 02                	push   $0x2
      67:	e8 fe 03 00 00       	call   46a <printf>
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

00000373 <initStringFigure>:
SYSCALL(initStringFigure)
     373:	b8 17 00 00 00       	mov    $0x17,%eax
     378:	cd 40                	int    $0x40
     37a:	c3                   	ret    

0000037b <sendMessage>:
SYSCALL(sendMessage)
     37b:	b8 18 00 00 00       	mov    $0x18,%eax
     380:	cd 40                	int    $0x40
     382:	c3                   	ret    

00000383 <getMessage>:
SYSCALL(getMessage)
     383:	b8 1a 00 00 00       	mov    $0x1a,%eax
     388:	cd 40                	int    $0x40
     38a:	c3                   	ret    

0000038b <registWindow>:
SYSCALL(registWindow)
     38b:	b8 19 00 00 00       	mov    $0x19,%eax
     390:	cd 40                	int    $0x40
     392:	c3                   	ret    

00000393 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     393:	55                   	push   %ebp
     394:	89 e5                	mov    %esp,%ebp
     396:	83 ec 18             	sub    $0x18,%esp
     399:	8b 45 0c             	mov    0xc(%ebp),%eax
     39c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     39f:	83 ec 04             	sub    $0x4,%esp
     3a2:	6a 01                	push   $0x1
     3a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3a7:	50                   	push   %eax
     3a8:	ff 75 08             	pushl  0x8(%ebp)
     3ab:	e8 3b ff ff ff       	call   2eb <write>
     3b0:	83 c4 10             	add    $0x10,%esp
}
     3b3:	90                   	nop
     3b4:	c9                   	leave  
     3b5:	c3                   	ret    

000003b6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3b6:	55                   	push   %ebp
     3b7:	89 e5                	mov    %esp,%ebp
     3b9:	53                   	push   %ebx
     3ba:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3bd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3c4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3c8:	74 17                	je     3e1 <printint+0x2b>
     3ca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3ce:	79 11                	jns    3e1 <printint+0x2b>
    neg = 1;
     3d0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3d7:	8b 45 0c             	mov    0xc(%ebp),%eax
     3da:	f7 d8                	neg    %eax
     3dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3df:	eb 06                	jmp    3e7 <printint+0x31>
  } else {
    x = xx;
     3e1:	8b 45 0c             	mov    0xc(%ebp),%eax
     3e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3ee:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3f1:	8d 41 01             	lea    0x1(%ecx),%eax
     3f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3f7:	8b 5d 10             	mov    0x10(%ebp),%ebx
     3fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3fd:	ba 00 00 00 00       	mov    $0x0,%edx
     402:	f7 f3                	div    %ebx
     404:	89 d0                	mov    %edx,%eax
     406:	0f b6 80 64 27 00 00 	movzbl 0x2764(%eax),%eax
     40d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     411:	8b 5d 10             	mov    0x10(%ebp),%ebx
     414:	8b 45 ec             	mov    -0x14(%ebp),%eax
     417:	ba 00 00 00 00       	mov    $0x0,%edx
     41c:	f7 f3                	div    %ebx
     41e:	89 45 ec             	mov    %eax,-0x14(%ebp)
     421:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     425:	75 c7                	jne    3ee <printint+0x38>
  if(neg)
     427:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     42b:	74 2d                	je     45a <printint+0xa4>
    buf[i++] = '-';
     42d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     430:	8d 50 01             	lea    0x1(%eax),%edx
     433:	89 55 f4             	mov    %edx,-0xc(%ebp)
     436:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     43b:	eb 1d                	jmp    45a <printint+0xa4>
    putc(fd, buf[i]);
     43d:	8d 55 dc             	lea    -0x24(%ebp),%edx
     440:	8b 45 f4             	mov    -0xc(%ebp),%eax
     443:	01 d0                	add    %edx,%eax
     445:	0f b6 00             	movzbl (%eax),%eax
     448:	0f be c0             	movsbl %al,%eax
     44b:	83 ec 08             	sub    $0x8,%esp
     44e:	50                   	push   %eax
     44f:	ff 75 08             	pushl  0x8(%ebp)
     452:	e8 3c ff ff ff       	call   393 <putc>
     457:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     45a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     45e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     462:	79 d9                	jns    43d <printint+0x87>
    putc(fd, buf[i]);
}
     464:	90                   	nop
     465:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     468:	c9                   	leave  
     469:	c3                   	ret    

0000046a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     46a:	55                   	push   %ebp
     46b:	89 e5                	mov    %esp,%ebp
     46d:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     470:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     477:	8d 45 0c             	lea    0xc(%ebp),%eax
     47a:	83 c0 04             	add    $0x4,%eax
     47d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     480:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     487:	e9 59 01 00 00       	jmp    5e5 <printf+0x17b>
    c = fmt[i] & 0xff;
     48c:	8b 55 0c             	mov    0xc(%ebp),%edx
     48f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     492:	01 d0                	add    %edx,%eax
     494:	0f b6 00             	movzbl (%eax),%eax
     497:	0f be c0             	movsbl %al,%eax
     49a:	25 ff 00 00 00       	and    $0xff,%eax
     49f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4a2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4a6:	75 2c                	jne    4d4 <printf+0x6a>
      if(c == '%'){
     4a8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4ac:	75 0c                	jne    4ba <printf+0x50>
        state = '%';
     4ae:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4b5:	e9 27 01 00 00       	jmp    5e1 <printf+0x177>
      } else {
        putc(fd, c);
     4ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4bd:	0f be c0             	movsbl %al,%eax
     4c0:	83 ec 08             	sub    $0x8,%esp
     4c3:	50                   	push   %eax
     4c4:	ff 75 08             	pushl  0x8(%ebp)
     4c7:	e8 c7 fe ff ff       	call   393 <putc>
     4cc:	83 c4 10             	add    $0x10,%esp
     4cf:	e9 0d 01 00 00       	jmp    5e1 <printf+0x177>
      }
    } else if(state == '%'){
     4d4:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4d8:	0f 85 03 01 00 00    	jne    5e1 <printf+0x177>
      if(c == 'd'){
     4de:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4e2:	75 1e                	jne    502 <printf+0x98>
        printint(fd, *ap, 10, 1);
     4e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4e7:	8b 00                	mov    (%eax),%eax
     4e9:	6a 01                	push   $0x1
     4eb:	6a 0a                	push   $0xa
     4ed:	50                   	push   %eax
     4ee:	ff 75 08             	pushl  0x8(%ebp)
     4f1:	e8 c0 fe ff ff       	call   3b6 <printint>
     4f6:	83 c4 10             	add    $0x10,%esp
        ap++;
     4f9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4fd:	e9 d8 00 00 00       	jmp    5da <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     502:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     506:	74 06                	je     50e <printf+0xa4>
     508:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     50c:	75 1e                	jne    52c <printf+0xc2>
        printint(fd, *ap, 16, 0);
     50e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     511:	8b 00                	mov    (%eax),%eax
     513:	6a 00                	push   $0x0
     515:	6a 10                	push   $0x10
     517:	50                   	push   %eax
     518:	ff 75 08             	pushl  0x8(%ebp)
     51b:	e8 96 fe ff ff       	call   3b6 <printint>
     520:	83 c4 10             	add    $0x10,%esp
        ap++;
     523:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     527:	e9 ae 00 00 00       	jmp    5da <printf+0x170>
      } else if(c == 's'){
     52c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     530:	75 43                	jne    575 <printf+0x10b>
        s = (char*)*ap;
     532:	8b 45 e8             	mov    -0x18(%ebp),%eax
     535:	8b 00                	mov    (%eax),%eax
     537:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     53a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     53e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     542:	75 25                	jne    569 <printf+0xff>
          s = "(null)";
     544:	c7 45 f4 d7 20 00 00 	movl   $0x20d7,-0xc(%ebp)
        while(*s != 0){
     54b:	eb 1c                	jmp    569 <printf+0xff>
          putc(fd, *s);
     54d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     550:	0f b6 00             	movzbl (%eax),%eax
     553:	0f be c0             	movsbl %al,%eax
     556:	83 ec 08             	sub    $0x8,%esp
     559:	50                   	push   %eax
     55a:	ff 75 08             	pushl  0x8(%ebp)
     55d:	e8 31 fe ff ff       	call   393 <putc>
     562:	83 c4 10             	add    $0x10,%esp
          s++;
     565:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     569:	8b 45 f4             	mov    -0xc(%ebp),%eax
     56c:	0f b6 00             	movzbl (%eax),%eax
     56f:	84 c0                	test   %al,%al
     571:	75 da                	jne    54d <printf+0xe3>
     573:	eb 65                	jmp    5da <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     575:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     579:	75 1d                	jne    598 <printf+0x12e>
        putc(fd, *ap);
     57b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     57e:	8b 00                	mov    (%eax),%eax
     580:	0f be c0             	movsbl %al,%eax
     583:	83 ec 08             	sub    $0x8,%esp
     586:	50                   	push   %eax
     587:	ff 75 08             	pushl  0x8(%ebp)
     58a:	e8 04 fe ff ff       	call   393 <putc>
     58f:	83 c4 10             	add    $0x10,%esp
        ap++;
     592:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     596:	eb 42                	jmp    5da <printf+0x170>
      } else if(c == '%'){
     598:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     59c:	75 17                	jne    5b5 <printf+0x14b>
        putc(fd, c);
     59e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5a1:	0f be c0             	movsbl %al,%eax
     5a4:	83 ec 08             	sub    $0x8,%esp
     5a7:	50                   	push   %eax
     5a8:	ff 75 08             	pushl  0x8(%ebp)
     5ab:	e8 e3 fd ff ff       	call   393 <putc>
     5b0:	83 c4 10             	add    $0x10,%esp
     5b3:	eb 25                	jmp    5da <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5b5:	83 ec 08             	sub    $0x8,%esp
     5b8:	6a 25                	push   $0x25
     5ba:	ff 75 08             	pushl  0x8(%ebp)
     5bd:	e8 d1 fd ff ff       	call   393 <putc>
     5c2:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5c8:	0f be c0             	movsbl %al,%eax
     5cb:	83 ec 08             	sub    $0x8,%esp
     5ce:	50                   	push   %eax
     5cf:	ff 75 08             	pushl  0x8(%ebp)
     5d2:	e8 bc fd ff ff       	call   393 <putc>
     5d7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5e1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5e5:	8b 55 0c             	mov    0xc(%ebp),%edx
     5e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5eb:	01 d0                	add    %edx,%eax
     5ed:	0f b6 00             	movzbl (%eax),%eax
     5f0:	84 c0                	test   %al,%al
     5f2:	0f 85 94 fe ff ff    	jne    48c <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     5f8:	90                   	nop
     5f9:	c9                   	leave  
     5fa:	c3                   	ret    

000005fb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     5fb:	55                   	push   %ebp
     5fc:	89 e5                	mov    %esp,%ebp
     5fe:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     601:	8b 45 08             	mov    0x8(%ebp),%eax
     604:	83 e8 08             	sub    $0x8,%eax
     607:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     60a:	a1 94 27 00 00       	mov    0x2794,%eax
     60f:	89 45 fc             	mov    %eax,-0x4(%ebp)
     612:	eb 24                	jmp    638 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     614:	8b 45 fc             	mov    -0x4(%ebp),%eax
     617:	8b 00                	mov    (%eax),%eax
     619:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     61c:	77 12                	ja     630 <free+0x35>
     61e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     621:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     624:	77 24                	ja     64a <free+0x4f>
     626:	8b 45 fc             	mov    -0x4(%ebp),%eax
     629:	8b 00                	mov    (%eax),%eax
     62b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     62e:	77 1a                	ja     64a <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     630:	8b 45 fc             	mov    -0x4(%ebp),%eax
     633:	8b 00                	mov    (%eax),%eax
     635:	89 45 fc             	mov    %eax,-0x4(%ebp)
     638:	8b 45 f8             	mov    -0x8(%ebp),%eax
     63b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     63e:	76 d4                	jbe    614 <free+0x19>
     640:	8b 45 fc             	mov    -0x4(%ebp),%eax
     643:	8b 00                	mov    (%eax),%eax
     645:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     648:	76 ca                	jbe    614 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     64a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     64d:	8b 40 04             	mov    0x4(%eax),%eax
     650:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     657:	8b 45 f8             	mov    -0x8(%ebp),%eax
     65a:	01 c2                	add    %eax,%edx
     65c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     65f:	8b 00                	mov    (%eax),%eax
     661:	39 c2                	cmp    %eax,%edx
     663:	75 24                	jne    689 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     665:	8b 45 f8             	mov    -0x8(%ebp),%eax
     668:	8b 50 04             	mov    0x4(%eax),%edx
     66b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66e:	8b 00                	mov    (%eax),%eax
     670:	8b 40 04             	mov    0x4(%eax),%eax
     673:	01 c2                	add    %eax,%edx
     675:	8b 45 f8             	mov    -0x8(%ebp),%eax
     678:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     67b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67e:	8b 00                	mov    (%eax),%eax
     680:	8b 10                	mov    (%eax),%edx
     682:	8b 45 f8             	mov    -0x8(%ebp),%eax
     685:	89 10                	mov    %edx,(%eax)
     687:	eb 0a                	jmp    693 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     689:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68c:	8b 10                	mov    (%eax),%edx
     68e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     691:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     693:	8b 45 fc             	mov    -0x4(%ebp),%eax
     696:	8b 40 04             	mov    0x4(%eax),%eax
     699:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a3:	01 d0                	add    %edx,%eax
     6a5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6a8:	75 20                	jne    6ca <free+0xcf>
    p->s.size += bp->s.size;
     6aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ad:	8b 50 04             	mov    0x4(%eax),%edx
     6b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b3:	8b 40 04             	mov    0x4(%eax),%eax
     6b6:	01 c2                	add    %eax,%edx
     6b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6bb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6be:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c1:	8b 10                	mov    (%eax),%edx
     6c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c6:	89 10                	mov    %edx,(%eax)
     6c8:	eb 08                	jmp    6d2 <free+0xd7>
  } else
    p->s.ptr = bp;
     6ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cd:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6d0:	89 10                	mov    %edx,(%eax)
  freep = p;
     6d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d5:	a3 94 27 00 00       	mov    %eax,0x2794
}
     6da:	90                   	nop
     6db:	c9                   	leave  
     6dc:	c3                   	ret    

000006dd <morecore>:

static Header*
morecore(uint nu)
{
     6dd:	55                   	push   %ebp
     6de:	89 e5                	mov    %esp,%ebp
     6e0:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6e3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6ea:	77 07                	ja     6f3 <morecore+0x16>
    nu = 4096;
     6ec:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     6f3:	8b 45 08             	mov    0x8(%ebp),%eax
     6f6:	c1 e0 03             	shl    $0x3,%eax
     6f9:	83 ec 0c             	sub    $0xc,%esp
     6fc:	50                   	push   %eax
     6fd:	e8 51 fc ff ff       	call   353 <sbrk>
     702:	83 c4 10             	add    $0x10,%esp
     705:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     708:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     70c:	75 07                	jne    715 <morecore+0x38>
    return 0;
     70e:	b8 00 00 00 00       	mov    $0x0,%eax
     713:	eb 26                	jmp    73b <morecore+0x5e>
  hp = (Header*)p;
     715:	8b 45 f4             	mov    -0xc(%ebp),%eax
     718:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     71b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     71e:	8b 55 08             	mov    0x8(%ebp),%edx
     721:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     724:	8b 45 f0             	mov    -0x10(%ebp),%eax
     727:	83 c0 08             	add    $0x8,%eax
     72a:	83 ec 0c             	sub    $0xc,%esp
     72d:	50                   	push   %eax
     72e:	e8 c8 fe ff ff       	call   5fb <free>
     733:	83 c4 10             	add    $0x10,%esp
  return freep;
     736:	a1 94 27 00 00       	mov    0x2794,%eax
}
     73b:	c9                   	leave  
     73c:	c3                   	ret    

0000073d <malloc>:

void*
malloc(uint nbytes)
{
     73d:	55                   	push   %ebp
     73e:	89 e5                	mov    %esp,%ebp
     740:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     743:	8b 45 08             	mov    0x8(%ebp),%eax
     746:	83 c0 07             	add    $0x7,%eax
     749:	c1 e8 03             	shr    $0x3,%eax
     74c:	83 c0 01             	add    $0x1,%eax
     74f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     752:	a1 94 27 00 00       	mov    0x2794,%eax
     757:	89 45 f0             	mov    %eax,-0x10(%ebp)
     75a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     75e:	75 23                	jne    783 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     760:	c7 45 f0 8c 27 00 00 	movl   $0x278c,-0x10(%ebp)
     767:	8b 45 f0             	mov    -0x10(%ebp),%eax
     76a:	a3 94 27 00 00       	mov    %eax,0x2794
     76f:	a1 94 27 00 00       	mov    0x2794,%eax
     774:	a3 8c 27 00 00       	mov    %eax,0x278c
    base.s.size = 0;
     779:	c7 05 90 27 00 00 00 	movl   $0x0,0x2790
     780:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     783:	8b 45 f0             	mov    -0x10(%ebp),%eax
     786:	8b 00                	mov    (%eax),%eax
     788:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     78b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     78e:	8b 40 04             	mov    0x4(%eax),%eax
     791:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     794:	72 4d                	jb     7e3 <malloc+0xa6>
      if(p->s.size == nunits)
     796:	8b 45 f4             	mov    -0xc(%ebp),%eax
     799:	8b 40 04             	mov    0x4(%eax),%eax
     79c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     79f:	75 0c                	jne    7ad <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a4:	8b 10                	mov    (%eax),%edx
     7a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7a9:	89 10                	mov    %edx,(%eax)
     7ab:	eb 26                	jmp    7d3 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b0:	8b 40 04             	mov    0x4(%eax),%eax
     7b3:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7b6:	89 c2                	mov    %eax,%edx
     7b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7bb:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7be:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c1:	8b 40 04             	mov    0x4(%eax),%eax
     7c4:	c1 e0 03             	shl    $0x3,%eax
     7c7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7cd:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7d0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d6:	a3 94 27 00 00       	mov    %eax,0x2794
      return (void*)(p + 1);
     7db:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7de:	83 c0 08             	add    $0x8,%eax
     7e1:	eb 3b                	jmp    81e <malloc+0xe1>
    }
    if(p == freep)
     7e3:	a1 94 27 00 00       	mov    0x2794,%eax
     7e8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7eb:	75 1e                	jne    80b <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7ed:	83 ec 0c             	sub    $0xc,%esp
     7f0:	ff 75 ec             	pushl  -0x14(%ebp)
     7f3:	e8 e5 fe ff ff       	call   6dd <morecore>
     7f8:	83 c4 10             	add    $0x10,%esp
     7fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
     7fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     802:	75 07                	jne    80b <malloc+0xce>
        return 0;
     804:	b8 00 00 00 00       	mov    $0x0,%eax
     809:	eb 13                	jmp    81e <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     80b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     811:	8b 45 f4             	mov    -0xc(%ebp),%eax
     814:	8b 00                	mov    (%eax),%eax
     816:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     819:	e9 6d ff ff ff       	jmp    78b <malloc+0x4e>
}
     81e:	c9                   	leave  
     81f:	c3                   	ret    

00000820 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     820:	55                   	push   %ebp
     821:	89 e5                	mov    %esp,%ebp
     823:	83 ec 1c             	sub    $0x1c,%esp
     826:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     829:	8b 55 10             	mov    0x10(%ebp),%edx
     82c:	8b 45 14             	mov    0x14(%ebp),%eax
     82f:	88 4d ec             	mov    %cl,-0x14(%ebp)
     832:	88 55 e8             	mov    %dl,-0x18(%ebp)
     835:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     838:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     83c:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     83f:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     843:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     846:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     84a:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     84d:	8b 45 08             	mov    0x8(%ebp),%eax
     850:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     854:	66 89 10             	mov    %dx,(%eax)
     857:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     85b:	88 50 02             	mov    %dl,0x2(%eax)
}
     85e:	8b 45 08             	mov    0x8(%ebp),%eax
     861:	c9                   	leave  
     862:	c2 04 00             	ret    $0x4

00000865 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     865:	55                   	push   %ebp
     866:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     868:	8b 45 08             	mov    0x8(%ebp),%eax
     86b:	2b 45 10             	sub    0x10(%ebp),%eax
     86e:	89 c2                	mov    %eax,%edx
     870:	8b 45 08             	mov    0x8(%ebp),%eax
     873:	2b 45 10             	sub    0x10(%ebp),%eax
     876:	0f af d0             	imul   %eax,%edx
     879:	8b 45 0c             	mov    0xc(%ebp),%eax
     87c:	2b 45 14             	sub    0x14(%ebp),%eax
     87f:	89 c1                	mov    %eax,%ecx
     881:	8b 45 0c             	mov    0xc(%ebp),%eax
     884:	2b 45 14             	sub    0x14(%ebp),%eax
     887:	0f af c1             	imul   %ecx,%eax
     88a:	01 d0                	add    %edx,%eax
}
     88c:	5d                   	pop    %ebp
     88d:	c3                   	ret    

0000088e <abs_int>:

static inline int abs_int(int x)
{
     88e:	55                   	push   %ebp
     88f:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     891:	8b 45 08             	mov    0x8(%ebp),%eax
     894:	99                   	cltd   
     895:	89 d0                	mov    %edx,%eax
     897:	33 45 08             	xor    0x8(%ebp),%eax
     89a:	29 d0                	sub    %edx,%eax
}
     89c:	5d                   	pop    %ebp
     89d:	c3                   	ret    

0000089e <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     89e:	55                   	push   %ebp
     89f:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     8a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8a5:	79 07                	jns    8ae <APGetIndex+0x10>
        return X_SMALLER;
     8a7:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8ac:	eb 40                	jmp    8ee <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8ae:	8b 45 08             	mov    0x8(%ebp),%eax
     8b1:	8b 00                	mov    (%eax),%eax
     8b3:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8b6:	7f 07                	jg     8bf <APGetIndex+0x21>
        return X_BIGGER;
     8b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8bd:	eb 2f                	jmp    8ee <APGetIndex+0x50>
    if (y < 0)
     8bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8c3:	79 07                	jns    8cc <APGetIndex+0x2e>
        return Y_SMALLER;
     8c5:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8ca:	eb 22                	jmp    8ee <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8cc:	8b 45 08             	mov    0x8(%ebp),%eax
     8cf:	8b 40 04             	mov    0x4(%eax),%eax
     8d2:	3b 45 10             	cmp    0x10(%ebp),%eax
     8d5:	7f 07                	jg     8de <APGetIndex+0x40>
        return Y_BIGGER;
     8d7:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8dc:	eb 10                	jmp    8ee <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8de:	8b 45 08             	mov    0x8(%ebp),%eax
     8e1:	8b 00                	mov    (%eax),%eax
     8e3:	0f af 45 10          	imul   0x10(%ebp),%eax
     8e7:	89 c2                	mov    %eax,%edx
     8e9:	8b 45 0c             	mov    0xc(%ebp),%eax
     8ec:	01 d0                	add    %edx,%eax
}
     8ee:	5d                   	pop    %ebp
     8ef:	c3                   	ret    

000008f0 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     8f0:	55                   	push   %ebp
     8f1:	89 e5                	mov    %esp,%ebp
     8f3:	83 ec 78             	sub    $0x78,%esp
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
     912:	e8 f4 f9 ff ff       	call   30b <open>
     917:	83 c4 10             	add    $0x10,%esp
     91a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     91d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     921:	79 2e                	jns    951 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     923:	83 ec 04             	sub    $0x4,%esp
     926:	ff 75 0c             	pushl  0xc(%ebp)
     929:	68 de 20 00 00       	push   $0x20de
     92e:	6a 01                	push   $0x1
     930:	e8 35 fb ff ff       	call   46a <printf>
     935:	83 c4 10             	add    $0x10,%esp
        return bmp;
     938:	8b 45 08             	mov    0x8(%ebp),%eax
     93b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     93e:	89 10                	mov    %edx,(%eax)
     940:	8b 55 cc             	mov    -0x34(%ebp),%edx
     943:	89 50 04             	mov    %edx,0x4(%eax)
     946:	8b 55 d0             	mov    -0x30(%ebp),%edx
     949:	89 50 08             	mov    %edx,0x8(%eax)
     94c:	e9 d2 01 00 00       	jmp    b23 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     951:	83 ec 04             	sub    $0x4,%esp
     954:	6a 0e                	push   $0xe
     956:	8d 45 ba             	lea    -0x46(%ebp),%eax
     959:	50                   	push   %eax
     95a:	ff 75 ec             	pushl  -0x14(%ebp)
     95d:	e8 81 f9 ff ff       	call   2e3 <read>
     962:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     965:	83 ec 04             	sub    $0x4,%esp
     968:	6a 28                	push   $0x28
     96a:	8d 45 92             	lea    -0x6e(%ebp),%eax
     96d:	50                   	push   %eax
     96e:	ff 75 ec             	pushl  -0x14(%ebp)
     971:	e8 6d f9 ff ff       	call   2e3 <read>
     976:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     979:	8b 45 96             	mov    -0x6a(%ebp),%eax
     97c:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     97f:	8b 45 9a             	mov    -0x66(%ebp),%eax
     982:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     985:	8b 55 c8             	mov    -0x38(%ebp),%edx
     988:	8b 45 cc             	mov    -0x34(%ebp),%eax
     98b:	0f af d0             	imul   %eax,%edx
     98e:	89 d0                	mov    %edx,%eax
     990:	01 c0                	add    %eax,%eax
     992:	01 d0                	add    %edx,%eax
     994:	83 ec 0c             	sub    $0xc,%esp
     997:	50                   	push   %eax
     998:	e8 a0 fd ff ff       	call   73d <malloc>
     99d:	83 c4 10             	add    $0x10,%esp
     9a0:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9a3:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9a7:	0f b7 c0             	movzwl %ax,%eax
     9aa:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9ad:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9b3:	0f af c2             	imul   %edx,%eax
     9b6:	83 c0 1f             	add    $0x1f,%eax
     9b9:	c1 e8 05             	shr    $0x5,%eax
     9bc:	c1 e0 02             	shl    $0x2,%eax
     9bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9c2:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9c8:	0f af c2             	imul   %edx,%eax
     9cb:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9d1:	83 ec 0c             	sub    $0xc,%esp
     9d4:	50                   	push   %eax
     9d5:	e8 63 fd ff ff       	call   73d <malloc>
     9da:	83 c4 10             	add    $0x10,%esp
     9dd:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9e0:	83 ec 04             	sub    $0x4,%esp
     9e3:	ff 75 e0             	pushl  -0x20(%ebp)
     9e6:	ff 75 dc             	pushl  -0x24(%ebp)
     9e9:	ff 75 ec             	pushl  -0x14(%ebp)
     9ec:	e8 f2 f8 ff ff       	call   2e3 <read>
     9f1:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     9f4:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9f8:	66 c1 e8 03          	shr    $0x3,%ax
     9fc:	0f b7 c0             	movzwl %ax,%eax
     9ff:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a09:	e9 e5 00 00 00       	jmp    af3 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a0e:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a11:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a14:	29 c2                	sub    %eax,%edx
     a16:	89 d0                	mov    %edx,%eax
     a18:	8d 50 ff             	lea    -0x1(%eax),%edx
     a1b:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a1e:	0f af c2             	imul   %edx,%eax
     a21:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a24:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a2b:	e9 b1 00 00 00       	jmp    ae1 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a30:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a33:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a36:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a39:	01 c8                	add    %ecx,%eax
     a3b:	89 c1                	mov    %eax,%ecx
     a3d:	89 c8                	mov    %ecx,%eax
     a3f:	01 c0                	add    %eax,%eax
     a41:	01 c8                	add    %ecx,%eax
     a43:	01 c2                	add    %eax,%edx
     a45:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a48:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a4c:	89 c1                	mov    %eax,%ecx
     a4e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a51:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a55:	01 c1                	add    %eax,%ecx
     a57:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a5a:	01 c8                	add    %ecx,%eax
     a5c:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a5f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a62:	01 c8                	add    %ecx,%eax
     a64:	0f b6 00             	movzbl (%eax),%eax
     a67:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a6a:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a6d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a70:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a73:	01 c8                	add    %ecx,%eax
     a75:	89 c1                	mov    %eax,%ecx
     a77:	89 c8                	mov    %ecx,%eax
     a79:	01 c0                	add    %eax,%eax
     a7b:	01 c8                	add    %ecx,%eax
     a7d:	01 c2                	add    %eax,%edx
     a7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a82:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a86:	89 c1                	mov    %eax,%ecx
     a88:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a8b:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a8f:	01 c1                	add    %eax,%ecx
     a91:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a94:	01 c8                	add    %ecx,%eax
     a96:	8d 48 fe             	lea    -0x2(%eax),%ecx
     a99:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a9c:	01 c8                	add    %ecx,%eax
     a9e:	0f b6 00             	movzbl (%eax),%eax
     aa1:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     aa4:	8b 55 d0             	mov    -0x30(%ebp),%edx
     aa7:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     aaa:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aad:	01 c8                	add    %ecx,%eax
     aaf:	89 c1                	mov    %eax,%ecx
     ab1:	89 c8                	mov    %ecx,%eax
     ab3:	01 c0                	add    %eax,%eax
     ab5:	01 c8                	add    %ecx,%eax
     ab7:	01 c2                	add    %eax,%edx
     ab9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     abc:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ac0:	89 c1                	mov    %eax,%ecx
     ac2:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ac5:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ac9:	01 c1                	add    %eax,%ecx
     acb:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ace:	01 c8                	add    %ecx,%eax
     ad0:	8d 48 fd             	lea    -0x3(%eax),%ecx
     ad3:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ad6:	01 c8                	add    %ecx,%eax
     ad8:	0f b6 00             	movzbl (%eax),%eax
     adb:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     add:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ae1:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ae4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ae7:	39 c2                	cmp    %eax,%edx
     ae9:	0f 87 41 ff ff ff    	ja     a30 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     aef:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     af3:	8b 55 cc             	mov    -0x34(%ebp),%edx
     af6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af9:	39 c2                	cmp    %eax,%edx
     afb:	0f 87 0d ff ff ff    	ja     a0e <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b01:	83 ec 0c             	sub    $0xc,%esp
     b04:	ff 75 ec             	pushl  -0x14(%ebp)
     b07:	e8 e7 f7 ff ff       	call   2f3 <close>
     b0c:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b0f:	8b 45 08             	mov    0x8(%ebp),%eax
     b12:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b15:	89 10                	mov    %edx,(%eax)
     b17:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b1a:	89 50 04             	mov    %edx,0x4(%eax)
     b1d:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b20:	89 50 08             	mov    %edx,0x8(%eax)
}
     b23:	8b 45 08             	mov    0x8(%ebp),%eax
     b26:	c9                   	leave  
     b27:	c2 04 00             	ret    $0x4

00000b2a <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b2a:	55                   	push   %ebp
     b2b:	89 e5                	mov    %esp,%ebp
     b2d:	53                   	push   %ebx
     b2e:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b31:	83 ec 0c             	sub    $0xc,%esp
     b34:	6a 1c                	push   $0x1c
     b36:	e8 02 fc ff ff       	call   73d <malloc>
     b3b:	83 c4 10             	add    $0x10,%esp
     b3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b41:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b44:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b4b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b4e:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b51:	6a 0c                	push   $0xc
     b53:	6a 0c                	push   $0xc
     b55:	6a 0c                	push   $0xc
     b57:	50                   	push   %eax
     b58:	e8 c3 fc ff ff       	call   820 <RGB>
     b5d:	83 c4 0c             	add    $0xc,%esp
     b60:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b64:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b68:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b6c:	88 43 15             	mov    %al,0x15(%ebx)
     b6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b72:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b75:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b79:	66 89 48 10          	mov    %cx,0x10(%eax)
     b7d:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b81:	88 50 12             	mov    %dl,0x12(%eax)
     b84:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b87:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b8a:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     b8e:	66 89 48 08          	mov    %cx,0x8(%eax)
     b92:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     b96:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     b99:	8b 45 08             	mov    0x8(%ebp),%eax
     b9c:	89 c2                	mov    %eax,%edx
     b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba1:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     ba3:	8b 45 0c             	mov    0xc(%ebp),%eax
     ba6:	89 c2                	mov    %eax,%edx
     ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bab:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bae:	8b 55 10             	mov    0x10(%ebp),%edx
     bb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb4:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     bb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bbd:	c9                   	leave  
     bbe:	c3                   	ret    

00000bbf <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     bbf:	55                   	push   %ebp
     bc0:	89 e5                	mov    %esp,%ebp
     bc2:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     bc5:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc8:	8b 50 08             	mov    0x8(%eax),%edx
     bcb:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bce:	8b 40 0c             	mov    0xc(%eax),%eax
     bd1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     bd4:	8b 45 0c             	mov    0xc(%ebp),%eax
     bd7:	8b 55 10             	mov    0x10(%ebp),%edx
     bda:	89 50 08             	mov    %edx,0x8(%eax)
     bdd:	8b 55 14             	mov    0x14(%ebp),%edx
     be0:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     be3:	8b 45 08             	mov    0x8(%ebp),%eax
     be6:	8b 55 f8             	mov    -0x8(%ebp),%edx
     be9:	89 10                	mov    %edx,(%eax)
     beb:	8b 55 fc             	mov    -0x4(%ebp),%edx
     bee:	89 50 04             	mov    %edx,0x4(%eax)
}
     bf1:	8b 45 08             	mov    0x8(%ebp),%eax
     bf4:	c9                   	leave  
     bf5:	c2 04 00             	ret    $0x4

00000bf8 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     bf8:	55                   	push   %ebp
     bf9:	89 e5                	mov    %esp,%ebp
     bfb:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     bfe:	8b 45 0c             	mov    0xc(%ebp),%eax
     c01:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c05:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c09:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c0d:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c10:	8b 45 0c             	mov    0xc(%ebp),%eax
     c13:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c17:	66 89 50 10          	mov    %dx,0x10(%eax)
     c1b:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c1f:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c22:	8b 45 08             	mov    0x8(%ebp),%eax
     c25:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c29:	66 89 10             	mov    %dx,(%eax)
     c2c:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c30:	88 50 02             	mov    %dl,0x2(%eax)
}
     c33:	8b 45 08             	mov    0x8(%ebp),%eax
     c36:	c9                   	leave  
     c37:	c2 04 00             	ret    $0x4

00000c3a <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c3a:	55                   	push   %ebp
     c3b:	89 e5                	mov    %esp,%ebp
     c3d:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c40:	8b 45 08             	mov    0x8(%ebp),%eax
     c43:	8b 40 0c             	mov    0xc(%eax),%eax
     c46:	89 c2                	mov    %eax,%edx
     c48:	c1 ea 1f             	shr    $0x1f,%edx
     c4b:	01 d0                	add    %edx,%eax
     c4d:	d1 f8                	sar    %eax
     c4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c52:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c55:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c59:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c5c:	8b 45 10             	mov    0x10(%ebp),%eax
     c5f:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c62:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c65:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c69:	0f 89 98 00 00 00    	jns    d07 <APDrawPoint+0xcd>
        i = 0;
     c6f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c76:	e9 8c 00 00 00       	jmp    d07 <APDrawPoint+0xcd>
    {
        j = x - off;
     c7b:	8b 45 0c             	mov    0xc(%ebp),%eax
     c7e:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c81:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     c84:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     c88:	79 69                	jns    cf3 <APDrawPoint+0xb9>
            j = 0;
     c8a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     c91:	eb 60                	jmp    cf3 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     c93:	ff 75 fc             	pushl  -0x4(%ebp)
     c96:	ff 75 f8             	pushl  -0x8(%ebp)
     c99:	ff 75 08             	pushl  0x8(%ebp)
     c9c:	e8 fd fb ff ff       	call   89e <APGetIndex>
     ca1:	83 c4 0c             	add    $0xc,%esp
     ca4:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     ca7:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cab:	74 55                	je     d02 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cad:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     cb1:	74 67                	je     d1a <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     cb3:	ff 75 10             	pushl  0x10(%ebp)
     cb6:	ff 75 0c             	pushl  0xc(%ebp)
     cb9:	ff 75 fc             	pushl  -0x4(%ebp)
     cbc:	ff 75 f8             	pushl  -0x8(%ebp)
     cbf:	e8 a1 fb ff ff       	call   865 <distance_2>
     cc4:	83 c4 10             	add    $0x10,%esp
     cc7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     cca:	7f 23                	jg     cef <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     ccc:	8b 45 08             	mov    0x8(%ebp),%eax
     ccf:	8b 48 18             	mov    0x18(%eax),%ecx
     cd2:	8b 55 ec             	mov    -0x14(%ebp),%edx
     cd5:	89 d0                	mov    %edx,%eax
     cd7:	01 c0                	add    %eax,%eax
     cd9:	01 d0                	add    %edx,%eax
     cdb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     cde:	8b 45 08             	mov    0x8(%ebp),%eax
     ce1:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     ce5:	66 89 0a             	mov    %cx,(%edx)
     ce8:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     cec:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     cef:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     cf3:	8b 55 0c             	mov    0xc(%ebp),%edx
     cf6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf9:	01 d0                	add    %edx,%eax
     cfb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     cfe:	7d 93                	jge    c93 <APDrawPoint+0x59>
     d00:	eb 01                	jmp    d03 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d02:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d03:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d07:	8b 55 10             	mov    0x10(%ebp),%edx
     d0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d0d:	01 d0                	add    %edx,%eax
     d0f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d12:	0f 8d 63 ff ff ff    	jge    c7b <APDrawPoint+0x41>
     d18:	eb 01                	jmp    d1b <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d1a:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d1b:	c9                   	leave  
     d1c:	c3                   	ret    

00000d1d <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d1d:	55                   	push   %ebp
     d1e:	89 e5                	mov    %esp,%ebp
     d20:	53                   	push   %ebx
     d21:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d24:	8b 45 0c             	mov    0xc(%ebp),%eax
     d27:	3b 45 14             	cmp    0x14(%ebp),%eax
     d2a:	0f 85 80 00 00 00    	jne    db0 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d30:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d34:	0f 88 9d 02 00 00    	js     fd7 <APDrawLine+0x2ba>
     d3a:	8b 45 08             	mov    0x8(%ebp),%eax
     d3d:	8b 00                	mov    (%eax),%eax
     d3f:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d42:	0f 8e 8f 02 00 00    	jle    fd7 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d48:	8b 45 10             	mov    0x10(%ebp),%eax
     d4b:	3b 45 18             	cmp    0x18(%ebp),%eax
     d4e:	7e 12                	jle    d62 <APDrawLine+0x45>
        {
            int tmp = y2;
     d50:	8b 45 18             	mov    0x18(%ebp),%eax
     d53:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d56:	8b 45 10             	mov    0x10(%ebp),%eax
     d59:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d5c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d5f:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d62:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d66:	79 07                	jns    d6f <APDrawLine+0x52>
     d68:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d6f:	8b 45 08             	mov    0x8(%ebp),%eax
     d72:	8b 40 04             	mov    0x4(%eax),%eax
     d75:	3b 45 18             	cmp    0x18(%ebp),%eax
     d78:	7d 0c                	jge    d86 <APDrawLine+0x69>
     d7a:	8b 45 08             	mov    0x8(%ebp),%eax
     d7d:	8b 40 04             	mov    0x4(%eax),%eax
     d80:	83 e8 01             	sub    $0x1,%eax
     d83:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     d86:	8b 45 10             	mov    0x10(%ebp),%eax
     d89:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d8c:	eb 15                	jmp    da3 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     d8e:	ff 75 f4             	pushl  -0xc(%ebp)
     d91:	ff 75 0c             	pushl  0xc(%ebp)
     d94:	ff 75 08             	pushl  0x8(%ebp)
     d97:	e8 9e fe ff ff       	call   c3a <APDrawPoint>
     d9c:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     d9f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     da3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da6:	3b 45 18             	cmp    0x18(%ebp),%eax
     da9:	7e e3                	jle    d8e <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     dab:	e9 2b 02 00 00       	jmp    fdb <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     db0:	8b 45 10             	mov    0x10(%ebp),%eax
     db3:	3b 45 18             	cmp    0x18(%ebp),%eax
     db6:	75 7f                	jne    e37 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     db8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dbc:	0f 88 18 02 00 00    	js     fda <APDrawLine+0x2bd>
     dc2:	8b 45 08             	mov    0x8(%ebp),%eax
     dc5:	8b 40 04             	mov    0x4(%eax),%eax
     dc8:	3b 45 10             	cmp    0x10(%ebp),%eax
     dcb:	0f 8e 09 02 00 00    	jle    fda <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     dd1:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd4:	3b 45 14             	cmp    0x14(%ebp),%eax
     dd7:	7e 12                	jle    deb <APDrawLine+0xce>
        {
            int tmp = x2;
     dd9:	8b 45 14             	mov    0x14(%ebp),%eax
     ddc:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     ddf:	8b 45 0c             	mov    0xc(%ebp),%eax
     de2:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     de5:	8b 45 d8             	mov    -0x28(%ebp),%eax
     de8:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     deb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     def:	79 07                	jns    df8 <APDrawLine+0xdb>
     df1:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     df8:	8b 45 08             	mov    0x8(%ebp),%eax
     dfb:	8b 00                	mov    (%eax),%eax
     dfd:	3b 45 14             	cmp    0x14(%ebp),%eax
     e00:	7d 0b                	jge    e0d <APDrawLine+0xf0>
     e02:	8b 45 08             	mov    0x8(%ebp),%eax
     e05:	8b 00                	mov    (%eax),%eax
     e07:	83 e8 01             	sub    $0x1,%eax
     e0a:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e0d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e10:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e13:	eb 15                	jmp    e2a <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e15:	ff 75 10             	pushl  0x10(%ebp)
     e18:	ff 75 f0             	pushl  -0x10(%ebp)
     e1b:	ff 75 08             	pushl  0x8(%ebp)
     e1e:	e8 17 fe ff ff       	call   c3a <APDrawPoint>
     e23:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e26:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e2d:	3b 45 14             	cmp    0x14(%ebp),%eax
     e30:	7e e3                	jle    e15 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e32:	e9 a4 01 00 00       	jmp    fdb <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e37:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e3e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e45:	8b 45 0c             	mov    0xc(%ebp),%eax
     e48:	2b 45 14             	sub    0x14(%ebp),%eax
     e4b:	50                   	push   %eax
     e4c:	e8 3d fa ff ff       	call   88e <abs_int>
     e51:	83 c4 04             	add    $0x4,%esp
     e54:	89 c3                	mov    %eax,%ebx
     e56:	8b 45 10             	mov    0x10(%ebp),%eax
     e59:	2b 45 18             	sub    0x18(%ebp),%eax
     e5c:	50                   	push   %eax
     e5d:	e8 2c fa ff ff       	call   88e <abs_int>
     e62:	83 c4 04             	add    $0x4,%esp
     e65:	39 c3                	cmp    %eax,%ebx
     e67:	0f 8e b5 00 00 00    	jle    f22 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e6d:	8b 45 10             	mov    0x10(%ebp),%eax
     e70:	2b 45 18             	sub    0x18(%ebp),%eax
     e73:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e76:	db 45 b0             	fildl  -0x50(%ebp)
     e79:	8b 45 0c             	mov    0xc(%ebp),%eax
     e7c:	2b 45 14             	sub    0x14(%ebp),%eax
     e7f:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e82:	db 45 b0             	fildl  -0x50(%ebp)
     e85:	de f9                	fdivrp %st,%st(1)
     e87:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     e8a:	8b 45 14             	mov    0x14(%ebp),%eax
     e8d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e90:	7e 0e                	jle    ea0 <APDrawLine+0x183>
        {
            s = x1;
     e92:	8b 45 0c             	mov    0xc(%ebp),%eax
     e95:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     e98:	8b 45 14             	mov    0x14(%ebp),%eax
     e9b:	89 45 e8             	mov    %eax,-0x18(%ebp)
     e9e:	eb 0c                	jmp    eac <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ea0:	8b 45 14             	mov    0x14(%ebp),%eax
     ea3:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     ea6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea9:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     eac:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     eb0:	79 07                	jns    eb9 <APDrawLine+0x19c>
     eb2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     eb9:	8b 45 08             	mov    0x8(%ebp),%eax
     ebc:	8b 00                	mov    (%eax),%eax
     ebe:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ec1:	7f 0b                	jg     ece <APDrawLine+0x1b1>
     ec3:	8b 45 08             	mov    0x8(%ebp),%eax
     ec6:	8b 00                	mov    (%eax),%eax
     ec8:	83 e8 01             	sub    $0x1,%eax
     ecb:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     ece:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ed1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     ed4:	eb 3f                	jmp    f15 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     ed6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ed9:	2b 45 0c             	sub    0xc(%ebp),%eax
     edc:	89 45 b0             	mov    %eax,-0x50(%ebp)
     edf:	db 45 b0             	fildl  -0x50(%ebp)
     ee2:	dc 4d d0             	fmull  -0x30(%ebp)
     ee5:	db 45 10             	fildl  0x10(%ebp)
     ee8:	de c1                	faddp  %st,%st(1)
     eea:	d9 7d b6             	fnstcw -0x4a(%ebp)
     eed:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     ef1:	b4 0c                	mov    $0xc,%ah
     ef3:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     ef7:	d9 6d b4             	fldcw  -0x4c(%ebp)
     efa:	db 5d cc             	fistpl -0x34(%ebp)
     efd:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f00:	ff 75 cc             	pushl  -0x34(%ebp)
     f03:	ff 75 e4             	pushl  -0x1c(%ebp)
     f06:	ff 75 08             	pushl  0x8(%ebp)
     f09:	e8 2c fd ff ff       	call   c3a <APDrawPoint>
     f0e:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f11:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f15:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f18:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f1b:	7e b9                	jle    ed6 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f1d:	e9 b9 00 00 00       	jmp    fdb <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f22:	8b 45 0c             	mov    0xc(%ebp),%eax
     f25:	2b 45 14             	sub    0x14(%ebp),%eax
     f28:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f2b:	db 45 b0             	fildl  -0x50(%ebp)
     f2e:	8b 45 10             	mov    0x10(%ebp),%eax
     f31:	2b 45 18             	sub    0x18(%ebp),%eax
     f34:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f37:	db 45 b0             	fildl  -0x50(%ebp)
     f3a:	de f9                	fdivrp %st,%st(1)
     f3c:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f3f:	8b 45 10             	mov    0x10(%ebp),%eax
     f42:	3b 45 18             	cmp    0x18(%ebp),%eax
     f45:	7e 0e                	jle    f55 <APDrawLine+0x238>
    {
        s = y2;
     f47:	8b 45 18             	mov    0x18(%ebp),%eax
     f4a:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f4d:	8b 45 10             	mov    0x10(%ebp),%eax
     f50:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f53:	eb 0c                	jmp    f61 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f55:	8b 45 10             	mov    0x10(%ebp),%eax
     f58:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f5b:	8b 45 18             	mov    0x18(%ebp),%eax
     f5e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f61:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f65:	79 07                	jns    f6e <APDrawLine+0x251>
     f67:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f6e:	8b 45 08             	mov    0x8(%ebp),%eax
     f71:	8b 40 04             	mov    0x4(%eax),%eax
     f74:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f77:	7f 0c                	jg     f85 <APDrawLine+0x268>
     f79:	8b 45 08             	mov    0x8(%ebp),%eax
     f7c:	8b 40 04             	mov    0x4(%eax),%eax
     f7f:	83 e8 01             	sub    $0x1,%eax
     f82:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     f85:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f88:	89 45 e0             	mov    %eax,-0x20(%ebp)
     f8b:	eb 3f                	jmp    fcc <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     f8d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f90:	2b 45 10             	sub    0x10(%ebp),%eax
     f93:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f96:	db 45 b0             	fildl  -0x50(%ebp)
     f99:	dc 4d c0             	fmull  -0x40(%ebp)
     f9c:	db 45 0c             	fildl  0xc(%ebp)
     f9f:	de c1                	faddp  %st,%st(1)
     fa1:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fa4:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fa8:	b4 0c                	mov    $0xc,%ah
     faa:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fae:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fb1:	db 5d bc             	fistpl -0x44(%ebp)
     fb4:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     fb7:	ff 75 e0             	pushl  -0x20(%ebp)
     fba:	ff 75 bc             	pushl  -0x44(%ebp)
     fbd:	ff 75 08             	pushl  0x8(%ebp)
     fc0:	e8 75 fc ff ff       	call   c3a <APDrawPoint>
     fc5:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     fc8:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     fcc:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fcf:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fd2:	7e b9                	jle    f8d <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     fd4:	90                   	nop
     fd5:	eb 04                	jmp    fdb <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     fd7:	90                   	nop
     fd8:	eb 01                	jmp    fdb <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     fda:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     fdb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fde:	c9                   	leave  
     fdf:	c3                   	ret    

00000fe0 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	53                   	push   %ebx
     fe4:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
     fe7:	8b 55 10             	mov    0x10(%ebp),%edx
     fea:	8b 45 18             	mov    0x18(%ebp),%eax
     fed:	01 d0                	add    %edx,%eax
     fef:	83 e8 01             	sub    $0x1,%eax
     ff2:	83 ec 04             	sub    $0x4,%esp
     ff5:	50                   	push   %eax
     ff6:	ff 75 0c             	pushl  0xc(%ebp)
     ff9:	ff 75 10             	pushl  0x10(%ebp)
     ffc:	ff 75 0c             	pushl  0xc(%ebp)
     fff:	ff 75 08             	pushl  0x8(%ebp)
    1002:	e8 16 fd ff ff       	call   d1d <APDrawLine>
    1007:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    100a:	8b 55 0c             	mov    0xc(%ebp),%edx
    100d:	8b 45 14             	mov    0x14(%ebp),%eax
    1010:	01 d0                	add    %edx,%eax
    1012:	83 e8 01             	sub    $0x1,%eax
    1015:	83 ec 04             	sub    $0x4,%esp
    1018:	ff 75 10             	pushl  0x10(%ebp)
    101b:	50                   	push   %eax
    101c:	ff 75 10             	pushl  0x10(%ebp)
    101f:	ff 75 0c             	pushl  0xc(%ebp)
    1022:	ff 75 08             	pushl  0x8(%ebp)
    1025:	e8 f3 fc ff ff       	call   d1d <APDrawLine>
    102a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    102d:	8b 55 10             	mov    0x10(%ebp),%edx
    1030:	8b 45 18             	mov    0x18(%ebp),%eax
    1033:	01 d0                	add    %edx,%eax
    1035:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1038:	8b 55 0c             	mov    0xc(%ebp),%edx
    103b:	8b 45 14             	mov    0x14(%ebp),%eax
    103e:	01 d0                	add    %edx,%eax
    1040:	8d 50 ff             	lea    -0x1(%eax),%edx
    1043:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1046:	8b 45 14             	mov    0x14(%ebp),%eax
    1049:	01 d8                	add    %ebx,%eax
    104b:	83 e8 01             	sub    $0x1,%eax
    104e:	83 ec 04             	sub    $0x4,%esp
    1051:	51                   	push   %ecx
    1052:	52                   	push   %edx
    1053:	ff 75 10             	pushl  0x10(%ebp)
    1056:	50                   	push   %eax
    1057:	ff 75 08             	pushl  0x8(%ebp)
    105a:	e8 be fc ff ff       	call   d1d <APDrawLine>
    105f:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1062:	8b 55 10             	mov    0x10(%ebp),%edx
    1065:	8b 45 18             	mov    0x18(%ebp),%eax
    1068:	01 d0                	add    %edx,%eax
    106a:	8d 48 ff             	lea    -0x1(%eax),%ecx
    106d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1070:	8b 45 14             	mov    0x14(%ebp),%eax
    1073:	01 d0                	add    %edx,%eax
    1075:	8d 50 ff             	lea    -0x1(%eax),%edx
    1078:	8b 5d 10             	mov    0x10(%ebp),%ebx
    107b:	8b 45 18             	mov    0x18(%ebp),%eax
    107e:	01 d8                	add    %ebx,%eax
    1080:	83 e8 01             	sub    $0x1,%eax
    1083:	83 ec 04             	sub    $0x4,%esp
    1086:	51                   	push   %ecx
    1087:	52                   	push   %edx
    1088:	50                   	push   %eax
    1089:	ff 75 0c             	pushl  0xc(%ebp)
    108c:	ff 75 08             	pushl  0x8(%ebp)
    108f:	e8 89 fc ff ff       	call   d1d <APDrawLine>
    1094:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1097:	8b 55 0c             	mov    0xc(%ebp),%edx
    109a:	8b 45 14             	mov    0x14(%ebp),%eax
    109d:	01 d0                	add    %edx,%eax
    109f:	8d 50 ff             	lea    -0x1(%eax),%edx
    10a2:	8b 45 08             	mov    0x8(%ebp),%eax
    10a5:	8b 40 0c             	mov    0xc(%eax),%eax
    10a8:	89 c1                	mov    %eax,%ecx
    10aa:	c1 e9 1f             	shr    $0x1f,%ecx
    10ad:	01 c8                	add    %ecx,%eax
    10af:	d1 f8                	sar    %eax
    10b1:	29 c2                	sub    %eax,%edx
    10b3:	89 d0                	mov    %edx,%eax
    10b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10b8:	8b 55 10             	mov    0x10(%ebp),%edx
    10bb:	8b 45 18             	mov    0x18(%ebp),%eax
    10be:	01 d0                	add    %edx,%eax
    10c0:	8d 50 ff             	lea    -0x1(%eax),%edx
    10c3:	8b 45 08             	mov    0x8(%ebp),%eax
    10c6:	8b 40 0c             	mov    0xc(%eax),%eax
    10c9:	89 c1                	mov    %eax,%ecx
    10cb:	c1 e9 1f             	shr    $0x1f,%ecx
    10ce:	01 c8                	add    %ecx,%eax
    10d0:	d1 f8                	sar    %eax
    10d2:	29 c2                	sub    %eax,%edx
    10d4:	89 d0                	mov    %edx,%eax
    10d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    10d9:	8b 45 08             	mov    0x8(%ebp),%eax
    10dc:	8b 40 0c             	mov    0xc(%eax),%eax
    10df:	89 c2                	mov    %eax,%edx
    10e1:	c1 ea 1f             	shr    $0x1f,%edx
    10e4:	01 d0                	add    %edx,%eax
    10e6:	d1 f8                	sar    %eax
    10e8:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    10eb:	8b 45 08             	mov    0x8(%ebp),%eax
    10ee:	8b 40 0c             	mov    0xc(%eax),%eax
    10f1:	89 c2                	mov    %eax,%edx
    10f3:	c1 ea 1f             	shr    $0x1f,%edx
    10f6:	01 d0                	add    %edx,%eax
    10f8:	d1 f8                	sar    %eax
    10fa:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    10fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1101:	0f 88 d8 00 00 00    	js     11df <APDrawRect+0x1ff>
    1107:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    110b:	0f 88 ce 00 00 00    	js     11df <APDrawRect+0x1ff>
    1111:	8b 45 08             	mov    0x8(%ebp),%eax
    1114:	8b 00                	mov    (%eax),%eax
    1116:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1119:	0f 8e c0 00 00 00    	jle    11df <APDrawRect+0x1ff>
    111f:	8b 45 08             	mov    0x8(%ebp),%eax
    1122:	8b 40 04             	mov    0x4(%eax),%eax
    1125:	3b 45 10             	cmp    0x10(%ebp),%eax
    1128:	0f 8e b1 00 00 00    	jle    11df <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    112e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1132:	79 07                	jns    113b <APDrawRect+0x15b>
    1134:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    113b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    113f:	79 07                	jns    1148 <APDrawRect+0x168>
    1141:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1148:	8b 45 08             	mov    0x8(%ebp),%eax
    114b:	8b 00                	mov    (%eax),%eax
    114d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1150:	7f 0b                	jg     115d <APDrawRect+0x17d>
    1152:	8b 45 08             	mov    0x8(%ebp),%eax
    1155:	8b 00                	mov    (%eax),%eax
    1157:	83 e8 01             	sub    $0x1,%eax
    115a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    115d:	8b 45 08             	mov    0x8(%ebp),%eax
    1160:	8b 40 04             	mov    0x4(%eax),%eax
    1163:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1166:	7f 0c                	jg     1174 <APDrawRect+0x194>
    1168:	8b 45 08             	mov    0x8(%ebp),%eax
    116b:	8b 40 04             	mov    0x4(%eax),%eax
    116e:	83 e8 01             	sub    $0x1,%eax
    1171:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1174:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    117b:	8b 45 0c             	mov    0xc(%ebp),%eax
    117e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1181:	eb 52                	jmp    11d5 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1183:	8b 45 10             	mov    0x10(%ebp),%eax
    1186:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1189:	eb 3e                	jmp    11c9 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    118b:	83 ec 04             	sub    $0x4,%esp
    118e:	ff 75 e8             	pushl  -0x18(%ebp)
    1191:	ff 75 ec             	pushl  -0x14(%ebp)
    1194:	ff 75 08             	pushl  0x8(%ebp)
    1197:	e8 02 f7 ff ff       	call   89e <APGetIndex>
    119c:	83 c4 10             	add    $0x10,%esp
    119f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11a2:	8b 45 08             	mov    0x8(%ebp),%eax
    11a5:	8b 48 18             	mov    0x18(%eax),%ecx
    11a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11ab:	89 d0                	mov    %edx,%eax
    11ad:	01 c0                	add    %eax,%eax
    11af:	01 d0                	add    %edx,%eax
    11b1:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11b4:	8b 45 08             	mov    0x8(%ebp),%eax
    11b7:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11bb:	66 89 0a             	mov    %cx,(%edx)
    11be:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    11c2:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    11c5:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11cc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11cf:	7e ba                	jle    118b <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11d1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    11d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11d8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11db:	7e a6                	jle    1183 <APDrawRect+0x1a3>
    11dd:	eb 01                	jmp    11e0 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    11df:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    11e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11e3:	c9                   	leave  
    11e4:	c3                   	ret    

000011e5 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    11e5:	55                   	push   %ebp
    11e6:	89 e5                	mov    %esp,%ebp
    11e8:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    11eb:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    11ef:	0f 88 8e 01 00 00    	js     1383 <APDcCopy+0x19e>
    11f5:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    11f9:	0f 88 84 01 00 00    	js     1383 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    11ff:	8b 55 0c             	mov    0xc(%ebp),%edx
    1202:	8b 45 20             	mov    0x20(%ebp),%eax
    1205:	01 d0                	add    %edx,%eax
    1207:	89 45 fc             	mov    %eax,-0x4(%ebp)
    120a:	8b 55 10             	mov    0x10(%ebp),%edx
    120d:	8b 45 24             	mov    0x24(%ebp),%eax
    1210:	01 d0                	add    %edx,%eax
    1212:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1215:	8b 55 18             	mov    0x18(%ebp),%edx
    1218:	8b 45 20             	mov    0x20(%ebp),%eax
    121b:	01 d0                	add    %edx,%eax
    121d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1220:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1223:	8b 45 24             	mov    0x24(%ebp),%eax
    1226:	01 d0                	add    %edx,%eax
    1228:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    122b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    122f:	0f 88 51 01 00 00    	js     1386 <APDcCopy+0x1a1>
    1235:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1239:	0f 88 47 01 00 00    	js     1386 <APDcCopy+0x1a1>
    123f:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1243:	0f 88 3d 01 00 00    	js     1386 <APDcCopy+0x1a1>
    1249:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    124d:	0f 88 33 01 00 00    	js     1386 <APDcCopy+0x1a1>
    1253:	8b 45 14             	mov    0x14(%ebp),%eax
    1256:	8b 00                	mov    (%eax),%eax
    1258:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    125b:	0f 8c 25 01 00 00    	jl     1386 <APDcCopy+0x1a1>
    1261:	8b 45 14             	mov    0x14(%ebp),%eax
    1264:	8b 40 04             	mov    0x4(%eax),%eax
    1267:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    126a:	0f 8c 16 01 00 00    	jl     1386 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1270:	8b 45 08             	mov    0x8(%ebp),%eax
    1273:	8b 00                	mov    (%eax),%eax
    1275:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1278:	7f 0b                	jg     1285 <APDcCopy+0xa0>
    127a:	8b 45 08             	mov    0x8(%ebp),%eax
    127d:	8b 00                	mov    (%eax),%eax
    127f:	83 e8 01             	sub    $0x1,%eax
    1282:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1285:	8b 45 08             	mov    0x8(%ebp),%eax
    1288:	8b 40 04             	mov    0x4(%eax),%eax
    128b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    128e:	7f 0c                	jg     129c <APDcCopy+0xb7>
    1290:	8b 45 08             	mov    0x8(%ebp),%eax
    1293:	8b 40 04             	mov    0x4(%eax),%eax
    1296:	83 e8 01             	sub    $0x1,%eax
    1299:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    129c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12a3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    12aa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12b1:	e9 bc 00 00 00       	jmp    1372 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12b6:	8b 45 08             	mov    0x8(%ebp),%eax
    12b9:	8b 00                	mov    (%eax),%eax
    12bb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12be:	8b 55 10             	mov    0x10(%ebp),%edx
    12c1:	01 ca                	add    %ecx,%edx
    12c3:	0f af d0             	imul   %eax,%edx
    12c6:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c9:	01 d0                	add    %edx,%eax
    12cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    12ce:	8b 45 14             	mov    0x14(%ebp),%eax
    12d1:	8b 00                	mov    (%eax),%eax
    12d3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12d6:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12d9:	01 ca                	add    %ecx,%edx
    12db:	0f af d0             	imul   %eax,%edx
    12de:	8b 45 18             	mov    0x18(%ebp),%eax
    12e1:	01 d0                	add    %edx,%eax
    12e3:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    12e6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12ed:	eb 74                	jmp    1363 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    12ef:	8b 45 14             	mov    0x14(%ebp),%eax
    12f2:	8b 50 18             	mov    0x18(%eax),%edx
    12f5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12fb:	01 c8                	add    %ecx,%eax
    12fd:	89 c1                	mov    %eax,%ecx
    12ff:	89 c8                	mov    %ecx,%eax
    1301:	01 c0                	add    %eax,%eax
    1303:	01 c8                	add    %ecx,%eax
    1305:	01 d0                	add    %edx,%eax
    1307:	0f b7 10             	movzwl (%eax),%edx
    130a:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    130e:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1312:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1315:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1319:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    131d:	38 c2                	cmp    %al,%dl
    131f:	75 18                	jne    1339 <APDcCopy+0x154>
    1321:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1325:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1329:	38 c2                	cmp    %al,%dl
    132b:	75 0c                	jne    1339 <APDcCopy+0x154>
    132d:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1331:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1335:	38 c2                	cmp    %al,%dl
    1337:	74 26                	je     135f <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1339:	8b 45 08             	mov    0x8(%ebp),%eax
    133c:	8b 50 18             	mov    0x18(%eax),%edx
    133f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1342:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1345:	01 c8                	add    %ecx,%eax
    1347:	89 c1                	mov    %eax,%ecx
    1349:	89 c8                	mov    %ecx,%eax
    134b:	01 c0                	add    %eax,%eax
    134d:	01 c8                	add    %ecx,%eax
    134f:	01 d0                	add    %edx,%eax
    1351:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1355:	66 89 10             	mov    %dx,(%eax)
    1358:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    135c:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    135f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1363:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1366:	2b 45 0c             	sub    0xc(%ebp),%eax
    1369:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    136c:	7d 81                	jge    12ef <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    136e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1372:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1375:	2b 45 10             	sub    0x10(%ebp),%eax
    1378:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    137b:	0f 8d 35 ff ff ff    	jge    12b6 <APDcCopy+0xd1>
    1381:	eb 04                	jmp    1387 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1383:	90                   	nop
    1384:	eb 01                	jmp    1387 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1386:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1387:	c9                   	leave  
    1388:	c3                   	ret    

00001389 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1389:	55                   	push   %ebp
    138a:	89 e5                	mov    %esp,%ebp
    138c:	83 ec 1c             	sub    $0x1c,%esp
    138f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1392:	8b 55 10             	mov    0x10(%ebp),%edx
    1395:	8b 45 14             	mov    0x14(%ebp),%eax
    1398:	88 4d ec             	mov    %cl,-0x14(%ebp)
    139b:	88 55 e8             	mov    %dl,-0x18(%ebp)
    139e:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    13a1:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13a5:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13a8:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13ac:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13af:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13b3:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13b6:	8b 45 08             	mov    0x8(%ebp),%eax
    13b9:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13bd:	66 89 10             	mov    %dx,(%eax)
    13c0:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13c4:	88 50 02             	mov    %dl,0x2(%eax)
}
    13c7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ca:	c9                   	leave  
    13cb:	c2 04 00             	ret    $0x4

000013ce <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    13ce:	55                   	push   %ebp
    13cf:	89 e5                	mov    %esp,%ebp
    13d1:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13d4:	8b 45 08             	mov    0x8(%ebp),%eax
    13d7:	8b 00                	mov    (%eax),%eax
    13d9:	83 ec 08             	sub    $0x8,%esp
    13dc:	8d 55 0c             	lea    0xc(%ebp),%edx
    13df:	52                   	push   %edx
    13e0:	50                   	push   %eax
    13e1:	e8 95 ef ff ff       	call   37b <sendMessage>
    13e6:	83 c4 10             	add    $0x10,%esp
}
    13e9:	90                   	nop
    13ea:	c9                   	leave  
    13eb:	c3                   	ret    

000013ec <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    13ec:	55                   	push   %ebp
    13ed:	89 e5                	mov    %esp,%ebp
    13ef:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    13f2:	83 ec 0c             	sub    $0xc,%esp
    13f5:	68 90 00 00 00       	push   $0x90
    13fa:	e8 3e f3 ff ff       	call   73d <malloc>
    13ff:	83 c4 10             	add    $0x10,%esp
    1402:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1405:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1409:	75 15                	jne    1420 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    140b:	83 ec 04             	sub    $0x4,%esp
    140e:	ff 75 08             	pushl  0x8(%ebp)
    1411:	68 f0 20 00 00       	push   $0x20f0
    1416:	6a 01                	push   $0x1
    1418:	e8 4d f0 ff ff       	call   46a <printf>
    141d:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1420:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1423:	83 c0 7c             	add    $0x7c,%eax
    1426:	83 ec 08             	sub    $0x8,%esp
    1429:	ff 75 08             	pushl  0x8(%ebp)
    142c:	50                   	push   %eax
    142d:	e8 68 ec ff ff       	call   9a <strcpy>
    1432:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1435:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1438:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    143f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1442:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1449:	8b 45 f4             	mov    -0xc(%ebp),%eax
    144c:	8b 40 34             	mov    0x34(%eax),%eax
    144f:	89 c2                	mov    %eax,%edx
    1451:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1454:	8b 40 38             	mov    0x38(%eax),%eax
    1457:	0f af d0             	imul   %eax,%edx
    145a:	89 d0                	mov    %edx,%eax
    145c:	01 c0                	add    %eax,%eax
    145e:	01 d0                	add    %edx,%eax
    1460:	83 ec 0c             	sub    $0xc,%esp
    1463:	50                   	push   %eax
    1464:	e8 d4 f2 ff ff       	call   73d <malloc>
    1469:	83 c4 10             	add    $0x10,%esp
    146c:	89 c2                	mov    %eax,%edx
    146e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1471:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1474:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1477:	8b 40 4c             	mov    0x4c(%eax),%eax
    147a:	85 c0                	test   %eax,%eax
    147c:	75 15                	jne    1493 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    147e:	83 ec 04             	sub    $0x4,%esp
    1481:	ff 75 08             	pushl  0x8(%ebp)
    1484:	68 10 21 00 00       	push   $0x2110
    1489:	6a 01                	push   $0x1
    148b:	e8 da ef ff ff       	call   46a <printf>
    1490:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1493:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1496:	8b 40 34             	mov    0x34(%eax),%eax
    1499:	89 c2                	mov    %eax,%edx
    149b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149e:	8b 40 38             	mov    0x38(%eax),%eax
    14a1:	0f af d0             	imul   %eax,%edx
    14a4:	89 d0                	mov    %edx,%eax
    14a6:	01 c0                	add    %eax,%eax
    14a8:	01 c2                	add    %eax,%edx
    14aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ad:	8b 40 4c             	mov    0x4c(%eax),%eax
    14b0:	83 ec 04             	sub    $0x4,%esp
    14b3:	52                   	push   %edx
    14b4:	68 ff ff ff 00       	push   $0xffffff
    14b9:	50                   	push   %eax
    14ba:	e8 71 ec ff ff       	call   130 <memset>
    14bf:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c5:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    14cc:	e8 7a ee ff ff       	call   34b <getpid>
    14d1:	89 c2                	mov    %eax,%edx
    14d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d6:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14dc:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e6:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    14ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f0:	8b 40 50             	mov    0x50(%eax),%eax
    14f3:	89 c2                	mov    %eax,%edx
    14f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f8:	8b 40 54             	mov    0x54(%eax),%eax
    14fb:	0f af d0             	imul   %eax,%edx
    14fe:	89 d0                	mov    %edx,%eax
    1500:	01 c0                	add    %eax,%eax
    1502:	01 d0                	add    %edx,%eax
    1504:	83 ec 0c             	sub    $0xc,%esp
    1507:	50                   	push   %eax
    1508:	e8 30 f2 ff ff       	call   73d <malloc>
    150d:	83 c4 10             	add    $0x10,%esp
    1510:	89 c2                	mov    %eax,%edx
    1512:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1515:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    1518:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151b:	8b 40 68             	mov    0x68(%eax),%eax
    151e:	85 c0                	test   %eax,%eax
    1520:	75 15                	jne    1537 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1522:	83 ec 04             	sub    $0x4,%esp
    1525:	ff 75 08             	pushl  0x8(%ebp)
    1528:	68 34 21 00 00       	push   $0x2134
    152d:	6a 01                	push   $0x1
    152f:	e8 36 ef ff ff       	call   46a <printf>
    1534:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1537:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153a:	8b 40 34             	mov    0x34(%eax),%eax
    153d:	89 c2                	mov    %eax,%edx
    153f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1542:	8b 40 38             	mov    0x38(%eax),%eax
    1545:	0f af d0             	imul   %eax,%edx
    1548:	89 d0                	mov    %edx,%eax
    154a:	01 c0                	add    %eax,%eax
    154c:	01 c2                	add    %eax,%edx
    154e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1551:	8b 40 4c             	mov    0x4c(%eax),%eax
    1554:	83 ec 04             	sub    $0x4,%esp
    1557:	52                   	push   %edx
    1558:	68 ff 00 00 00       	push   $0xff
    155d:	50                   	push   %eax
    155e:	e8 cd eb ff ff       	call   130 <memset>
    1563:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1566:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1569:	8b 55 0c             	mov    0xc(%ebp),%edx
    156c:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    156f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1573:	74 35                	je     15aa <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1575:	8b 45 10             	mov    0x10(%ebp),%eax
    1578:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    157e:	83 ec 0c             	sub    $0xc,%esp
    1581:	50                   	push   %eax
    1582:	e8 b6 f1 ff ff       	call   73d <malloc>
    1587:	83 c4 10             	add    $0x10,%esp
    158a:	89 c2                	mov    %eax,%edx
    158c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158f:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1592:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1595:	8b 55 10             	mov    0x10(%ebp),%edx
    1598:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    159b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159e:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    15a5:	e9 8d 00 00 00       	jmp    1637 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ad:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b7:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c1:	8b 40 18             	mov    0x18(%eax),%eax
    15c4:	89 c2                	mov    %eax,%edx
    15c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c9:	8b 40 1c             	mov    0x1c(%eax),%eax
    15cc:	0f af d0             	imul   %eax,%edx
    15cf:	89 d0                	mov    %edx,%eax
    15d1:	01 c0                	add    %eax,%eax
    15d3:	01 d0                	add    %edx,%eax
    15d5:	83 ec 0c             	sub    $0xc,%esp
    15d8:	50                   	push   %eax
    15d9:	e8 5f f1 ff ff       	call   73d <malloc>
    15de:	83 c4 10             	add    $0x10,%esp
    15e1:	89 c2                	mov    %eax,%edx
    15e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e6:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    15e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ec:	8b 40 30             	mov    0x30(%eax),%eax
    15ef:	85 c0                	test   %eax,%eax
    15f1:	75 15                	jne    1608 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    15f3:	83 ec 04             	sub    $0x4,%esp
    15f6:	ff 75 08             	pushl  0x8(%ebp)
    15f9:	68 5c 21 00 00       	push   $0x215c
    15fe:	6a 01                	push   $0x1
    1600:	e8 65 ee ff ff       	call   46a <printf>
    1605:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1608:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160b:	8b 40 18             	mov    0x18(%eax),%eax
    160e:	89 c2                	mov    %eax,%edx
    1610:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1613:	8b 40 1c             	mov    0x1c(%eax),%eax
    1616:	0f af d0             	imul   %eax,%edx
    1619:	89 d0                	mov    %edx,%eax
    161b:	01 c0                	add    %eax,%eax
    161d:	01 c2                	add    %eax,%edx
    161f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1622:	8b 40 30             	mov    0x30(%eax),%eax
    1625:	83 ec 04             	sub    $0x4,%esp
    1628:	52                   	push   %edx
    1629:	68 ff ff ff 00       	push   $0xffffff
    162e:	50                   	push   %eax
    162f:	e8 fc ea ff ff       	call   130 <memset>
    1634:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1637:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    163a:	c9                   	leave  
    163b:	c3                   	ret    

0000163c <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    163c:	55                   	push   %ebp
    163d:	89 e5                	mov    %esp,%ebp
    163f:	53                   	push   %ebx
    1640:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1643:	8b 45 0c             	mov    0xc(%ebp),%eax
    1646:	83 f8 03             	cmp    $0x3,%eax
    1649:	74 02                	je     164d <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    164b:	eb 33                	jmp    1680 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    164d:	8b 45 08             	mov    0x8(%ebp),%eax
    1650:	8b 48 08             	mov    0x8(%eax),%ecx
    1653:	8b 45 08             	mov    0x8(%ebp),%eax
    1656:	8b 50 38             	mov    0x38(%eax),%edx
    1659:	8b 45 08             	mov    0x8(%ebp),%eax
    165c:	8b 40 34             	mov    0x34(%eax),%eax
    165f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1662:	83 c3 34             	add    $0x34,%ebx
    1665:	83 ec 0c             	sub    $0xc,%esp
    1668:	51                   	push   %ecx
    1669:	52                   	push   %edx
    166a:	50                   	push   %eax
    166b:	6a 00                	push   $0x0
    166d:	6a 00                	push   $0x0
    166f:	53                   	push   %ebx
    1670:	6a 32                	push   $0x32
    1672:	6a 00                	push   $0x0
    1674:	ff 75 08             	pushl  0x8(%ebp)
    1677:	e8 ef ec ff ff       	call   36b <paintWindow>
    167c:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    167f:	90                   	nop
        default: break;
            
            
    }
    return False;
    1680:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1685:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1688:	c9                   	leave  
    1689:	c3                   	ret    

0000168a <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    168a:	55                   	push   %ebp
    168b:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    168d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1690:	8b 50 08             	mov    0x8(%eax),%edx
    1693:	8b 45 08             	mov    0x8(%ebp),%eax
    1696:	8b 00                	mov    (%eax),%eax
    1698:	39 c2                	cmp    %eax,%edx
    169a:	74 07                	je     16a3 <APPreJudge+0x19>
        return False;
    169c:	b8 00 00 00 00       	mov    $0x0,%eax
    16a1:	eb 05                	jmp    16a8 <APPreJudge+0x1e>
    return True;
    16a3:	b8 01 00 00 00       	mov    $0x1,%eax
}
    16a8:	5d                   	pop    %ebp
    16a9:	c3                   	ret    

000016aa <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    16aa:	55                   	push   %ebp
    16ab:	89 e5                	mov    %esp,%ebp
    16ad:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    16b0:	8b 45 08             	mov    0x8(%ebp),%eax
    16b3:	8b 55 0c             	mov    0xc(%ebp),%edx
    16b6:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    16b9:	83 ec 0c             	sub    $0xc,%esp
    16bc:	ff 75 08             	pushl  0x8(%ebp)
    16bf:	e8 c7 ec ff ff       	call   38b <registWindow>
    16c4:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    16c7:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    16ce:	8b 45 08             	mov    0x8(%ebp),%eax
    16d1:	8b 00                	mov    (%eax),%eax
    16d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    16d6:	ff 75 f4             	pushl  -0xc(%ebp)
    16d9:	ff 75 f0             	pushl  -0x10(%ebp)
    16dc:	ff 75 ec             	pushl  -0x14(%ebp)
    16df:	ff 75 08             	pushl  0x8(%ebp)
    16e2:	e8 e7 fc ff ff       	call   13ce <APSendMessage>
    16e7:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    16ea:	83 ec 0c             	sub    $0xc,%esp
    16ed:	ff 75 08             	pushl  0x8(%ebp)
    16f0:	e8 8e ec ff ff       	call   383 <getMessage>
    16f5:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    16f8:	8b 45 08             	mov    0x8(%ebp),%eax
    16fb:	83 c0 6c             	add    $0x6c,%eax
    16fe:	83 ec 08             	sub    $0x8,%esp
    1701:	50                   	push   %eax
    1702:	ff 75 08             	pushl  0x8(%ebp)
    1705:	e8 80 ff ff ff       	call   168a <APPreJudge>
    170a:	83 c4 10             	add    $0x10,%esp
    170d:	84 c0                	test   %al,%al
    170f:	74 1b                	je     172c <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    1711:	8b 45 08             	mov    0x8(%ebp),%eax
    1714:	ff 70 74             	pushl  0x74(%eax)
    1717:	ff 70 70             	pushl  0x70(%eax)
    171a:	ff 70 6c             	pushl  0x6c(%eax)
    171d:	ff 75 08             	pushl  0x8(%ebp)
    1720:	8b 45 0c             	mov    0xc(%ebp),%eax
    1723:	ff d0                	call   *%eax
    1725:	83 c4 10             	add    $0x10,%esp
    1728:	84 c0                	test   %al,%al
    172a:	75 0c                	jne    1738 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    172c:	8b 45 08             	mov    0x8(%ebp),%eax
    172f:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1736:	eb b2                	jmp    16ea <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1738:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1739:	90                   	nop
    173a:	c9                   	leave  
    173b:	c3                   	ret    

0000173c <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    173c:	55                   	push   %ebp
    173d:	89 e5                	mov    %esp,%ebp
    173f:	57                   	push   %edi
    1740:	56                   	push   %esi
    1741:	53                   	push   %ebx
    1742:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1745:	a1 98 27 00 00       	mov    0x2798,%eax
    174a:	85 c0                	test   %eax,%eax
    174c:	0f 85 2c 02 00 00    	jne    197e <APGridPaint+0x242>
    {
        iconReady = 1;
    1752:	c7 05 98 27 00 00 01 	movl   $0x1,0x2798
    1759:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    175c:	8d 45 98             	lea    -0x68(%ebp),%eax
    175f:	83 ec 08             	sub    $0x8,%esp
    1762:	68 83 21 00 00       	push   $0x2183
    1767:	50                   	push   %eax
    1768:	e8 83 f1 ff ff       	call   8f0 <APLoadBitmap>
    176d:	83 c4 0c             	add    $0xc,%esp
    1770:	8b 45 98             	mov    -0x68(%ebp),%eax
    1773:	a3 bc 27 00 00       	mov    %eax,0x27bc
    1778:	8b 45 9c             	mov    -0x64(%ebp),%eax
    177b:	a3 c0 27 00 00       	mov    %eax,0x27c0
    1780:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1783:	a3 c4 27 00 00       	mov    %eax,0x27c4
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1788:	83 ec 04             	sub    $0x4,%esp
    178b:	ff 35 c4 27 00 00    	pushl  0x27c4
    1791:	ff 35 c0 27 00 00    	pushl  0x27c0
    1797:	ff 35 bc 27 00 00    	pushl  0x27bc
    179d:	e8 88 f3 ff ff       	call   b2a <APCreateCompatibleDCFromBitmap>
    17a2:	83 c4 10             	add    $0x10,%esp
    17a5:	a3 c8 27 00 00       	mov    %eax,0x27c8
        grid_river = APLoadBitmap ("grid_river.bmp");
    17aa:	8d 45 98             	lea    -0x68(%ebp),%eax
    17ad:	83 ec 08             	sub    $0x8,%esp
    17b0:	68 91 21 00 00       	push   $0x2191
    17b5:	50                   	push   %eax
    17b6:	e8 35 f1 ff ff       	call   8f0 <APLoadBitmap>
    17bb:	83 c4 0c             	add    $0xc,%esp
    17be:	8b 45 98             	mov    -0x68(%ebp),%eax
    17c1:	a3 f8 27 00 00       	mov    %eax,0x27f8
    17c6:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17c9:	a3 fc 27 00 00       	mov    %eax,0x27fc
    17ce:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17d1:	a3 00 28 00 00       	mov    %eax,0x2800
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    17d6:	83 ec 04             	sub    $0x4,%esp
    17d9:	ff 35 00 28 00 00    	pushl  0x2800
    17df:	ff 35 fc 27 00 00    	pushl  0x27fc
    17e5:	ff 35 f8 27 00 00    	pushl  0x27f8
    17eb:	e8 3a f3 ff ff       	call   b2a <APCreateCompatibleDCFromBitmap>
    17f0:	83 c4 10             	add    $0x10,%esp
    17f3:	a3 e8 27 00 00       	mov    %eax,0x27e8
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    17f8:	8d 45 98             	lea    -0x68(%ebp),%eax
    17fb:	83 ec 08             	sub    $0x8,%esp
    17fe:	68 a0 21 00 00       	push   $0x21a0
    1803:	50                   	push   %eax
    1804:	e8 e7 f0 ff ff       	call   8f0 <APLoadBitmap>
    1809:	83 c4 0c             	add    $0xc,%esp
    180c:	8b 45 98             	mov    -0x68(%ebp),%eax
    180f:	a3 ec 27 00 00       	mov    %eax,0x27ec
    1814:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1817:	a3 f0 27 00 00       	mov    %eax,0x27f0
    181c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    181f:	a3 f4 27 00 00       	mov    %eax,0x27f4
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1824:	83 ec 04             	sub    $0x4,%esp
    1827:	ff 35 f4 27 00 00    	pushl  0x27f4
    182d:	ff 35 f0 27 00 00    	pushl  0x27f0
    1833:	ff 35 ec 27 00 00    	pushl  0x27ec
    1839:	e8 ec f2 ff ff       	call   b2a <APCreateCompatibleDCFromBitmap>
    183e:	83 c4 10             	add    $0x10,%esp
    1841:	a3 9c 27 00 00       	mov    %eax,0x279c
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1846:	8d 45 98             	lea    -0x68(%ebp),%eax
    1849:	83 ec 08             	sub    $0x8,%esp
    184c:	68 af 21 00 00       	push   $0x21af
    1851:	50                   	push   %eax
    1852:	e8 99 f0 ff ff       	call   8f0 <APLoadBitmap>
    1857:	83 c4 0c             	add    $0xc,%esp
    185a:	8b 45 98             	mov    -0x68(%ebp),%eax
    185d:	a3 d0 27 00 00       	mov    %eax,0x27d0
    1862:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1865:	a3 d4 27 00 00       	mov    %eax,0x27d4
    186a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    186d:	a3 d8 27 00 00       	mov    %eax,0x27d8
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1872:	83 ec 04             	sub    $0x4,%esp
    1875:	ff 35 d8 27 00 00    	pushl  0x27d8
    187b:	ff 35 d4 27 00 00    	pushl  0x27d4
    1881:	ff 35 d0 27 00 00    	pushl  0x27d0
    1887:	e8 9e f2 ff ff       	call   b2a <APCreateCompatibleDCFromBitmap>
    188c:	83 c4 10             	add    $0x10,%esp
    188f:	a3 04 28 00 00       	mov    %eax,0x2804
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1894:	8d 45 98             	lea    -0x68(%ebp),%eax
    1897:	83 ec 08             	sub    $0x8,%esp
    189a:	68 bd 21 00 00       	push   $0x21bd
    189f:	50                   	push   %eax
    18a0:	e8 4b f0 ff ff       	call   8f0 <APLoadBitmap>
    18a5:	83 c4 0c             	add    $0xc,%esp
    18a8:	8b 45 98             	mov    -0x68(%ebp),%eax
    18ab:	a3 ac 27 00 00       	mov    %eax,0x27ac
    18b0:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18b3:	a3 b0 27 00 00       	mov    %eax,0x27b0
    18b8:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18bb:	a3 b4 27 00 00       	mov    %eax,0x27b4
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    18c0:	83 ec 04             	sub    $0x4,%esp
    18c3:	ff 35 b4 27 00 00    	pushl  0x27b4
    18c9:	ff 35 b0 27 00 00    	pushl  0x27b0
    18cf:	ff 35 ac 27 00 00    	pushl  0x27ac
    18d5:	e8 50 f2 ff ff       	call   b2a <APCreateCompatibleDCFromBitmap>
    18da:	83 c4 10             	add    $0x10,%esp
    18dd:	a3 cc 27 00 00       	mov    %eax,0x27cc
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    18e2:	8d 45 98             	lea    -0x68(%ebp),%eax
    18e5:	83 ec 08             	sub    $0x8,%esp
    18e8:	68 cd 21 00 00       	push   $0x21cd
    18ed:	50                   	push   %eax
    18ee:	e8 fd ef ff ff       	call   8f0 <APLoadBitmap>
    18f3:	83 c4 0c             	add    $0xc,%esp
    18f6:	8b 45 98             	mov    -0x68(%ebp),%eax
    18f9:	a3 a0 27 00 00       	mov    %eax,0x27a0
    18fe:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1901:	a3 a4 27 00 00       	mov    %eax,0x27a4
    1906:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1909:	a3 a8 27 00 00       	mov    %eax,0x27a8
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    190e:	83 ec 04             	sub    $0x4,%esp
    1911:	ff 35 a8 27 00 00    	pushl  0x27a8
    1917:	ff 35 a4 27 00 00    	pushl  0x27a4
    191d:	ff 35 a0 27 00 00    	pushl  0x27a0
    1923:	e8 02 f2 ff ff       	call   b2a <APCreateCompatibleDCFromBitmap>
    1928:	83 c4 10             	add    $0x10,%esp
    192b:	a3 b8 27 00 00       	mov    %eax,0x27b8
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1930:	8d 45 98             	lea    -0x68(%ebp),%eax
    1933:	83 ec 08             	sub    $0x8,%esp
    1936:	68 df 21 00 00       	push   $0x21df
    193b:	50                   	push   %eax
    193c:	e8 af ef ff ff       	call   8f0 <APLoadBitmap>
    1941:	83 c4 0c             	add    $0xc,%esp
    1944:	8b 45 98             	mov    -0x68(%ebp),%eax
    1947:	a3 dc 27 00 00       	mov    %eax,0x27dc
    194c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    194f:	a3 e0 27 00 00       	mov    %eax,0x27e0
    1954:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1957:	a3 e4 27 00 00       	mov    %eax,0x27e4
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    195c:	83 ec 04             	sub    $0x4,%esp
    195f:	ff 35 e4 27 00 00    	pushl  0x27e4
    1965:	ff 35 e0 27 00 00    	pushl  0x27e0
    196b:	ff 35 dc 27 00 00    	pushl  0x27dc
    1971:	e8 b4 f1 ff ff       	call   b2a <APCreateCompatibleDCFromBitmap>
    1976:	83 c4 10             	add    $0x10,%esp
    1979:	a3 08 28 00 00       	mov    %eax,0x2808
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    197e:	8b 45 08             	mov    0x8(%ebp),%eax
    1981:	8b 40 08             	mov    0x8(%eax),%eax
    1984:	85 c0                	test   %eax,%eax
    1986:	75 17                	jne    199f <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1988:	83 ec 08             	sub    $0x8,%esp
    198b:	68 f0 21 00 00       	push   $0x21f0
    1990:	6a 01                	push   $0x1
    1992:	e8 d3 ea ff ff       	call   46a <printf>
    1997:	83 c4 10             	add    $0x10,%esp
        return;
    199a:	e9 f2 03 00 00       	jmp    1d91 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    199f:	8b 45 08             	mov    0x8(%ebp),%eax
    19a2:	8b 40 10             	mov    0x10(%eax),%eax
    19a5:	85 c0                	test   %eax,%eax
    19a7:	7e 10                	jle    19b9 <APGridPaint+0x27d>
    19a9:	8b 45 08             	mov    0x8(%ebp),%eax
    19ac:	8b 50 14             	mov    0x14(%eax),%edx
    19af:	8b 45 08             	mov    0x8(%ebp),%eax
    19b2:	8b 40 10             	mov    0x10(%eax),%eax
    19b5:	39 c2                	cmp    %eax,%edx
    19b7:	7c 17                	jl     19d0 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    19b9:	83 ec 08             	sub    $0x8,%esp
    19bc:	68 16 22 00 00       	push   $0x2216
    19c1:	6a 01                	push   $0x1
    19c3:	e8 a2 ea ff ff       	call   46a <printf>
    19c8:	83 c4 10             	add    $0x10,%esp
        return;
    19cb:	e9 c1 03 00 00       	jmp    1d91 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    19d0:	8b 45 08             	mov    0x8(%ebp),%eax
    19d3:	8b 40 14             	mov    0x14(%eax),%eax
    19d6:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    19dc:	89 45 dc             	mov    %eax,-0x24(%ebp)
    19df:	8b 45 dc             	mov    -0x24(%ebp),%eax
    19e2:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    19e5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    19ec:	e9 96 03 00 00       	jmp    1d87 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    19f1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    19f8:	e9 7c 03 00 00       	jmp    1d79 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    19fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a00:	c1 e0 04             	shl    $0x4,%eax
    1a03:	89 c2                	mov    %eax,%edx
    1a05:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a08:	01 c2                	add    %eax,%edx
    1a0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a0d:	01 d0                	add    %edx,%eax
    1a0f:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a12:	8b 45 08             	mov    0x8(%ebp),%eax
    1a15:	8b 40 0c             	mov    0xc(%eax),%eax
    1a18:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a1b:	c1 e2 02             	shl    $0x2,%edx
    1a1e:	01 d0                	add    %edx,%eax
    1a20:	8b 00                	mov    (%eax),%eax
    1a22:	83 f8 07             	cmp    $0x7,%eax
    1a25:	0f 87 49 03 00 00    	ja     1d74 <APGridPaint+0x638>
    1a2b:	8b 04 85 2c 22 00 00 	mov    0x222c(,%eax,4),%eax
    1a32:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1a34:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1a37:	6a 0c                	push   $0xc
    1a39:	6a 0c                	push   $0xc
    1a3b:	6a 0c                	push   $0xc
    1a3d:	50                   	push   %eax
    1a3e:	e8 46 f9 ff ff       	call   1389 <RGB>
    1a43:	83 c4 0c             	add    $0xc,%esp
    1a46:	8b 1d c8 27 00 00    	mov    0x27c8,%ebx
    1a4c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a4f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1a52:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a55:	6b c0 32             	imul   $0x32,%eax,%eax
    1a58:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1a5b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5e:	8d 78 34             	lea    0x34(%eax),%edi
    1a61:	83 ec 0c             	sub    $0xc,%esp
    1a64:	83 ec 04             	sub    $0x4,%esp
    1a67:	89 e0                	mov    %esp,%eax
    1a69:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1a6d:	66 89 30             	mov    %si,(%eax)
    1a70:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1a74:	88 50 02             	mov    %dl,0x2(%eax)
    1a77:	6a 32                	push   $0x32
    1a79:	6a 32                	push   $0x32
    1a7b:	6a 00                	push   $0x0
    1a7d:	6a 00                	push   $0x0
    1a7f:	53                   	push   %ebx
    1a80:	51                   	push   %ecx
    1a81:	ff 75 94             	pushl  -0x6c(%ebp)
    1a84:	57                   	push   %edi
    1a85:	e8 5b f7 ff ff       	call   11e5 <APDcCopy>
    1a8a:	83 c4 30             	add    $0x30,%esp
                    break;
    1a8d:	e9 e3 02 00 00       	jmp    1d75 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1a92:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a95:	6a 69                	push   $0x69
    1a97:	6a 69                	push   $0x69
    1a99:	6a 69                	push   $0x69
    1a9b:	50                   	push   %eax
    1a9c:	e8 e8 f8 ff ff       	call   1389 <RGB>
    1aa1:	83 c4 0c             	add    $0xc,%esp
    1aa4:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1aa8:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1aac:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ab0:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1ab3:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1aba:	8d 45 98             	lea    -0x68(%ebp),%eax
    1abd:	6a 69                	push   $0x69
    1abf:	6a 69                	push   $0x69
    1ac1:	6a 69                	push   $0x69
    1ac3:	50                   	push   %eax
    1ac4:	e8 c0 f8 ff ff       	call   1389 <RGB>
    1ac9:	83 c4 0c             	add    $0xc,%esp
    1acc:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ad0:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1ad4:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ad8:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1adb:	8b 45 08             	mov    0x8(%ebp),%eax
    1ade:	8d 50 34             	lea    0x34(%eax),%edx
    1ae1:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ae4:	ff 75 bc             	pushl  -0x44(%ebp)
    1ae7:	ff 75 b8             	pushl  -0x48(%ebp)
    1aea:	52                   	push   %edx
    1aeb:	50                   	push   %eax
    1aec:	e8 ce f0 ff ff       	call   bbf <APSetPen>
    1af1:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1af4:	8b 45 08             	mov    0x8(%ebp),%eax
    1af7:	8d 58 34             	lea    0x34(%eax),%ebx
    1afa:	8d 55 98             	lea    -0x68(%ebp),%edx
    1afd:	83 ec 04             	sub    $0x4,%esp
    1b00:	83 ec 04             	sub    $0x4,%esp
    1b03:	89 e0                	mov    %esp,%eax
    1b05:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1b09:	66 89 08             	mov    %cx,(%eax)
    1b0c:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1b10:	88 48 02             	mov    %cl,0x2(%eax)
    1b13:	53                   	push   %ebx
    1b14:	52                   	push   %edx
    1b15:	e8 de f0 ff ff       	call   bf8 <APSetBrush>
    1b1a:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b1d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b20:	6b d0 32             	imul   $0x32,%eax,%edx
    1b23:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b26:	6b c0 32             	imul   $0x32,%eax,%eax
    1b29:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b2c:	83 c1 34             	add    $0x34,%ecx
    1b2f:	83 ec 0c             	sub    $0xc,%esp
    1b32:	6a 32                	push   $0x32
    1b34:	6a 32                	push   $0x32
    1b36:	52                   	push   %edx
    1b37:	50                   	push   %eax
    1b38:	51                   	push   %ecx
    1b39:	e8 a2 f4 ff ff       	call   fe0 <APDrawRect>
    1b3e:	83 c4 20             	add    $0x20,%esp
                    break;
    1b41:	e9 2f 02 00 00       	jmp    1d75 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b46:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1b49:	6a 0c                	push   $0xc
    1b4b:	6a 0c                	push   $0xc
    1b4d:	6a 0c                	push   $0xc
    1b4f:	50                   	push   %eax
    1b50:	e8 34 f8 ff ff       	call   1389 <RGB>
    1b55:	83 c4 0c             	add    $0xc,%esp
    1b58:	8b 1d 08 28 00 00    	mov    0x2808,%ebx
    1b5e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b61:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b64:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b67:	6b c0 32             	imul   $0x32,%eax,%eax
    1b6a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b6d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b70:	8d 78 34             	lea    0x34(%eax),%edi
    1b73:	83 ec 0c             	sub    $0xc,%esp
    1b76:	83 ec 04             	sub    $0x4,%esp
    1b79:	89 e0                	mov    %esp,%eax
    1b7b:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1b7f:	66 89 30             	mov    %si,(%eax)
    1b82:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1b86:	88 50 02             	mov    %dl,0x2(%eax)
    1b89:	6a 32                	push   $0x32
    1b8b:	6a 32                	push   $0x32
    1b8d:	6a 00                	push   $0x0
    1b8f:	6a 00                	push   $0x0
    1b91:	53                   	push   %ebx
    1b92:	51                   	push   %ecx
    1b93:	ff 75 94             	pushl  -0x6c(%ebp)
    1b96:	57                   	push   %edi
    1b97:	e8 49 f6 ff ff       	call   11e5 <APDcCopy>
    1b9c:	83 c4 30             	add    $0x30,%esp
                    break;
    1b9f:	e9 d1 01 00 00       	jmp    1d75 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ba4:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1ba7:	6a 0c                	push   $0xc
    1ba9:	6a 0c                	push   $0xc
    1bab:	6a 0c                	push   $0xc
    1bad:	50                   	push   %eax
    1bae:	e8 d6 f7 ff ff       	call   1389 <RGB>
    1bb3:	83 c4 0c             	add    $0xc,%esp
    1bb6:	8b 1d e8 27 00 00    	mov    0x27e8,%ebx
    1bbc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bbf:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bc2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bc5:	6b c0 32             	imul   $0x32,%eax,%eax
    1bc8:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bcb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bce:	8d 78 34             	lea    0x34(%eax),%edi
    1bd1:	83 ec 0c             	sub    $0xc,%esp
    1bd4:	83 ec 04             	sub    $0x4,%esp
    1bd7:	89 e0                	mov    %esp,%eax
    1bd9:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1bdd:	66 89 30             	mov    %si,(%eax)
    1be0:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1be4:	88 50 02             	mov    %dl,0x2(%eax)
    1be7:	6a 32                	push   $0x32
    1be9:	6a 32                	push   $0x32
    1beb:	6a 00                	push   $0x0
    1bed:	6a 00                	push   $0x0
    1bef:	53                   	push   %ebx
    1bf0:	51                   	push   %ecx
    1bf1:	ff 75 94             	pushl  -0x6c(%ebp)
    1bf4:	57                   	push   %edi
    1bf5:	e8 eb f5 ff ff       	call   11e5 <APDcCopy>
    1bfa:	83 c4 30             	add    $0x30,%esp
                    break;
    1bfd:	e9 73 01 00 00       	jmp    1d75 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c02:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c05:	6a 0c                	push   $0xc
    1c07:	6a 0c                	push   $0xc
    1c09:	6a 0c                	push   $0xc
    1c0b:	50                   	push   %eax
    1c0c:	e8 78 f7 ff ff       	call   1389 <RGB>
    1c11:	83 c4 0c             	add    $0xc,%esp
    1c14:	8b 1d cc 27 00 00    	mov    0x27cc,%ebx
    1c1a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c1d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c20:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c23:	6b c0 32             	imul   $0x32,%eax,%eax
    1c26:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c29:	8b 45 08             	mov    0x8(%ebp),%eax
    1c2c:	8d 78 34             	lea    0x34(%eax),%edi
    1c2f:	83 ec 0c             	sub    $0xc,%esp
    1c32:	83 ec 04             	sub    $0x4,%esp
    1c35:	89 e0                	mov    %esp,%eax
    1c37:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1c3b:	66 89 30             	mov    %si,(%eax)
    1c3e:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1c42:	88 50 02             	mov    %dl,0x2(%eax)
    1c45:	6a 32                	push   $0x32
    1c47:	6a 32                	push   $0x32
    1c49:	6a 00                	push   $0x0
    1c4b:	6a 00                	push   $0x0
    1c4d:	53                   	push   %ebx
    1c4e:	51                   	push   %ecx
    1c4f:	ff 75 94             	pushl  -0x6c(%ebp)
    1c52:	57                   	push   %edi
    1c53:	e8 8d f5 ff ff       	call   11e5 <APDcCopy>
    1c58:	83 c4 30             	add    $0x30,%esp
                    break;
    1c5b:	e9 15 01 00 00       	jmp    1d75 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c60:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1c63:	6a 0c                	push   $0xc
    1c65:	6a 0c                	push   $0xc
    1c67:	6a 0c                	push   $0xc
    1c69:	50                   	push   %eax
    1c6a:	e8 1a f7 ff ff       	call   1389 <RGB>
    1c6f:	83 c4 0c             	add    $0xc,%esp
    1c72:	8b 1d 04 28 00 00    	mov    0x2804,%ebx
    1c78:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c7b:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c7e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c81:	6b c0 32             	imul   $0x32,%eax,%eax
    1c84:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c87:	8b 45 08             	mov    0x8(%ebp),%eax
    1c8a:	8d 78 34             	lea    0x34(%eax),%edi
    1c8d:	83 ec 0c             	sub    $0xc,%esp
    1c90:	83 ec 04             	sub    $0x4,%esp
    1c93:	89 e0                	mov    %esp,%eax
    1c95:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1c99:	66 89 30             	mov    %si,(%eax)
    1c9c:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1ca0:	88 50 02             	mov    %dl,0x2(%eax)
    1ca3:	6a 32                	push   $0x32
    1ca5:	6a 32                	push   $0x32
    1ca7:	6a 00                	push   $0x0
    1ca9:	6a 00                	push   $0x0
    1cab:	53                   	push   %ebx
    1cac:	51                   	push   %ecx
    1cad:	ff 75 94             	pushl  -0x6c(%ebp)
    1cb0:	57                   	push   %edi
    1cb1:	e8 2f f5 ff ff       	call   11e5 <APDcCopy>
    1cb6:	83 c4 30             	add    $0x30,%esp
                    break;
    1cb9:	e9 b7 00 00 00       	jmp    1d75 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cbe:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1cc1:	6a 0c                	push   $0xc
    1cc3:	6a 0c                	push   $0xc
    1cc5:	6a 0c                	push   $0xc
    1cc7:	50                   	push   %eax
    1cc8:	e8 bc f6 ff ff       	call   1389 <RGB>
    1ccd:	83 c4 0c             	add    $0xc,%esp
    1cd0:	8b 1d 9c 27 00 00    	mov    0x279c,%ebx
    1cd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cd9:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cdc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cdf:	6b c0 32             	imul   $0x32,%eax,%eax
    1ce2:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ce5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce8:	8d 78 34             	lea    0x34(%eax),%edi
    1ceb:	83 ec 0c             	sub    $0xc,%esp
    1cee:	83 ec 04             	sub    $0x4,%esp
    1cf1:	89 e0                	mov    %esp,%eax
    1cf3:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1cf7:	66 89 30             	mov    %si,(%eax)
    1cfa:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1cfe:	88 50 02             	mov    %dl,0x2(%eax)
    1d01:	6a 32                	push   $0x32
    1d03:	6a 32                	push   $0x32
    1d05:	6a 00                	push   $0x0
    1d07:	6a 00                	push   $0x0
    1d09:	53                   	push   %ebx
    1d0a:	51                   	push   %ecx
    1d0b:	ff 75 94             	pushl  -0x6c(%ebp)
    1d0e:	57                   	push   %edi
    1d0f:	e8 d1 f4 ff ff       	call   11e5 <APDcCopy>
    1d14:	83 c4 30             	add    $0x30,%esp
                    break;
    1d17:	eb 5c                	jmp    1d75 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d19:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d1c:	6a 0c                	push   $0xc
    1d1e:	6a 0c                	push   $0xc
    1d20:	6a 0c                	push   $0xc
    1d22:	50                   	push   %eax
    1d23:	e8 61 f6 ff ff       	call   1389 <RGB>
    1d28:	83 c4 0c             	add    $0xc,%esp
    1d2b:	8b 1d b8 27 00 00    	mov    0x27b8,%ebx
    1d31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d34:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d37:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d3a:	6b c0 32             	imul   $0x32,%eax,%eax
    1d3d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d40:	8b 45 08             	mov    0x8(%ebp),%eax
    1d43:	8d 78 34             	lea    0x34(%eax),%edi
    1d46:	83 ec 0c             	sub    $0xc,%esp
    1d49:	83 ec 04             	sub    $0x4,%esp
    1d4c:	89 e0                	mov    %esp,%eax
    1d4e:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1d52:	66 89 30             	mov    %si,(%eax)
    1d55:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1d59:	88 50 02             	mov    %dl,0x2(%eax)
    1d5c:	6a 32                	push   $0x32
    1d5e:	6a 32                	push   $0x32
    1d60:	6a 00                	push   $0x0
    1d62:	6a 00                	push   $0x0
    1d64:	53                   	push   %ebx
    1d65:	51                   	push   %ecx
    1d66:	ff 75 94             	pushl  -0x6c(%ebp)
    1d69:	57                   	push   %edi
    1d6a:	e8 76 f4 ff ff       	call   11e5 <APDcCopy>
    1d6f:	83 c4 30             	add    $0x30,%esp
                    break;
    1d72:	eb 01                	jmp    1d75 <APGridPaint+0x639>
                default: break;
    1d74:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d75:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1d79:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1d7d:	0f 8e 7a fc ff ff    	jle    19fd <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d83:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1d87:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1d8b:	0f 8e 60 fc ff ff    	jle    19f1 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1d91:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1d94:	5b                   	pop    %ebx
    1d95:	5e                   	pop    %esi
    1d96:	5f                   	pop    %edi
    1d97:	5d                   	pop    %ebp
    1d98:	c3                   	ret    

00001d99 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1d99:	55                   	push   %ebp
    1d9a:	89 e5                	mov    %esp,%ebp
    1d9c:	53                   	push   %ebx
    1d9d:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1da0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1da7:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1dab:	74 17                	je     1dc4 <sprintint+0x2b>
    1dad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1db1:	79 11                	jns    1dc4 <sprintint+0x2b>
        neg = 1;
    1db3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1dba:	8b 45 10             	mov    0x10(%ebp),%eax
    1dbd:	f7 d8                	neg    %eax
    1dbf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1dc2:	eb 06                	jmp    1dca <sprintint+0x31>
    } else {
        x = xx;
    1dc4:	8b 45 10             	mov    0x10(%ebp),%eax
    1dc7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1dca:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1dd1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1dd4:	8d 41 01             	lea    0x1(%ecx),%eax
    1dd7:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1dda:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1ddd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1de0:	ba 00 00 00 00       	mov    $0x0,%edx
    1de5:	f7 f3                	div    %ebx
    1de7:	89 d0                	mov    %edx,%eax
    1de9:	0f b6 80 78 27 00 00 	movzbl 0x2778(%eax),%eax
    1df0:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1df4:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1df7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1dfa:	ba 00 00 00 00       	mov    $0x0,%edx
    1dff:	f7 f3                	div    %ebx
    1e01:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e04:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e08:	75 c7                	jne    1dd1 <sprintint+0x38>
    if(neg)
    1e0a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e0e:	74 0e                	je     1e1e <sprintint+0x85>
        buf[i++] = '-';
    1e10:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e13:	8d 50 01             	lea    0x1(%eax),%edx
    1e16:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1e19:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1e1e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e21:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1e24:	eb 1b                	jmp    1e41 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1e26:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e29:	8b 00                	mov    (%eax),%eax
    1e2b:	8d 48 01             	lea    0x1(%eax),%ecx
    1e2e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e31:	89 0a                	mov    %ecx,(%edx)
    1e33:	89 c2                	mov    %eax,%edx
    1e35:	8b 45 08             	mov    0x8(%ebp),%eax
    1e38:	01 d0                	add    %edx,%eax
    1e3a:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1e3d:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1e41:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1e45:	7f df                	jg     1e26 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1e47:	eb 21                	jmp    1e6a <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1e49:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e4c:	8b 00                	mov    (%eax),%eax
    1e4e:	8d 48 01             	lea    0x1(%eax),%ecx
    1e51:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e54:	89 0a                	mov    %ecx,(%edx)
    1e56:	89 c2                	mov    %eax,%edx
    1e58:	8b 45 08             	mov    0x8(%ebp),%eax
    1e5b:	01 c2                	add    %eax,%edx
    1e5d:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1e60:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e63:	01 c8                	add    %ecx,%eax
    1e65:	0f b6 00             	movzbl (%eax),%eax
    1e68:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1e6a:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1e6e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1e72:	79 d5                	jns    1e49 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1e74:	90                   	nop
    1e75:	83 c4 20             	add    $0x20,%esp
    1e78:	5b                   	pop    %ebx
    1e79:	5d                   	pop    %ebp
    1e7a:	c3                   	ret    

00001e7b <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1e7b:	55                   	push   %ebp
    1e7c:	89 e5                	mov    %esp,%ebp
    1e7e:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1e81:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1e88:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1e8f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1e96:	8d 45 0c             	lea    0xc(%ebp),%eax
    1e99:	83 c0 04             	add    $0x4,%eax
    1e9c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1e9f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1ea6:	e9 d9 01 00 00       	jmp    2084 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1eab:	8b 55 0c             	mov    0xc(%ebp),%edx
    1eae:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1eb1:	01 d0                	add    %edx,%eax
    1eb3:	0f b6 00             	movzbl (%eax),%eax
    1eb6:	0f be c0             	movsbl %al,%eax
    1eb9:	25 ff 00 00 00       	and    $0xff,%eax
    1ebe:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1ec1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1ec5:	75 2c                	jne    1ef3 <sprintf+0x78>
            if(c == '%'){
    1ec7:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1ecb:	75 0c                	jne    1ed9 <sprintf+0x5e>
                state = '%';
    1ecd:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1ed4:	e9 a7 01 00 00       	jmp    2080 <sprintf+0x205>
            } else {
                dst[j++] = c;
    1ed9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1edc:	8d 50 01             	lea    0x1(%eax),%edx
    1edf:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1ee2:	89 c2                	mov    %eax,%edx
    1ee4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee7:	01 d0                	add    %edx,%eax
    1ee9:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1eec:	88 10                	mov    %dl,(%eax)
    1eee:	e9 8d 01 00 00       	jmp    2080 <sprintf+0x205>
            }
        } else if(state == '%'){
    1ef3:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1ef7:	0f 85 83 01 00 00    	jne    2080 <sprintf+0x205>
            if(c == 'd'){
    1efd:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1f01:	75 4c                	jne    1f4f <sprintf+0xd4>
                buf[bi] = '\0';
    1f03:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f06:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f09:	01 d0                	add    %edx,%eax
    1f0b:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f0e:	83 ec 0c             	sub    $0xc,%esp
    1f11:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f14:	50                   	push   %eax
    1f15:	e8 1f e3 ff ff       	call   239 <atoi>
    1f1a:	83 c4 10             	add    $0x10,%esp
    1f1d:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1f20:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1f27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f2a:	8b 00                	mov    (%eax),%eax
    1f2c:	83 ec 08             	sub    $0x8,%esp
    1f2f:	ff 75 d8             	pushl  -0x28(%ebp)
    1f32:	6a 01                	push   $0x1
    1f34:	6a 0a                	push   $0xa
    1f36:	50                   	push   %eax
    1f37:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1f3a:	50                   	push   %eax
    1f3b:	ff 75 08             	pushl  0x8(%ebp)
    1f3e:	e8 56 fe ff ff       	call   1d99 <sprintint>
    1f43:	83 c4 20             	add    $0x20,%esp
                ap++;
    1f46:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1f4a:	e9 2a 01 00 00       	jmp    2079 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1f4f:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1f53:	74 06                	je     1f5b <sprintf+0xe0>
    1f55:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1f59:	75 4c                	jne    1fa7 <sprintf+0x12c>
                buf[bi] = '\0';
    1f5b:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f61:	01 d0                	add    %edx,%eax
    1f63:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f66:	83 ec 0c             	sub    $0xc,%esp
    1f69:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f6c:	50                   	push   %eax
    1f6d:	e8 c7 e2 ff ff       	call   239 <atoi>
    1f72:	83 c4 10             	add    $0x10,%esp
    1f75:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1f78:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1f7f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f82:	8b 00                	mov    (%eax),%eax
    1f84:	83 ec 08             	sub    $0x8,%esp
    1f87:	ff 75 dc             	pushl  -0x24(%ebp)
    1f8a:	6a 00                	push   $0x0
    1f8c:	6a 10                	push   $0x10
    1f8e:	50                   	push   %eax
    1f8f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1f92:	50                   	push   %eax
    1f93:	ff 75 08             	pushl  0x8(%ebp)
    1f96:	e8 fe fd ff ff       	call   1d99 <sprintint>
    1f9b:	83 c4 20             	add    $0x20,%esp
                ap++;
    1f9e:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1fa2:	e9 d2 00 00 00       	jmp    2079 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1fa7:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1fab:	75 46                	jne    1ff3 <sprintf+0x178>
                s = (char*)*ap;
    1fad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fb0:	8b 00                	mov    (%eax),%eax
    1fb2:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1fb5:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1fb9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fbd:	75 25                	jne    1fe4 <sprintf+0x169>
                    s = "(null)";
    1fbf:	c7 45 f4 4c 22 00 00 	movl   $0x224c,-0xc(%ebp)
                while(*s != 0){
    1fc6:	eb 1c                	jmp    1fe4 <sprintf+0x169>
                    dst[j++] = *s;
    1fc8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1fcb:	8d 50 01             	lea    0x1(%eax),%edx
    1fce:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1fd1:	89 c2                	mov    %eax,%edx
    1fd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1fd6:	01 c2                	add    %eax,%edx
    1fd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fdb:	0f b6 00             	movzbl (%eax),%eax
    1fde:	88 02                	mov    %al,(%edx)
                    s++;
    1fe0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    1fe4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fe7:	0f b6 00             	movzbl (%eax),%eax
    1fea:	84 c0                	test   %al,%al
    1fec:	75 da                	jne    1fc8 <sprintf+0x14d>
    1fee:	e9 86 00 00 00       	jmp    2079 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    1ff3:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    1ff7:	75 1d                	jne    2016 <sprintf+0x19b>
                dst[j++] = *ap;
    1ff9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1ffc:	8d 50 01             	lea    0x1(%eax),%edx
    1fff:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2002:	89 c2                	mov    %eax,%edx
    2004:	8b 45 08             	mov    0x8(%ebp),%eax
    2007:	01 c2                	add    %eax,%edx
    2009:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    200c:	8b 00                	mov    (%eax),%eax
    200e:	88 02                	mov    %al,(%edx)
                ap++;
    2010:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2014:	eb 63                	jmp    2079 <sprintf+0x1fe>
            } else if(c == '%'){
    2016:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    201a:	75 17                	jne    2033 <sprintf+0x1b8>
                dst[j++] = c;
    201c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    201f:	8d 50 01             	lea    0x1(%eax),%edx
    2022:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2025:	89 c2                	mov    %eax,%edx
    2027:	8b 45 08             	mov    0x8(%ebp),%eax
    202a:	01 d0                	add    %edx,%eax
    202c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    202f:	88 10                	mov    %dl,(%eax)
    2031:	eb 46                	jmp    2079 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2033:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2037:	7e 18                	jle    2051 <sprintf+0x1d6>
    2039:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    203d:	7f 12                	jg     2051 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    203f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2042:	8d 50 01             	lea    0x1(%eax),%edx
    2045:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2048:	8b 55 e0             	mov    -0x20(%ebp),%edx
    204b:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    204f:	eb 2f                	jmp    2080 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2051:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2054:	8d 50 01             	lea    0x1(%eax),%edx
    2057:	89 55 c8             	mov    %edx,-0x38(%ebp)
    205a:	89 c2                	mov    %eax,%edx
    205c:	8b 45 08             	mov    0x8(%ebp),%eax
    205f:	01 d0                	add    %edx,%eax
    2061:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2064:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2067:	8d 50 01             	lea    0x1(%eax),%edx
    206a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    206d:	89 c2                	mov    %eax,%edx
    206f:	8b 45 08             	mov    0x8(%ebp),%eax
    2072:	01 d0                	add    %edx,%eax
    2074:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2077:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2079:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2080:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2084:	8b 55 0c             	mov    0xc(%ebp),%edx
    2087:	8b 45 ec             	mov    -0x14(%ebp),%eax
    208a:	01 d0                	add    %edx,%eax
    208c:	0f b6 00             	movzbl (%eax),%eax
    208f:	84 c0                	test   %al,%al
    2091:	0f 85 14 fe ff ff    	jne    1eab <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2097:	8b 45 c8             	mov    -0x38(%ebp),%eax
    209a:	8d 50 01             	lea    0x1(%eax),%edx
    209d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20a0:	89 c2                	mov    %eax,%edx
    20a2:	8b 45 08             	mov    0x8(%ebp),%eax
    20a5:	01 d0                	add    %edx,%eax
    20a7:	c6 00 00             	movb   $0x0,(%eax)
}
    20aa:	90                   	nop
    20ab:	c9                   	leave  
    20ac:	c3                   	ret    
